
/*
=========================================================
💡📋 Programação PL/SQL - Sistema Emissora UFPE CIn 2025.1

Conjunto de procedures, functions e validações PL/SQL 
para automação e controle do banco de dados.
=========================================================
*/

-- Comandos utilizados: DECLARE, TYPE, RECORD, SELECT INTO, DBMS_OUTPUT
-- Objetivo: Criar um tipo registro para funcionário e exibir informações do funcionário do mês
DECLARE 
    TYPE m_employee IS RECORD (
        employee_id employee.employee_id%TYPE,
        employee_salary employee.employee_salary%TYPE,
        employee_supervisor employee.employee_supervisor%TYPE,
        employee_name employee.employee_name%TYPE
    );
    v_employee m_employee;
    monthEmploye_supervisor_name employee.employee_name%TYPE;
BEGIN
    SELECT e.employee_id, e.employee_salary, e.employee_supervisor, e.employee_name
    INTO v_employee
    FROM employee e
    WHERE e.employee_id = 2;

    -- Exibe informações do funcionário do mês
    DBMS_OUTPUT.PUT_LINE('🏆 FUNCIONÁRIO DO MÊS');
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_employee.employee_id);
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_employee.employee_name);
    DBMS_OUTPUT.PUT_LINE('Salário: R$ ' || v_employee.employee_salary);
    
    SELECT e.employee_name
    INTO monthEmploye_supervisor_name
    FROM employee e
    WHERE e.employee_id = v_employee.employee_supervisor;

    DBMS_OUTPUT.PUT_LINE('Supervisor: ' || NVL(monthEmploye_supervisor_name, 'Sem supervisor'));
    

END;
/

-- Comandos utilizados: DECLARE, TYPE TABLE, BULK COLLECT INTO, FOR LOOP, DBMS_OUTPUT
-- Objetivo: Criar um tipo coleção para armazenar nomes de programas e listar programas por gênero
DECLARE 
    TYPE program_names_type IS TABLE OF program.nome%TYPE;
    v_program_names program_names_type;
    v_genre VARCHAR2(50) := 'Drama';
BEGIN
    SELECT p.nome BULK COLLECT INTO v_program_names
    FROM program p
    JOIN genre g ON p.id = g.program_id
    WHERE g.nome = v_genre;
    
    DBMS_OUTPUT.PUT_LINE('📺 Programas do gênero ' || v_genre || ':');
    FOR i IN 1..v_program_names.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('• ' || v_program_names(i));
    END LOOP;
END;
/

-- Comandos utilizados: DECLARE, TYPE TABLE, WHILE LOOP, CASE WHEN, DBMS_OUTPUT
-- Objetivo: Categorizar funcionários por faixa salarial usando WHILE loop com contador manual
DECLARE 
    TYPE emp_table IS TABLE OF employee%ROWTYPE;
    v_category VARCHAR2(50);
    employee_table emp_table ;
    v_counter NUMBER := 1;
    v_total_employees NUMBER;
    
BEGIN
    SELECT * BULK COLLECT INTO employee_table FROM employee ;
    v_total_employees := employee_table.COUNT;
    DBMS_OUTPUT.PUT_LINE('👥 ANÁLISE SALARIAL (' || v_total_employees || ' funcionários):');
    DBMS_OUTPUT.PUT_LINE('================================================');
    WHILE v_counter <= employee_table.COUNT LOOP

        CASE 
            WHEN employee_table(v_counter).employee_salary < 3000 THEN
                v_category := '🟢 Júnior';
            WHEN employee_table(v_counter).employee_salary  BETWEEN 3000 AND 6000 THEN
                v_category := '🟡 Pleno';
            WHEN employee_table(v_counter).employee_salary > 6000 THEN
                v_category := '🔴 Sênior';
            ELSE
                v_category := '⚪ Indefinido';
        END CASE;

    
