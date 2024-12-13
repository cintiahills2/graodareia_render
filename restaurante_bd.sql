-- PostgreSQL SQL Dump

-- Banco de dados: restaurante_bd

-- Criar esquema
CREATE SCHEMA IF NOT EXISTS restaurante_bd;
SET search_path TO restaurante_bd;

-- --------------------------------------------------------

-- Estrutura para tabela categorias
CREATE TABLE categorias (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  imagem VARCHAR(255) NOT NULL
);

-- Dados para tabela categorias
INSERT INTO categorias (id, nome, imagem) VALUES
(1, 'Massas', 'categoria_massas.png'),
(2, 'Bebidas', 'categoria_bebidas.png'),
(3, 'Pizzas', 'categoria_pizzas.png'),
(4, 'Sobremesas', 'categoria_sobremesas.png'),
(5, 'Saladas', 'categoria_saladas.png');

-- --------------------------------------------------------

-- Estrutura para tabela mensagens
CREATE TABLE mensagens (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  email VARCHAR(200) NOT NULL,
  mensagem VARCHAR(1000) NOT NULL,
  data TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  tratado BOOLEAN
);

-- Dados para tabela mensagens
INSERT INTO mensagens (id, nome, email, mensagem, data, tratado) VALUES
(1, '1', '1@1.a', '1', '2024-11-06 14:59:54', TRUE),
(2, '2', '2@2.aa', '2', '2024-11-06 15:00:18', NULL),
(3, '3', '3@3.mm', '3', '2024-11-06 15:00:51', NULL),
(4, 'Filipa Ferreira', 'mglxhome@gmail.com', 'ggggg', '2024-11-07 09:23:23', NULL),
(5, 'testezinhooooo', 's@s.com', 'aeeeee', '2024-12-12 20:51:35', NULL),
(6, 'vero', 'vero@vero.com', 'iascbnoiabscl', '2024-12-12 21:01:08', NULL);

-- --------------------------------------------------------

-- Estrutura para tabela produtos
CREATE TABLE produtos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  descricao VARCHAR(200) NOT NULL,
  preco NUMERIC(10, 2) NOT NULL,
  imagem VARCHAR(255) NOT NULL,
  id_categoria INT NOT NULL REFERENCES categorias(id)
);

-- Dados para tabela produtos
INSERT INTO produtos (id, nome, descricao, preco, imagem, id_categoria) VALUES
(1, 'Pizza Margherita', 'Clássica pizza italiana com molho de tomate, mozzarella e manjericão fresco.', 7.00, 'pizza_margherita.png', 3),
(2, 'Pizza Pepperoni', 'Molho de tomate, queijo mozzarella e fatias generosas de pepperoni.', 8.00, 'pizza_peperoni.png', 3),
(3, 'Pizza Quatro Queijos', 'Mistura especial de mozzarella, parmesão, gorgonzola e provolone.', 8.50, 'pizza_4queijos.png', 3),
(4, 'Pizza Bacalhau', 'Pizza com lascas de bacalhau, cebola, azeitonas e salsa.', 10.00, 'pizza_bacalhau.png', 3),
(5, 'Pizza Queijo da Serra', 'Feita com queijo da Serra da Estrela e um toque de alecrim.', 11.00, 'pizza_queijoserra.png', 3),
(6, 'Pizza Atum', 'Molho de tomate, queijo, atum e cebola roxa.', 7.50, 'pizza_atum.png', 3),
(7, 'Pizza Cogumelos e Espinafres', 'Cobertura de cogumelos frescos, espinafres e mozzarella.', 7.40, 'pizza_cogumelos.png', 3),
(8, 'Pizza Alheira com Rúcula', 'Alheira portuguesa com folhas de rúcula e mozzarella.', 9.00, 'pizza_alheira.png', 3),
(9, 'Spaghetti à Bolonhesa', 'Spaghetti com molho bolonhesa feito com carne moída e tomate.', 6.40, 'massa_bolognesa.png', 1),
(10, 'Penne à Carbonara', 'Penne com molho de ovos, queijo e pedaços de bacon.', 7.20, 'massa_carbonara.png', 1),
(11, 'Tagliatelle com Gambas e Alho', 'Tagliatelle com camarões salteados no alho.', 9.60, 'massa_gamba.png', 1),
(12, 'Lasagna de Bacalhau', 'Lasagna recheada com camadas de bacalhau desfiado e molho branco.', 10.40, 'lasagna_bacalhau.png', 1),
(13, 'Ravioli de Queijo e Espinafres', 'Ravioli artesanal recheado com queijo ricota e espinafre.', 8.40, 'ravioli.png', 1),
(14, 'Fettuccine com Cogumelos', 'Fettuccine servido com molho cremoso de cogumelos.', 8.00, 'massa_cogumelos.png', 1),
(15, 'Linguine com Amêijoas', 'Linguine servido com amêijoas frescas e azeite.', 10.00, 'massa_ameijoas.png', 1),
(16, 'Canelone de Frango com Bechamel', 'Canelone recheado com frango e coberto com molho bechamel.', 9.20, 'canelone.png', 1),
(17, 'Salada Caesar', 'Clássica salada com alface romana, croutons, parmesão e molho Caesar.', 5.00, 'salada_caesar.png', 5),
(18, 'Salada Mediterrânea com Queijo Feta', 'Mix de vegetais frescos com azeitonas, queijo feta e azeite.', 5.60, 'salada_mediterranea.png', 5),
(19, 'Salada de Frango Grelhado', 'Alface, tomate, cenoura e frango grelhado com molho de sua escolha.', 6.00, 'salada_frango.png', 5),
(20, 'Salada de Grão-de-Bico com Atum', 'Grão-de-bico, atum, cebola roxa e temperos frescos.', 6.40, 'salada_graoatum.png', 5);

-- --------------------------------------------------------

-- Estrutura para tabela reservas
CREATE TABLE reservas (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  data DATE NOT NULL,
  horario TIME NOT NULL,
  pessoas INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Dados para tabela reservas
INSERT INTO reservas (id, nome, telefone, data, horario, pessoas, created_at) VALUES
(1, 'Filipa Ferreira', '911083609', '2025-04-15', '12:00:00', 200, '2024-11-06 20:57:45'),
(2, 'Teste', '910514897', '2024-11-30', '21:00:00', 4, '2024-11-06 21:12:36');

-- --------------------------------------------------------

-- Estrutura para tabela utilizador
CREATE TABLE utilizador (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
