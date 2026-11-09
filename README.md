# Project Data Extraction

Este projeto conecta-se a um banco de dados SQL Server, extrai dados de funcionários, vendas e produtos, e salva o resultado em um arquivo Excel dentro da pasta `extract/file_xlsx`. A partir deste resultado, é feita a análise no Dashboard em Power BI.

<img width="1314" height="735" alt="Power BI Desktop 13_08_2026 18_58_55" src="https://github.com/user-attachments/assets/8a9abec4-1c1b-4708-b299-7b2ef9be1016" />
<img width="1317" height="731" alt="Power BI Desktop 13_08_2026 18_59_14" src="https://github.com/user-attachments/assets/95128cdb-ed4a-471d-b91e-e9831e70b23b" />



## Estrutura do projeto

- `db_config/`: scripts SQL para criação do banco e das views utilizadas
- `extract/data_extract.py`: script principal de extração e geração do Excel
- `extract/file_xlsx/`: pasta de saída do arquivo gerado
- `dashboard.pbix`: arquivo do Power BI relacionado ao projeto

## Requisitos

- Python 3.10+
- SQL Server com banco de dados configurado
- Driver ODBC para SQL Server instalado no ambiente
- Acesso ao banco `EMPRESA_DB`

## Preparação do banco

Antes de executar o script, importe os scripts SQL da pasta `db_config/` na ordem adequada para criar as estruturas necessárias:

1. `1 - empresa_db.sql`
2. `2 - view_vendas.sql`
3. `3 - view_produtos.sql`

O script principal espera as seguintes entidades no banco:

- tabela `TB_FUNCIONARIO`
- view `vwVendas`
- view `vwProdutos`

## Instalação

Crie um ambiente virtual e instale as dependências:

```bash
python -m venv .venv
source .venv/bin/activate   # Linux/macOS
.venv\Scripts\activate      # Windows
pip install -r requirements.txt
```

## Configuração da conexão

No arquivo `extract/data_extract.py`, o código usa a seguinte string de conexão:

```python
Driver={ODBC Driver 18 for SQL Server};
Server=;
Database=EMPRESA_DB;
Trusted_Connection=yes;
TrustServerCertificate=yes;
```

Você deve ajustar os valores de `Server` e `Database` conforme o ambiente do seu SQL Server.

## Execução

A partir da raiz do projeto, execute:

```bash
python extract/data_extract.py
```

Ao final da execução, o arquivo será gerado em:

```text
extract/file_xlsx/Dados.xlsx
```

## Saída

O arquivo Excel contém 3 planilhas:

- `Funcionários`
- `Vendas`
- `Produtos`

## Dependências principais

- `pandas`
- `pyodbc`
- `openpyxl`

Se o driver ODBC não estiver disponível, instale o Microsoft ODBC Driver 18 for SQL Server antes de executar o script.
