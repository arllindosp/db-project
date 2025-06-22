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