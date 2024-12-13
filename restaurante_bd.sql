-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 12/12/2024 às 22:53
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `restaurante_bd`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `imagem` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categorias`
--

INSERT INTO `categorias` (`id`, `nome`, `imagem`) VALUES
(1, 'Massas', 'categoria_massas.png'),
(2, 'Bebidas', 'categoria_bebidas.png'),
(3, 'Pizzas', 'categoria_pizzas.png'),
(4, 'Sobremesas', 'categoria_sobremesas.png'),
(5, 'saladas', 'categoria_saladas.png');

-- --------------------------------------------------------

--
-- Estrutura para tabela `mensagens`
--

CREATE TABLE `mensagens` (
  `id` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `mensagem` varchar(1000) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp(),
  `tratado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `mensagens`
--

INSERT INTO `mensagens` (`id`, `nome`, `email`, `mensagem`, `data`, `tratado`) VALUES
(1, '1', '1@1.a', '1', '2024-11-06 14:59:54', 1),
(2, '2', '2@2.aa', '2', '2024-11-06 15:00:18', NULL),
(3, '3', '3@3.mm', '3', '2024-11-06 15:00:51', NULL),
(4, 'Filipa Ferreira', 'mglxhome@gmail.com', 'ggggg', '2024-11-07 09:23:23', NULL),
(5, 'testezinhooooo', 's@s.com', 'aeeeee', '2024-12-12 20:51:35', NULL),
(6, 'vero', 'vero@vero.com', 'iascbnoiabscl', '2024-12-12 21:01:08', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(200) NOT NULL,
  `preco` float(10,2) NOT NULL,
  `imagem` varchar(255) NOT NULL,
  `id_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `descricao`, `preco`, `imagem`, `id_categoria`) VALUES
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
(20, 'Salada de Grão-de-Bico com Atum', 'Grão-de-bico, atum, cebola roxa e temperos frescos.', 6.40, 'salada_graoatum.png', 5),
(21, 'Imperial 25cl - (Super Bock)', 'Cerveja clássica no formato de 25cl.', 1.60, 'imperial.png', 2),
(22, 'Caneca 50cl - (Super Bock)', 'Cerveja clássica em caneca de 50cl.', 2.40, 'caneca.png', 2),
(23, 'Cerveja Artesanal 33cl', 'Cerveja artesanal de alta qualidade.', 3.60, 'cerveja_artesanal.png', 2),
(24, 'Cerveja sem Álcool 33cl - Super Bock 00', 'Cerveja sem álcool para uma experiência leve.', 2.00, 'cervejaSemAlcool.png', 2),
(25, 'Água das Pedras', 'Água mineral gaseificada, ideal para refrescar.', 1.50, 'aguaPedras.png', 2),
(26, 'Sangria (tinta ou branca)', 'Tradicional sangria, disponível em versão tinta ou branca.', 3.00, 'sangria.png', 2),
(27, 'Sumo Natural de Laranja 30cl', 'Sumo de laranja fresco e natural.', 2.50, 'sumo_laranja.png', 2),
(28, 'Sumo de Ananás', 'Delicioso sumo de ananás.', 2.50, 'sumo_ananas.png', 2),
(29, 'Sumo de Pêssego', 'Sumo refrescante de pêssego.', 2.50, 'sumo_pessego.png', 2),
(30, 'Limonada Artesanal', 'Limonada fresca preparada artesanalmente.', 2.80, 'limonada.png', 2),
(31, 'Mojito Clássico', 'Coquetel refrescante com hortelã e rum.', 4.50, 'mojito.png', 2),
(32, 'Caipirinha de Lima', 'Caipirinha clássica com limão e cachaça.', 4.00, 'caipirinha.png', 2),
(33, 'Gin Tónico Clássico', 'Gin combinado com água tónica e limão.', 5.00, 'ginTonico.png', 2),
(34, 'Porto Tónico', 'Combinação de vinho do Porto branco com água tónica.', 4.50, 'portoTonico.png', 2),
(35, 'Vinho Verde Branco (copo) 250cl', 'Vinho verde branco servido no copo.', 3.50, 'vinhoVerde.png', 2),
(36, 'Iced Tea de Limão', 'Chá gelado com sabor a limão.', 2.20, 'icedTea_limao.png', 2),
(37, 'Água Tónica', 'Água gaseificada com toque amargo.', 1.80, 'aguaTonica.png', 2),
(38, 'Baba de Camelo', 'Sobremesa portuguesa cremosa feita de leite condensado e ovos.', 2.50, 'sobremesa_baba.png', 4),
(39, 'Pastel de Nata', 'Deliciosa massa folhada com recheio cremoso de ovos.', 1.50, 'sobremesa_pastel.png', 4),
(40, 'Arroz Doce', 'Clássica sobremesa portuguesa de arroz com leite e canela.', 2.00, 'sobremesa_arroz.png', 4),
(41, 'Tarte de Amêndoa', 'Tarte crocante de amêndoas caramelizadas.', 2.80, 'sobremesa_tardeAmendoas.png', 4),
(42, 'Pão-de-Ló de Ovar', 'Tradicional pão-de-ló português, com interior cremoso.', 3.00, 'sobremesa_paoDeLo.png', 4),
(43, 'Pudim', 'Pudim caseiro feito com ovos e caramelo.', 2.50, 'sobremesa_pudim.png', 4),
(44, 'Mousse de Chocolate', 'Mousse cremosa feita com chocolate belga.', 2.80, 'sobremesa_mousseChocolate.png', 4),
(45, 'Queijada de Sintra', 'Pequena torta doce feita com queijo fresco e açúcar.', 2.00, 'sobremesa_queijada.png', 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `data` date NOT NULL,
  `horario` time NOT NULL,
  `pessoas` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `reservas`
--

INSERT INTO `reservas` (`id`, `nome`, `telefone`, `data`, `horario`, `pessoas`, `created_at`) VALUES
(1, 'Filipa Ferreira', '911083609', '2025-04-15', '12:00:00', 200, '2024-11-06 20:57:45'),
(5, 'teste', '910514897', '2024-11-30', '21:00:00', 4, '2024-11-06 21:12:36'),
(6, 'teste', '910514897', '2024-11-15', '12:30:00', 10, '2024-11-07 09:22:44'),
(7, 'teste cintia', '99999999', '2024-12-09', '12:00:00', 3977, '2024-12-11 15:22:40'),
(8, 'testezinhooooo', '99999999', '2024-12-22', '22:56:00', 3977, '2024-12-12 20:52:03'),
(9, 'vero', '99999999', '2024-12-12', '00:01:00', 9999999, '2024-12-12 21:00:10');

-- --------------------------------------------------------

--
-- Estrutura para tabela `utilizador`
--

CREATE TABLE `utilizador` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `mensagens`
--
ALTER TABLE `mensagens`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_categorias_produtos` (`id_categoria`);

--
-- Índices de tabela `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `utilizador`
--
ALTER TABLE `utilizador`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `mensagens`
--
ALTER TABLE `mensagens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de tabela `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `utilizador`
--
ALTER TABLE `utilizador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `produtos`
--
ALTER TABLE `produtos`
  ADD CONSTRAINT `FK_categorias_produtos` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
