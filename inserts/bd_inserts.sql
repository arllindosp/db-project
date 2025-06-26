-- INSERINDO PROGRAMAS (NÃO INFORME O 'id' e NÃO USE number_of_seasons)
INSERT INTO program (nome, classifc_ind) VALUES ('Café com Notícias', 10);
INSERT INTO program (nome, classifc_ind) VALUES ('Brincando e Aprendendo', 0);
INSERT INTO program (nome, classifc_ind) VALUES ('Segredos Urbanos', 14);          
INSERT INTO program (nome, classifc_ind) VALUES ('Sabor em Família', 10);          
INSERT INTO program (nome, classifc_ind) VALUES ('Show do Riso', 12);              
INSERT INTO program (nome, classifc_ind) VALUES ('Noite de Mistério', 16);         
INSERT INTO program (nome, classifc_ind) VALUES ('Debate em Foco', 12);            
INSERT INTO program (nome, classifc_ind) VALUES ('Cinema Livre', 14);              
INSERT INTO program (nome, classifc_ind) VALUES ('Mundo Animal', 0);               
INSERT INTO program (nome, classifc_ind) VALUES ('Vidas Cruzadas', 18);

--Gêneros dos programas

-- Café com Notícias: Jornalismo
INSERT INTO genre (program_id, nome) VALUES (1, 'Jornalismo');

-- Brincando e Aprendendo: Infantil, Educativo
INSERT INTO genre (program_id, nome) VALUES (2, 'Infantil');
INSERT INTO genre (program_id, nome) VALUES (2, 'Educativo');

-- Segredos Urbanos: Drama, Policial
INSERT INTO genre (program_id, nome) VALUES (3, 'Drama');
INSERT INTO genre (program_id, nome) VALUES (3, 'Policial');

-- Sabor em Família: Culinária
INSERT INTO genre (program_id, nome) VALUES (4, 'Culinária');

-- Show do Riso: Humor
INSERT INTO genre (program_id, nome) VALUES (5, 'Humor');

-- Noite de Mistério: Suspense, Policial
INSERT INTO genre (program_id, nome) VALUES (6, 'Suspense');
INSERT INTO genre (program_id, nome) VALUES (6, 'Policial');

-- Debate em Foco: Debate, Atualidades
INSERT INTO genre (program_id, nome) VALUES (7, 'Debate');
INSERT INTO genre (program_id, nome) VALUES (7, 'Atualidades');

-- Cinema Livre: (sem gênero cadastrado)

-- Mundo Animal: Documentário, Natureza
INSERT INTO genre (program_id, nome) VALUES (9, 'Documentário');
INSERT INTO genre (program_id, nome) VALUES (9, 'Natureza');

-- Vidas Cruzadas: Drama
INSERT INTO genre (program_id, nome) VALUES (10, 'Drama');


-- TEMPORADAS DOS PROGRAMAS

-- Café com Notícias: 2 temporadas
INSERT INTO season (id_program, season_status) VALUES (1, 'finished');
INSERT INTO season (id_program, season_status) VALUES (1, 'ongoing');

-- Brincando e Aprendendo: 1 temporada
INSERT INTO season (id_program, season_status) VALUES (2, 'finished');

-- Segredos Urbanos: 3 temporadas
INSERT INTO season (id_program, season_status) VALUES (3, 'finished');
INSERT INTO season (id_program, season_status) VALUES (3, 'finished');
INSERT INTO season (id_program, season_status) VALUES (3, 'ongoing');

-- Sabor em Família: 2 temporadas
INSERT INTO season (id_program, season_status) VALUES (4, 'finished');
INSERT INTO season (id_program, season_status) VALUES (4, 'ongoing');

-- Show do Riso: 1 temporada
INSERT INTO season (id_program, season_status) VALUES (5, 'ongoing');

-- Noite de Mistério: 2 temporadas
INSERT INTO season (id_program, season_status) VALUES (6, 'finished');
INSERT INTO season (id_program, season_status) VALUES (6, 'ongoing');

-- Debate em Foco: Sem temporadas cadastradas

-- Cinema Livre: 1 temporada
INSERT INTO season (id_program, season_status) VALUES (8, 'ongoing');

-- Mundo Animal: 2 temporadas
INSERT INTO season (id_program, season_status) VALUES (9, 'finished');
INSERT INTO season (id_program, season_status) VALUES (9, 'ongoing');