DBMS_OUTPUT.PUT_LINE(v_counter || '. ' || 
                   employee_table(v_counter).employee_name || 
                   ' - R$ ' || employee_table(v_counter).employee_salary ||
                   ' (' || v_category || ')');

        v_counter := v_counter + 1;
    END LOOP ;
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT_LINE('✅ Processamento concluído: ');

END;
/
            
-- Comandos utilizados: CREATE FUNCTION, IN parameter, RETURN, SELECT INTO, AVG
-- Objetivo: Função simples para calcular receita média de broadcasts por canal
CREATE OR REPLACE FUNCTION calcular_receita_media (
    p_channel_frequency IN NUMBER
) RETURN NUMBER
IS
    v_average_revenue NUMBER := 0;
BEGIN
    SELECT NVL(AVG(broadcast_revenue), 0)
    INTO v_average_revenue
    FROM broadcast 
    WHERE channel_frequency = p_channel_frequency;
    
    RETURN ROUND(v_average_revenue, 2);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1; -- Indica erro
END calcular_receita_media;
/

-- Comandos utilizados: DECLARE, FUNCTION CALL, FOR LOOP, IF/ELSIF/ELSE, DBMS_OUTPUT
-- Objetivo: Bloco anônimo para testar a função e exibir receita média por canal
DECLARE 
    v_receita_media NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('📊 RECEITA MÉDIA POR CANAL');
    DBMS_OUTPUT.PUT_LINE('==========================');
    
    -- Loop para todos os canais
    FOR canal IN (SELECT frequency, channel_name FROM channel ORDER BY frequency) LOOP
        v_receita_media := calcular_receita_media(canal.frequency);
        
        -- Substituindo CASE por IF/ELSIF/ELSE
        IF v_receita_media = -1 THEN
            DBMS_OUTPUT.PUT_LINE(canal.channel_name || ' - ❌ Erro no cálculo');
        ELSIF v_receita_media = 0 THEN
            DBMS_OUTPUT.PUT_LINE(canal.channel_name || ' - 🔴 Sem receita');
        ELSE
            DBMS_OUTPUT.PUT_LINE(canal.channel_name || ' - R$ ' || 
                               TO_CHAR(v_receita_media, '999,999.99') || ' (média)');
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('==========================');
    DBMS_OUTPUT.PUT_LINE('✅ Cálculo concluído');
END;
/

-- Comandos utilizados: CREATE PACKAGE, FUNCTION declaration, PROCEDURE declaration
-- Objetivo: Package simples para gerenciar apenas estúdios
CREATE OR REPLACE PACKAGE pkg_studio_simples IS
    
    -- Functions básicas
    FUNCTION contar_estudios RETURN NUMBER;
    FUNCTION custo_manutencao_total RETURN NUMBER;
    
    -- Procedures básicas
    PROCEDURE listar_estudios;
    PROCEDURE estudios_por_capacidade;
    
END pkg_studio_simples;
/

