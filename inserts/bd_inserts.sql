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
    
    TRUNCATE TABLE episode_copy;
    INSERT INTO episode_copy SELECT * FROM episode;

    INSERT INTO episode(id_c, id_program, season_number)
    VALUES (v_content_id, v_id_program, v_season_number);
END;
/
-- Episódio 2
INSERT INTO content (content_duration, content_title) VALUES (44, 'Episódio 2: O Plano de Pedro');
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

    TRUNCATE TABLE episode_copy;
    INSERT INTO episode_copy SELECT * FROM episode;

    INSERT INTO episode(id_c, id_program, season_number)
    VALUES (v_content_id, v_id_program, v_season_number);
END;
/

-- Episódio 3
INSERT INTO content (content_duration, content_title) VALUES (46, 'Episódio 3: A Festa Surpresa');
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

    TRUNCATE TABLE episode_copy;
    INSERT INTO episode_copy SELECT * FROM episode;

    INSERT INTO episode(id_c, id_program, season_number)
    VALUES (v_content_id, v_id_program, v_season_number);
END;
/

INSERT INTO program (nome, classifc_ind) VALUES ('Eu, pedro e as crianças', '10');


INSERT INTO season (id_program, season_status)
SELECT id, 'ongoing'
FROM program
WHERE nome = 'Todo mundo odeia Pedro Moraes';
TRUNCATE TABLE season_copy;

INSERT INTO season_copy
SELECT * FROM season;

INSERT INTO season (id_program, season_status)
SELECT id, 'ongoing'
FROM program
WHERE nome = 'Todo mundo odeia Pedoro Moraes';
TRUNCATE TABLE season_copy;

INSERT INTO season_copy
SELECT * FROM season;

INSERT INTO season(id_program,season_status)
SELECT id, 'ongoing'
FROM PROGRAM
WHERE nome = 'Eu, pedro e as crianças';
SELECT * FROM PROGRAM;
SELECT * FROM season;
SELECT * FROM GENRE;
SELECT * FROM EPISODE;




