-- TABELA: Paciente
CREATE TABLE Paciente (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INTEGER
);

-- TABELA: Responsavel (é uma entidade independente, não um paciente)
CREATE TABLE Responsavel (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INTEGER
);

-- RELAÇÃO: ResponsávelPor
CREATE TABLE ResponsavelPor (
    paciente_cpf VARCHAR(11),
    responsavel_cpf VARCHAR(11),
    PRIMARY KEY (paciente_cpf),
    FOREIGN KEY (paciente_cpf) REFERENCES Paciente(cpf),
    FOREIGN KEY (responsavel_cpf) REFERENCES Responsavel(cpf)
);

-- TABELA: Medico
CREATE TABLE Medico (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INTEGER,
    qualificacao VARCHAR(255) NOT NULL
);

-- TABELA: Rede de Clínica
CREATE TABLE RedeClinica (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    custo NUMERIC(10,2) NOT NULL
);

-- RELAÇÃO: Assina/Associado
CREATE TABLE AssociacaoPacienteClinica (
    paciente_cpf VARCHAR(11),
    clinica_id INTEGER,
    PRIMARY KEY (paciente_cpf, clinica_id),
    FOREIGN KEY (paciente_cpf) REFERENCES Paciente(cpf),
    FOREIGN KEY (clinica_id) REFERENCES RedeClinica(id)
);

-- RELAÇÃO: Trabalha
CREATE TABLE MedicoClinica (
    medico_cpf VARCHAR(11),
    clinica_id INTEGER,
    PRIMARY KEY (medico_cpf, clinica_id),
    FOREIGN KEY (medico_cpf) REFERENCES Medico(cpf),
    FOREIGN KEY (clinica_id) REFERENCES RedeClinica(id)
);

-- RELAÇÃO: Atendimento (Paciente é atendido por Médico)
CREATE TABLE Atendimento (
    paciente_cpf VARCHAR(11),
    medico_cpf VARCHAR(11),
    data DATE,
    PRIMARY KEY (paciente_cpf, medico_cpf, data),
    FOREIGN KEY (paciente_cpf) REFERENCES Paciente(cpf),
    FOREIGN KEY (medico_cpf) REFERENCES Medico(cpf)
);

-- TABELA: Vicio
CREATE TABLE Vicio (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- RELAÇÃO: TemVicio
CREATE TABLE TemVicio (
    paciente_cpf VARCHAR(11),
    vicio_id INTEGER,
    PRIMARY KEY (paciente_cpf, vicio_id),
    FOREIGN KEY (paciente_cpf) REFERENCES Paciente(cpf),
    FOREIGN KEY (vicio_id) REFERENCES Vicio(id)
);

-- TABELA: HistoricoVicio (relacionamento com atributos)
CREATE TABLE HistoricoVicio (
    paciente_cpf VARCHAR(11),
    vicio_id INTEGER,
    qtd_tempo INTERVAL,
    qtd_dinheiro NUMERIC(10,2),
    qtd_acessos INTEGER,
    PRIMARY KEY (paciente_cpf, vicio_id),
    FOREIGN KEY (paciente_cpf) REFERENCES Paciente(cpf),
    FOREIGN KEY (vicio_id) REFERENCES Vicio(id)
);

-- TABELA: Sintoma
CREATE TABLE Sintoma (
    nome VARCHAR(100) PRIMARY KEY,
    descricao TEXT,
    gravidade INTEGER CHECK (gravidade BETWEEN 1 AND 10)
);

-- RELAÇÃO: Causa (Vício causa Sintoma)
CREATE TABLE Causa (
    vicio_id INTEGER,
    sintoma_nome VARCHAR(100),
    PRIMARY KEY (vicio_id, sintoma_nome),
    FOREIGN KEY (vicio_id) REFERENCES Vicio(id),
    FOREIGN KEY (sintoma_nome) REFERENCES Sintoma(nome)
);
