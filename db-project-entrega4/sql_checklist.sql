-- =====================================================
-- 1. ALTER TABLE - Modificações estruturais
-- =====================================================

-- Adicionando nova coluna para armazenar rating dos programas
ALTER TABLE program ADD (
    rating_average NUMBER(3,2),
    total_episodes NUMBER(4) DEFAULT 0
);

-- Modificando tamanho da coluna de nome do programa
ALTER TABLE program MODIFY (
    nome VARCHAR2(100)
);

-- Adicionando constraint para validar rating
ALTER TABLE program ADD CONSTRAINT chk_rating_range 
    CHECK (rating_average BETWEEN 0.00 AND 10.00);

-- Adicionando nova coluna para orçamento dos episódios
ALTER TABLE content ADD (
    production_budget NUMBER(10,2),
    content_type VARCHAR2(20) DEFAULT 'EPISODE'
);

-- =====================================================
-- 2. CREATE INDEX - Otimização de consultas
-- =====================================================

-- Índice para busca rápida por nome de programa
CREATE INDEX idx_program_nome ON program(nome);

-- Índice composto para consultas por gênero e classificação
CREATE INDEX idx_program_genre_class ON program(classifc_ind);

-- Índice para busca de funcionários por supervisor
CREATE INDEX idx_employee_supervisor ON employee(employee_supervisor);

-- Índice para otimizar consultas de transmissão por data
CREATE INDEX idx_broadcast_time ON broadcast(broadcast_begin_time);

-- Índice único para frequência de canal
CREATE UNIQUE INDEX idx_channel_frequency ON channel(frequency);

-- =====================================================
-- 3. INSERT INTO - Inserção de dados
-- =====================================================

-- Inserindo novos programas de diferentes gêneros
INSERT INTO program (nome, classifc_ind) VALUES ('Tech News 2025', 10);
INSERT INTO program (nome, classifc_ind) VALUES ('Esporte Total', 0);
INSERT INTO program (nome, classifc_ind) VALUES ('Cine Arte', 16);

-- Inserindo novos funcionários especializados
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (26, 8000, 2, 'Carla Santos - Editora Sênior');

INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (27, 7500, 3, 'Roberto Lima - Técnico de Som');

-- Inserindo novo anunciante do setor tecnológico
INSERT INTO advertiser (advertiser_name) VALUES ('InnovaTech Solutions');

-- =====================================================
-- 4. UPDATE - Atualização de dados
-- =====================================================

-- Atualizando salários dos supervisores (aumento de 10%)
UPDATE employee 
SET employee_salary = employee_salary * 1.10 
WHERE employee_supervisor = 1;

-- Atualizando classificação indicativa de programas infantis
UPDATE program 
SET classifc_ind = 0 
WHERE nome LIKE '%Brincando%' OR nome LIKE '%Infantil%';

-- Atualizando orçamento de produções de alto custo
UPDATE production 
SET production_cost = production_cost * 1.15 
WHERE production_cost > 6000;

-- =====================================================
-- 5. DELETE - Exclusão de dados
-- =====================================================

-- Removendo campanhas sem anúncios associados
DELETE FROM campaign 
WHERE campaign_id NOT IN (
    SELECT DISTINCT campaign_id 
    FROM promote 
    WHERE campaign_id IS NOT NULL
);

-- Removendo participações que já terminaram há mais de 1 ano
DELETE FROM participate 
WHERE participation_end < ADD_MONTHS(SYSDATE, -12);

-- =====================================================
-- 6. SELECT-FROM-WHERE - Consultas básicas
-- =====================================================

-- Programas com classificação para adultos
SELECT nome, classifc_ind 
FROM program 
WHERE classifc_ind >= 16;

-- Funcionários com salário acima da média
SELECT employee_name, employee_salary 
FROM employee 
WHERE employee_salary > (SELECT AVG(employee_salary) FROM employee);

-- Episódios com duração superior a 45 minutos
SELECT c.content_title, c.content_duration 
FROM content c 
INNER JOIN episode e ON c.content_id = e.content_id 
WHERE c.content_duration > 45;

-- =====================================================
-- 7. BETWEEN - Consultas com intervalo
-- =====================================================

-- Programas com classificação entre 12 e 16 anos
SELECT nome, classifc_ind 
FROM program 
WHERE classifc_ind BETWEEN 12 AND 16;

