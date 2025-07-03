# 📺 Banco de Dados Emissora TV/Rádio

Sistema de gerenciamento completo para emissoras de televisão e rádio desenvolvido em Oracle Database.

---

## 👥 Equipe de Desenvolvimento

- **Pedro Moraes** (phmss)  
- **Matheus Silva** (mhbs4)  
- **Arlindo** (apsj)  
- **Marcus Vinícius** (mvsl2)  
- **Gabriel Correia** (gcb2)  
- **Aline Acioly** (aan4)
- **Layla** (lbbs)

**Instituição:** Universidade Federal de Pernambuco (UFPE) - Centro de Informática  
**Disciplina:** Banco de Dados - 2025.1

---

## 📄 Descrição do Projeto

Este projeto implementa um banco de dados completo para gerenciar todas as operações de uma emissora de TV/Rádio.

- 📦 **Programas e Episódios**: Gestão completa de programas, temporadas e episódios  
- 📢 **Sistema Publicitário**: Anunciantes, campanhas e anúncios  
- 👩‍💼 **Recursos Humanos**: Funcionários em estrutura hierárquica  
- 🎬 **Produção**: Estudos, produções e participações  
- 📡 **Transmissão**: Canais, exibições e interrupções publicitárias

---

## 📁 Estrutura do Projeto

```
db-project/
├── sequences/         # Sequências para geração de IDs
│   └── sequences.sql
├── tables/            # Estrutura completa das tabelas
│   └── tables_schema.sql
├── procedures/        # Procedures para inserção de dados
│   └── procedures.sql
├── triggers/          # Triggers de automação e validação
│   └── bd_triggers.sql
├── inserts/           # Povoamento completo do banco
│   └── bd_inserts.sql
└── sql_pl/            # Programação PL/SQL avançada
    ├── pl_checklist.sql    # Checklist completo PL/SQL
    └── sql_checklist.sql   # Comandos SQL essenciais
```

---

## 🚀 Como Executar

### Ordem de Execução (OBRIGATÓRIA)

Execute os scripts na seguinte ordem para garantir que todas as dependências sejam respeitadas:

```sql
-- 1. Criar sequências
@sequences/sequences.sql

-- 2. Criar estrutura das tabelas
@tables/tables_schema.sql

-- 3. Criar procedures
@procedures/procedures.sql

-- 4. Criar triggers
@triggers/bd_triggers.sql

-- 5. Popular o banco com dados
@inserts/bd_inserts.sql

-- 6. (Opcional) Executar exemplos PL/SQL
@sql_pl/pl_checklist.sql
@sql_pl/sql_checklist.sql
```

---

## ✅ Pré-requisitos

- Oracle Database 11g ou superior  
- SQL*Plus ou Oracle SQL Developer  
- Privilégios para criação de objetos no schema  

---

## 🧪 Como Testar

### 1. Verificar Estrutura das Tabelas

```sql
SELECT table_name FROM user_tables ORDER BY table_name;
```

### 2. Verificar Constraints

```sql
SELECT constraint_name, table_name, constraint_type
FROM user_constraints
WHERE table_name IN ('PROGRAM', 'EPISODE', 'ADVERTISEMENT')
ORDER BY table_name;
```

### 3. Verificar Dados Inseridos

```sql
-- Contar registros por tabela
SELECT 'PROGRAM' AS tabela, COUNT(*) AS registros FROM program
UNION ALL
SELECT 'EPISODE', COUNT(*) FROM episode
UNION ALL
SELECT 'ADVERTISEMENT', COUNT(*) FROM advertisement
UNION ALL
SELECT 'EMPLOYEE', COUNT(*) FROM employee;
```

### 4. Testar Relacionamentos

```sql
-- Programas e seus gêneros
SELECT p.nome, g.nome AS genero
FROM program p
LEFT JOIN genre g ON p.id = g.program_id;

-- Funcionários e supervisores
SELECT e.employee_name, s.employee_name AS supervisor
FROM employee e
LEFT JOIN employee s ON e.employee_supervisor = s.employee_id;
```

