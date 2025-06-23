/*
=========================================================
🟪✨ Sequências do Banco de Dados Emissora TV/Rádio - UFPE CIn 2025.1

Este script define todas as sequências utilizadas para geração 
de chaves primárias e identificadores únicos nas tabelas do banco.
=========================================================
*/

/* ===========================
   program_seq: IDs para tabela program
   =========================== */
CREATE SEQUENCE program_seq
START WITH 1
INCREMENT BY 1
NOCACHE
CYCLE;


/* ===========================
   content_seq: IDs para tabela content
   =========================== */
CREATE SEQUENCE content_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

/* ===========================
   advertiser_seq: IDs para tabela advertiser
   =========================== */
CREATE SEQUENCE advertiser_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

/* ===========================
   campaign_seq: IDs para tabela campaign
   =========================== */
CREATE SEQUENCE campaign_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

/* ===========================
   address_seq: IDs para tabela studio_address
   =========================== */
CREATE SEQUENCE address_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

/* ===========================
   studio_seq: IDs para tabela studio
   =========================== */
CREATE SEQUENCE studio_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

/* ===========================
   employee_seq: IDs para tabela employee
   =========================== */
CREATE SEQUENCE employee_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;