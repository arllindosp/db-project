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
  insert_episode_content(1, 25, 'Café com Notícias - Edição 01', 1, 1);
  insert_episode_content(1, 25, 'Café com Notícias - Edição 02', 1, 1);
  insert_episode_content(1, 25, 'Café com Notícias - Edição 03', 1, 1);
  insert_episode_content(1, 25, 'Café com Notícias - Edição 04', 1, 1);
  insert_episode_content(1, 25, 'Café com Notícias - Edição 05', 1, 1);
  insert_episode_content(1, 25, 'Café com Notícias - Edição 06', 1, 2);
  insert_episode_content(1, 25, 'Café com Notícias - Edição 07', 1, 2);
  insert_episode_content(1, 25, 'Café com Notícias - Edição 08', 1, 2);
  insert_episode_content(1, 25, 'Café com Notícias - Edição 09', 1, 2);
  insert_episode_content(1, 25, 'Café com Notícias - Edição 10', 1, 2);
END;
/

-- Brincando e Aprendendo (id_program = 2, temporada 1)
BEGIN
  insert_episode_content(1, 22, 'Brincando e Aprendendo - O Alfabeto', 2, 1);
  insert_episode_content(1, 22, 'Brincando e Aprendendo - Números Divertidos', 2, 1);
  insert_episode_content(1, 22, 'Brincando e Aprendendo - Animais do Brasil', 2, 1);
  insert_episode_content(1, 22, 'Brincando e Aprendendo - Cores e Formas', 2, 1);
  insert_episode_content(1, 22, 'Brincando e Aprendendo - Brincadeiras Tradicionais', 2, 1);
  insert_episode_content(1, 22, 'Brincando e Aprendendo - Hora da Música', 2, 1);
END;
/

-- Segredos Urbanos (id_program = 3, temporadas 1, 2 e 3)
BEGIN
  insert_episode_content(2, 45, 'Segredos Urbanos - O Caso da Rua 7', 3, 1);
  insert_episode_content(2, 45, 'Segredos Urbanos - Mistério no Centro', 3, 1);
  insert_episode_content(2, 45, 'Segredos Urbanos - O Enigma do Parque', 3, 2);
  insert_episode_content(2, 45, 'Segredos Urbanos - Sombra na Estação', 3, 2);
  insert_episode_content(2, 45, 'Segredos Urbanos - O Roubo do Século', 3, 3);
  insert_episode_content(2, 45, 'Segredos Urbanos - Testemunha Ocular', 3, 3);
  insert_episode_content(2, 45, 'Segredos Urbanos - O Mistério do Cofre', 3, 3);
  insert_episode_content(2, 45, 'Segredos Urbanos - Fuga na Madrugada', 3, 3);
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
  insert_episode_content(2, 50, 'Noite de Mistério - O Visitante', 6, 1);
  insert_episode_content(2, 50, 'Noite de Mistério - O Quadro', 6, 1);
  insert_episode_content(2, 50, 'Noite de Mistério - O Elevador', 6, 1);
  insert_episode_content(2, 50, 'Noite de Mistério - O Sótão', 6, 2);
  insert_episode_content(2, 50, 'Noite de Mistério - O Apartamento 13', 6, 2);
  insert_episode_content(2, 50, 'Noite de Mistério - O Último Trem', 6, 2);
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
  insert_episode_content(2, 55, 'Vidas Cruzadas - Destinos', 10, 1);
  insert_episode_content(2, 55, 'Vidas Cruzadas - Reencontros', 10, 1);
END;
/

-- INSERINDO ANUNCIANTES VARIADOS
INSERT INTO advertiser (advertiser_name) VALUES ('Aurora Cosméticos');
INSERT INTO advertiser (advertiser_name) VALUES ('Supermercado Preço Bom');
INSERT INTO advertiser (advertiser_name) VALUES ('AutoCar Veículos');
INSERT INTO advertiser (advertiser_name) VALUES ('TechX Eletrônicos');
INSERT INTO advertiser (advertiser_name) VALUES ('Mundo Pet');
INSERT INTO advertiser (advertiser_name) VALUES ('Editora Saber');
INSERT INTO advertiser (advertiser_name) VALUES ('Farmácia Popular');
INSERT INTO advertiser (advertiser_name) VALUES ('Sorvetes Geladinho');

-- INSERINDO CAMPANHAS VARIADAS
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Beleza de Verão', 'Campanha de verão com foco em beleza e bem-estar');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Ofertas da Semana', 'Campanha semanal de promoções');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Feirão de Carros', 'Campanha de vendas de automóveis');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('TechX Lançamento', 'Campanha de lançamento de eletrônicos');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Promoção Pet Feliz', 'Campanha para produtos pet');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Verão em Família', 'Campanha colaborativa de verão');
INSERT INTO campaign (campaign_name, campaign_description) VALUES ('Verão Refrescante', 'Campanha colaborativa de sorvetes');

-- INSERINDO ANÚNCIOS VARIADOS (usando a procedure insert_advertisement_content)
BEGIN
  insert_advertisement_content(1, 2, 'Comercial Perfume Aurora', 'Adultos');         -- content_id 1
  insert_advertisement_content(1, 3, 'Comercial Supermercado Preço Bom', 'Família'); -- content_id 2
  insert_advertisement_content(0, 2, 'Comercial Carro Novo', 'Adultos');             -- content_id 3
  insert_advertisement_content(1, 2, 'Comercial Celular TechX', 'Jovens');           -- content_id 4
  insert_advertisement_content(0, 2, 'Comercial Pet Feliz', 'Todos');                -- content_id 5
  insert_advertisement_content(0, 2, 'Comercial Editora Saber', 'Estudantes');       -- content_id 6
  insert_advertisement_content(1, 2, 'Comercial Farmácia Popular', 'Idosos');        -- content_id 7
  insert_advertisement_content(1, 2, 'Comercial Sorvetes Geladinho', 'Crianças');    -- content_id 8
END;

-- PROMOTE: vincula anúncio, anunciante e campanha, com orçamento variado
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (48, 1, 1, 6000); -- Perfume Aurora solo
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (48, 1, 6, 4000); -- Perfume Aurora colab
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (48, 2, 6, 3000); -- Perfume Aurora colab
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (48, 8, 6, 2000); -- Perfume Aurora colab

INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (49, 2, 2, 7000); -- Supermercado Preço Bom solo
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (49, 2, 10, 3500); -- Supermercado Preço Bom colab
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (49, 8, 10, 2500); -- Supermercado Preço Bom colab

INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (50, 3, 3, 8000); -- Carro Novo solo

INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (51, 4, 4, 9000); -- Celular TechX solo

INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (52, 5, 5, 4000); -- Pet Feliz solo

INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (54, 7, 9, 3500); -- Farmácia Popular solo

INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (55, 8, 10, 5000); -- Sorvetes Geladinho solo
INSERT INTO promote (advertisement_id, advertiser_id, campaign_id, promotion_budget)
VALUES (56, 2, 10, 2000); -- Sorvetes Geladinho colab