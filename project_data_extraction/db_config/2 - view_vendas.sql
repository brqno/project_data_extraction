CREATE VIEW vwVendas AS
SELECT 
     A.NumeroPedido                       AS [Número do Pedido]
    ,A.ClienteId                          AS [ID do Cliente]
    ,A.FuncionarioId                      AS [ID do Funcionário]
    ,CONVERT(DATE, A.DataPedido)          AS [Data do Pedido]
    ,CONVERT(DATE, A.DataEntrega)         AS [Data de Entrega]
    ,COUNT(B.ProdutoId)                   AS [Quantidade de Produtos por Pedido]
    ,SUM(B.Preco)                         AS [Preço Bruto Total]
    ,SUM(B.Preco * B.Desconto)            AS [Total de Desconto em R$]
    ,SUM(B.Preco * (1 - B.Desconto))      AS [Valor Líquido do Pedido]
    ,C.Cidade                             AS [Cidade da Venda]
    ,C.Pais                               AS [País da Venda]

FROM TB_PEDIDO                      AS A

INNER JOIN TB_DETALHE_PEDIDO        AS B
      ON A.NumeroPedido = B.NumeroPedido

INNER JOIN TB_ENDERECO              AS C
      ON A.ClienteId = C.ClienteId

GROUP BY 
    A.NumeroPedido
   ,A.ClienteId
   ,A.FuncionarioId
   ,CONVERT(DATE, A.DataPedido)
   ,CONVERT(DATE, A.DataEntrega)
   ,C.Cidade
   ,C.Pais
GO