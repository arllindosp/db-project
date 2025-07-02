-- Comandos utilizados: ALTER TABLE
-- Objetivo: Adicionar uma nova coluna para armazenar o e-mail dos funcionários.
ALTER TABLE employee ADD (email VARCHAR2(100));

-- Comandos utilizados: INSERT INTO
-- Objetivo: Inserir uma nova temporada para um programa com id = 2.
INSERT INTO season (id_program, season_status)
VALUES (2, 'ongoing');

-- Comandos utilizados: UPDATE
-- Objetivo: Atualizar o salário dos funcionários, aumentando em 10%.
UPDATE employee
SET employee_salary = employee_salary * 1.10;

-- Comandos utilizados: DELETE
-- Objetivo: Remover a temporada 2 do programa com id = 2;
DELETE FROM season
WHERE season_number = 2 AND id_program = 2;

-- Comandos utilizados: CREATE INDEX
-- Objetivo: Criar um índice para otimizar buscas pela audiência das transmissões.
CREATE INDEX idx_broadcast_reach_audience ON broadcast(reach_audience);

-- Comandos utilizados: SELECT, INNER JOIN, WHERE, ORDER BY
-- Objetivo: Retornar todos os episódios do programa 'Brincando e Aprendendo' com detalhes.
SELECT E.episode_number, E.season_number, C.content_title, C.content_duration, C.content_production_status
FROM program P
INNER JOIN episode E ON E.id_program = P.id
INNER JOIN content C ON C.content_id = E.content_id
WHERE P.nome = 'Brincando e Aprendendo';

-- Comandos utilizados: SELECT, COUNT, INNER JOIN, GROUP BY
-- Objetivo: Contar o número de temporadas de cada programa.
SELECT P.nome, COUNT(S.season_number) AS number_of_seasons
FROM SEASON S
INNER JOIN program P ON P.id = S.id_program
GROUP BY P.nome;

-- Funcionários que são chefes (sem supervisor)
SELECT E.employee_name, E.employee_salary
FROM employee E 
WHERE employee_supervisor IS NULL;

-- Comandos utilizados: SELECT, AVG, LEFT JOIN, RIGHT JOIN, GROUP BY
-- Objetivo: Calcular a audiência média de cada conteúdo, considerando interrupções e transmissões.
SELECT C.content_title, AVG(BD.reach_audience) AS average_audience
FROM broadcast BD
LEFT JOIN interrupt I ON I.content_id = BD.content_id
RIGHT JOIN content C ON (C.content_id = BD.content_id OR C.content_ID = I.advertisement_ID)
GROUP BY C.content_title;

-- Comandos utilizados: SELECT, INNER JOIN, WHERE, SUBCONSULTA, MIN
-- Objetivo: Listar o(s) conteúdo(s) com a menor audiência registrada.
SELECT C.content_title, BD.reach_audience, BD.broadcast_begin_time, BD.broadcast_end_time
FROM content C
INNER JOIN broadcast BD ON BD.content_id = C.content_id
WHERE BD.reach_audience = (SELECT MIN(broadcast.reach_audience) FROM broadcast);