-- Vidas Cruzadas: 1 temporada
INSERT INTO season (id_program, season_status) VALUES (10, 'ongoing');


-- EPISÓDIOS DOS PROGRAMAS

-- EPISÓDIOS (especialização de content)
-- Café com Notícias (id_program = 1, temporadas 1 e 2, 5 episódios cada)
BEGIN
  insert_episode_content(0, 25, 'Café com Notícias - Edição 01', 1, 1);
  insert_episode_content(0, 25, 'Café com Notícias - Edição 02', 1, 1);
  insert_episode_content(0, 25, 'Café com Notícias - Edição 03', 1, 1);
  insert_episode_content(0, 25, 'Café com Notícias - Edição 04', 1, 1);
  insert_episode_content(0, 25, 'Café com Notícias - Edição 05', 1, 1);
  insert_episode_content(0, 25, 'Café com Notícias - Edição 06', 1, 2);
  insert_episode_content(0, 25, 'Café com Notícias - Edição 07', 1, 2);
  insert_episode_content(0, 25, 'Café com Notícias - Edição 08', 1, 2);
  insert_episode_content(0, 25, 'Café com Notícias - Edição 09', 1, 2);
  insert_episode_content(0, 25, 'Café com Notícias - Edição 10', 1, 2);
END;
/

-- Brincando e Aprendendo (id_program = 2, temporada 1)
BEGIN
  insert_episode_content(0, 22, 'Brincando e Aprendendo - O Alfabeto', 2, 1);
  insert_episode_content(0, 22, 'Brincando e Aprendendo - Números Divertidos', 2, 1);
  insert_episode_content(0, 22, 'Brincando e Aprendendo - Animais do Brasil', 2, 1);
  insert_episode_content(0, 22, 'Brincando e Aprendendo - Cores e Formas', 2, 1);
  insert_episode_content(0, 22, 'Brincando e Aprendendo - Brincadeiras Tradicionais', 2, 1);
  insert_episode_content(0, 22, 'Brincando e Aprendendo - Hora da Música', 2, 1);
END;
/

-- Segredos Urbanos (id_program = 3, temporadas 1, 2 e 3)
BEGIN
  insert_episode_content(0, 45, 'Segredos Urbanos - O Caso da Rua 7', 3, 1);
  insert_episode_content(0, 45, 'Segredos Urbanos - Mistério no Centro', 3, 1);
  insert_episode_content(0, 45, 'Segredos Urbanos - O Enigma do Parque', 3, 2);
  insert_episode_content(0, 45, 'Segredos Urbanos - Sombra na Estação', 3, 2);
  insert_episode_content(0, 45, 'Segredos Urbanos - O Roubo do Século', 3, 3);
  insert_episode_content(0, 45, 'Segredos Urbanos - Testemunha Ocular', 3, 3);
  insert_episode_content(0, 45, 'Segredos Urbanos - O Mistério do Cofre', 3, 3);
  insert_episode_content(0, 45, 'Segredos Urbanos - Fuga na Madrugada', 3, 3);
END;
/

-- Sabor em Família (id_program = 4, temporadas 1 e 2)
BEGIN
  insert_episode_content(1, 30, 'Sabor em Família - Receitas de Domingo', 4, 1);
  insert_episode_content(1, 30, 'Sabor em Família - Sabores do Nordeste', 4, 1);
  insert_episode_content(1, 30, 'Sabor em Família - Doces Caseiros', 4, 2);
  insert_episode_content(1, 30, 'Sabor em Família - Pratos Rápidos', 4, 2);
  insert_episode_content(1, 30, 'Sabor em Família - Especial de Natal', 4, 2);
END;
/

-- Show do Riso (id_program = 5, temporada 1)
BEGIN
  insert_episode_content(1, 28, 'Show do Riso - Stand Up 1', 5, 1);
  insert_episode_content(1, 28, 'Show do Riso - Stand Up 2', 5, 1);
  insert_episode_content(1, 28, 'Show do Riso - Esquetes Inéditas', 5, 1);
  insert_episode_content(1, 28, 'Show do Riso - Melhores Piadas', 5, 1);
END;
/

