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
DROP TABLE studio_address CASCADE CONSTRAINTS;
DROP TABLE campaign CASCADE CONSTRAINTS;
DROP TABLE advertiser CASCADE CONSTRAINTS;
DROP TABLE advertisement CASCADE CONSTRAINTS;
DROP TABLE episode CASCADE CONSTRAINTS;
DROP TABLE season CASCADE CONSTRAINTS;
DROP TABLE genre CASCADE CONSTRAINTS;
DROP TABLE program CASCADE CONSTRAINTS;
DROP TABLE content CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;

/* ===========================
   🟪 PROGRAM TABLE
   • Stores all TV programs and their classification
   =========================== */

CREATE TABLE program(
    id NUMBER,
    nome VARCHAR2(50),
    classifc_ind NUMBER,
    CONSTRAINT program_pkey PRIMARY KEY (id),
    CONSTRAINT program_nome_nn CHECK (nome IS NOT NULL),
    CONSTRAINT classInd_range CHECK (classifc_ind IN (0, 10, 12, 14, 16, 18)),
    CONSTRAINT classInd_nn CHECK(classifc_ind IS NOT NULL)
);
COMMENT ON TABLE program IS 'Tabela dos programas da emissora';
COMMENT ON COLUMN program.id IS 'Código de identicação do programa';
COMMENT ON COLUMN program.nome IS 'Nome de programa' ;
COMMENT ON COLUMN program.classifc_ind IS 'Classificação inditificativa do programa';

/* ===========================
   🎭 GENRE TABLE (Multivalued Attribute)
   • Stores all genres associated with each TV program
   =========================== */
CREATE TABLE genre(
    program_id NUMBER,
    nome VARCHAR2(50),
    CONSTRAINT genre_pkey PRIMARY KEY (program_id,nome),
    CONSTRAINT genre_fk FOREIGN KEY (program_id) REFERENCES program(id)
);
COMMENT ON TABLE genre IS 'Tabela que define o atributo composto "genre" da entidade programa';

/* ===========================
   📅 SEASON TABLE (Weak Entity)
   • Stores all seasons associated with each TV program
   =========================== */
CREATE TABLE season(
    id_program NUMBER,
    season_number NUMBER,
    season_status VARCHAR2(50),
    CONSTRAINT season_pkey PRIMARY KEY(id_program, season_number),
    CONSTRAINT season_program_fk FOREIGN KEY (id_program) REFERENCES program(id),
    CONSTRAINT seasonStatus_categories CHECK( season_status IN ('ongoing', 'finished')),
    CONSTRAINT seasonStatus_nn CHECK(season_status IS NOT NULL)
);
COMMENT ON TABLE season IS 'Tabela que define a entidade fraca "temporada"';

/* ===========================
   📦 CONTENT TABLE (Superentity)
    • Stores all content broadcasted by the station
   =========================== */
CREATE TABLE content(
    content_id NUMBER,
    content_duration NUMBER,
    content_title VARCHAR2(100),
    CONSTRAINT content_pk PRIMARY KEY(content_id),
    CONSTRAINT contentDuration_nn CHECK(content_duration IS NOT NULL),
    CONSTRAINT contentTitle_nn CHECK(content_title IS NOT NULL)
);
COMMENT ON TABLE content IS 'Tabela que define o conteúdo transmitido pela emissora';

/* ===========================
   🎬 EPISODE TABLE (Specialization of Content)
    • Stores all episodes associated with each season and program
   =========================== */
CREATE TABLE episode(
    id_c NUMBER,
    id_program NUMBER,
    season_number NUMBER,
    episode_number NUMBER,
    CONSTRAINT episode_pk PRIMARY KEY(id_c, id_program,season_number),
    CONSTRAINT episode_fk FOREIGN KEY (id_c) REFERENCES content(content_id),
    CONSTRAINT episode_season_fk FOREIGN KEY(id_program,season_number) REFERENCES season(id_program,season_number),
    CONSTRAINT episode_nn CHECK (episode_number IS NOT NULL),
    CONSTRAINT episode_range CHECK(episode_number > 0) 

);

/* ===========================
   🎯 CAMPAIGN TABLE
   • Stores all advertising campaigns purchased by advertisers
   =========================== */
CREATE TABLE advertisement(
    id_c NUMBER,
    target_audience VARCHAR2(100),
    CONSTRAINT advertisement_pk PRIMARY KEY(id_c),
    CONSTRAINT advertisement_fk FOREIGN KEY(id_c) REFERENCES content(content_id),
    CONSTRAINT target_audience_nn CHECK(target_audience IS  NOT NULL)

);

/* ===========================
   💼 ADVERTISER TABLE
   • Stores all advertisers (sponsors) for commercials
   =========================== */
