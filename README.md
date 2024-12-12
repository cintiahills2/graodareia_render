# A restaurant project in python, made by Filipa and Cíntia

# UFCD 10790 - Projeto de Programação

# WebPage de Cardápio com funcionalidades de administrador

Uma pagina web desenvolvida em Python para gerir um cardapio digital.
Ao utilizador permite ver o cardapio, fazer uma reserva e contactar o comerciante. As funcionalidades de administrador permitem gerir produtos do cardapio, pedidos de reserva e contactos.

## Índice

- [Introdução](#introdução)
- [Âmbito do Projeto](#âmbito-do-projeto)
- [Levantamento de Requisitos](#levantamento-de-requisitos)
- [Elaboração do Projeto](#elaboração-do-projeto)
- [Desempenho do Projeto](#desempenho-do-projeto)
- [Como Executar o Projeto](#como-executar-o-projeto)
- [Resultados](#resultados)
- [Conclusão](#conclusão)
- [Trabalhos Futuros](#trabalhos-futuros)

## Introdução

Este projeto consiste numa página web que permite aos utilizadores visualizar um cardápio de produtos de forma digital, adicionalmente tambem permite fazer reservas e entrar em contacto com o comerciante. Além disso, a aplicação possui funcionalidades de administrador para que o comerciante possa gerir o cardápio, reservas e contactos sem a necessidade de ter conhecimento de programação.

## Âmbito do Projeto

- **Objetivo**: Desenvolver uma pagina web simples com cardapio, reservas e contactos.

- **Objetivos Específicos**:

  - Implementar funcionalidades CRUD (Adicionar, Ler, Atualizar, Eliminar)
  - Utilizar uma base de dados para armazenamento.

- **Público-Alvo**: Restaurantes e bares.

- **Limitações**: Nao permite compra/venda direta de produtos.

## Levantamento de Requisitos

### Requisitos Funcionais

- **RF01**: A aplicação deve permitir adicionar produtos ao cardápio, incluindo nome, descrição, preço e categoria.
- **RF02**: A aplicação deve listar os produtos disponíveis no cardápio de forma organizada por categorias.
- **RF03**: A aplicação deve permitir a edição dos dados dos produtos no cardápio.
- **RF04**: A aplicação deve permitir a exclusão de produtos do cardápio.
- **RF05**: A aplicação deve possibilitar que o utilizador faça reservas através de um formulário com nome, data e hora, e número de pessoas.
- **RF06**: A aplicação deve permitir que aos administradores visualizar, aceitar, rejeitar e/ou arquivar pedidos de reserva.
- **RF07**:  A aplicação deve permitir que os utilizadores enviem mensagens de contacto através de um formulário.
- **RF08**: A aplicação deve permitir que os administradores visualizem, respondam e/ou arquivem mensagens de contacto.
- **RF09**: A aplicação deve exibir mensagens ao utilizador após a realização de uma reserva ou envio de mensagem de contacto.

### Requisitos Não Funcionais

- **RNF01**: Python A aplicação deve ser desenvolvida em Python 3.12.6.
- **RNF02**: Deve utilizar o framework Flask para a criação do backend.
- **RNF03**: Deve utilizar o banco de dados MySQL.
- **RNF04**: A aplicação deve ser responsiva e adaptável a diferentes tamanhos de ecrã.
- **RNF05**: A aplicação deve ser segura e protegida contra ataques comuns.
- **RNF06**: Deve suportar os navegadores mais populares (Google Chrome, Mozilla Firefox, Microsoft Edge).
- **RNF07**: A documentação do código deve seguir as boas práticas para facilitar a manutenção e extensões futuras.

## Desenvolvimento do Projeto

### Arquitetura

A aplicação segue uma arquitetura Model-View-Controller (MVC) simplificada, onde cada camada desempenha um papel específico para organizar o código e facilitar a manutenção.

- **Front-End (View)**: Interface do Utilizador > Responsável por exibir o cardápio, formulários de reserva e contacto, e outras páginas aos utilizadores.
             
Funcionalidades principais:
  Exibir o cardápio e produtos por categorias.
  Mostrar formulários para reservas e contacto.
  Página de administrador para gestão de produtos, reservas e conactos.

- **Back-End (Controller e Model)**: Lógica de negócio e interação com o banco de dados.
Controller (Flask):
  Gere as requisições dos utilizadores e administra a lógica da aplicação.
  Envia e recebe dados entre a interface (frontend) e a base de dados.
Model (Base de Dados):
  Armazena todas as informações da aplicação, como produtos, reservas e mensagens de contacto.
  Operações CRUD são realizadas nesta camada.

- **Banco de Dados (Data Layer)**: Armazena dados estruturados.

- **Fluxo de trabalho**:

    [Cliente: Browser] <---> [Flask (Backend)]
         ↑                           |
         |                           ↓
    [Frontend: HTML, CSS] [Base de Dados: MySQL]

### Tecnologias Utilizadas

- **Linguagens**: Python 3.12.6
- **Bibliotecas**:
  - `flask`: 
    - `flask`: Para criação de aplicações web.
    - `render_template`: Para renderização de templates HTML.
    - `request`: Para manipulação de requisições HTTP.
    - `redirect`: Para redirecionamento de URLs.
    - `url_for`: Para geração de URLs.
    - `jsonify`: Para serialização de dados em JSON.
  - `flask_mysqldb`:
    - `MySQLdb`: Para interação com o banco de dados MySQL.
  - `werkzeug.utils`:
    - `secure_filename`: Para validação de nomes de ficheiros.
  - `collections`:
    - `defaultdict`: Para criação de dicionários com valores padrão.

- **Ferramentas**:
  - GitHub para controlo de versão.
  - Visual Studio Code como IDE.

### Implementação

- Documentar ficheiros do projeto com os comentários para perceber as funcionalidades

## Desempenho do Projeto

### Testes Realizados

- **Testes funcionais**: 
  - Verificar se cada funcionalidade (adicionar, editar, listar, excluir) funciona conforme esperado.
  - Testar diferentes cenários para o sistema de reservas e mensagens.
- **Testes de integração**:
  - Verificar se as diferentes partes do sistema (front-end, back-end, banco de dados) interagem corretamente. 
  - Testar diferentes navegadores e dispositivos.
- **Testes de desempenho**:
  - Medir o tempo de resposta para diferentes operações.
  - Verificar se o sistema pode lidar com um grande número de usuários simultâneos.
- **Testes de segurança**:
  - Verificar se o sistema é seguro contra ataques comuns.
  - Testar a resistência a ataques de injeção de SQL, XSS, etc.

## Como Executar o Projeto

```bash
# Clonar o repositório
git clone https://github.com/nome-do-utilizador/nome-do-projeto.git

# Navegar até ao diretório do projeto
cd nome-do-projeto

# Criar e ativar um ambiente virtual (opcional)
python -m venv venv
source venv/bin/activate  # No Linux/Mac
venv\Scripts\activate     # No Windows

# Instalar as dependências
pip install -r requirements.txt 

# Executar a applicação
python app.py
```