-- Noite de Mistério (id_program = 6, temporadas 1 e 2)
BEGIN
  insert_episode_content(1, 50, 'Noite de Mistério - O Visitante', 6, 1);
  insert_episode_content(1, 50, 'Noite de Mistério - O Quadro', 6, 1);
  insert_episode_content(1, 50, 'Noite de Mistério - O Elevador', 6, 1);
  insert_episode_content(1, 50, 'Noite de Mistério - O Sótão', 6, 2);
  insert_episode_content(1, 50, 'Noite de Mistério - O Apartamento 13', 6, 2);
  insert_episode_content(1, 50, 'Noite de Mistério - O Último Trem', 6, 2);
END;
/

-- Cinema Livre (id_program = 8, temporada 1)
BEGIN
  insert_episode_content(1, 90, 'Cinema Livre - Filme Nacional', 8, 1);
  insert_episode_content(1, 95, 'Cinema Livre - Clássico Internacional', 8, 1);
END;
/

-- Mundo Animal (id_program = 9, temporadas 1 e 2)
BEGIN
  insert_episode_content(1, 35, 'Mundo Animal - Floresta Amazônica', 9, 1);
  insert_episode_content(1, 35, 'Mundo Animal - Pantanal Selvagem', 9, 1);
  insert_episode_content(1, 35, 'Mundo Animal - Vida Marinha', 9, 2);
  insert_episode_content(1, 35, 'Mundo Animal - Cerrado Brasileiro', 9, 2);
END;
/

-- Vidas Cruzadas (id_program = 10, temporada 1)
BEGIN
  insert_episode_content(1, 55, 'Vidas Cruzadas - Destinos', 10, 1);
  insert_episode_content(1, 55, 'Vidas Cruzadas - Reencontros', 10, 1);
END;
/


-- INSERINDO 8 ANUNCIANTES FICTÍCIOS TÍPICOS DE EMISSORAS DE TV
INSERT INTO advertiser (advertiser_name) VALUES ('Café Imperial');
INSERT INTO advertiser (advertiser_name) VALUES ('Supermercados BomLar');
INSERT INTO advertiser (advertiser_name) VALUES ('AutoFácil Veículos');
INSERT INTO advertiser (advertiser_name) VALUES ('TecnoMais Eletrônicos');
INSERT INTO advertiser (advertiser_name) VALUES ('Sorvetes Polar');
INSERT INTO advertiser (advertiser_name) VALUES ('Farmácias VidaPlena');
INSERT INTO advertiser (advertiser_name) VALUES ('Faculdade Horizonte');
INSERT INTO advertiser (advertiser_name) VALUES ('Construtora NovaMorada');

-- INSERINDO 12 CAMPANHAS VARIADAS
-- INSERINDO 12 CAMPANHAS VARIADAS (SEM mencionar colaboração)
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Beleza de Verão', 'Campanha de verão com foco em beleza e bem-estar');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Ofertas da Semana', 'Campanha semanal de promoções');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Feirão de Carros', 'Campanha de vendas de automóveis');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('TecnoMais Lançamento', 'Campanha de lançamento de eletrônicos');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Promoção Pet Feliz', 'Campanha para produtos pet');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Saúde e Bem-Estar', 'Campanha de saúde e qualidade de vida');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Educação para Todos', 'Campanha de incentivo à educação');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Cuidado Popular', 'Campanha de produtos farmacêuticos');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Verão Refrescante', 'Campanha de sorvetes e bebidas geladas');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Festival de Economia', 'Campanha de descontos e ofertas especiais');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Outono Elegante', 'Campanha de moda e estilo para o outono');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Construindo Sonhos', 'Campanha de imóveis e construção');