-- Funcionários com salário na faixa intermediária
SELECT employee_name, employee_salary 
FROM employee 
WHERE employee_salary BETWEEN 5000 AND 15000;

-- Transmissões de julho de 2025
SELECT c.content_title, b.broadcast_begin_time 
FROM content c 
INNER JOIN broadcast b ON c.content_id = b.content_id 
WHERE b.broadcast_begin_time BETWEEN 
    TO_TIMESTAMP('2025-07-01', 'YYYY-MM-DD') AND 
    TO_TIMESTAMP('2025-07-31', 'YYYY-MM-DD');

-- =====================================================
-- 8. IN - Consultas com lista de valores
-- =====================================================

-- Programas de gêneros específicos
SELECT p.nome, g.nome AS genero 
FROM program p 
INNER JOIN genre g ON p.id = g.program_id 
WHERE g.nome IN ('Drama', 'Suspense', 'Jornalismo');

-- Funcionários supervisores diretos
SELECT employee_name, employee_salary 
FROM employee 
WHERE employee_id IN (2, 3, 4, 5);

-- Canais principais da emissora
SELECT channel_name, frequency 
FROM channel 
WHERE frequency IN (12, 21, 25);

-- =====================================================
-- 9. LIKE - Consultas com padrões de texto
-- =====================================================

-- Programas que começam com 'Café'
SELECT nome, classifc_ind 
FROM program 
WHERE nome LIKE 'Café%';

-- Funcionários com nome que contém 'Silva'
SELECT employee_name, employee_salary 
FROM employee 
WHERE employee_name LIKE '%Silva%';

-- Anúncios de produtos tecnológicos
SELECT c.content_title 
FROM content c 
INNER JOIN advertisement a ON c.content_id = a.advertisement_id 
WHERE c.content_title LIKE '%TecnoMais%' OR c.content_title LIKE '%Smartphone%';

-- =====================================================
-- 10. IS NULL ou IS NOT NULL - Consultas com valores nulos
-- =====================================================

-- Funcionários que são chefes (sem supervisor)
SELECT employee_name, employee_salary 
FROM employee 
WHERE employee_supervisor IS NULL;

-- Funcionários que têm supervisor
SELECT employee_name, employee_salary, employee_supervisor 
FROM employee 
WHERE employee_supervisor IS NOT NULL;

-- Programas sem rating definido
SELECT nome 
FROM program 
WHERE rating_average IS NULL;

-- =====================================================
-- 11. INNER JOIN - Junção interna
-- =====================================================

-- Episódios com informações do programa
SELECT p.nome AS programa, c.content_title AS episodio, c.content_duration 
FROM program p 
INNER JOIN episode e ON p.id = e.id_program 
INNER JOIN content c ON e.content_id = c.content_id;

-- Funcionários e seus supervisores
SELECT f.employee_name AS funcionario, s.employee_name AS supervisor 
FROM employee f 
INNER JOIN employee s ON f.employee_supervisor = s.employee_id;

-- Anúncios com suas campanhas
SELECT c.content_title, cp.campaign_name, a.target_audience 
FROM content c 
INNER JOIN advertisement a ON c.content_id = a.advertisement_id 
INNER JOIN promote pr ON a.advertisement_id = pr.advertisement_id 
INNER JOIN campaign cp ON pr.campaign_id = cp.campaign_id;

-- =====================================================
-- 12. MAX - Valor máximo
-- =====================================================

-- Maior salário da emissora
SELECT MAX(employee_salary) AS maior_salario 
FROM employee;

-- Programa com maior número de temporadas
SELECT p.nome, MAX(s.season_number) AS max_temporadas 
FROM program p 
INNER JOIN season s ON p.id = s.id_program 
GROUP BY p.nome 
ORDER BY max_temporadas DESC;

-- Episódio mais longo
SELECT content_title, MAX(content_duration) AS maior_duracao 
FROM content c 
INNER JOIN episode e ON c.content_id = e.content_id 
GROUP BY content_title 
ORDER BY maior_duracao DESC;

-- =====================================================
-- 13. MIN - Valor mínimo
-- =====================================================

-- Menor salário da emissora
SELECT MIN(employee_salary) AS menor_salario 
FROM employee;