-- Comandos utilizados: CREATE PACKAGE BODY, CURSOR explícito, OPEN/FETCH/CLOSE
-- Objetivo: Implementação simples do package de estúdios
CREATE OR REPLACE PACKAGE BODY pkg_studio_simples IS

    -- Function: contar total de estúdios
    FUNCTION contar_estudios RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total FROM studio;
        RETURN v_total;
    END contar_estudios;
    
    -- Function: custo total de manutenção
    FUNCTION custo_manutencao_total RETURN NUMBER IS
        v_custo NUMBER;
    BEGIN
        SELECT NVL(SUM(maintenance_cost), 0) INTO v_custo FROM studio;
        RETURN v_custo;
    END custo_manutencao_total;
    
    -- Procedure: listar estúdios com cursor explícito
    PROCEDURE listar_estudios IS
        -- Cursor explícito simples
        CURSOR cur_estudios IS
            SELECT studio_id, studio_name, studio_capacity, maintenance_cost
            FROM studio
            ORDER BY studio_name;
        
        rec_studio cur_estudios%ROWTYPE;
        v_contador NUMBER := 0;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('🏢 LISTA DE ESTÚDIOS');
        DBMS_OUTPUT.PUT_LINE('===================');
        
        -- OPEN: Abre o cursor
        OPEN cur_estudios;
        
        LOOP
            -- FETCH: Busca próximo estúdio
            FETCH cur_estudios INTO rec_studio;
            
            -- Sai quando não há mais estúdios
            EXIT WHEN cur_estudios%NOTFOUND;
            
            v_contador := v_contador + 1;
            
            DBMS_OUTPUT.PUT_LINE(v_contador || '. ' || rec_studio.studio_name);
            DBMS_OUTPUT.PUT_LINE('   👥 Capacidade: ' || rec_studio.studio_capacity);
            DBMS_OUTPUT.PUT_LINE('   💸 Manutenção: R$ ' || rec_studio.maintenance_cost);
            
            -- Categoriza por capacidade
            IF rec_studio.studio_capacity > 100 THEN
                DBMS_OUTPUT.PUT_LINE('   🔴 Porte: GRANDE');
            ELSIF rec_studio.studio_capacity >= 50 THEN
                DBMS_OUTPUT.PUT_LINE('   🟡 Porte: MÉDIO');
            ELSE
                DBMS_OUTPUT.PUT_LINE('   🟢 Porte: PEQUENO');
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('   ─────────────────');
        END LOOP;
        
        -- CLOSE: Fecha o cursor
        CLOSE cur_estudios;
        
        DBMS_OUTPUT.PUT_LINE('✅ Total: ' || v_contador || ' estúdios');
        
    EXCEPTION
        WHEN OTHERS THEN
            IF cur_estudios%ISOPEN THEN
                CLOSE cur_estudios;
            END IF;
            DBMS_OUTPUT.PUT_LINE('❌ Erro: ' || SQLERRM);
    END listar_estudios;
    
    -- Procedure: ranking por capacidade
    PROCEDURE estudios_por_capacidade IS
        -- Cursor explícito ordenado por capacidade
        CURSOR cur_ranking IS
            SELECT studio_name, studio_capacity, maintenance_cost
            FROM studio
            ORDER BY studio_capacity DESC;
        
        rec_ranking cur_ranking%ROWTYPE;
        v_posicao NUMBER := 0;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('🏆 RANKING POR CAPACIDADE');
        DBMS_OUTPUT.PUT_LINE('========================');
        
        -- OPEN: Abre cursor
        OPEN cur_ranking;
        
        LOOP
            -- FETCH: Busca próximo estúdio
            FETCH cur_ranking INTO rec_ranking;
            
            -- Sai quando não há mais estúdios
            EXIT WHEN cur_ranking%NOTFOUND;
            
            v_posicao := v_posicao + 1;
            
            DBMS_OUTPUT.PUT_LINE(v_posicao || '. ' || rec_ranking.studio_name);
            DBMS_OUTPUT.PUT_LINE('   👥 Capacidade: ' || rec_ranking.studio_capacity);
            DBMS_OUTPUT.PUT_LINE('   💸 Manutenção: R$ ' || rec_ranking.maintenance_cost);
            DBMS_OUTPUT.PUT_LINE('   ─────────────────');
        END LOOP;
        
        -- CLOSE: Fecha cursor
        CLOSE cur_ranking;
        
        DBMS_OUTPUT.PUT_LINE('✅ Ranking completo');
        
    EXCEPTION
        WHEN OTHERS THEN
            IF cur_ranking%ISOPEN THEN
                CLOSE cur_ranking;
            END IF;
            DBMS_OUTPUT.PUT_LINE('❌ Erro: ' || SQLERRM);
    END estudios_por_capacidade;
    
END pkg_studio_simples;
/

