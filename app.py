
from flask import Flask, render_template, request, redirect, url_for, jsonify, flash
from flask_mysql_connector import MySQL
from flask_sqlalchemy import SQLAlchemy
import os, re
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user #Para login
from werkzeug.security import generate_password_hash, check_password_hash #Para password
from werkzeug.utils import secure_filename
from collections import defaultdict
from dotenv import load_dotenv
load_dotenv()

print("DB Config:", os.getenv('DB_USER'), os.getenv('DB_PASSWORD'), os.getenv('DB_HOST'), os.getenv('DB_PORT'), os.getenv('DB_NAME'))


app = Flask(__name__)
app.secret_key = 'PI2024.05'







# Configuração do banco de dados PostgreSQL
app.config['SQLALCHEMY_DATABASE_URI'] = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

@app.route('/bd')
def home():
    return "Aplicação conectada ao banco de dados PostgreSQL!"


login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'  # 'login' é o nome da rota de login


# Exemplo de um banco de dados de administrador simples (podemos usar a base de dados)
admins = {
    "admin@example.com": {"password": generate_password_hash("admin123"), "id": 1}
}

class Admin(UserMixin):
    def __init__(self, id):
        self.id = id

    @staticmethod
    def get(id):
        return Admin(id)

@login_manager.user_loader
def load_user(user_id):
    return Admin.get(user_id)

# Rota para login
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        senha = request.form['senha']

        # Verifique se o e-mail existe e a senha está correta
        admin = admins.get(email)
        if admin and check_password_hash(admin['password'], senha):
            user = Admin(admin['id'])
            login_user(user)
            return redirect(url_for('admin'))
        else:
            flash('E-mail ou senha incorretos', 'danger')

    return render_template('login.html')

# Rota para o logout
@app.route('/logout', methods=['POST'])
def logout():
    logout_user()
    return redirect(url_for('home'))

# Configurações do MySQL usando variáveis de ambiente
app.config['MYSQL_HOST'] = os.getenv('MYSQL_HOST', 'localhost')
app.config['MYSQL_USER'] = os.getenv('MYSQL_USER', 'root')
app.config['MYSQL_PASSWORD'] = os.getenv('MYSQL_PASSWORD', '')
app.config['MYSQL_DB'] = os.getenv('MYSQL_DB', 'restaurante_bd')

mysql = MySQL(app)  # Inicializa a extensão MySQL com as configurações do Flask

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/cardapio')
def cardapio():
    try:
        cur = mysql.connection.cursor()
        
        # Consulta para produtos
        cur.execute("SELECT * FROM produtos")
        produtos = cur.fetchall()

        # Consulta para categorias
        cur.execute("SELECT * FROM categorias")
        categorias = cur.fetchall()

        # Dicionario de categorias
        categorias_dict = {categoria[0]: {'nome': categoria[1], 'imagem': categoria[2]} for categoria in categorias}
        ## Agrupar produtos por categoria
        produtos_por_categoria = defaultdict(list)
        for produto in produtos: produtos_por_categoria[produto[5]].append(produto)
        
        cur.close()
    except Exception as e:
        print(f"Erro ao aceder ao banco de dados: {e}")
        produtos = []
    
    return render_template('cardapio.html', categorias=categorias_dict, produtos=produtos, produtos_por_categoria=produtos_por_categoria)

@app.route('/admin')
@login_required
def admin():
    try:
        cur = mysql.connection.cursor()

        # Consulta para categorias
        cur.execute("SELECT * FROM categorias")
        categorias = cur.fetchall()
        # Consulta para produtos
        cur.execute("SELECT * FROM produtos")
        produtos = cur.fetchall()
        # Consulta para contactos
        cur.execute("SELECT * FROM mensagens")
        mensagens = cur.fetchall()
        # Dicionario de categorias
        categorias_dict = {categoria[0]: categoria[1] for categoria in categorias}
        ## Agrupar produtos por categoria
        produtos_por_categoria = defaultdict(list)
        for produto in produtos: produtos_por_categoria[produto[5]].append(produto)
        # Consulta para reservas
        cur.execute("SELECT * FROM reservas")
        reservas = cur.fetchall()
        cur.close()
    except Exception as e:
        print(f"Erro ao aceder ao banco de dados: {e}")
        produtos = []
    return render_template('admin.html', categorias=categorias_dict, produtos=produtos, produtos_por_categoria=produtos_por_categoria, mensagens=mensagens, reservas=reservas)

@app.route('/admin/reservas/update', methods=['POST'])
def update_reserva_status():
    try:
        reserva_id = request.form['reserva_id']
        novo_status = request.form['status']
        
        cur = mysql.connection.cursor()
        # Atualizar o estado e a data de modificação
        cur.execute("""
            UPDATE reservas 
            SET status = %s, ultima_modificacao = NOW() 
            WHERE id = %s
        """, (novo_status, reserva_id))
        mysql.connection.commit()
        cur.close()

    except Exception as e:
        print(f"Erro ao atualizar a reserva: {e}")
    return redirect(url_for('admin') + '#reservas')


