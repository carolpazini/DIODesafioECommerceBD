-- criação do banco de dados

CREATE DATABASE ecommerce;
USE ecommerce;

-- TabelaCliente 
create TABLE Cliente(
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
	TipoPessoa ENUM('Pessoa Juridica', 'Pessoa Física') NOT NULL,
	Telefone VARCHAR(11) NOT NULL,
	Email VARCHAR(45) NOT NULL,
	IdEnderecoEntrega INT NOT NULL,
	IdEnderecoCobranca INT NOT NULL
);

ALTER TABLE Cliente 
	add CONSTRAINT fk_Cliente_EnderecoEntrega1 FOREIGN KEY (IdEnderecoEntrega) REFERENCES EnderecoEntrega(idEnderecoEntrega),
    add CONSTRAINT fk_Cliente_EnderecoCobranca FOREIGN KEY (IdEnderecoCobranca) REFERENCES EnderecoCobranca(idEnderecoCobranca);
    
    
-- Tabela PessoaFisica OK
CREATE TABLE PessoaFisica(
	idPessoaFisica INT AUTO_INCREMENT PRIMARY KEY,
	Nome VARCHAR(45) NOT NULL,
  	CPF CHAR(11) NOT NULL,
	RG VARCHAR(10) NOT NULL,
	idCliente INT NOT NULL,
	CONSTRAINT fk_Cliente_PessoaFisica FOREIGN KEY (idCliente) REFERENCES CLIENTE(idCliente)
);

-- Tabela PessoaJuridica ok 
CREATE TABLE PessoaJuridica(
	idPessoaJuridica INT AUTO_INCREMENT PRIMARY KEY,
	NomeFantasia VARCHAR(45) NOT NULL,
	RazaoSocial VARCHAR(45) NOT NULL,
  	CNPJ CHAR(14) NOT NULL,
	idCliente INT NOT NULL,
	CONSTRAINT fk_Cliente_PessoaJuridica FOREIGN KEY (idCliente) REFERENCES CLIENTE(idCliente)
);

-- EndereçoCobrança OK
CREATE TABLE EnderecoCobranca(
	idEnderecoCobranca INT AUTO_INCREMENT PRIMARY KEY,
	CEP INT NOT NULL,
	Rua VARCHAR(45) NOT NULL,
	Numero VARCHAR(45) NOT NULL,
	Complemento VARCHAR(45) NOT NULL,
	Bairro VARCHAR(45) NOT NULL,
	Cidade VARCHAR(45) NOT NULL,
	Estado VARCHAR(45) NOT NULL,
	Pais VARCHAR(45) NOT NULL,
	idPagamento INT NOT NULL,
	CONSTRAINT fk_Pagamento_EnderecoCobranca FOREIGN KEY (idPagamento) REFERENCES PAGAMENTO(idPagamento)  
);

-- EndereçoEntrega OK
CREATE TABLE EnderecoEntrega(
	idEnderecoEntrega INT AUTO_INCREMENT PRIMARY KEY,
	CEP INT NOT NULL,
	Rua VARCHAR(45) NOT NULL,
	Numero VARCHAR(45) NOT NULL,
	Complemento VARCHAR(45) NOT NULL,
	Bairro VARCHAR(45) NOT NULL,
	Cidade VARCHAR(45) NOT NULL,
	Estado VARCHAR(45) NOT NULL,
	Pais VARCHAR(45) NOT NULL,
	idCliente INT NOT NULL,
	CONSTRAINT fk_Cliente_EnderecoEntrega FOREIGN KEY (idCliente) REFERENCES CLIENTE(idCliente)  
);

-- Fornecedor OK
CREATE TABLE Fornecedor(
	idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
	RazaoSocial VARCHAR(45) NOT NULL,
	NomeFantasia VARCHAR(45) NOT NULL,
	CNPJ CHAR(14) NOT NULL,
	Endereco VARCHAR(45) NOT NULL,
	Telefone VARCHAR(45) NOT NULL,
	Email VARCHAR(45) NOT NULL
);