-- INSERINDO ANÚNCIOS PARA AS CAMPANHAS
-- INSERINDO ANÚNCIOS PARA A CAMPANHA "Beleza de Verão"
BEGIN
  insert_advertisement_content(0, 3, 'Protetor Solar VidaPlena', 'Adultos');
  insert_advertisement_content(0, 1, 'Sorvete Light Verão', 'Todos');
  insert_advertisement_content(0, 2, 'Arroz BomLar - Oferta Especial', 'Famílias');
  insert_advertisement_content(0, 2, 'Feijão Preto Supermercado BomLar', 'Famílias');
  insert_advertisement_content(1, 4, 'Promoção de Carros Usados - AutoFácil', 'Adultos');
  insert_advertisement_content(1, 2, 'Test Drive Grátis - AutoFácil', 'Adultos');
  insert_advertisement_content(1, 2, 'Smartphone TecnoMais - Lançamento', 'Jovens');
  insert_advertisement_content(1, 3, 'Notebook TecnoMais - Alta Performance', 'Profissionais');
  insert_advertisement_content(1, 1, 'Smartwatch TecnoMais - Conectividade', 'Jovens');
  insert_advertisement_content(1, 1, 'Fone de Ouvido Bluetooth TecnoMais', 'Jovens');
  insert_advertisement_content(1, 1, 'Tablet TecnoMais - Portabilidade', 'Estudantes');
  insert_advertisement_content(0, 2, 'Ração Premium Pet Feliz', 'Donos de Animais');
  insert_advertisement_content(1, 1, 'Brinquedos Diversão Pet Feliz', 'Donos de Animais');
  insert_advertisement_content(0, 2.5, 'Banho e Tosa Pet Feliz - Promoção', 'Donos de Animais');
  insert_advertisement_content(1, 1.5, 'Suplemento Vitaminas VidaPlena', 'Adultos');
  insert_advertisement_content(0, 1, 'Medicamentos Genéricos VidaPlena', 'Adultos');
  insert_advertisement_content(1, 5, 'Financiamento Especial AutoFácil', 'Adultos');
  insert_advertisement_content(0, 1.5, 'liquidação de Frutas e Verduras BomLar', 'Famílias');
END;
-- RELACIONANDO ANÚNCIOS, ANUNCIANTES E CAMPANHAS (PROMOTE) 

-- Farmácias VidaPlena promovendo protetor solar em "Beleza de Verão"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (48, 6, 1, 2500);

-- Sorvetes Polar promovendo sorvete em "Beleza de Verão" e "Verão Refrescante"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (49, 5, 1, 1800);
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (49, 5, 9, 2100);

-- Supermercados BomLar promovendo arroz e feijão em campanhas de ofertas
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (50, 2, 2, 2200); -- Arroz em "Ofertas da Semana"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (51, 2, 10, 1700); -- Feijão em "Festival de Economia"

-- AutoFácil Veículos promovendo carros em "Feirão de Carros" e financiamento em "Construindo Sonhos"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (52, 3, 3, 3000); -- Promoção de carros usados
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (64, 3, 12, 2000); -- Financiamento em "Construindo Sonhos"

-- TecnoMais Eletrônicos promovendo eletrônicos em campanhas de tecnologia e educação
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (54, 4, 4, 3500); -- Smartphone em "TecnoMais Lançamento"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (55, 4, 7, 2100); -- Notebook em "Educação para Todos"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (56, 4, 1, 900);  -- Smartwatch em "Beleza de Verão"

-- Pet Feliz promovendo ração, brinquedos e banho/tosa em "Promoção Pet Feliz"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (59, 5, 5, 800);  -- Ração
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (60, 5, 5, 700);  -- Brinquedos
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (61, 5, 5, 600);  -- Banho e tosa

-- Farmácias VidaPlena promovendo suplemento em "Saúde e Bem-Estar" e genéricos em "Cuidado Popular"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (62, 6, 6, 1200); -- Suplemento em "Saúde e Bem-Estar"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (63, 6, 8, 1100); -- Genéricos em "Cuidado Popular"

-- Supermercados BomLar promovendo liquidação em "Festival de Economia"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (65, 2, 10, 900);

-- TecnoMais Eletrônicos promovendo fone de ouvido em "Festival de Economia"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (57, 4, 10, 1100);

-- TecnoMais Eletrônicos promovendo tablet em "Educação para Todos"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (58, 4, 7, 1300);

-- AutoFácil Veículos promovendo test drive em "Feirão de Carros" e "Festival de Economia"
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (53, 3, 3, 1800);
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (53, 3, 10, 1200);

-- INSERINDO ENDEREÇOS DOS ESTÚDIOS (com todos os campos obrigatórios)
INSERT INTO studio_address (neighborhood, street, address_number)
VALUES ('Carmo', 'Rua do Cinema', 123);
INSERT INTO studio_address (neighborhood, street, address_number)
VALUES ('Centro', 'Travessa do Humor', 45);
INSERT INTO studio_address (neighborhood, street, address_number)
VALUES ('Boa Vista', 'Av. das Produções', 5);


