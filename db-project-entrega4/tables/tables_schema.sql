/*
=========================================================
📺 TV/Radio Station Database Schema
🏛️ Universidade Federal de Pernambuco (UFPE)
    Centro de Informática - CIn
    Tema: Emissora de TV/Rádio
    Disciplina: Banco de Dados - 2025.1
    Esquema Relacional Normalizado

     Autores:
        • Pedro Moraes        (phmss)
        • Matheus Silva       (mhbs4)
        • Arlindo             (apsj)
        • Marcus Vinícius     (mvsl2)
        • Gabriel Correia     (gcb2)
        • Layla               (lbbs)
=========================================================

*/

DROP TABLE participate CASCADE CONSTRAINTS;
DROP TABLE production CASCADE CONSTRAINTS;
DROP TABLE interrupt CASCADE CONSTRAINTS;
DROP TABLE broadcast CASCADE CONSTRAINTS;
DROP TABLE channel CASCADE CONSTRAINTS;
DROP TABLE promote CASCADE CONSTRAINTS;
DROP TABLE studio CASCADE CONSTRAINTS;
DROP TABLE campaign CASCADE CONSTRAINTS;
DROP TABLE advertiser CASCADE CONSTRAINTS;
DROP TABLE advertisement CASCADE CONSTRAINTS;
DROP TABLE episode CASCADE CONSTRAINTS;
DROP TABLE season CASCADE CONSTRAINTS;
DROP TABLE genre CASCADE CONSTRAINTS;
DROP TABLE program CASCADE CONSTRAINTS;
DROP TABLE content CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE studio_address CASCADE CONSTRAINTS;

CREATE TABLE program(
    id NUMBER,
    nome VARCHAR2(50),
    classifc_ind NUMBER,
    CONSTRAINT program_pkey PRIMARY KEY (id),
    CONSTRAINT program_nome_nn CHECK (nome IS NOT NULL),
    CONSTRAINT classInd_range CHECK (classifc_ind IN (0, 10, 12, 14, 16, 18)),
    CONSTRAINT classInd_nn CHECK(classifc_ind IS NOT NULL)
);

CREATE TABLE genre(
    program_id NUMBER,
    nome VARCHAR2(50),
    CONSTRAINT genre_pkey PRIMARY KEY (program_id,nome),
    CONSTRAINT genre_fk FOREIGN KEY (program_id) REFERENCES program(id)
);

CREATE TABLE season(
    id_program NUMBER,
    season_number NUMBER,
    season_status VARCHAR2(50),
    CONSTRAINT season_pkey PRIMARY KEY(id_program, season_number),
    CONSTRAINT season_program_fk FOREIGN KEY (id_program) REFERENCES program(id),
    CONSTRAINT seasonStatus_categories CHECK( season_status IN ('ongoing', 'finished')),
    CONSTRAINT seasonStatus_nn CHECK(season_status IS NOT NULL)
);

CREATE TABLE content(
   content_id NUMBER,
   content_production_status NUMBER,
   content_duration NUMBER,
   content_title VARCHAR2(100),
   CONSTRAINT content_pk PRIMARY KEY(content_id),
   CONSTRAINT contentProductionstatus_range CHECK(content_production_status >= 0),
   CONSTRAINT contentProductionStatus_nn CHECK(content_production_status IS NOT NULL),
   CONSTRAINT contentDuration_nn CHECK(content_duration IS NOT NULL),
   CONSTRAINT contentTitle_nn CHECK(content_title IS NOT NULL)
);

CREATE TABLE episode(
    content_id NUMBER,
    id_program NUMBER,
    season_number NUMBER,
    episode_number NUMBER,
    CONSTRAINT episode_pk PRIMARY KEY(content_id, id_program,season_number),
    CONSTRAINT episode_fk FOREIGN KEY (content_id) REFERENCES content(content_id),
    CONSTRAINT episode_season_fk FOREIGN KEY(id_program,season_number) REFERENCES season(id_program,season_number),
    CONSTRAINT episode_nn CHECK (episode_number IS NOT NULL),
    CONSTRAINT episode_range CHECK(episode_number > 0) 
);

