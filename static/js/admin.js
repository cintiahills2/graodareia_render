
    // JavaScript para abrir a modal e preencher com dados do produto
    function openEditModal(id) {
        // Obtenha os dados do produto via AJAX
        fetch(`/get_produto/${id}`)
            .then(response => response.json())
            .then(data => {
                if (!data.error) {
                    // Preencher os campos com os dados recebidos
                    document.getElementById('produtoNome').value = data.nome;
                    document.getElementById('produtoDescricao').value = data.descricao;
                    document.getElementById('produtoPreco').value = data.preco;
    
                    // Definir o caminho da imagem atual
                    document.getElementById('produtoImagemAtual').src = `/static/imgs/${data.imagem}`;
    
                    // Definir o ID do produto a ser atualizado
                    document.getElementById('produtoId').value = data.id;
    
                    // Configurar a ação do formulário com a URL para atualização
                    document.getElementById('editForm').action = `/update_produto/${id}`;
    
                    // Abrir a modal
                    $('#editModal').modal('show');
                }
            });
    }


    document.addEventListener('DOMContentLoaded', function() {
        const table = document.querySelector('#contactTable');
        const headers = table.querySelectorAll('th.sortable');
        let currentSort = { column: null, direction: 'asc' };

        // Função para ordenar a tabela
        function sortTable(column) {
            const rows = Array.from(table.querySelectorAll('tbody tr'));
            const index = Array.from(headers).indexOf(column);
            const isAscending = currentSort.column === index && currentSort.direction === 'asc';

            rows.sort((rowA, rowB) => {
                const cellA = rowA.children[index].textContent.trim();
                const cellB = rowB.children[index].textContent.trim();
                if (cellA < cellB) return isAscending ? 1 : -1;
                if (cellA > cellB) return isAscending ? -1 : 1;
                return 0;
            });

            // Atualizar a tabela com a nova ordem
            rows.forEach(row => table.querySelector('tbody').appendChild(row));

            // Atualizar estado de ordenação
            currentSort = { column: index, direction: isAscending ? 'desc' : 'asc' };

            // Atualizar os indicadores de ordenação
            headers.forEach(header => {
                const indicator = header.querySelector('.sort-indicator');
                if (header === column) {
                    indicator.textContent = isAscending ? '▲' : '▼';
                } else {
                    indicator.textContent = '';
                }
            });
        }

        // Ativar a ordenação nos cabeçalhos
        headers.forEach(header => {
            header.addEventListener('click', () => sortTable(header));
        });

        // Função para filtrar a tabela com base no texto do campo de pesquisa
        const searchInput = document.querySelector('#searchContact');
        const mostrarPendentesBtn = document.getElementById('mostrarPendentesBtn');

        searchInput.addEventListener('input', function() {
            filterTable();
        });

        // Função para alternar entre mostrar pendentes ou todos os contatos
        mostrarPendentesBtn.addEventListener('click', function() {
            this.dataset.showPendentes = this.dataset.showPendentes === 'true' ? 'false' : 'true';
            filterTable();  // Filtra novamente após mudar o estado de "Pendentes"
        });

        // Função para filtrar a tabela aplicando tanto o nome quanto o estado pendente
        function filterTable() {
            const filter = searchInput.value.toLowerCase();
            const showPendentes = mostrarPendentesBtn.dataset.showPendentes === 'true';
            const rows = table.querySelectorAll('tbody tr');

            rows.forEach(row => {
                const cells = Array.from(row.cells);
                const nome = cells[1].textContent.toLowerCase();
                const estado = cells[5].textContent.trim().toLowerCase();

                const matchesName = nome.includes(filter); // Checa se o nome corresponde ao filtro
                const matchesStatus = !showPendentes || estado === 'pendente'; // Checa se o estado é "Pendente" se estiver filtrando

                if (matchesName && matchesStatus) {
                    row.style.display = '';  // Mostra a linha se atender ambos os critérios
                } else {
                    row.style.display = 'none';  // Esconde a linha se não atender ambos os critérios
                }
            });

            // Atualiza o texto do botão de pendentes para refletir o estado atual
            if (showPendentes) {
                mostrarPendentesBtn.textContent = 'Mostrar Todos';
            } else {
                mostrarPendentesBtn.textContent = 'Mostrar Apenas Pendentes';
            }
        }
    });


    document.addEventListener('DOMContentLoaded', function() {
        // Filtros
        const filtroData = document.getElementById('filtroData');
        const filtroEstado = document.getElementById('filtroEstado');
        const filtroCliente = document.getElementById('filtroCliente');
        const reservas = document.querySelectorAll('.reserva-item');

        // Função para aplicar os filtros
        function aplicarFiltros() {
            reservas.forEach(function(reserva) {
                const nomeCliente = reserva.getAttribute('data-nome').toLowerCase();
                const dataReserva = reserva.getAttribute('data-data');
                const estadoReserva = reserva.getAttribute('data-estado').toLowerCase();
                
                const filtroNome = filtroCliente.value.toLowerCase();
                const filtroDataValue = filtroData.value;
                const filtroEstadoValue = filtroEstado.value.toLowerCase();

                // Verifica se a reserva corresponde aos filtros
                const correspondeNome = nomeCliente.includes(filtroNome);
                const correspondeData = filtroDataValue === "" || dataReserva === filtroDataValue;
                const correspondeEstado = filtroEstadoValue === "" || estadoReserva.includes(filtroEstadoValue);

                if (correspondeNome && correspondeData && correspondeEstado) {
                    reserva.style.display = ''; // Mostrar reserva
                } else {
                    reserva.style.display = 'none'; // Esconder reserva
                }
            });
        }

        // Aplicar filtros ao digitar no campo
        filtroData.addEventListener('change', aplicarFiltros);
        filtroEstado.addEventListener('change', aplicarFiltros);
        filtroCliente.addEventListener('input', aplicarFiltros);
    });


