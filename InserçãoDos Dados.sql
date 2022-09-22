USE ecommerce;

SELECT * FROM cliente;
DESC cliente;

-- Inserção OK 
INSERT INTO cliente (TipoPessoa, Telefone, Email)
	VALUES ("Pessoa Física","11 20665945","maria@mail.com"),
			("Pessoa Física","31 20685945","joao@mail.com"),
            ("Pessoa Física","11 20665425","ana@mail.com"),
            ("Pessoa Física","21 20665745","jose@mail.com"),
            ("Pessoa Física","11 20665245","carla@mail.com"),
            ("Pessoa Jurídica","11 20665245","sanrio@mail.com"),
            ("Pessoa Jurídica","11 20665245","papelarte@mail.com"),
            ("Pessoa Jurídica","11 20665245","bruxilda@mail.com"),
            ("Pessoa Jurídica","11 20665245","rainha@mail.com"),
            ("Pessoa Jurídica","11 20665245","bunnycute@mail.com");
            
            
-- Inserção OK 
SELECT * FROM pessoafisica;
DESC pessoafisica;

INSERT INTO pessoafisica (Nome, CPF, RG, idCliente)
	VALUES ("Maria da Silva",12345678901,98765432-1,6),
			("João Souza",98765432102,65432198-2,7),
            ("Ana Santos",12365478925,65412378-2,8),
            ("José de Tal",32145698785,45678925-6,9),
            ("Carla Ricci",78945612396,65485295-4,10);
            
-- Inserção OK 
SELECT * FROM pessoajuridica;
DESC pessoajuridica;

INSERT INTO pessoajuridica (NomeFantasia, CNPJ, RazaoSocial, idCliente)
	VALUES ("Sanrio",12345678901123,"Sanrio Ltda",11),
			("PapelArte",98765432102000,"PapelArte Ltda",12),
            ("Bruxilda",12365478925000,"Bruxilda Ltda",13),
            ("Rainha do Bairro",32145698785000,"Rainha do Bairro Ltda",14),
            ("Bunny Cute",78945612396000,"Bunny Cute Ltda",15);

-- Inserção OK 
SELECT * FROM enderecoentrega;
DESC enderecoentrega;

INSERT INTO enderecoentrega (CEP, Rua, Numero, Complemento, Bairro, Cidade, Estado, Pais, idCliente)
	VALUES (36985741, "Rua abc", 123, "ap 1", "Jd. da Luz", "São Paulo", "SP", "Brasil", 6),
			(14789123, "Rua qwer", 456, "ap 2", "Jd. da Lua", "Rio de Janeiro", "RJ", "Brasil", 7),
            (98741258, "Rua asdf", 789, "ap 3", "Jd. do Sol", "São Paulo", "SP", "Brasil", 8),
            (14789963, "Rua jkl", 987, "ap 4", "Jd. das Estrelas", "Rio de Janeiro", "RJ", "Brasil", 9),
            (36987258, "Rua zxcv", 654, "ap 5", "Jd. da Praia", "Santos", "SP", "Brasil", 10),
            (02587321, "Av. tyui", 321, "cj 1", "Jd. da Paz", "São Paulo", "SP", "Brasil", 11),
            (02145963, "Al. bnm", 147, "cj 2", "Jd. do Mar", "Santos", "SP", "Brasil", 12),
            (14789025, "Av. ghjk", 258, "cj 3", "Jd. da Leitura", "São Paulo", "SP", "Brasil", 13),
            (65478123, "Rua uiop", 369, "cj 4", "Jd. da Água", "Rio de Janeiro", "RJ", "Brasil", 14),
            (98753654, "Av. dfgh", 654, "cj 5", "Jd. da Terra", "Campinas", "SP", "Brasil", 15);

-- Inserção OK
SELECT * FROM frete;
INSERT INTO `ecommerce`.`frete` (`idFrete`, `Endereço`, `PesoTotal`, `Valor`) VALUES ('1', '36985741', '0.5', '10');
INSERT INTO `ecommerce`.`frete` (`idFrete`, `Endereço`, `PesoTotal`, `Valor`) VALUES ('2', '98741258', '1', '15');

-- Inserção OK
SELECT * FROM enderecocobranca;
DESC enderecocobranca;

INSERT INTO enderecocobranca (CEP, Rua, Numero, Complemento, Bairro, Cidade, Estado, Pais, idPagamento)
	VALUES (14789123, "Rua qwer", 456, "ap 2", "Jd. da Lua", "Rio de Janeiro", "RJ", "Brasil",2),
			(98753654, "Av. dfgh", 654, "cj 5", "Jd. da Terra", "Campinas", "SP", "Brasil", 3);
 
 -- Inserção 
SELECT * FROM entrega;

-- Inserção OK
SELECT * FROM estoque;

-- Inserção OK
SELECT * FROM fornecedor;