CREATE TABLE advertiser (
    advertiser_id NUMBER,
    advertiser_name VARCHAR2(100),
    CONSTRAINT advertiser_pk PRIMARY KEY(advertiser_id),
    CONSTRAINT advertiser_name_nn CHECK(advertiser_name IS NOT NULL)
);
COMMENT ON TABLE advertiser IS 'Tabela que armazena os anunciantes (advertisers/sponsors) dos comerciais';
COMMENT ON COLUMN advertiser.advertiser_id IS 'Identificador único do anunciante';
COMMENT ON COLUMN advertiser.advertiser_name IS 'Nome do anunciante';

/* ===========================
   🎯 CAMPAIGN TABLE
   • Stores advertising campaigns purchased by advertisers
   =========================== */
CREATE TABLE campaign(
    campaign_id NUMBER,
    campaign_description VARCHAR2(1000),
    CONSTRAINT campaign_pk PRIMARY KEY(campaign_id),
    CONSTRAINT campaign_description_nn CHECK (campaign_description IS NOT NULL)
);
COMMENT ON TABLE campaign IS 'Tabela que armazena as campanhas publicitárias compradas pelos anunciantes';
COMMENT ON COLUMN campaign.campaign_id IS 'Identificador único da campanha publicitária';
COMMENT ON COLUMN campaign.campaign_description IS 'Detalhes/descrição detalhada da campanha publicitária';

/* ===========================
   🏠 ADDRESS TABLE
   • Stores addresses for studios
   =========================== */

CREATE TABLE studio_address(
    address_id NUMBER,
    neighborhood VARCHAR2(100),
    street VARCHAR2(100),
    address_numb NUMBER(10),
    CONSTRAINT address_pk PRIMARY KEY (address_id),
    CONSTRAINT neighborhood_nn CHECK(neighborhood IS NOT NULL),
    CONSTRAINT street_nn CHECK(street IS NOT NULL),
    CONSTRAINT address_numb CHECK(address_numb IS NOT NULL)
);
COMMENT ON TABLE studio_address IS 'Tabela que armazena endereços de estúdios';
COMMENT ON COLUMN studio_address.address_id IS 'Identificador único do endereço';
COMMENT ON COLUMN studio_address.neighborhood IS 'Bairro do endereço';
COMMENT ON COLUMN studio_address.street IS 'Rua do endereço';
COMMENT ON COLUMN studio_address.address_numb IS 'Número do endereço';

/* ===========================
   🏢 STUDIO TABLE
   • Stores all studios and links to address
   =========================== */

CREATE TABLE studio(
    studio_id NUMBER,
    studio_capacity NUMBER,
    maintenance_cost NUMBER,
    address_id NUMBER,
    CONSTRAINT studio_pk PRIMARY KEY(studio_id),
    CONSTRAINT studio_capacity_nn CHECK(studio_capacity IS NOT NULL),
    CONSTRAINT maintenance_cost_nn CHECK (maintenance_cost IS NOT NULL),
    CONSTRAINT studio_fk FOREIGN KEY(address_id) REFERENCES studio_address(address_id)
);
COMMENT ON TABLE studio IS 'Tabela que armazena os estúdios e seus endereços';
COMMENT ON COLUMN studio.studio_id IS 'Identificador único do estúdio';
COMMENT ON COLUMN studio.studio_capacity IS 'Capacidade máxima do estúdio';
COMMENT ON COLUMN studio.maintenance_cost IS 'Custo de manutenção do estúdio';
COMMENT ON COLUMN studio.address_id IS 'Referência ao endereço do estúdio';

CREATE TABLE promote(
    advertisement_id NUMBER,
    advertiser_id NUMBER,
    campaign_id NUMBER,
    CONSTRAINT promote_pk PRIMARY KEY(advertisement_id, advertiser_id, campaign_id),
    CONSTRAINT promote_advertisement_fk FOREIGN KEY(advertisement_id) REFERENCES advertisement(id_c),
    CONSTRAINT promote_advertiser_fk FOREIGN KEY(advertiser_id) REFERENCES advertiser(advertiser_id),
    CONSTRAINT promote_campaign_fk FOREIGN KEY(campaign_id) REFERENCES campaign(campaign_id)
);

COMMENT ON TABLE promote IS 'Tabela que relaciona campanhas publicitárias com anunciantes e conteúdos';
COMMENT ON COLUMN promote.advertisement_id IS 'Identificador do conteúdo publicitário';

CREATE TABLE channel(
    frequency NUMBER,
    channel_name VARCHAR2(70),
    CONSTRAINT channel_pk PRIMARY KEY(frequency),
    CONSTRAINT channel_name_nn CHECK(channel_name IS NOT NULL)
);

COMMENT ON TABLE channel IS 'Tabela que armazena os canais de transmissão';
COMMENT ON COLUMN channel.frequency IS 'Frequência do canal';