-- Vendedor OK
CREATE TABLE Vendedor(
	idVendedor INT AUTO_INCREMENT PRIMARY KEY,
	NomeFantasia VARCHAR(45),
	Cnpj CHAR(14),
	RazaoSocial VARCHAR(45),
	Telefone VARCHAR(11),
	Email VARCHAR(45),
    Endereco VARCHAR(45)
);

-- VendedorComFornecedor ok
CREATE TABLE IF NOT EXISTS VendedorComFornecedor(
	Vendedor_idVendedor INT NOT NULL,
	Fornecedor_idFornecedor INT NOT NULL,
	PRIMARY KEY (Vendedor_idVendedor, Fornecedor_idFornecedor),
	INDEX fk_VendedorComFornecedor_Fornecedor1_idx (Fornecedor_idFornecedor ASC) VISIBLE,
	INDEX fk_VendedorComFornecedor_Vendedor1_idx (Vendedor_idVendedor ASC) VISIBLE,
	CONSTRAINT fk_VendedorComFornecedor_Vendedor1
    FOREIGN KEY (Vendedor_idVendedor)
    REFERENCES Vendedor(idVendedor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
	CONSTRAINT fk_VendedorComFornecedor_Fornecedor1
    FOREIGN KEY (Fornecedor_idFornecedor)
    REFERENCES Fornecedor (idFornecedor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Entrega ok
CREATE TABLE IF NOT EXISTS Entrega (
  idEntrega INT NOT NULL,
  DataPrevisaoEntrega DATE NOT NULL,
  IdStatus VARCHAR(45) NOT NULL,
  DataStatus TIMESTAMP(6) NOT NULL,
  Pedido_Cliente_idCliente INT NOT NULL,
  EnderecoEntrega_idEnderecoEntrega INT NOT NULL,
  Frete_idFrete1 INT NOT NULL,
  Pedido_idPedido1 INT NOT NULL,
  Pedido_Cliente_idCliente1 INT NOT NULL,
  Pedido_Pagamento_idPagamento INT NOT NULL,
  PRIMARY KEY (idEntrega, EnderecoEntrega_idEnderecoEntrega, Frete_idFrete1, Pedido_idPedido1, Pedido_Cliente_idCliente1, Pedido_Pagamento_idPagamento),
  INDEX fk_Entrega_EnderecoEntrega1_idx (EnderecoEntrega_idEnderecoEntrega ASC) VISIBLE,
  INDEX fk_Entrega_Frete2_idx (Frete_idFrete1 ASC) VISIBLE,
  INDEX fk_Entrega_Pedido2_idx (Pedido_idPedido1 ASC, Pedido_Cliente_idCliente1 ASC, Pedido_Pagamento_idPagamento ASC) VISIBLE,
  CONSTRAINT fk_Entrega_EnderecoEntrega1
    FOREIGN KEY (EnderecoEntrega_idEnderecoEntrega)
    REFERENCES EnderecoEntrega (idEnderecoEntrega)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Entrega_Frete2
    FOREIGN KEY (Frete_idFrete1)
    REFERENCES Frete (idFrete)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Entrega_Pedido2
    FOREIGN KEY (Pedido_idPedido1 , Pedido_Cliente_idCliente1 , Pedido_Pagamento_idPagamento)
    REFERENCES Pedido (idPedido , Cliente_idCliente , Pagamento_idPagamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Frete ok
CREATE TABLE IF NOT EXISTS Frete (
  idFrete INT NOT NULL,
  Endereço VARCHAR(45) NOT NULL,
  PesoTotal FLOAT NOT NULL,
  Valor FLOAT NOT NULL,
  PRIMARY KEY (idFrete))
ENGINE = InnoDB;

-- Pedido ok
CREATE TABLE IF NOT EXISTS Pedido (
  idPedido INT NOT NULL,
  StatusPedido VARCHAR(45) NOT NULL,
  Descrição VARCHAR(45) NULL,
  ValorTotal FLOAT NOT NULL,
  ValorTotalFrete FLOAT NOT NULL,
  IdEnderecoCobranca VARCHAR(45) NULL,
  IdEnderecoEntrega VARCHAR(45) NOT NULL,
  DataStatus TIMESTAMP(6) NOT NULL,
  DataRealizacao TIMESTAMP(6) NOT NULL,
  DataEntrega DATETIME NOT NULL,
  PesoTotal FLOAT NOT NULL,
  Cliente_idCliente INT NOT NULL,
  Pagamento_idPagamento INT NOT NULL,
  Frete_idFrete1 INT NOT NULL,
  PRIMARY KEY (idPedido, Cliente_idCliente, Pagamento_idPagamento, Frete_idFrete1),
  INDEX fk_Pedido_Cliente2_idx (Cliente_idCliente ASC) VISIBLE,
  INDEX fk_Pedido_Pagamento1_idx (Pagamento_idPagamento ASC) VISIBLE,
  INDEX fk_Pedido_Frete2_idx (Frete_idFrete1 ASC) VISIBLE,
  CONSTRAINT fk_Pedido_Cliente2
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES Cliente (idCliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Pedido_Pagamento1
    FOREIGN KEY (Pagamento_idPagamento)
    REFERENCES Pagamento (idPagamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Pedido_Frete2
    FOREIGN KEY (Frete_idFrete1)
    REFERENCES Frete (idFrete)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- PedidoHasProduto ok
CREATE TABLE IF NOT EXISTS `Pedido_has_Produto` (
  `Pedido_idPedido` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL DEFAULT 1,
  `PesoTotal` FLOAT NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Produto_idProduto`),
  INDEX `fk_Pedido_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Produto_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Produto_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Rastreio ok
CREATE TABLE IF NOT EXISTS `Rastreio` (
  `idRastreio` INT NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  `DataStatus` TIMESTAMP(6) NOT NULL,
  `Localizacao` VARCHAR(45) NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  `CodigoRastreio` VARCHAR(45) NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente1` INT NOT NULL,
  `Pedido_Pagamento_idPagamento` INT NOT NULL,
  `Pedido_Frete_idFrete1` INT NOT NULL,
  PRIMARY KEY (`idRastreio`, `Pedido_idPedido`, `Pedido_Cliente_idCliente1`, `Pedido_Pagamento_idPagamento`, `Pedido_Frete_idFrete1`),
  UNIQUE INDEX `CodigoRastreio_UNIQUE` (`CodigoRastreio` ASC) VISIBLE,
  INDEX `fk_Rastreio_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente1` ASC, `Pedido_Pagamento_idPagamento` ASC, `Pedido_Frete_idFrete1` ASC) VISIBLE,
  CONSTRAINT `fk_Rastreio_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente1` , `Pedido_Pagamento_idPagamento` , `Pedido_Frete_idFrete1`)
    REFERENCES `Pedido` (`idPedido` , `Cliente_idCliente` , `Pagamento_idPagamento` , `Frete_idFrete1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Status ok
CREATE TABLE IF NOT EXISTS `Status` (
  `idStatus` INT NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  `Rastreio_idRastreio` INT NOT NULL,
  PRIMARY KEY (`idStatus`, `Rastreio_idRastreio`),
  INDEX `fk_Status_Rastreio1_idx` (`Rastreio_idRastreio` ASC) VISIBLE,
  CONSTRAINT `fk_Status_Rastreio1`
    FOREIGN KEY (`Rastreio_idRastreio`)
    REFERENCES `Rastreio` (`idRastreio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- TipoPagamento OK
CREATE TABLE IF NOT EXISTS `TipoPagamento` (
  `idTipoPagamento` INT NOT NULL,
  `TipoPagamento` ENUM('Cartao Credito', 'Cartao Debito', 'Boleto') NOT NULL,
  PRIMARY KEY (`idTipoPagamento`))
ENGINE = InnoDB;


-- Pagamento OK
CREATE TABLE IF NOT EXISTS `Pagamento` (
  `idPagamento` INT NOT NULL,
  `Ativo` BIT NULL,
  `TipoPagamento_idTipoPagamento` INT NOT NULL,
  PRIMARY KEY (`idPagamento`, `TipoPagamento_idTipoPagamento`),
  INDEX `fk_Pagamento_TipoPagamento1_idx` (`TipoPagamento_idTipoPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_TipoPagamento1`
    FOREIGN KEY (`TipoPagamento_idTipoPagamento`)
    REFERENCES `TipoPagamento` (`idTipoPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- PagamentoBoleto ok
CREATE TABLE IF NOT EXISTS `Pagamento Boleto` (
  `idPagamento Boleto` INT NOT NULL,
  `DataEmissao` DATE NULL,
  `DataVencimento` DATE NULL,
  `Emissor` VARCHAR(45) NULL,
  `NumeroDocumento` INT NULL,
  `Cedente` VARCHAR(45) NULL,
  `CodigoCedente` VARCHAR(45) NULL,
  `Sacado` VARCHAR(45) NULL,
  `TipoPagamento_idTipoPagamento` INT NOT NULL,
  PRIMARY KEY (`idPagamento Boleto`, `TipoPagamento_idTipoPagamento`),
  INDEX `fk_Pagamento Boleto_TipoPagamento1_idx` (`TipoPagamento_idTipoPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento Boleto_TipoPagamento1`
    FOREIGN KEY (`TipoPagamento_idTipoPagamento`)
    REFERENCES `TipoPagamento` (`idTipoPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- PagamentoCartaoCredito ok
CREATE TABLE IF NOT EXISTS `Pagamento Cartao Credito` (
  `idPagamento Cartao Credito` INT NOT NULL,
  `NumeroCartao` INT NULL,
  `Validade` DATE NULL,
  `CVC` INT NULL,
  `NomeComoNoCartao` VARCHAR(45) NULL,
  `QuantidadeParcelas` INT NULL,
  `TipoPagamento_idTipoPagamento1` INT NOT NULL,
  PRIMARY KEY (`idPagamento Cartao Credito`, `TipoPagamento_idTipoPagamento1`),
  INDEX `fk_Pagamento Cartao Credito_TipoPagamento2_idx` (`TipoPagamento_idTipoPagamento1` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento Cartao Credito_TipoPagamento2`
    FOREIGN KEY (`TipoPagamento_idTipoPagamento1`)
    REFERENCES `TipoPagamento` (`idTipoPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- PagamentoCartaoDebito ok
CREATE TABLE IF NOT EXISTS `Pagamento Cartao Debito` (
  `idPagamento Cartao Debito` INT NOT NULL,
  `NumeroCartao` INT NULL,
  `Validade` DATE NULL,
  `CVC` INT NULL,
  `NomeComoNoCartao` VARCHAR(45) NULL,
  `TipoPagamento_idTipoPagamento` INT NOT NULL,
  PRIMARY KEY (`idPagamento Cartao Debito`, `TipoPagamento_idTipoPagamento`),
  INDEX `fk_Pagamento Cartao Debito_TipoPagamento1_idx` (`TipoPagamento_idTipoPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento Cartao Debito_TipoPagamento1`
    FOREIGN KEY (`TipoPagamento_idTipoPagamento`)
    REFERENCES `TipoPagamento` (`idTipoPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Produto ok
CREATE TABLE IF NOT EXISTS `Produto` (
  `idProduto` INT NOT NULL,
  `Categoria` VARCHAR(45) NULL,
  `Descricao` VARCHAR(45) NULL,
  `Valor` FLOAT NOT NULL,
  `Peso` FLOAT NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;

-- ProdutoPorFornecedor ok
CREATE TABLE IF NOT EXISTS `Produto por Fornecedor` (
  `Produto_idProduto` INT NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Fornecedor_idFornecedor`),
  INDEX `fk_Produto_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  INDEX `fk_Produto_has_Fornecedor_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Fornecedor_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- ProdutoPorVendedor ok
CREATE TABLE IF NOT EXISTS `Produto por Vendedor` (
  `Produto_idProduto` INT NOT NULL,
  `Vendedor_idVendedor` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Vendedor_idVendedor`),
  INDEX `fk_Produto_has_Vendedor_Vendedor1_idx` (`Vendedor_idVendedor` ASC) VISIBLE,
  INDEX `fk_Produto_has_Vendedor_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Vendedor_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Vendedor_Vendedor1`
    FOREIGN KEY (`Vendedor_idVendedor`)
    REFERENCES `Vendedor` (`idVendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- ProdutoEmEstoque ok
CREATE TABLE IF NOT EXISTS `ProdutoEmEstoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Estoque ok
CREATE TABLE IF NOT EXISTS `Estoque` (
  `idEstoque` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;

--


