import pyodbc
import pandas as pd
from pathlib import Path

conn_str = (
    r'Driver={ODBC Driver 18 for SQL Server};'
    r'Server=;'
    r'Database=EMPRESA_DB;'
    r'Trusted_Connection=yes;'
    r'TrustServerCertificate=yes;' 
)

conn = pyodbc.connect(conn_str)
cursor = conn.cursor()

def funcionarios():
    query_funcionarios = """
    SELECT
        FuncionarioId							AS [ID do Funcionário]
        ,NomeCompleto                           AS [Nome do Funcionário]
        ,Cargo									AS [Cargo do Funcionário]
        ,CONVERT(DATE, DataNascimento)			AS [Data de Nascimento do Funcionário]
        ,Salario								AS [Salário do Funcionário]

    FROM TB_FUNCIONARIO 
    """

    df_funcionarios = pd.read_sql(query_funcionarios, conn)
    return df_funcionarios

def vendas():
    query_vendas = "SELECT * FROM vwVendas"

    df_vendas = pd.read_sql(query_vendas, conn)
    df_vendas['Data do Pedido'] = pd.to_datetime(df_vendas['Data do Pedido'])
    df_vendas['Data de Entrega'] = pd.to_datetime(df_vendas['Data de Entrega'])
    return df_vendas

def produtos():
    query_produtos = "SELECT * FROM vwProdutos" 

    df_produtos = pd.read_sql(query_produtos, conn)
    return df_produtos

base_dir = Path(__file__).parent / "file_xlsx"
base_dir.mkdir(parents=True, exist_ok=True)
file_path = base_dir / "Dados.xlsx"

def into_excel(df_funcionarios, df_vendas, df_produtos, caminho_arquivo=file_path):
    with pd.ExcelWriter(caminho_arquivo, engine='openpyxl') as writer:

        df_funcionarios.to_excel(writer, sheet_name='Funcionários', index=False)
        df_vendas.to_excel(writer, sheet_name='Vendas', index=False)
        df_produtos.to_excel(writer, sheet_name='Produtos', index=False)
        
    print(f"Arquivo '{caminho_arquivo}' gerado com sucesso!")


df_func = funcionarios()
df_vend = vendas()
df_prod = produtos()

conn.close()

into_excel(df_func, df_vend, df_prod)