### 5. Testar Triggers (Validações)

```sql
-- Deve falhar – classificação inválida
INSERT INTO program (nome, classifc_ind) VALUES ('Teste Erro', 99);

-- Deve falhar – referência inexistente
INSERT INTO episode (content_id, id_program, season_number)
VALUES (999, 999, 1);
```

### 6. Verificar Sequences

```sql
SELECT sequence_name, last_number FROM user_sequences;
```

---

## 🎯 Funcionalidades Principais

### Gestão de Programas
- 🟪 Criação automática de IDs via sequences
- 🟪 Controle de temporadas (ongoing/finished)
- 🟪 Numeração automática de episódios
- 🟪 Múltiplos gêneros por programa

### Sistema Publicitário
- 🟪 Relacionamento anunciantes-campanhas-anúncios
- 🟪 Controle de orçamento e público-alvo
- 🟪 Interrupções programadas durante transmissões

### Recursos Humanos
- 🟪 Estrutura hierárquica de funcionários
- 🟪 Participação em produções com controle de funções
- 🟪 Validação automática de dados via triggers

### Produção de Conteúdo
- 🟪 Gestão de estúdios e endereços
- 🟪 Controle de custos e cronogramas
- 🟪 Relacionamento produção-participação

---

## 💡 Programação PL/SQL

O projeto inclui exemplos abrangentes de programação PL/SQL:

### pl_checklist.sql
- **Records e Collections**: Tipos customizados para dados complexos
- **Functions e Procedures**: Cálculos de receita e estatísticas
- **Packages**: Organização modular do código
- **Cursors Explícitos**: Controle manual com OPEN/FETCH/CLOSE
- **Triggers de Comando**: Logs automáticos de operações
- **Exception Handling**: Tratamento robusto de erros

### sql_checklist.sql
- **26 Comandos SQL**: Desde ALTER TABLE até CREATE VIEW
- **JOINs Avançados**: INNER, LEFT, RIGHT, FULL OUTER
- **Subconsultas**: Com operadores relacionais, IN, ANY, ALL
- **Funções Agregadas**: MAX, MIN, AVG, COUNT
- **Agrupamento**: GROUP BY e HAVING
- **Operações de Conjunto**: UNION, INTERSECT, MINUS

---

## 📋  Estatísticas do Banco

- 17 Tabelas inter-relacionadas  
- 25 Funcionários em estrutura hierárquica  
- 10 Programas com múltiplas temporadas  
- 47 Episódios distribuídos entre os programas  
- 18 Anúncios publicitários  
- 8 Anunciantes com 12 campanhas  
- 3 Canais especializados  
- 3 Estúdios de produção

---

## 🛠️ Tecnologias Utilizadas

- **Oracle Database** – Sistema de gerenciamento de banco de dados  
- **PL/SQL** – Procedures, functions, packages, triggers e blocos anônimos  
- **SQL** – Linguagem de consulta e manipulação de dados completa

---

## ⚠️ Observações Importantes

- O script de limpeza (`DELETE`) deve ser executado antes de repovoar o banco  
- As triggers garantem a integridade e automação do sistema  
- Todas as constraints de integridade referencial estão implementadas  
- O banco está populado com dados realistas para testes
- Os exemplos PL/SQL servem como material de estudo e referência

---

## 📌 Status

- **Status:** Completo 
- **Versão:** 2.0  
- **Data:** Julho 2025
- **Licença:** MIT License

---

## 🤝 Contribuições

Este projeto foi desenvolvido como trabalho acadêmico para a disciplina de Banco de Dados da UFPE. Contribuições são bem-vindas através de issues e pull requests.

---

## 📞 Contato

Para dúvidas ou sugestões, entre em contato com a equipe de desenvolvimento através dos usuários listados na seção de equipe.