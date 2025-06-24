/*
=========================================================
️🗳️ Inserts do Banco de Dados Emissora TV/Rádio - UFPE CIn 2025.1

Este script contém comandos INSERT para popular as tabelas
do banco de dados com dados de exemplo para testes e validação.
=========================================================
*/

DELETE FROM season WHERE id_program IN (SELECT id FROM program WHERE nome = 'Todo mundo odeia Pedro Moraes');
DELETE FROM season WHERE id_program IN (SELECT id FROM program WHERE nome = 'Eu, pedro e as crianças');
DELETE FROM episode
WHERE id_program IN (
    SELECT id FROM program WHERE nome = 'Todo mundo odeia Pedro Moraes'
);
DELETE FROM content WHERE content_title = 'Episódio Piloto'; -- ou outro título inserido
DELETE FROM program WHERE nome = 'Todo mundo odeia Pedro Moraes';
DELETE FROM program Where nome = 'Eu, pedro e as crianças';
DELETE FROM season WHERE id_program IN (SELECT id FROM program WHERE nome = 'Todo mundo odeia Pedro Moraes');
DELETE FROM program WHERE nome = 'Todo mundo odeia Pedro Moraes';


--  • Criando o programa
INSERT INTO program (nome, classifc_ind) VALUES ('Todo mundo odeia Pedro Moraes', '10');

--  • Insere os gêneros associados ao programa "Todo mundo odeia Pedro Moraes"
INSERT INTO genre (program_id, nome) 
SELECT id, 'terror'
FROM program
WHERE nome = 'Todo mundo odeia Pedro Moraes';

INSERT INTO genre (program_id, nome) 
SELECT id, 'comédia'
FROM program
WHERE nome = 'Todo mundo odeia Pedro Moraes';

-- Atualiza a tabela auxiliar season_copy com os dados atuais da tabela season.
-- Necessário para que a trigger de season utilize informações atualizadas e evite problemas de mutating table.
TRUNCATE TABLE season_copy;
INSERT INTO season_copy
SELECT * FROM season;

-- • Insere as temporadas associadas ao programa "Todo mundo odeia Pedro Moraes"
INSERT INTO season (id_program, season_status)
SELECT id, 'finished'
FROM program
WHERE nome = 'Todo mundo odeia Pedro Moraes';

TRUNCATE TABLE season_copy;
INSERT INTO season_copy
SELECT * FROM season;

INSERT INTO season (id_program, season_status)
SELECT id, 'ongoing'
FROM program
WHERE nome = 'Todo mundo odeia Pedro Moraes';

-- • Insere os episódios associadas ao programa "Todo mundo odeia Pedro Moraes";
-- Episódio 1
INSERT INTO content (content_duration,content_title) VALUES (45,'Episódio Piloto' );
TRUNCATE TABLE episode_copy;

DECLARE
    v_content_id NUMBER;
    v_id_program NUMBER;
    v_season_number NUMBER;
BEGIN
    SELECT content_seq.CURRVAL INTO v_content_id FROM DUAL;
    SELECT s.id_program, s.season_number
    INTO v_id_program, v_season_number
    FROM season s
    JOIN program p ON s.id_program = p.id
    WHERE p.nome = 'Todo mundo odeia Pedro Moraes'
      AND s.season_number = 1;

    INSERT INTO episode_copy SELECT * FROM episode;

    INSERT INTO episode(content_id, id_program, season_number)
    VALUES (v_content_id, v_id_program, v_season_number);
END;
/
-- Episódio 2
INSERT INTO content (content_duration, content_title) VALUES (44, 'Episódio 2: O Plano de Pedro');
    TRUNCATE TABLE episode_copy;
DECLARE
    v_content_id NUMBER;
    v_id_program NUMBER;
    v_season_number NUMBER;
BEGIN
    SELECT content_seq.CURRVAL INTO v_content_id FROM DUAL;
    SELECT s.id_program, s.season_number
    INTO v_id_program, v_season_number
    FROM season s
    JOIN program p ON s.id_program = p.id
    WHERE p.nome = 'Todo mundo odeia Pedro Moraes'
      AND s.season_number = 1;

    INSERT INTO episode_copy SELECT * FROM episode;

    INSERT INTO episode(content_id, id_program, season_number)
    VALUES (v_content_id, v_id_program, v_season_number);
END;
/

-- Episódio 3
INSERT INTO content (content_duration, content_title) VALUES (46, 'Episódio 3: A Festa Surpresa');
    TRUNCATE TABLE episode_copy;
DECLARE
    v_content_id NUMBER;
    v_id_program NUMBER;
    v_season_number NUMBER;
BEGIN
    SELECT content_seq.CURRVAL INTO v_content_id FROM DUAL;
    SELECT s.id_program, s.season_number
    INTO v_id_program, v_season_number
    FROM season s
    JOIN program p ON s.id_program = p.id
    WHERE p.nome = 'Todo mundo odeia Pedro Moraes'
      AND s.season_number = 1;

    INSERT INTO episode_copy SELECT * FROM episode;

    INSERT INTO episode(content_id, id_program, season_number)
    VALUES (v_content_id, v_id_program, v_season_number);
END;
/

/* ===========================
   📢 CRIANDO ANÚNCIOS
   =========================== */

-- 1. Cria um anunciante (advertiser)
INSERT INTO advertiser (advertiser_name) VALUES ( 'Aurora Perfumes');

-- 2. Cria uma campanha (campaign)
INSERT INTO campaign (campaign_description) VALUES ('Aurora Perfumes Summer Launch 2025');

