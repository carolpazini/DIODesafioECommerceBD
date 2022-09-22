use ecommerce;

-- Recuperação simples com SELECT Statement
SELECT * FROM pessoafisica;

SELECT Nome, CPF 
	FROM pessoafisica;


-- Filtro com WHERE Statement

SELECT cliente.Telefone, cliente.Email, pessoafisica.Nome
	FROM cliente, pessoafisica
    WHERE cliente.idCliente = pessoafisica.idCliente;
    
-- Crie expressão para gerar atributos derivados

SELECT p.Descricao, pe.Quantidade, p.Valor,
	pe.Quantidade * p.Valor as "Valor do Estoque"
	FROM produto as p , produtoemestoque as pe
    WHERE p.idProduto = pe.Produto_idProduto;

-- Defina ordenação dos dados com ORDER BY

SELECT * FROM pessoajuridica
ORDER BY CNPJ, idCliente, NomeFantasia  ASC;

-- Condições de filtros aos grupos – HAVING Statement

SELECT Estado, Cidade
FROM enderecoentrega
GROUP BY Estado, Cidade
HAVING Estado = "SP";

SELECT COUNT(Cidade), Estado
FROM enderecoentrega
GROUP BY Cidade
Having COUNT(Cidade) > 2;


-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
-- cliente, pessoafisica, enderecoentrega

SELECT p.Nome, p.CPF, c.Telefone, c.Email, 
	CONCAT(e.Rua, ', ', e.Numero,', ', e.Complemento,', ',e.Bairro,', ',e.Cidade,', ', e.Estado,', ', e.Pais,', CEP ', e.CEP) AS "Endereço"
	FROM enderecoentrega AS e
	INNER JOIN cliente AS c ON c.idCliente = e.idCliente
    INNER JOIN pessoafisica AS p ON p.idCliente = e.idCliente