-- Comandos utilizados: SELECT, INNER JOIN, WHERE, BETWEEN, UNION, ORDER BY
-- Objetivo: Listar conteúdos exibidos ou interrompidos no canal 12 em um intervalo de tempo específico.
SELECT C.content_title, BD.broadcast_begin_time AS begin_time
FROM broadcast BD
INNER JOIN content C ON C.content_id = BD.content_id
WHERE BD.channel_frequency = 12
  AND BD.broadcast_begin_time BETWEEN TO_TIMESTAMP('2025-07-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
                                 AND TO_TIMESTAMP('2025-07-01 09:20:00', 'YYYY-MM-DD HH24:MI:SS')
UNION
SELECT C.content_title, I.interruption_time AS begin_time
FROM interrupt I
INNER JOIN content C ON C.content_id = I.advertisement_id
WHERE I.channel_frequency = 12
  AND I.interruption_time BETWEEN TO_TIMESTAMP('2025-07-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
                            AND TO_TIMESTAMP('2025-07-01 09:20:00', 'YYYY-MM-DD HH24:MI:SS')
ORDER BY begin_time;

-- Comandos utilizados: SELECT, INNER JOIN, WHERE, LIKE
-- Objetivo: Listar todos os funcionários que atuam em funções que terminam com 'tor' (ex: Diretor, Apresentador).
SELECT E.employee_name, P.role
FROM employee E
INNER JOIN participate P ON P.employee_id = E.employee_id
WHERE P.role LIKE '%tor';

-- Comandos utilizados: SELECT, INNER JOIN, WHERE, SUBCONSULTA, ANY
-- Objetivo: Listar apresentadores cujo salário é maior que qualquer apresentador do programa 'Show do Riso'.
SELECT employee_name, employee_salary
FROM employee E
INNER JOIN participate P ON P.employee_id = E.employee_id
WHERE P.role = 'Apresentador' AND employee_salary > ANY (
    SELECT E2.employee_salary
    FROM employee E2
    INNER JOIN participate P2 ON P2.employee_id = E2.employee_id
    INNER JOIN content C ON C.content_id = P2.content_id
    INNER JOIN episode EP ON EP.content_id = C.content_id
    INNER JOIN program PR ON PR.id = EP.id_program
    WHERE P2.role = 'Apresentador'
      AND PR.nome = 'Show do Riso'
);

-- Comandos utilizados: SELECT, INNER JOIN, COUNT, GROUP BY, ORDER BY
-- Objetivo: Contar o total de episódios por classificação indicativa dos programas.
SELECT P.classifc_ind, COUNT(EP.episode_number) as total_episodios
FROM program P
INNER JOIN episode EP ON EP.id_program = P.id
GROUP BY P.classifc_ind
ORDER BY P.classifc_ind;

-- Comandos utilizados: SELECT, SUBCONSULTA, MAX, MIN
-- Objetivo: Calcular a maior e menor duração de produção entre todas as produções.
SELECT MAX(PRODUCTION_DURATION) AS MAX_PRODUCTION_DURATION, MIN(PRODUCTION_DURATION) AS MIN_PRODUCTION_DURATION
FROM (SELECT (PR.PRODUCTION_END - PR.PRODUCTION_BEGIN) AS PRODUCTION_DURATION
        FROM production PR);

-- Comandos utilizados: SELECT DISTINCT, INNER JOIN, WHERE, IN, ORDER BY
-- Objetivo: Listar anunciantes e campanhas em que participaram, exceto 'Supermercados BomLar', considerando campanhas em que 'Supermercados BomLar' também participou.
SELECT DISTINCT A.advertiser_name, C.campaign_name
FROM advertiser A
INNER JOIN promote P ON P.advertiser_id = A.advertiser_id
INNER JOIN campaign C ON C.campaign_id = P.campaign_id
WHERE A.advertiser_name <> 'Supermercados BomLar' AND C.campaign_id IN (
    SELECT C2.campaign_id
    FROM campaign C2
    INNER JOIN promote P2 ON P2.campaign_id = C2.campaign_id
    INNER JOIN advertiser A2 ON A2.advertiser_id = P2.advertiser_id
    WHERE A2.advertiser_name = 'Supermercados BomLar'
)
ORDER BY A.advertiser_name;

-- Comandos utilizados: SELECT, INNER JOIN, AVG, GROUP BY, HAVING
-- Objetivo: Listar programas cuja audiência mínima em todas as transmissões é superior a 30.000.
SELECT P.nome, AVG(BD.reach_audience) AS avg_program_audience
FROM program P
INNER JOIN episode EP ON EP.id_program = P.id
INNER JOIN broadcast BD ON BD.content_id = EP.content_id
GROUP BY P.nome
HAVING MIN(BD.reach_audience) > 30000;

-- Comandos utilizados: SELECT, INNER JOIN, WHERE, SUBCONSULTA, ALL
-- Objetivo: Listar anunciantes cujo orçamento de promoção é maior que todos os orçamentos das campanhas do anunciante 'Sorvetes Polar'.
SELECT A.advertiser_name, P.promotion_budget
FROM advertiser A
INNER JOIN promote P ON P.advertiser_id = A.advertiser_id
WHERE P.promotion_budget > ALL (
    SELECT P2.promotion_budget
    FROM promote P2
    INNER JOIN advertiser A2 ON A2.advertiser_id = P2.advertiser_id
    WHERE A2.advertiser_name = 'Sorvetes Polar'
);

-- View com informações resumidas dos programas
CREATE OR REPLACE VIEW vw_program_summary AS
SELECT 
    p.nome AS programa,
    p.classifc_ind AS classificacao,
    COUNT(DISTINCT s.season_number) AS total_temporadas,
    COUNT(e.content_id) AS total_episodios,
    AVG(c.content_duration) AS duracao_media
FROM program p
LEFT JOIN season s ON p.id = s.id_program
LEFT JOIN episode e ON p.id = e.id_program
LEFT JOIN content c ON e.content_id = c.content_id
GROUP BY p.nome, p.classifc_ind;

-- =====================================================
-- GRANT / REVOKE - Controle de acesso
-- =====================================================

-- OBS: Como mencionado, GRANT/REVOKE não funciona no Oracle Live SQL
-- Mas aqui estão os comandos que seriam usados:

/*
-- Concedendo permissões de SELECT para usuário consultor
GRANT SELECT ON program TO consultor_emissora;
GRANT SELECT ON episode TO consultor_emissora;
GRANT SELECT ON broadcast TO consultor_emissora;

-- Concedendo permissões limitadas para usuário editor
GRANT SELECT, INSERT, UPDATE ON content TO editor_programas;
GRANT SELECT, INSERT, UPDATE ON episode TO editor_programas;

-- Revogando permissões
REVOKE INSERT, UPDATE ON content FROM editor_programas;
REVOKE ALL ON program FROM consultor_emissora;

-- Concedendo acesso à view resumida
GRANT SELECT ON vw_program_summary TO publico_geral;
*/