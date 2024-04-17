CREATE TABLE `Utente`(
    `username` VARCHAR(255) NOT NULL,
    `nome` VARCHAR(255) NOT NULL,
    `cognome` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `n_telefono` CHAR(10) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`username`)
);
CREATE TABLE `Prodotto`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome` VARCHAR(255) NOT NULL,
    `descrizione` VARCHAR(255) NOT NULL,
    `prezzo` DOUBLE NOT NULL,
    `fascia_iva` DOUBLE NOT NULL,
    `dimensioni` CHAR(10) NOT NULL,
    `disponibilita` SMALLINT NOT NULL,
    `categoria` VARCHAR(255) NOT NULL,
    `colore` VARCHAR(255) NOT NULL,
    `immagine` BLOB
);