-- Programa com menor classificação indicativa
SELECT nome, MIN(classifc_ind) AS menor_classificacao 
FROM program 
GROUP BY nome 
ORDER BY menor_classificacao;

-- Anúncio mais curto
SELECT content_title, MIN(content_duration) AS menor_duracao 
FROM content c 
INNER JOIN advertisement a ON c.content_id = a.advertisement_id 
GROUP BY content_title 
ORDER BY menor_duracao;

-- =====================================================
-- 14. AVG - Média
-- =====================================================

-- Salário médio por nível hierárquico
SELECT 
    CASE 
        WHEN employee_supervisor IS NULL THEN 'Chefe'
        WHEN employee_id IN (2,3,4,5) THEN 'Supervisor'
        ELSE 'Funcionário'
    END AS nivel,
    AVG(employee_salary) AS salario_medio
FROM employee 
GROUP BY 
    CASE 
        WHEN employee_supervisor IS NULL THEN 'Chefe'
        WHEN employee_id IN (2,3,4,5) THEN 'Supervisor'
        ELSE 'Funcionário'
    END;

-- Duração média dos episódios por programa
SELECT p.nome, AVG(c.content_duration) AS duracao_media 
FROM program p 
INNER JOIN episode e ON p.id = e.id_program 
INNER JOIN content c ON e.content_id = c.content_id 
GROUP BY p.nome;

-- Custo médio de produção por estúdio
SELECT s.studio_name, AVG(pr.production_cost) AS custo_medio 
FROM studio s 
INNER JOIN production pr ON s.studio_id = pr.studio_id 
GROUP BY s.studio_name;

-- =====================================================
-- 15. COUNT - Contagem
-- =====================================================

-- Número de funcionários por supervisor
SELECT s.employee_name AS supervisor, COUNT(f.employee_id) AS total_subordinados 
FROM employee s 
LEFT JOIN employee f ON s.employee_id = f.employee_supervisor 
GROUP BY s.employee_name 
ORDER BY total_subordinados DESC;

-- Número de episódios por programa
SELECT p.nome, COUNT(e.content_id) AS total_episodios 
FROM program p 
LEFT JOIN episode e ON p.id = e.id_program 
GROUP BY p.nome 
ORDER BY total_episodios DESC;

-- Número de anúncios por anunciante
SELECT ad.advertiser_name, COUNT(a.advertisement_id) AS total_anuncios 
FROM advertiser ad 
LEFT JOIN promote pr ON ad.advertiser_id = pr.advertiser_id 
LEFT JOIN advertisement a ON pr.advertisement_id = a.advertisement_id 
GROUP BY ad.advertiser_name;

-- =====================================================
-- 16. LEFT ou RIGHT ou FULL OUTER JOIN - Junções externas
-- =====================================================

-- LEFT JOIN: Todos os programas e seus gêneros (mesmo sem gênero)
SELECT p.nome, g.nome AS genero 
FROM program p 
LEFT JOIN genre g ON p.id = g.program_id 
ORDER BY p.nome;

-- RIGHT JOIN: Todos os funcionários e suas participações
SELECT e.employee_name, c.content_title 
FROM participate pa 
RIGHT JOIN employee e ON pa.employee_id = e.employee_id 
LEFT JOIN content c ON pa.content_id = c.content_id;

-- FULL OUTER JOIN: Programas e temporadas (incluindo dados ausentes)
SELECT p.nome, s.season_number, s.season_status 
FROM program p 
FULL OUTER JOIN season s ON p.id = s.id_program 
ORDER BY p.nome, s.season_number;

-- =====================================================
-- 17. SUBCONSULTA COM OPERADOR RELACIONAL
-- =====================================================

-- Funcionários com salário maior que a média
SELECT employee_name, employee_salary 
FROM employee 
WHERE employee_salary > (
    SELECT AVG(employee_salary) FROM employee
);

-- Programas com mais episódios que o programa 'Café com Notícias'
SELECT p.nome, COUNT(e.content_id) AS total_episodios 
FROM program p 
INNER JOIN episode e ON p.id = e.id_program 
GROUP BY p.nome 
HAVING COUNT(e.content_id) > (
    SELECT COUNT(ep.content_id) 
    FROM program pr 
    INNER JOIN episode ep ON pr.id = ep.id_program 
    WHERE pr.nome = 'Café com Notícias'
);

