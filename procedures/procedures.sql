CREATE OR REPLACE PROCEDURE insert_episode_content (
    p_production_status IN NUMBER,
    p_duration         IN NUMBER,
    p_title            IN VARCHAR2,
    p_id_program       IN NUMBER,
    p_season_number    IN NUMBER
) AS
    v_content_id content.content_id%TYPE;
BEGIN
    -- Insere na tabela content e pega o novo content_id
    INSERT INTO content (content_production_status, content_duration, content_title)
    VALUES (p_production_status, p_duration, p_title)
    RETURNING content_id INTO v_content_id;

    -- Insere na tabela episode usando o content_id gerado
    INSERT INTO episode (content_id, id_program, season_number)
    VALUES (v_content_id, p_id_program, p_season_number);
END;
/

CREATE OR REPLACE PROCEDURE insert_advertisement_content (
    p_production_status IN NUMBER,
    p_duration         IN NUMBER,
    p_title            IN VARCHAR2,
    p_target_audience  IN VARCHAR2
) AS
    v_content_id content.content_id%TYPE;
BEGIN
    -- Insere na tabela content e pega o novo content_id
    INSERT INTO content (content_production_status, content_duration, content_title)
    VALUES (p_production_status, p_duration, p_title)
    RETURNING content_id INTO v_content_id;

    -- Insere na tabela advertisement usando o content_id gerado
    INSERT INTO advertisement (advertisement_id, target_audience)
    VALUES (v_content_id, p_target_audience);
END;
/