CREATE TABLE broadcast(
    channel_frequency NUMBER,
    content_id NUMBER,
    broadcast_begin_time TIMESTAMP,
    broadcast_end_time TIMESTAMP,
    reach_audience NUMBER,
    CONSTRAINT broadcast_pk PRIMARY KEY(channel_frequency, content_id),
    CONSTRAINT broadcast_channel_fk FOREIGN KEY(channel_frequency) REFERENCES channel(frequency),
    CONSTRAINT broadcast_content_fk FOREIGN KEY(content_id) REFERENCES content(content_id),
    CONSTRAINT broadcast_begin_time_nn CHECK(broadcast_begin_time IS NOT NULL),
    CONSTRAINT broadcast_end_time_nn CHECK(broadcast_end_time IS NOT NULL),
    CONSTRAINT broadcast_reach_audience_nn CHECK(reach_audience IS NOT NULL),
    CONSTRAINT broadcast_reach_audience_range CHECK(reach_audience >= 0)
);

COMMENT ON TABLE broadcast IS 'Tabela que armazena as transmissões de conteúdos nos canais';
COMMENT ON COLUMN broadcast.channel_frequency IS 'Frequência do canal de transmissão';
COMMENT ON COLUMN broadcast.content_id IS 'Identificador do conteúdo transmitido';
COMMENT ON COLUMN broadcast.broadcast_begin_time IS 'Horário de início da transmissão';
COMMENT ON COLUMN broadcast.broadcast_end_time IS 'Horário de término da transmissão';
COMMENT ON COLUMN broadcast.reach_audience IS 'Número de pessoas alcançadas pela transmissão';

CREATE TABLE interrupt(
    content_id NUMBER,
    channel_frequency NUMBER,
    advertisement_id NUMBER,
    interruption_time TIMESTAMP,
    CONSTRAINT interrupt_pk PRIMARY KEY(content_id, channel_frequency, advertisement_id),
    CONSTRAINT interrupt_broadcast_fk FOREIGN KEY(channel_frequency, content_id) REFERENCES broadcast(channel_frequency, content_id),
    CONSTRAINT interrupt_advertisement_fk FOREIGN KEY(advertisement_id) REFERENCES advertisement(id_c),
    CONSTRAINT interrupt_time_nn CHECK(interruption_time IS NOT NULL)
);
COMMENT ON TABLE interrupt IS 'Tabela que armazena as interrupções de conteúdos para anúncios';
COMMENT ON COLUMN interrupt.content_id IS 'Identificador do conteúdo interrompido';
COMMENT ON COLUMN interrupt.channel_frequency IS 'Frequência do canal onde ocorreu a interrupção';
COMMENT ON COLUMN interrupt.advertisement_id IS 'Identificador do anúncio exibido durante a interrupção';
COMMENT ON COLUMN interrupt.interruption_time IS 'Horário da interrupção para o anúncio';

CREATE TABLE production(
    studio_id NUMBER,
    content_id NUMBER,
    production_begin TIMESTAMP,
    production_end TIMESTAMP,
    CONSTRAINT production_pk PRIMARY KEY(studio_id, content_id),
    CONSTRAINT production_studio_fk FOREIGN KEY(studio_id) REFERENCES studio(studio_id),
    CONSTRAINT production_content_fk FOREIGN KEY(content_id) REFERENCES content(content_id),
    CONSTRAINT production_begin_nn CHECK(production_begin IS NOT NULL),
    CONSTRAINT production_end_nn CHECK(production_end IS NOT NULL),
    CONSTRAINT production_end_after_begin CHECK(production_end > production_begin)
);
COMMENT ON TABLE production IS 'Tabela que armazena as produções de conteúdos nos estúdios';
COMMENT ON COLUMN production.studio_id IS 'Identificador do estúdio onde o conteúdo foi produzido';
COMMENT ON COLUMN production.content_id IS 'Identificador do conteúdo produzido';
COMMENT ON COLUMN production.production_begin IS 'Horário de início da produção do conteúdo';
COMMENT ON COLUMN production.production_end IS 'Horário de término da produção do conteúdo';

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
COMMENT ON TABLE employee IS 'Tabela que armazena os funcionários da emissora';
COMMENT ON COLUMN employee.employee_id IS 'Identificador único do funcionário';
COMMENT ON COLUMN employee.employee_salary IS 'Salário do funcionário';
COMMENT ON COLUMN employee.employee_supervisor IS 'Identificador do supervisor do funcionário';
COMMENT ON COLUMN employee.employee_name IS 'Nome do funcionário';

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

COMMENT ON TABLE participate IS 'Tabela que armazena a participação dos funcionários nas produções';
COMMENT ON COLUMN participate.employee_id IS 'Identificador do funcionário que participa da produção';  
COMMENT ON COLUMN participate.studio_id IS 'Identificador do estúdio onde a produção ocorre';
COMMENT ON COLUMN participate.content_id IS 'Identificador do conteúdo produzido';
COMMENT ON COLUMN participate.role IS 'Função do funcionário na produção';
COMMENT ON COLUMN participate.participation_begin IS 'Horário de início da participação do funcionário na produção';
COMMENT ON COLUMN participate.participation_end IS 'Horário de término da participação do funcionário na produção';