CREATE TABLE advertisement(
   advertisement_id NUMBER,
   advertiser_id NUMBER,
   campaign_id NUMBER,
   target_audience VARCHAR2(100),
   CONSTRAINT advertisement_pk PRIMARY KEY(advertisement_id),
   CONSTRAINT advertisement_fk FOREIGN KEY(advertisement_id) REFERENCES content(content_id),
   CONSTRAINT target_audience_nn CHECK(target_audience IS  NOT NULL)
);

CREATE TABLE advertiser (
    advertiser_id NUMBER,
    advertiser_name VARCHAR2(100),
    CONSTRAINT advertiser_pk PRIMARY KEY(advertiser_id),
    CONSTRAINT advertiser_name_nn CHECK(advertiser_name IS NOT NULL)
);

CREATE TABLE campaign(
    campaign_id NUMBER,
    campaign_name VARCHAR2(100),
    campaign_description VARCHAR2(1000),
    CONSTRAINT campaign_pk PRIMARY KEY(campaign_id),
    CONSTRAINT campaign_name_nn CHECK(campaign_name IS NOT NULL),
    CONSTRAINT campaign_description_nn CHECK (campaign_description IS NOT NULL)
);

CREATE TABLE studio_address(
    address_id NUMBER,
    neighborhood VARCHAR2(100),
    street VARCHAR2(100),
    address_number NUMBER(10),
    CONSTRAINT address_pk PRIMARY KEY (address_id),
    CONSTRAINT neighborhood_nn CHECK(neighborhood IS NOT NULL),
    CONSTRAINT street_nn CHECK(street IS NOT NULL),
    CONSTRAINT address_number_nn CHECK(address_number IS NOT NULL)
);

CREATE TABLE studio(
   studio_id NUMBER,
   studio_name VARCHAR2(100),
   studio_capacity NUMBER,
   maintenance_cost NUMBER,
   address_id NUMBER,
   CONSTRAINT studio_pk PRIMARY KEY(studio_id),
   CONSTRAINT studio_name_nn CHECK(studio_name IS NOT NULL),
   CONSTRAINT studio_capacity_nn CHECK(studio_capacity IS NOT NULL),
   CONSTRAINT maintenance_cost_nn CHECK (maintenance_cost IS NOT NULL),
   CONSTRAINT studio_fk FOREIGN KEY(address_id) REFERENCES studio_address(address_id)
);

CREATE TABLE promote(
   advertisement_id NUMBER,
   advertiser_id NUMBER,
   campaign_id NUMBER,
   promotion_budget NUMBER,
   CONSTRAINT promote_pk PRIMARY KEY(advertisement_id, advertiser_id, campaign_id),
   CONSTRAINT promote_advertisement_fk FOREIGN KEY(advertisement_id) REFERENCES advertisement(advertisement_id),
   CONSTRAINT promote_advertiser_fk FOREIGN KEY(advertiser_id) REFERENCES advertiser(advertiser_id),
   CONSTRAINT promote_campaign_fk FOREIGN KEY(campaign_id) REFERENCES campaign(campaign_id),
   CONSTRAINT promotion_budget_nn CHECK(promotion_budget IS NOT NULL),
   CONSTRAINT promotion_budget_range CHECK(promotion_budget >= 0)
);

CREATE TABLE channel(
    frequency NUMBER,
    channel_name VARCHAR2(70),
    CONSTRAINT channel_pk PRIMARY KEY(frequency),
    CONSTRAINT channel_name_nn CHECK(channel_name IS NOT NULL)
);