-- Estúdios com custo de manutenção acima da média
SELECT studio_name, maintenance_cost 
FROM studio 
WHERE maintenance_cost > (
    SELECT AVG(maintenance_cost) FROM studio
);

-- =====================================================
-- 18. SUBCONSULTA COM IN
-- =====================================================

-- Funcionários que participaram de produções
SELECT employee_name 
FROM employee 
WHERE employee_id IN (
    SELECT DISTINCT employee_id FROM participate
);

-- Programas que têm episódios produzidos
SELECT nome 
FROM program 
WHERE id IN (
    SELECT DISTINCT e.id_program 
    FROM episode e 
    INNER JOIN production pr ON e.content_id = pr.content_id
);

-- Anunciantes que têm campanhas ativas
SELECT advertiser_name 
FROM advertiser 
WHERE advertiser_id IN (
    SELECT DISTINCT advertiser_id FROM promote
);

-- =====================================================
-- 19. SUBCONSULTA COM ANY
-- =====================================================

-- Funcionários com salário maior que qualquer supervisor
SELECT employee_name, employee_salary 
FROM employee 
WHERE employee_salary > ANY (
    SELECT employee_salary 
    FROM employee 
    WHERE employee_id IN (2, 3, 4, 5)
);

-- Programas com classificação maior que qualquer programa infantil
SELECT nome, classifc_ind 
FROM program 
WHERE classifc_ind > ANY (
    SELECT classifc_ind 
    FROM program 
    WHERE classifc_ind = 0
);

-- Estúdios com capacidade maior que qualquer estúdio do centro
SELECT s.studio_name, s.studio_capacity 
FROM studio s 
INNER JOIN studio_address sa ON s.address_id = sa.address_id 
WHERE s.studio_capacity > ANY (
    SELECT st.studio_capacity 
    FROM studio st 
    INNER JOIN studio_address sta ON st.address_id = sta.address_id 
    WHERE sta.neighborhood = 'Centro'
);

-- =====================================================
-- 20. SUBCONSULTA COM ALL
-- =====================================================

-- Funcionários com salário maior que todos os funcionários subordinados
SELECT e1.employee_name, e1.employee_salary 
FROM employee e1 
WHERE e1.employee_salary > ALL (
    SELECT e2.employee_salary 
    FROM employee e2 
    WHERE e2.employee_supervisor = e1.employee_id
) AND e1.employee_id IN (
    SELECT DISTINCT employee_supervisor 
    FROM employee 
    WHERE employee_supervisor IS NOT NULL
);

-- Programas com mais temporadas que todos os programas infantis
SELECT p.nome, COUNT(s.season_number) AS total_temporadas 
FROM program p 
INNER JOIN season s ON p.id = s.id_program 
GROUP BY p.nome 
HAVING COUNT(s.season_number) > ALL (
    SELECT COUNT(se.season_number) 
    FROM program pr 
    INNER JOIN season se ON pr.id = se.id_program 
    WHERE pr.classifc_ind = 0 
    GROUP BY pr.id
);

-- =====================================================
-- 21. ORDER BY - Ordenação
-- =====================================================

-- Funcionários ordenados por salário (decrescente)
SELECT employee_name, employee_salary 
FROM employee 
ORDER BY employee_salary DESC;

-- Programas ordenados por nome (alfabética)
SELECT nome, classifc_ind 
FROM program 
ORDER BY nome ASC;

-- Transmissões ordenadas por data e hora
SELECT c.content_title, b.broadcast_begin_time, ch.channel_name 
FROM content c 
INNER JOIN broadcast b ON c.content_id = b.content_id 
INNER JOIN channel ch ON b.channel_frequency = ch.frequency 
ORDER BY b.broadcast_begin_time DESC, ch.channel_name;

-- =====================================================
-- 22. GROUP BY - Agrupamento
-- =====================================================

-- Total de episódios por programa
SELECT p.nome, COUNT(e.content_id) AS total_episodios 
FROM program p 
LEFT JOIN episode e ON p.id = e.id_program 
GROUP BY p.nome;

-- Receita total por canal
SELECT ch.channel_name, SUM(b.broadcast_revenue) AS receita_total 
FROM channel ch 
INNER JOIN broadcast b ON ch.frequency = b.channel_frequency 
GROUP BY ch.channel_name;