-- Inserção OK
SELECT * FROM pagamento;
DESC pagamento;
INSERT INTO `ecommerce`.`pagamento` (`idPagamento`, `Ativo`, `TipoPagamento_idTipoPagamento`) VALUES ('1', 'SIM', '1');
INSERT INTO `ecommerce`.`pagamento` (`idPagamento`, `Ativo`, `TipoPagamento_idTipoPagamento`) VALUES ('2', 'NAO', '2');
INSERT INTO `ecommerce`.`pagamento` (`idPagamento`, `Ativo`, `TipoPagamento_idTipoPagamento`) VALUES ('3', 'SIM', '3');

UPDATE `ecommerce`.`pagamento` SET `Ativo` = 'SIM' WHERE (`idPagamento` = '2');
INSERT INTO `ecommerce`.`pagamento` (`idPagamento`, `Ativo`, `TipoPagamento_idTipoPagamento`) 
	VALUES ('4', 'SIM', '1');


-- Inserção OK
SELECT * FROM `pagamento boleto`;
INSERT INTO `ecommerce`.`pagamento boleto` (`idPagamento Boleto`, `DataEmissao`, `DataVencimento`, `Emissor`, `NumeroDocumento`, `Cedente`, `CodigoCedente`, `Sacado`, `TipoPagamento_idTipoPagamento`) 
	VALUES ('1', '2022-09-22', '2022-09-24', 'ECommerce', '1234', 'Banco X', '9874', 'Maria da Silva', '1');
INSERT INTO `ecommerce`.`pagamento boleto` (`idPagamento Boleto`, `DataEmissao`, `DataVencimento`, `Emissor`, `NumeroDocumento`, `Cedente`, `CodigoCedente`, `Sacado`, `TipoPagamento_idTipoPagamento`) 
	VALUES ('2', '2022-09-21', '2022-09-23', 'ECommerce', '1233', 'Banco X', '9874', 'Ana Santos', '1');

-- Inserção ok
SELECT * FROM `pagamento cartao credito`;
INSERT INTO `ecommerce`.`pagamento cartao credito` (`idPagamento Cartao Credito`, `NumeroCartao`, `Validade`, `CVC`, `NomeComoNoCartao`, `QuantidadeParcelas`, `TipoPagamento_idTipoPagamento1`) 
	VALUES ('1', '369874122589', '2029-06-30', '123', 'Joao Souza', '1', '2');

-- Inserção OK
SELECT * FROM `pagamento cartao debito`;
INSERT INTO `ecommerce`.`pagamento cartao debito` (`idPagamento Cartao Debito`, `NumeroCartao`, `Validade`, `CVC`, `NomeComoNoCartao`, `TipoPagamento_idTipoPagamento`) 
	VALUES ('1', '123467893214', '2030-08-31', '987', 'Bunny Cute Ltda', '3');


-- Inserção OK
SELECT * FROM tipopagamento;
DESC tipopagamento;
INSERT INTO tipopagamento (TipoPagamento)
	VALUES ("Cartao Credito"),
			("Cartao Debito"),
            ("Boleto");

-- Inserção ok
SELECT * FROM pedido;

-- Inserção ok
SELECT * FROM pedido_has_produto;
INSERT INTO `ecommerce`.`pedido_has_produto` (`Pedido_idPedido`, `Produto_idProduto`, `Quantidade`, `PesoTotal`) 
	VALUES ('1', '9', '5', '1');

-- Inserção OK
SELECT * FROM produto;
DESC produto;

-- Inserção OK
SELECT * FROM `produto por fornecedor`;

-- Inserção OK
SELECT * FROM `produto por vendedor`;

-- Inserção OK
SELECT * FROM produtoemestoque;

-- Inserção OK
SELECT * FROM rastreio;
INSERT INTO `ecommerce`.`rastreio` (`idRastreio`, `Descricao`, `DataStatus`, `Localizacao`, `Pedido_Cliente_idCliente`, `CodigoRastreio`, `Pedido_idPedido`, `Pedido_Cliente_idCliente1`, `Pedido_Pagamento_idPagamento`, `Pedido_Frete_idFrete1`) 
	VALUES ('1', 'Entregue', '2022-09-22 00:00:00.000', '98753654', '1', 'XPTO1234', '1', '15', '3', '3');
    
 -- Inserção OK
SELECT * FROM `status`;
INSERT INTO `ecommerce`.`status` (`idStatus`, `Descricao`, `Rastreio_idRastreio`) 
VALUES ('1', 'Entregue', '1');


-- Inserção OK
SELECT * FROM vendedor;
DESC vendedor;

-- Inserção OK
SELECT * FROM vendedorcomfornecedor;

INSERT INTO `ecommerce`.`vendedorcomfornecedor` (`Vendedor_idVendedor`, `Fornecedor_idFornecedor`) VALUES ('1', '1');
INSERT INTO `ecommerce`.`vendedorcomfornecedor` (`Vendedor_idVendedor`, `Fornecedor_idFornecedor`) VALUES ('2', '2');
