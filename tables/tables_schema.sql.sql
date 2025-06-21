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
    program VARCHAR2(50),
    nome VARCHAR2(50),
    CONSTRAINT genre_pkey PRIMARY KEY (program,nome)
);
COMMENT ON TABLE genre IS 'Tabela que define o atributo composto "genre" da entidade programa';

/* ===========================
   📅 SEASON TABLE (Weak Entity)
   • Stores all seasons associated with each TV program
   =========================== */
CREATE TABLE season(
    id_program NUMBER,
    season_number NUMBER,
    season_status VARCHAR(50),
    CONSTRAINT season_pkey PRIMARY KEY(id_program, season_status),
    CONSTRAINT season_program_fk FOREIGN KEY (id_program) REFERENCES program(id),
    CONSTRAINT seasonStatus_categories CHECK( season_status IN ('ongoing', 'finished'))
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
CREATE TABLE commercial(
    id_c NUMBER,
    target_audience VARCHAR2(100),
    CONSTRAINT commercial_pk PRIMARY KEY(id_c),
    CONSTRAINT commercial_fk FOREIGN KEY(id_c) REFERENCES content(content_id),
    CONSTRAINT target_audience_nn CHECK(target_audience IS  NOT NULL)

);

/* ===========================
   💼 ADVERTISER TABLE
   • Stores all advertisers (sponsors) for commercials
   =========================== */
CREATE TABLE advertiser (
    advertiser_id NUMBER,
    advertiser_name VARCHAR(100),
    CONSTRAINT advertiser_pk PRIMARY KEY(advertiser_id),
    CONSTRAINT advertiser_name_nn CHECK(advertiser_name IS NOT NULL)
)COMMENT ON TABLE advertiser IS 'Tabela que armazena os anunciantes (advertisers/sponsors) dos comerciais';
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

CREATE TABLE adress(
    adress_id NUMBER,
    neighborhood VARCHAR(100),
    street VARCHAR(100),
    adress_numb NUMBER(10),
    CONSTRAINT adress_pk PRIMARY KEY (adress_id),
    CONSTRAINT neighborhood_nn CHECK(neighborhood IS NOT NULL),
    CONSTRAINT street_nn CHECK(street IS NOT NULL),
    CONSTRAINT adress_numb CHECK(adress_numb IS NOT NULL)
)
COMMENT ON TABLE address IS 'Tabela que armazena endereços de estúdios';
COMMENT ON COLUMN address.address_id IS 'Identificador único do endereço';
COMMENT ON COLUMN address.neighborhood IS 'Bairro do endereço';
COMMENT ON COLUMN address.street IS 'Rua do endereço';
COMMENT ON COLUMN address.address_numb IS 'Número do endereço';

/* ===========================
   🏢 STUDIO TABLE
   • Stores all studios and links to address
   =========================== */

CREATE TABLE studio(
    studio_id NUMBER,
    studio_capacity NUMBER,
    maintenance_cost NUMBER,
    adress_id NUMBER,
    CONSTRAINT studio_pk PRIMARY KEY(studio_id),
    CONSTRAINT studio_capacity_nn CHECK(studio_capacity IS NOT NULL),
    CONSTRAINT maintenance_cost_nn CHECK (maintenance_cost IS NOT NULL),
    CONSTRAINT studio_fk FOREIGN KEY(adress_id) REFERENCES adress(adress_id)
)
COMMENT ON TABLE studio IS 'Tabela que armazena os estúdios e seus endereços';
COMMENT ON COLUMN studio.studio_id IS 'Identificador único do estúdio';
COMMENT ON COLUMN studio.studio_capacity IS 'Capacidade máxima do estúdio';
COMMENT ON COLUMN studio.maintenance_cost IS 'Custo de manutenção do estúdio';
COMMENT ON COLUMN studio.adress_id IS 'Referência ao endereço do estúdio';