-- Custo médio de produção por tipo de conteúdo
SELECT 
    CASE 
        WHEN a.advertisement_id IS NOT NULL THEN 'Anúncio'
        ELSE 'Episódio'
    END AS tipo_conteudo,
    AVG(pr.production_cost) AS custo_medio
FROM content c 
LEFT JOIN advertisement a ON c.content_id = a.advertisement_id 
INNER JOIN production pr ON c.content_id = pr.content_id 
GROUP BY 
    CASE 
        WHEN a.advertisement_id IS NOT NULL THEN 'Anúncio'
        ELSE 'Episódio'
    END;

-- =====================================================
-- 23. HAVING - Filtro em agrupamentos
-- =====================================================

-- Programas com mais de 5 episódios
SELECT p.nome, COUNT(e.content_id) AS total_episodios 
FROM program p 
INNER JOIN episode e ON p.id = e.id_program 
GROUP BY p.nome 
HAVING COUNT(e.content_id) > 5;

-- Supervisores com mais de 4 subordinados
SELECT s.employee_name, COUNT(f.employee_id) AS total_subordinados 
FROM employee s 
INNER JOIN employee f ON s.employee_id = f.employee_supervisor 
GROUP BY s.employee_name 
HAVING COUNT(f.employee_id) > 4;

-- Anunciantes com orçamento total acima de 5000
SELECT ad.advertiser_name, SUM(pr.promotion_budget) AS orcamento_total 
FROM advertiser ad 
INNER JOIN promote pr ON ad.advertiser_id = pr.advertiser_id 
GROUP BY ad.advertiser_name 
HAVING SUM(pr.promotion_budget) > 5000;

-- =====================================================
-- 24. UNION ou INTERSECT ou MINUS
-- =====================================================

-- UNION: Todos os nomes (funcionários + programas)
SELECT employee_name AS nome, 'Funcionário' AS tipo FROM employee
UNION
SELECT nome AS nome, 'Programa' AS tipo FROM program
ORDER BY nome;

-- INTERSECT: Funcionários que são supervisores E têm supervisor
SELECT employee_name FROM employee WHERE employee_id IN (2,3,4,5)
INTERSECT
SELECT employee_name FROM employee WHERE employee_supervisor IS NOT NULL;

-- MINUS: Programas que não têm temporadas
SELECT nome FROM program
MINUS
SELECT p.nome FROM program p INNER JOIN season s ON p.id = s.id_program;

-- =====================================================
-- 25. CREATE VIEW - Visões
-- =====================================================

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

-- View com hierarquia de funcionários
CREATE OR REPLACE VIEW vw_employee_hierarchy AS
SELECT 
    f.employee_name AS funcionario,
    f.employee_salary AS salario,
    s.employee_name AS supervisor,
    CASE 
        WHEN f.employee_supervisor IS NULL THEN 'Chefe'
        WHEN f.employee_id IN (2,3,4,5) THEN 'Supervisor'
        ELSE 'Funcionário'
    END AS nivel_hierarquico
FROM employee f
LEFT JOIN employee s ON f.employee_supervisor = s.employee_id;

-- View com estatísticas de audiência por canal
CREATE OR REPLACE VIEW vw_channel_stats AS
SELECT 
    ch.channel_name,
    ch.frequency,
    COUNT(b.content_id) AS total_transmissoes,
    SUM(b.reach_audience) AS audiencia_total,
    AVG(b.reach_audience) AS audiencia_media,
    SUM(b.broadcast_revenue) AS receita_total
FROM channel ch
LEFT JOIN broadcast b ON ch.frequency = b.channel_frequency
GROUP BY ch.channel_name, ch.frequency;

-- =====================================================
-- 26. GRANT / REVOKE - Controle de acesso
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

-- =====================================================
-- CONSULTAS DEMONSTRATIVAS DAS VIEWS CRIADAS
-- =====================================================

-- Usando a view de resumo dos programas
SELECT * FROM vw_program_summary 
ORDER BY total_episodios DESC;

-- Usando a view de hierarquia
SELECT * FROM vw_employee_hierarchy 
ORDER BY nivel_hierarquico, salario DESC;

-- Usando a view de estatísticas de canal
SELECT * FROM vw_channel_stats 
ORDER BY receita_total DESC;

