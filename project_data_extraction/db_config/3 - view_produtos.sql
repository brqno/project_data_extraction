CREATE VIEW vwProdutos AS
SELECT 
     A.ProdutoId                        AS [ID do Produto]
    ,A.Descricao                        AS [Descrição do Produto]
    ,A.Preco                            AS [Preço do Produto]
    ,A.Unidades                         AS [Quantidade de Unidades]

    ,CASE WHEN A.Descontinuado = 0 
         THEN 'Disponível'
         ELSE 'Descontinuado'
     END                                AS [Status do Produto]

    ,A.CategoriaId                      AS [ID da Categoria]
    ,b.Descricao                        AS [Descrição da Categoria]
    ,A.FornecedorId                     AS [ID do Fornecedor]
    ,C.NumeroPedido
	 
FROM TB_PRODUTO                          AS A
INNER JOIN TB_CATEGORIA                  AS B
	 ON A.CategoriaId = B.CategoriaId
INNER JOIN TB_DETALHE_PEDIDO             AS C
     ON A.ProdutoId = C.ProdutoId
GO