# Define o caminho da pasta onde as imagens serão salvas
UPLOAD_FOLDER_CAT = 'static/categoriasImgs'
app.config['UPLOAD_FOLDER_CAT'] = UPLOAD_FOLDER_CAT


@app.route('/inserir_categoria', methods=['POST'])
def inserir_categoria():
    categoria_nome = request.form['categoria_nome']
    categoria_imagem = request.files['categoria_imagem']
    
    # Sanitizar o nome da categoria para o nome da tabela
    categoria_nome_sanitizado = re.sub(r'[^a-zA-Z0-9]', '_', categoria_nome.lower())
    
    # Verificar se o nome é reservado
    RESERVED_NAMES = [
        'select', 'insert', 'update', 'delete', 'drop', 'create', 'table', 'database', 'index', 'view', 'trigger', 'procedure', 'function'
    ]
    if categoria_nome_sanitizado in RESERVED_NAMES:
        return "Erro: Nome da categoria é reservado e não pode ser usado.", 400
    
    # Valida e salva a imagem
    if categoria_imagem and categoria_imagem.filename != '':
        # Gera um nome seguro para o arquivo
        filename = secure_filename(categoria_imagem.filename)
        categoria_imagem.save(os.path.join(app.config['UPLOAD_FOLDER_CAT'], filename))
    else:
        # Se a imagem não estiver disponível ou inválida
        return "Erro: Imagem inválida.", 400

    # Conectar ao banco de dados
    connection = mysql.connection
    cursor = connection.cursor()
    
    # Verificar se o nome da categoria já existe na tabela categorias
    cursor.execute("SELECT id FROM categorias WHERE nome = %s", (categoria_nome,))
    result = cursor.fetchone()
    if result:
        return "Erro: Nome da categoria indisponível.", 400
    
    # Inserir o nome da categoria na tabela categorias
    cursor.execute("INSERT INTO categorias (nome, imagem) VALUES (%s, %s)", (categoria_nome, filename))
    connection.commit()
    
    cursor.close()
    connection.close()
    
    return redirect(url_for('admin'))

# Define o caminho da pasta onde as imagens serão salvas
UPLOAD_FOLDER = 'static/imgs/produtos'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/inserir_produto', methods=['GET', 'POST'])
def inserir_produto():
    try:
        # Captura os dados do formulário
        nome = request.form['nome']
        descricao = request.form['descricao']
        preco = request.form['preco']
        imagem = request.files['imagem']
        id_categoria = request.form['categoria']
        
        # Imprime a categoria selecionada para depuração
        print(f"Categoria selecionada: {id_categoria}")
        
        # Valida e salva a imagem
        if imagem and imagem.filename != '':
            # Gera um nome seguro para o arquivo
            filename = secure_filename(imagem.filename)
            imagem.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        else:
            # Se a imagem não estiver disponível ou inválida
            return "Erro: Imagem inválida.", 400

        # Conectar ao banco de dados
        cur = mysql.connection.cursor()
        cur.execute('''
            INSERT INTO produtos (nome, descricao, preco, imagem, id_categoria)
            VALUES (%s, %s, %s, %s, %s)
        ''', (nome, descricao, preco, filename, id_categoria))
        mysql.connection.commit()
        cur.close()

        return redirect(url_for('admin'))  # Redireciona para a página de listagem após inserção
    except Exception as e:
        print(f"Erro ao inserir produto: {e}")
        return f"Erro ao inserir produto: {e}", 500