-- 3. Cria um anúncio (advertisement) vinculado a um conteúdo
INSERT INTO content (content_duration, content_title) VALUES ( 10, 'Lançamento Perfume Aurora - Sinta a Nova Essência');

DECLARE
    v_content_id NUMBER;
BEGIN
    SELECT c.content_id INTO v_content_id 
    FROM content c
    WHERE c.content_title = 'Lançamento Perfume Aurora - Sinta a Nova Essência';
    INSERT INTO advertisement (content_id, target_audience) VALUES (v_content_id, 'Mulheres 18-35');
END;
/
DECLARE
    v_advertisement_id NUMBER;
    v_advertiser_id NUMBER;
    v_campaign_id NUMBER;

BEGIN
    SELECT c.campaign_id INTO v_campaign_id
    FROM campaign c
    WHERE c.campaign_description = 'Aurora Perfumes Summer Launch 2025';

    SELECT a.advertiser_id INTO v_advertiser_id
    FROM advertiser a
    WHERE a.advertiser_name = 'Aurora Perfumes';

    SELECT a.content_id INTO v_advertisement_id
    FROM advertisement a
    JOIN content c ON a.content_id = c.content_id
    WHERE c.content_title = 'Lançamento Perfume Aurora - Sinta a Nova Essência';

-- 4. Relaciona anúncio, anunciante e campanha na promote
    INSERT INTO promote (advertisement_id, advertiser_id, campaign_id) VALUES (v_advertisement_id,v_advertiser_id,v_campaign_id);
    
END;
/

-- Esta constraint garante que toda tupla em advertisement deve estar associada a uma tupla existente em promote,
-- ou seja, todo anúncio deve obrigatoriamente participar da relação ternária (advertisement, advertiser, campaign).
-- Isso reforça a participação total de advertisement na relação promote.
ALTER TABLE advertisement
ADD CONSTRAINT advertisement_promote_fk 
FOREIGN KEY (advertisement_id,advertiser_id,campaign_id)
REFERENCES promote(advertisement_id,advertiser_id,campaign_id)
DEFERRABLE INITIALLY DEFERRED;

DECLARE
    v_advertisement_id NUMBER;
    v_advertiser_id NUMBER;
    v_campaign_id NUMBER;

BEGIN
    SELECT c.campaign_id INTO v_campaign_id
    FROM campaign c
    WHERE c.campaign_description = 'Aurora Perfumes Summer Launch 2025';

    SELECT a.advertiser_id INTO v_advertiser_id
    FROM advertiser a
    WHERE a.advertiser_name = 'Aurora Perfumes';

    SELECT a.content_id INTO v_advertisement_id
    FROM advertisement a
    JOIN content c ON a.content_id = c.content_id
    WHERE c.content_title = 'Lançamento Perfume Aurora - Sinta a Nova Essência';

-- 4. Relaciona anúncio, anunciante e campanha na promote
    INSERT INTO promote (advertisement_id, advertiser_id, campaign_id) VALUES (v_advertisement_id,v_advertiser_id,v_campaign_id);
    
END;
/

-- Atualiza os campos de chave estrangeira em advertisement para garantir participação total na relação ternária promote
UPDATE advertisement a
SET (a.advertisement_id, a.advertiser_id, a.campaign_id) = (
    SELECT p.advertisement_id, p.advertiser_id, p.campaign_id
    FROM promote p
    WHERE p.advertisement_id = a.content_id
)
WHERE EXISTS (
    SELECT 1 FROM promote p WHERE p.advertisement_id = a.content_id
);

-- Insere o canal "Canal Globix" com frequência 101 e cria uma transmissão (broadcast)
-- do episódio "Episódio Piloto" nesse canal, das 20:00 às 21:00, para 10.000 espectadores.
INSERT INTO channel (frequency, channel_name) VALUES (101, 'Canal Globix');

DECLARE
    v_episode_content_id NUMBER;
BEGIN
    SELECT e.content_id
    INTO v_episode_content_id
    FROM episode e
    JOIN content c ON e.content_id = c.content_id
    WHERE c.content_title = 'Episódio Piloto';

    INSERT INTO broadcast (
        channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience
    ) VALUES (
        101, v_episode_content_id,
        TO_TIMESTAMP('2025-07-01 20:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-07-01 21:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        10000
    );
END;
/

DECLARE
    v_episode_content_id NUMBER;
    v_advertisement_content_id NUMBER;
BEGIN
    -- Get the content_id of the episode being broadcast
    SELECT e.content_id
    INTO v_episode_content_id
    FROM episode e
    JOIN content c ON e.content_id = c.content_id
    WHERE c.content_title = 'Episódio Piloto';

    -- Get the content_id of the advertisement
    SELECT c.content_id
    INTO v_advertisement_content_id
    FROM advertisement a
    JOIN content c ON a.content_id = c.content_id
    WHERE c.content_title = 'Lançamento Perfume Aurora - Sinta a Nova Essência';

    -- Insert the interruption
    INSERT INTO interrupt (
        content_id, channel_frequency, advertisement_id, interruption_time
    ) VALUES (
        v_episode_content_id,
        101,
        v_advertisement_content_id,
        TO_TIMESTAMP('2025-07-01 20:30:00', 'YYYY-MM-DD HH24:MI:SS')
    );
END;
/

select * from channel;
select * from ADVERTISEMENT;
select * from ADVERTISER;
SELECT * FROM PROGRAM;
SELECT * FROM season;
SELECT * FROM GENRE;
SELECT * FROM EPISODE;
SELECT * FROM ADVERTISEMENT;
SELECT * FROM BROADCAST;
SELECT * FROM INTERRUPT;


