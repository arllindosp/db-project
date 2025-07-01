/*
=========================================================
🟦⚡ Triggers do Banco de Dados Emissora TV/Rádio - UFPE CIn 2025.1

Este script define todas as triggers responsáveis por regras 
automáticas e integridade nas tabelas do banco.
=========================================================
*/

/* ===========================
   trg_program_id: Preenche o campo 'id' da tabela program com o próximo valor da sequence program_seq antes do INSERT
   =========================== */
CREATE OR REPLACE TRIGGER trg_program_id
BEFORE INSERT ON program
FOR EACH ROW
BEGIN
    SELECT program_seq.NEXTVAL 
    INTO :NEW.id 
    FROM DUAL;
END;
/

/* ===========================
   trg_auto_season_number: Numera automaticamente as temporadas de cada programa
   - Executa ANTES do INSERT na tabela season
   - Conta quantas temporadas já existem para o programa
   - Atribui o próximo número sequencial (1, 2, 3...)
   - Garante numeração contínua por programa
   =========================== */
CREATE OR REPLACE TRIGGER trg_auto_season_number
BEFORE INSERT ON season
FOR EACH ROW
DECLARE
  v_next_number NUMBER;
BEGIN
  SELECT COUNT(*) + 1
  INTO v_next_number
  FROM season
  WHERE id_program = :NEW.id_program;
  :NEW.season_number := v_next_number;
END;
/


/* ===========================
   trg_enforce_season_status: Impede criação de nova temporada se a última estiver em andamento
   - Executa ANTES do INSERT na tabela season
   - Verifica se a temporada mais recente do programa está 'ongoing'
   - Bloqueia inserção se houver conflito de status
   - Garante que apenas uma temporada por programa esteja ativa
   =========================== */
CREATE OR REPLACE TRIGGER trg_enforce_season_status
BEFORE INSERT ON season
FOR EACH ROW
DECLARE
  v_season_status VARCHAR2(50);
BEGIN
  BEGIN
    SELECT s1.season_status
    INTO v_season_status
    FROM season s1
    WHERE s1.season_number = 
      (SELECT MAX(season_number)
       FROM season s2
       WHERE s1.id_program = s2.id_program)
      AND s1.id_program = :NEW.id_program;
    IF v_season_status = 'ongoing' THEN
      RAISE_APPLICATION_ERROR(-20001, 'Cannot insert a new season while the last one is ongoing.');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL; -- Não faz nada se não existe temporada anterior
  END;
END;
/

/* ===========================
   trg_auto_ep_number: Numera automaticamente os episódios dentro de cada temporada
   - Executa ANTES do INSERT na tabela episode
   - Conta episódios existentes na mesma temporada e programa
   - Atribui numeração sequencial (1, 2, 3...) por temporada
   - Garante ordem correta dos episódios
   =========================== */
CREATE OR REPLACE TRIGGER trg_auto_ep_number
BEFORE INSERT ON episode
FOR EACH ROW
DECLARE 
  v_next_number NUMBER;
BEGIN
  SELECT COUNT(*) + 1
  INTO v_next_number
  FROM episode
  WHERE season_number = :NEW.season_number
  AND id_program = :NEW.id_program;
  :NEW.episode_number := v_next_number;
END;
/

/* ===========================
   trg_content_id: Gera ID único para todo tipo de conteúdo (episódios e anúncios)
   - Executa ANTES do INSERT na tabela content
   - Utiliza sequence content_seq para IDs únicos
   - Aplica-se tanto para episódios quanto anúncios
   - Garante chave primária sempre preenchida
   =========================== */
CREATE OR REPLACE TRIGGER trg_content_id
BEFORE INSERT ON content
FOR EACH ROW
BEGIN
    SELECT content_seq.NEXTVAL
    INTO :NEW.content_id
    FROM DUAL;
END;
/

/* ===========================
   trg_advertiser_id: Gera ID sequencial para anunciantes (se não informado)
   - Executa ANTES do INSERT na tabela advertiser
   - Verifica se ID não foi fornecido manualmente
   - Utiliza sequence advertiser_seq como fallback
   - Permite flexibilidade na inserção de dados
   =========================== */

CREATE OR REPLACE TRIGGER trg_advertiser_id
BEFORE INSERT ON advertiser
FOR EACH ROW
BEGIN
    IF :NEW.advertiser_id IS NULL THEN
        SELECT advertiser_seq.NEXTVAL INTO :NEW.advertiser_id FROM dual;
    END IF;
END;
/

/* ===========================
   trg_campaign_id: Gera ID sequencial para campanhas publicitárias (se não informado)
   - Executa ANTES do INSERT na tabela campaign
   - Verifica se ID não foi fornecido manualmente
   - Utiliza sequence campaign_seq como fallback
   - Facilita inserção sem necessidade de calcular IDs
   =========================== */

CREATE OR REPLACE TRIGGER trg_campaign_id
BEFORE INSERT ON campaign
FOR EACH ROW
BEGIN
    IF :NEW.campaign_id IS NULL THEN
        SELECT campaign_seq.NEXTVAL INTO :NEW.campaign_id FROM dual;
    END IF;
END;
/

/* ===========================
   trg_employee_id: Gera ID sequencial para funcionários (se não informado)
   - Executa ANTES do INSERT na tabela employee
   - Verifica se ID não foi fornecido manualmente
   - Utiliza sequence employee_seq como fallback
   - Garante consistência nos IDs de funcionários
   =========================== */
CREATE OR REPLACE TRIGGER trg_employee_id
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF :NEW.employee_id IS NULL THEN
        SELECT employee_seq.NEXTVAL INTO :NEW.employee_id FROM dual;
    END IF;
END;
/

/* ===========================
   trg_address_id: Gera ID sequencial para endereços (se não informado)
   - Executa ANTES do INSERT na tabela studio_address
   - Verifica se ID não foi fornecido manualmente
   - Utiliza sequence address_seq como fallback
   - Facilita inserção de endereços sem necessidade de calcular IDs
   =========================== */
CREATE OR REPLACE TRIGGER trg_address_id
BEFORE INSERT ON studio_address
FOR EACH ROW
BEGIN
    IF :NEW.address_id IS NULL THEN
        SELECT address_seq.NEXTVAL INTO :NEW.address_id FROM dual;
    END IF;
END;
/

/* ===========================
   trg_studio_id: Gera ID sequencial para estúdios (se não informado)
   - Executa ANTES do INSERT na tabela studio
   - Verifica se ID não foi fornecido manualmente
   - Utiliza sequence studio_seq como fallback
   - Facilita cadastro de novos estúdios de produção
   =========================== */
   
CREATE OR REPLACE TRIGGER trg_studio_id
BEFORE INSERT ON studio
FOR EACH ROW
BEGIN
    IF :NEW.studio_id IS NULL THEN
        SELECT studio_seq.NEXTVAL INTO :NEW.studio_id FROM dual;
    END IF;
END;
/