@app.route('/get_produto/<int:id>', methods=['GET'])
def get_produto(id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM produtos WHERE id = %s", (id,))
    produto = cur.fetchone()
    cur.close()

    if produto:
        return jsonify({
            'id': produto[0],
            'nome': produto[1],
            'descricao': produto[2],
            'preco': produto[3],
            'imagem': produto[4]
        })
    else:
        return jsonify({'error': 'Produto não encontrado'}), 404

@app.route('/update_produto/<int:id>', methods=['POST'])
def update_produto(id):
    nome = request.form['nome']
    descricao = request.form['descricao']
    preco = request.form['preco']
    imagem = request.files.get('imagem')

    # Recuperar os dados do produto antes de atualizar
    cur = mysql.connection.cursor()
    cur.execute("SELECT imagem FROM produtos WHERE id = %s", (id,))
    produto = cur.fetchone()
    cur.close()

    # Verifica se o nome do produto já existe em outro produto
    cur = mysql.connection.cursor()
    cur.execute("SELECT id FROM produtos WHERE nome = %s AND id != %s", (nome, id))
    existing_product = cur.fetchone()
    cur.close()
    if existing_product:
        flash('Erro: Nome de produto já existe.', 'error')
        return redirect(url_for('admin'))
    
    # Se uma nova imagem foi fornecida
    if imagem and imagem.filename != '':
        # Excluir a imagem antiga
        old_image = produto[0]
        old_image_path = os.path.join(UPLOAD_FOLDER, old_image)
        if os.path.exists(old_image_path):
            os.remove(old_image_path)

        # Salvar a nova imagem
        filename = secure_filename(imagem.filename)
        imagem.save(os.path.join(UPLOAD_FOLDER, filename))

        # Usar o nome da nova imagem
        imagem_filename = filename
    else:
        # Se não foi fornecida uma nova imagem, manter a imagem antiga
        imagem_filename = produto[0]

        # Atualizar no banco de dados
    cur = mysql.connection.cursor()
    cur.execute("""
        UPDATE produtos
        SET nome = %s, descricao = %s, preco = %s, imagem = %s
        WHERE id = %s
    """, (nome, descricao, preco, imagem_filename, id))
    mysql.connection.commit()
    cur.close()

    return redirect(url_for('admin'))  # Redireciona para a página de produtos

@app.route('/delete_produto/<int:id>', methods=['POST'])
def delete_produtos(id):
    try:
        print(f"Tentando apagar prdutos com ID: {id}")
        cur = mysql.connection.cursor()
        cur.execute('SELECT * FROM produtos WHERE id = %s', (id,))
        massa = cur.fetchone()
        if not massa:
            print("ID não encontrado.")
            return redirect(url_for('admin'))

        cur.execute('DELETE FROM produtos WHERE id = %s', (id,))
        mysql.connection.commit()
        print("Registro apagado com sucesso.")
        return redirect(url_for('admin'))
    except Exception as e:
        print(f"Erro ao apagar produto: {e}")
        return redirect(url_for('admin'))
    finally:
        cur.close()
    
@app.route('/contacto', methods=['GET', 'POST'])
def contacto():
    if request.method == 'POST':
        nome = request.form['nome']
        email = request.form['email']
        mensagem = request.form['mensagem']
        # Lógica para processar o formulário
        cur = mysql.connection.cursor()
        cur.execute('''
            INSERT INTO mensagens (nome, email, mensagem)
            VALUES (%s, %s, %s)
        ''', (nome, email, mensagem))
        mysql.connection.commit()
        cur.close()
        # Redirecionamento após o envio do formulário
        return render_template('obrigado.html', nome=nome)
    return render_template('contacto.html')

@app.route('/tratar_mensagem/<int:id>', methods=['POST'])
def tratar_mensagem(id):
    try:
        # Conectar ao banco de dados
        cur = mysql.connection.cursor()
        
        # Verificar o estado atual da coluna 'tratado'
        cur.execute('SELECT tratado FROM mensagens WHERE id = %s', (id,))
        estado_atual = cur.fetchone()[0]
        
        # Alternar o valor de 'tratado'
        novo_estado = 1 if estado_atual is None else None
        
        # Atualizar a coluna 'tratado'
        cur.execute('''
            UPDATE mensagens
            SET tratado = %s
            WHERE id = %s
        ''', (novo_estado, id))
        
        mysql.connection.commit()
        cur.close()

        return redirect(url_for('admin') + '#contactos')  # Redireciona para a página de listagem de mensagens
    except Exception as e:
        print(f"Erro ao tratar mensagem: {e}")

@app.route('/reservas', methods=['GET', 'POST'])
def reservas():
    if request.method == 'POST':
        nome = request.form['nome']
        telefone = request.form['telefone']
        data = request.form['data']
        horario = request.form['horario']
        pessoas = request.form['pessoas']
        
        # Lógica para processar o formulário
        cur = mysql.connection.cursor()
        cur.execute('''
        INSERT INTO reservas (nome, telefone, data, horario, pessoas)
        VALUES (%s, %s, %s, %s, %s)
        ''', (nome, telefone, data, horario, pessoas))
        mysql.connection.commit()
        cur.close()

        return render_template('reserva_confirmada.html', nome=nome, data=data, horario=horario, pessoas=pessoas)
    return render_template('reservas.html')

@app.route('/galeria')
def galeria():
    # Caminho para a pasta de imagens
    image_folder = 'static/images'
    
    # Lista todos os arquivos dentro da pasta
    images = [f for f in os.listdir(image_folder) if f.endswith(('.jpg', '.jpeg', '.png'))]
    
    # Ordena as imagens se necessário
    images.sort()

    return render_template('galeria.html', images=images)

if __name__ == '__main__':
    app.run(debug=True, port=5000)