CREATE TABLE broadcast(
   channel_frequency NUMBER,
   content_id NUMBER,
   broadcast_begin_time TIMESTAMP,
   broadcast_end_time TIMESTAMP,
   reach_audience NUMBER,
   broadcast_revenue NUMBER,
   CONSTRAINT broadcast_pk PRIMARY KEY(channel_frequency, content_id),
   CONSTRAINT broadcast_channel_fk FOREIGN KEY(channel_frequency) REFERENCES channel(frequency),
   CONSTRAINT broadcast_content_fk FOREIGN KEY(content_id) REFERENCES content(content_id),
   CONSTRAINT broadcast_begin_time_nn CHECK(broadcast_begin_time IS NOT NULL),
   CONSTRAINT broadcast_end_time_nn CHECK(broadcast_end_time IS NOT NULL),
   CONSTRAINT broadcast_reach_audience_range CHECK(reach_audience >= 0),
   CONSTRAINT broadcast_revenue_range CHECK(broadcast_revenue >= 0),
   CONSTRAINT broadcast_end_after_begin CHECK(broadcast_end_time > broadcast_begin_time),
   CONSTRAINT broadcast_revenue_nn CHECK(broadcast_revenue IS NOT NULL)
);

CREATE TABLE interrupt(
    content_id NUMBER,
    channel_frequency NUMBER,
    advertisement_id NUMBER,
    interruption_time TIMESTAMP,
    CONSTRAINT interrupt_pk PRIMARY KEY(content_id, channel_frequency, advertisement_id, interruption_time),
    CONSTRAINT interrupt_broadcast_fk FOREIGN KEY(channel_frequency, content_id) REFERENCES broadcast(channel_frequency, content_id),
    CONSTRAINT interrupt_advertisement_fk FOREIGN KEY(advertisement_id) REFERENCES advertisement(advertisement_id),
    CONSTRAINT interrupt_time_nn CHECK(interruption_time IS NOT NULL)
);

CREATE TABLE production(
   studio_id NUMBER,
   content_id NUMBER,
   production_cost NUMBER,
   production_begin TIMESTAMP,
   production_end TIMESTAMP,
   CONSTRAINT production_pk PRIMARY KEY(studio_id, content_id),
   CONSTRAINT production_studio_fk FOREIGN KEY(studio_id) REFERENCES studio(studio_id),
   CONSTRAINT production_cost_nn CHECK(production_cost IS NOT NULL),
   CONSTRAINT production_cost_range CHECK(production_cost >= 0),
   CONSTRAINT production_content_fk FOREIGN KEY(content_id) REFERENCES content(content_id),
   CONSTRAINT production_begin_nn CHECK(production_begin IS NOT NULL),
   CONSTRAINT production_end_nn CHECK(production_end IS NOT NULL),
   CONSTRAINT production_end_after_begin CHECK(production_end > production_begin)
);

CREATE TABLE employee(
    employee_id NUMBER,
    employee_salary NUMBER,
    employee_supervisor NUMBER,
    employee_name VARCHAR2(100),
    CONSTRAINT employee_pk PRIMARY KEY(employee_id),
    CONSTRAINT employee_supervisor_fk FOREIGN KEY(employee_supervisor) REFERENCES employee(employee_id),
    CONSTRAINT employee_name_nn CHECK(employee_name IS NOT NULL),
    CONSTRAINT employee_salary_nn CHECK(employee_salary IS NOT NULL),
    CONSTRAINT employee_salary_range CHECK(employee_salary >= 0)
);

/* ===========================
   🤝 PARTICIPATE TABLE
   • Stores employee participation in productions
   =========================== */
CREATE TABLE participate(
    employee_id NUMBER,
    studio_id NUMBER,
    content_id NUMBER,
    role VARCHAR2(50),
    participation_begin TIMESTAMP,
    participation_end TIMESTAMP,
    CONSTRAINT participate_pk PRIMARY KEY(employee_id, studio_id, content_id),
    CONSTRAINT participate_employee_fk FOREIGN KEY(employee_id) REFERENCES employee(employee_id),
    CONSTRAINT participate_production_fk FOREIGN KEY(studio_id, content_id) REFERENCES production(studio_id, content_id),
    CONSTRAINT participate_role_nn CHECK(role IS NOT NULL),
    CONSTRAINT participate_begin_nn CHECK(participation_begin IS NOT NULL),
    CONSTRAINT participate_end_nn CHECK(participation_end IS NOT NULL),
    CONSTRAINT participate_end_after_begin CHECK(participation_end > participation_begin)
);