-- INSERINDO ESTÚDIOS DE GRAVAÇÃO (com todos os campos obrigatórios)
INSERT INTO studio (studio_name, studio_capacity, maintenance_cost, address_id)
VALUES ('Estúdio Recife', 80, 1500, 1);
INSERT INTO studio (studio_name, studio_capacity, maintenance_cost, address_id)
VALUES ('Estúdio Olinda', 60, 1200, 2);
INSERT INTO studio (studio_name, studio_capacity, maintenance_cost, address_id)
VALUES ('Estúdio Jaboatão', 40, 900, 3);

-- PRODUÇÃO DE ANUNCIOS

-- Protetor Solar VidaPlena 
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 48, 5000, TO_TIMESTAMP('2025-05-01 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-10 18:00', 'YYYY-MM-DD HH24:MI'));

-- Sorvete Light Verão 
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 49, 4000, TO_TIMESTAMP('2025-05-02 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-12 17:00', 'YYYY-MM-DD HH24:MI'));

-- Notebook TecnoMais 
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 55, 7000, TO_TIMESTAMP('2025-05-03 11:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-13 16:00', 'YYYY-MM-DD HH24:MI'));

-- Smartwatch TecnoMais 
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 56, 6500, TO_TIMESTAMP('2025-05-04 12:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-14 15:00', 'YYYY-MM-DD HH24:MI'));

-- Arroz BomLar - Oferta Especial 
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 50, 3500, TO_TIMESTAMP('2025-05-05 13:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-15 14:00', 'YYYY-MM-DD HH24:MI'));

-- Financiamento Especial AutoFácil 
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 64, 8000, TO_TIMESTAMP('2025-05-06 14:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-16 13:00', 'YYYY-MM-DD HH24:MI'));

-- Ração Premium Pet Feliz 
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 59, 3000, TO_TIMESTAMP('2025-05-07 15:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-17 12:00', 'YYYY-MM-DD HH24:MI'));

-- PRODUÇÃO DE EPISÓDIOS

-- Café com Notícias - Edição 01 (content_id 1)
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 1, 8000, TO_TIMESTAMP('2025-04-01 08:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-10 18:00', 'YYYY-MM-DD HH24:MI'));

-- Show do Riso - Stand Up 1 
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 30, 7000, TO_TIMESTAMP('2025-04-05 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-15 17:00', 'YYYY-MM-DD HH24:MI'));

-- Brincando e Aprendendo - O Alfabeto (content_id 11)
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 11, 5000, TO_TIMESTAMP('2025-04-09 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-19 18:00', 'YYYY-MM-DD HH24:MI'));

-- Brincando e Aprendendo - Números Divertidos (content_id 12)
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 12, 5000, TO_TIMESTAMP('2025-04-10 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-20 18:00', 'YYYY-MM-DD HH24:MI'));

-- Noite de mistérios - O Sotão 
INSERT INTO production (studio_id, content_id, production_cost, production_begin, production_end)
VALUES (1, 37, 6000, TO_TIMESTAMP('2025-04-07 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-17 18:00', 'YYYY-MM-DD HH24:MI'));

-- FUNCIONÁRIOS EM PIRÂMIDE: 1 chefe, 4 supervisores, cada supervisor com 5 subordinados

-- Chefe máximo
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (1, 25000, NULL, 'João Silva');

-- Supervisores (subordinados ao chefe)
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (2, 12000, 1, 'Maria Souza');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (3, 12000, 1, 'Carlos Lima');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (4, 12000, 1, 'Fernanda Alves');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (5, 12000, 1, 'Ricardo Costa');

-- Subordinados da Supervisora 1
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (6, 4000, 2, 'Ana Martins');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (7, 4000, 2, 'Bruno Dias');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (8, 4000, 2, 'Clara Ramos');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (9, 4000, 2, 'Daniel Pinto');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (10, 4000, 2, 'Eduarda Melo');

-- Subordinados do Supervisor 2
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (11, 4000, 3, 'Felipe Rocha');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (12, 4000, 3, 'Gabriela Nunes');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (13, 4000, 3, 'Henrique Barros');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (14, 4000, 3, 'Isabela Freitas');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (15, 4000, 3, 'Joana Teixeira');

-- Subordinados da Supervisora 3
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (16, 4000, 4, 'Lucas Fernandes');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (17, 4000, 4, 'Marina Borges');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (18, 4000, 4, 'Nicolas Ribeiro');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (19, 4000, 4, 'Olivia Cardoso');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (20, 4000, 4, 'Paulo Duarte');

