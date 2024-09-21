-- Tabela de usuários
CREATE TABLE Usuario (
    email VARCHAR(255) PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    senha VARCHAR(255),
    data_nascimento DATE
);

-- Tabela de telefones dos usuários
CREATE TABLE Telefone (
    usuario_email VARCHAR(255),
    telefone VARCHAR(20),
    PRIMARY KEY(usuario_email, telefone),
    FOREIGN KEY (usuario_email) REFERENCES Usuario(email)
);

-- Tabela de restaurantes
CREATE TABLE Restaurante (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) UNIQUE,
    cidade VARCHAR(40),
    rua VARCHAR(60),
    numero VARCHAR(10)
);

-- Tabela de horários dos restaurantes
CREATE TABLE Horario (
    id_restaurante INT,
    hora_inicio TIME,
    hora_final TIME,
    PRIMARY KEY (id_restaurante, hora_inicio, hora_final),
    FOREIGN KEY (id_restaurante) REFERENCES Restaurante(id) ON DELETE CASCADE
);

-- Tabela de avaliações dos restaurantes
CREATE TABLE Avaliacao (
    usuario_email VARCHAR(255) NOT NULL,
    id_restaurante INT NOT NULL,
    estrelas INT NOT NULL CHECK (estrelas >= 0 AND estrelas <= 5),
    comentario TEXT,
    data_avaliacao DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (usuario_email, id_restaurante),
    FOREIGN KEY (usuario_email) REFERENCES Usuario(email),
    FOREIGN KEY (id_restaurante) REFERENCES Restaurante(id)
);

-- Tabela de reservas dos restaurantes
CREATE TABLE Reserva (
    usuario_email VARCHAR(255) NOT NULL,
    id_restaurante INT NOT NULL,
    numero_mesa INT NOT NULL,
    data_reserva DATE NOT NULL,
    horario_reserva TIME NOT NULL,
    PRIMARY KEY (usuario_email, id_restaurante, numero_mesa, data_reserva, horario_reserva),
    FOREIGN KEY (usuario_email) REFERENCES Usuario(email),
    FOREIGN KEY (id_restaurante) REFERENCES Restaurante(id) ON DELETE CASCADE
);

-- Tabela para restaurantes de cozinha única
CREATE TABLE RestauranteUnico (
    id_restaurante INT PRIMARY KEY,
    tipo_cozinha VARCHAR(100) NOT NULL,
    cozinheiro_chefe VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_restaurante) REFERENCES Restaurante(id) ON DELETE CASCADE
);

-- Tabela para restaurantes com múltiplas cozinhas
CREATE TABLE RestauranteMultiplo (
    id_restaurante INT PRIMARY KEY,
    FOREIGN KEY (id_restaurante) REFERENCES Restaurante(id) ON DELETE CASCADE
);

-- Tabela para detalhes de cada cozinha para restaurantes múltiplos
CREATE TABLE DetalhesCozinha (
    id_restaurante INT,
    tipo_cozinha VARCHAR(255) NOT NULL,
    cozinheiro_chefe VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_restaurante, tipo_cozinha),
    FOREIGN KEY (id_restaurante) REFERENCES RestauranteMultiplo(id_restaurante)
);

SELECT * FROM Usuario;