-- Comandos utilizados: PACKAGE function/procedure call, DBMS_OUTPUT
-- Objetivo: Teste simples do package
DECLARE
    v_total NUMBER;
    v_custo NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('🧪 TESTE PACKAGE ESTÚDIOS');
    DBMS_OUTPUT.PUT_LINE('========================');
    
    v_total := pkg_studio_simples.contar_estudios;
    v_custo := pkg_studio_simples.custo_manutencao_total;
    
    DBMS_OUTPUT.PUT_LINE('Total estúdios: ' || v_total);
    DBMS_OUTPUT.PUT_LINE('Custo total: R$ ' || v_custo);
    DBMS_OUTPUT.PUT_LINE('');
    
    pkg_studio_simples.listar_estudios;
    DBMS_OUTPUT.PUT_LINE('');
    pkg_studio_simples.estudios_por_capacidade;
END;
/

-- Comandos utilizados: CREATE TRIGGER, AFTER INSERT, DBMS_OUTPUT (COMANDO - sem FOR EACH ROW)
-- Objetivo: Trigger de comando para log simples de inserções na tabela employee
CREATE OR REPLACE TRIGGER trg_employee_log_comando
    AFTER INSERT ON employee
BEGIN
    -- Executa UMA VEZ por comando INSERT, independente de quantos funcionários foram inseridos
    DBMS_OUTPUT.PUT_LINE('🔔 OPERAÇÃO REALIZADA: Novo(s) funcionário(s) cadastrado(s)');
    DBMS_OUTPUT.PUT_LINE('📅 Data/Hora: ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('👤 Usuário: ' || USER);
    DBMS_OUTPUT.PUT_LINE('─────────────────────────────────────');
END;
/

-- Comandos utilizados: CREATE TRIGGER, AFTER UPDATE, DBMS_OUTPUT (COMANDO - sem FOR EACH ROW)
-- Objetivo: Trigger de comando para log de atualizações salariais
CREATE OR REPLACE TRIGGER trg_salary_update_comando
    AFTER UPDATE OF employee_salary ON employee
BEGIN
    -- Executa UMA VEZ por comando UPDATE de salário
    DBMS_OUTPUT.PUT_LINE('💰 ATUALIZAÇÃO SALARIAL REALIZADA');
    DBMS_OUTPUT.PUT_LINE('📅 ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('👤 Por: ' || USER);
    DBMS_OUTPUT.PUT_LINE('─────────────────────────────────────');
END;
/

-- Comandos utilizados: CREATE TRIGGER, AFTER INSERT, DBMS_OUTPUT (COMANDO - sem FOR EACH ROW)
-- Objetivo: Trigger de comando para log de novos estúdios
CREATE OR REPLACE TRIGGER trg_studio_log_comando
    AFTER INSERT ON studio
BEGIN
    -- Executa UMA VEZ por comando INSERT na tabela studio
    DBMS_OUTPUT.PUT_LINE('🏢 NOVO ESTÚDIO CADASTRADO');
    DBMS_OUTPUT.PUT_LINE('📅 ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('👤 Cadastrado por: ' || USER);
END;
/

-- Comandos utilizados: INSERT, trigger test
-- Objetivo: Teste dos triggers de comando
BEGIN
    DBMS_OUTPUT.PUT_LINE('🧪 TESTANDO TRIGGERS DE COMANDO');
    DBMS_OUTPUT.PUT_LINE('===============================');
    
    -- Teste 1: Insert de um funcionário (trigger executa 1 vez)
    INSERT INTO employee (employee_id, employee_name, employee_salary, employee_supervisor)
    VALUES (999, 'João Teste', 4500, NULL);
    
    -- Teste 2: Update de salários (trigger executa 1 vez, mesmo afetando múltiplas linhas)
    UPDATE employee 
    SET employee_salary = employee_salary + 100 
    WHERE employee_salary < 5000;
    
    -- Teste 3: Insert de estúdio (trigger executa 1 vez)
    INSERT INTO studio (studio_id, studio_name, studio_capacity, maintenance_cost, address_id)
    VALUES (999, 'Estúdio Teste', 75, 2500, 1);
    
    DBMS_OUTPUT.PUT_LINE('✅ Testes concluídos');
    
    -- Limpa os dados de teste
    DELETE FROM employee WHERE employee_id = 999;
    DELETE FROM studio WHERE studio_id = 999;
    
END;
/