-- Subordinados do Supervisor 4
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (21, 4000, 5, 'Quesia Pires');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (22, 4000, 5, 'Rafael Cunha');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (23, 4000, 5, 'Sofia Azevedo');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (24, 4000, 5, 'Thiago Monteiro');
INSERT INTO employee (employee_id, employee_salary, employee_supervisor, employee_name)
VALUES (25, 4000, 5, 'Ursula Vieira');

-- PARTICIPAÇÃO DOS FUNCIONÁRIOS NOS EPISÓDIOS PRODUZIDOS

-- Café com Notícias - Edição 01 (content_id 1)
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (2, 1, 1, 'Diretor', TO_TIMESTAMP('2025-04-01 08:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-10 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (6, 1, 1, 'Cinegrafista', TO_TIMESTAMP('2025-04-01 08:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-10 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (12, 1, 1, 'Editor', TO_TIMESTAMP('2025-04-01 08:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-10 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (21, 1, 1, 'Apresentador', TO_TIMESTAMP('2025-04-01 08:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-10 18:00', 'YYYY-MM-DD HH24:MI'));

-- Show do Riso - Stand Up 1 
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (3, 1, 30, 'Diretor', TO_TIMESTAMP('2025-04-05 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-15 17:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (7, 1, 30, 'Cinegrafista', TO_TIMESTAMP('2025-04-05 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-15 17:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (13, 1, 30, 'Editor', TO_TIMESTAMP('2025-04-05 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-15 17:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (22, 1, 30, 'Apresentador', TO_TIMESTAMP('2025-04-05 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-15 17:00', 'YYYY-MM-DD HH24:MI'));

-- Noite de Mistério - O Sotão 
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (4, 1, 37, 'Diretor', TO_TIMESTAMP('2025-04-07 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-17 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (8, 1, 37, 'Cinegrafista', TO_TIMESTAMP('2025-04-07 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-17 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (14, 1, 37, 'Editor', TO_TIMESTAMP('2025-04-07 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-17 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (23, 1, 37, 'Apresentador', TO_TIMESTAMP('2025-04-07 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-17 18:00', 'YYYY-MM-DD HH24:MI'));

-- Brincando e Aprendendo - O Alfabeto (content_id 6)
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (5, 1, 11, 'Diretor', TO_TIMESTAMP('2025-04-09 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-19 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (9, 1, 11, 'Cinegrafista', TO_TIMESTAMP('2025-04-09 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-19 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (15, 1, 11, 'Editor', TO_TIMESTAMP('2025-04-09 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-19 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (24, 1, 11, 'Apresentador', TO_TIMESTAMP('2025-04-09 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-19 18:00', 'YYYY-MM-DD HH24:MI'));

-- Brincando e Aprendendo - Números Divertidos (content_id 7)
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (1, 1, 12, 'Diretor', TO_TIMESTAMP('2025-04-10 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-20 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (10, 1, 12, 'Cinegrafista', TO_TIMESTAMP('2025-04-10 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-20 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (16, 1, 12, 'Editor', TO_TIMESTAMP('2025-04-10 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-20 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (25, 1, 12, 'Apresentador', TO_TIMESTAMP('2025-04-10 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-04-20 18:00', 'YYYY-MM-DD HH24:MI'));

-- PARTICIPAÇÃO DOS FUNCIONÁRIOS NAS PRODUÇÕES DOS ANÚNCIOS (misturando equipes de diferentes supervisores)

-- Protetor Solar VidaPlena (content_id 48, studio_id 1)
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (2, 1, 48, 'Diretor', TO_TIMESTAMP('2025-05-01 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-10 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (11, 1, 48, 'Cinegrafista', TO_TIMESTAMP('2025-05-01 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-10 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (17, 1, 48, 'Editor', TO_TIMESTAMP('2025-05-01 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-10 18:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (21, 1, 48, 'Apresentador', TO_TIMESTAMP('2025-05-01 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-10 18:00', 'YYYY-MM-DD HH24:MI'));

-- Sorvete Light Verão (content_id 49, studio_id 1)
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (3, 1, 49, 'Diretor', TO_TIMESTAMP('2025-05-02 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-12 17:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (6, 1, 49, 'Cinegrafista', TO_TIMESTAMP('2025-05-02 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-12 17:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (14, 1, 49, 'Editor', TO_TIMESTAMP('2025-05-02 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-12 17:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (22, 1, 49, 'Apresentador', TO_TIMESTAMP('2025-05-02 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-12 17:00', 'YYYY-MM-DD HH24:MI'));

-- Notebook TecnoMais (content_id 55, studio_id 1)
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (4, 1, 55, 'Diretor', TO_TIMESTAMP('2025-05-03 11:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-13 16:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (12, 1, 55, 'Cinegrafista', TO_TIMESTAMP('2025-05-03 11:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-13 16:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (18, 1, 55, 'Editor', TO_TIMESTAMP('2025-05-03 11:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-13 16:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (23, 1, 55, 'Apresentador', TO_TIMESTAMP('2025-05-03 11:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-13 16:00', 'YYYY-MM-DD HH24:MI'));

-- Smartwatch TecnoMais (content_id 56, studio_id 1)
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (5, 1, 56, 'Diretor', TO_TIMESTAMP('2025-05-04 12:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-14 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (7, 1, 56, 'Cinegrafista', TO_TIMESTAMP('2025-05-04 12:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-14 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (19, 1, 56, 'Editor', TO_TIMESTAMP('2025-05-04 12:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-14 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (24, 1, 56, 'Apresentador', TO_TIMESTAMP('2025-05-04 12:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-14 15:00', 'YYYY-MM-DD HH24:MI'));

-- Arroz BomLar - Oferta Especial (content_id 50, studio_id 1)
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (3, 1, 50, 'Diretor', TO_TIMESTAMP('2025-05-05 13:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-15 14:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (8, 1, 50, 'Cinegrafista', TO_TIMESTAMP('2025-05-05 13:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-15 14:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (15, 1, 50, 'Editor', TO_TIMESTAMP('2025-05-05 13:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-15 14:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (25, 1, 50, 'Apresentador', TO_TIMESTAMP('2025-05-05 13:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-15 14:00', 'YYYY-MM-DD HH24:MI'));

-- Financiamento Especial AutoFácil (content_id 64, studio_id 1)
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (4, 1, 64, 'Diretor', TO_TIMESTAMP('2025-05-06 14:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-16 13:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (13, 1, 64, 'Cinegrafista', TO_TIMESTAMP('2025-05-06 14:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-16 13:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (20, 1, 64, 'Editor', TO_TIMESTAMP('2025-05-06 14:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-16 13:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (16, 1, 64, 'Apresentador', TO_TIMESTAMP('2025-05-06 14:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-16 13:00', 'YYYY-MM-DD HH24:MI'));

-- Ração Premium Pet Feliz (content_id 59, studio_id 1)
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (5, 1, 59, 'Diretor', TO_TIMESTAMP('2025-05-07 15:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-17 12:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (9, 1, 59, 'Cinegrafista', TO_TIMESTAMP('2025-05-07 15:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-17 12:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (10, 1, 59, 'Editor', TO_TIMESTAMP('2025-05-07 15:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-17 12:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO participate (employee_id, studio_id, content_id, role, participation_begin, participation_end)
VALUES (18, 1, 59, 'Apresentador', TO_TIMESTAMP('2025-05-07 15:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-05-17 12:00', 'YYYY-MM-DD HH24:MI'));

-- INSERINDO 3 CANAIS DA MESMA EMISSORA (Exemplo: Emissora "Rede Cidade")
INSERT INTO channel (channel_name, frequency) VALUES ('Globix TV',  12);
INSERT INTO channel (channel_name, frequency) VALUES ('Globix News',  21);
INSERT INTO channel (channel_name, frequency) VALUES ('Globix Kids', 25);

-- EXIBIÇÕES DE CONTEÚDO (BROADCAST) DE ACORDO COM O ESTILO DO CANAL

-- Globix TV: programação geral, exibe jornalismo, novelas, variedades e anúncios
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (12, 1,  TO_TIMESTAMP('2025-07-01 08:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 08:30', 'YYYY-MM-DD HH24:MI'), 50000, 2000); -- Café com Notícias
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (12, 48, TO_TIMESTAMP('2025-07-01 08:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 08:32', 'YYYY-MM-DD HH24:MI'), 50000, 800); -- Protetor Solar VidaPlena (anúncio)
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (12, 5,  TO_TIMESTAMP('2025-07-01 08:32', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 09:17', 'YYYY-MM-DD HH24:MI'), 60000, 2500); -- Show do Riso
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (12, 49, TO_TIMESTAMP('2025-07-01 09:17', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 09:19', 'YYYY-MM-DD HH24:MI'), 60000, 900); -- Sorvete Light Verão (anúncio)

-- Globix News: foco em jornalismo, debates, atualidades e anúncios relacionados
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (21, 1,  TO_TIMESTAMP('2025-07-01 07:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 07:30', 'YYYY-MM-DD HH24:MI'), 40000, 1800); -- Café com Notícias
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (21, 48, TO_TIMESTAMP('2025-07-01 07:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 07:32', 'YYYY-MM-DD HH24:MI'), 40000, 700); -- Protetor Solar VidaPlena (anúncio)
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (21, 37, TO_TIMESTAMP('2025-07-01 07:32', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 08:37', 'YYYY-MM-DD HH24:MI'), 35000, 1500); -- Debate em Foco
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (21, 50, TO_TIMESTAMP('2025-07-01 08:37', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 08:39', 'YYYY-MM-DD HH24:MI'), 35000, 600); -- Arroz BomLar - Oferta Especial (anúncio)


-- Globix Kids: programação infantil e educativa, exibe episódios infantis e anúncios voltados para crianças/família
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (25, 6,  TO_TIMESTAMP('2025-07-01 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 09:35', 'YYYY-MM-DD HH24:MI'), 30000, 1200); -- Brincando e Aprendendo - O Alfabeto 
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (25, 49, TO_TIMESTAMP('2025-07-01 09:35', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 09:37', 'YYYY-MM-DD HH24:MI'), 30000, 500); -- Sorvete Light Verão (anúncio)
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (25, 7,  TO_TIMESTAMP('2025-07-01 09:37', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 10:13', 'YYYY-MM-DD HH24:MI'), 32000, 1300); -- Brincando e Aprendendo - Números Divertidos 
INSERT INTO broadcast (channel_frequency, content_id, broadcast_begin_time, broadcast_end_time, reach_audience, broadcast_revenue)
VALUES (25, 59, TO_TIMESTAMP('2025-07-01 10:13', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-07-01 10:15', 'YYYY-MM-DD HH24:MI'), 32000, 400); -- Ração Premium Pet Feliz (anúncio)


-- INTERRUPÇÕES DE ANÚNCIOS DURANTE EXIBIÇÕES (SOMENTE ONDE HÁ TEMPO SOBRANDO)

-- Globix TV: Show do Riso 
INSERT INTO interrupt (content_id, channel_frequency, advertisement_id, interruption_time)
VALUES (5, 12, 49, TO_TIMESTAMP('2025-07-01 09:17', 'YYYY-MM-DD HH24:MI')); -- Sorvete Light Verão interrompe Show do Riso

INSERT INTO interrupt (content_id, channel_frequency, advertisement_id, interruption_time)
VALUES (5, 12, 55, TO_TIMESTAMP('2025-07-01 09:18', 'YYYY-MM-DD HH24:MI')); -- Notebook TecnoMais interrompe Show do Riso

INSERT INTO interrupt (content_id, channel_frequency, advertisement_id, interruption_time)
VALUES (5, 12, 56, TO_TIMESTAMP('2025-07-01 09:21', 'YYYY-MM-DD HH24:MI')); -- Smartwatch TecnoMais interrompe Show do Riso

-- Globix Kids: Brincando e Aprendendo - O Alfabeto tem tempo sobrando antes do anúncio
INSERT INTO interrupt (content_id, channel_frequency, advertisement_id, interruption_time)
VALUES (6, 25, 64, TO_TIMESTAMP('2025-07-01 09:35', 'YYYY-MM-DD HH24:MI')); -- Financiamento Especial AutoFácil interrompe Brincando e Aprendendo - O Alfabeto

-- Globix Kids: Brincando e Aprendendo - Números Divertidos tem tempo sobrando antes do anúncio
INSERT INTO interrupt (content_id, channel_frequency, advertisement_id, interruption_time)
VALUES (7, 25, 59, TO_TIMESTAMP('2025-07-01 10:12', 'YYYY-MM-DD HH24:MI')); -- Ração Premium Pet Feliz interrompe Brincando e Aprendendo - Números Divertidos

