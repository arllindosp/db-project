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
CREATE OR REPLACE TRIGGER trg_auto_season_number
BEFORE INSERT ON season
FOR EACH ROW
DECLARE
  v_next_number NUMBER;
BEGIN
  SELECT NVL(MAX(season_number), 0) + 1
  INTO v_next_number
  FROM season_copy
  WHERE id_program = :NEW.id_program;

  :NEW.season_number := v_next_number;
END;
/
CREATE OR REPLACE TRIGGER trg_auto_ep_number
BEFORE INSERT ON episode
FOR EACH ROW
DECLARE
  v_next_number NUMBER;
BEGIN
  SELECT NVL(MAX(episode_number), 0) + 1
  INTO v_next_number
  FROM episode_copy
  WHERE id_program = :NEW.id_program;

  :NEW.episode_number := v_next_number;
END;
/
CREATE OR REPLACE TRIGGER trg_content_id
BEFORE INSERT ON content
FOR EACH ROW
BEGIN
    SELECT content_seq.NEXTVAL
    INTO :NEW.content_id
    FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER trg_advertiser_id
BEFORE INSERT ON advertiser
FOR EACH ROW
BEGIN
    IF :NEW.advertiser_id IS NULL THEN
        SELECT advertiser_seq.NEXTVAL INTO :NEW.advertiser_id FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_campaign_id
BEFORE INSERT ON campaign
FOR EACH ROW
BEGIN
    IF :NEW.campaign_id IS NULL THEN
        SELECT campaign_seq.NEXTVAL INTO :NEW.campaign_id FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_employee_id
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF :NEW.employee_id IS NULL THEN
        SELECT employee_seq.NEXTVAL INTO :NEW.employee_id FROM dual;
    END IF;
END;
/