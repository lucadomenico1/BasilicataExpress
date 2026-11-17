-- =====================================================================
--  Basilicata Express - schema del database + dati di prova
--  Per MySQL 8.x.  Si esegue UNA volta (cancella e ricrea tutto).
-- =====================================================================
DROP DATABASE IF EXISTS basilicata_express;
CREATE DATABASE basilicata_express CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE basilicata_express;

-- ---------- UTENTE: clienti e amministratori nella stessa tabella ----------
CREATE TABLE utente (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(50)  NOT NULL,
    cognome       VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,          -- UNIQUE: due utenti non possono avere la stessa email
    password_hash VARCHAR(255) NOT NULL,                 -- mai la password in chiaro! formato  sale$hash
    ruolo         ENUM('CLIENTE','ADMIN') NOT NULL DEFAULT 'CLIENTE'
) ENGINE=InnoDB;

-- ---------- COMUNE: le localita' di partenza/arrivo ----------
CREATE TABLE comune (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- ---------- TRATTA: il "prodotto" che si vende ----------
CREATE TABLE tratta (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    partenza_id       INT NOT NULL,
    arrivo_id         INT NOT NULL,
    data_ora_partenza DATETIME NOT NULL,
    mezzo             ENUM('BUS','TRENO','NAVETTA') NOT NULL,
    prezzo            DECIMAL(6,2) NOT NULL CHECK (prezzo > 0),
    posti_disponibili INT NOT NULL CHECK (posti_disponibili >= 0),
    FOREIGN KEY (partenza_id) REFERENCES comune(id),
    FOREIGN KEY (arrivo_id)   REFERENCES comune(id),
    INDEX idx_tratta_ricerca (partenza_id, arrivo_id, data_ora_partenza)
) ENGINE=InnoDB;

-- ---------- ORDINE: testata dell'ordine ----------
CREATE TABLE ordine (
    id                     INT AUTO_INCREMENT PRIMARY KEY,
    utente_id              INT NOT NULL,
    data_ordine            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totale                 DECIMAL(8,2) NOT NULL,
    intestatario           VARCHAR(100) NOT NULL,         -- chi paga
    email_biglietti        VARCHAR(100) NOT NULL,         -- a questa email "spediamo" i biglietti
    indirizzo_fatturazione VARCHAR(200) NOT NULL,
    metodo_pagamento       ENUM('CARTA','PAYPAL','BONIFICO') NOT NULL,
    carta_ultime4          CHAR(4) NULL,                  -- solo le ultime 4 cifre, MAI il numero completo
    FOREIGN KEY (utente_id) REFERENCES utente(id),
    INDEX idx_ordine_data (data_ordine)
) ENGINE=InnoDB;

-- ---------- DETTAGLIO_ORDINE: una riga per ogni tratta acquistata ----------
-- Contiene una COPIA dei dati della tratta (partenza, arrivo, data, prezzo):
--  * se il prezzo della tratta cambia dopo, l'ordine mantiene il prezzo pagato
--  * se l'admin cancella la tratta, l'ordine mantiene tutti i dati (tratta_id diventa NULL)
CREATE TABLE dettaglio_ordine (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    ordine_id         INT NOT NULL,
    tratta_id         INT NULL,
    partenza          VARCHAR(80) NOT NULL,
    arrivo            VARCHAR(80) NOT NULL,
    data_ora_partenza DATETIME NOT NULL,
    prezzo_unitario   DECIMAL(6,2) NOT NULL,
    quantita          INT NOT NULL CHECK (quantita > 0),
    FOREIGN KEY (ordine_id) REFERENCES ordine(id)  ON DELETE CASCADE,
    FOREIGN KEY (tratta_id) REFERENCES tratta(id)  ON DELETE SET NULL
) ENGINE=InnoDB;

-- =====================================================================
--  DATI DI PROVA
-- =====================================================================
-- Password di prova:  admin -> Admin123!    cliente -> Cliente123!
INSERT INTO utente (nome, cognome, email, password_hash, ruolo) VALUES
('Admin', 'Sistema', 'admin@basilicataexpress.it',
 'a1b2c3d4e5f60718293a4b5c6d7e8f90$45a98f6c4c1330eadcfd4f59ea54b5c238011da5a6e479bf4a795173e85e77016ca97ed48435ac6fcfb317fbda0f4783b2c3f19edbf223ea9fea1136f325a8b4', 'ADMIN'),
('Mario', 'Rossi', 'mario.rossi@example.com',
 '0f1e2d3c4b5a69788796a5b4c3d2e1f0$7a56e6b30018ea2dd39174d25a6d527555692be7bae86864a875f4426c4e515a9e54d4084e9243b0c59295c7e41adb00fd261d2e2ce5f3b6c17b5871247804b0', 'CLIENTE');

INSERT INTO comune (nome) VALUES
('Potenza'),
('Matera'),
('Melfi'),
('Lagonegro'),
('Maratea'),
('Policoro'),
('Metaponto'),
('Venosa'),
('Pisticci'),
('Rionero in Vulture'),
('Tricarico'),
('Viggiano');

INSERT INTO tratta (partenza_id, arrivo_id, data_ora_partenza, mezzo, prezzo, posti_disponibili) VALUES
(1, 2, '2026-12-10 06:30:00', 'BUS', 6.50, 40),
(3, 1, '2026-12-10 12:30:00', 'BUS', 5.00, 30),
(2, 7, '2026-12-10 18:30:00', 'TRENO', 3.20, 50),
(1, 8, '2026-12-10 10:30:00', 'BUS', 5.50, 20),
(2, 11, '2026-12-10 16:30:00', 'BUS', 3.50, 20),
(8, 3, '2026-12-10 08:30:00', 'NAVETTA', 2.50, 20),
(1, 3, '2026-12-16 11:00:00', 'BUS', 5.00, 40),
(4, 5, '2026-12-16 17:00:00', 'NAVETTA', 3.50, 20),
(6, 2, '2026-12-16 09:00:00', 'BUS', 7.00, 30),
(3, 10, '2026-12-16 15:00:00', 'NAVETTA', 2.50, 20),
(5, 1, '2026-12-16 07:00:00', 'BUS', 7.50, 20),
(2, 1, '2026-12-22 08:45:00', 'BUS', 6.50, 50),
(1, 4, '2026-12-22 14:45:00', 'BUS', 4.50, 50),
(7, 6, '2026-12-22 06:45:00', 'TRENO', 2.80, 20),
(2, 9, '2026-12-22 12:45:00', 'BUS', 3.00, 30),
(1, 12, '2026-12-22 18:45:00', 'BUS', 6.00, 20),
(1, 2, '2026-12-28 06:30:00', 'BUS', 6.50, 50),
(3, 1, '2026-12-28 12:30:00', 'BUS', 5.00, 20),
(2, 7, '2026-12-28 18:30:00', 'TRENO', 3.20, 20),
(1, 8, '2026-12-28 10:30:00', 'BUS', 5.50, 30),
(2, 11, '2026-12-28 16:30:00', 'BUS', 3.50, 20),
(8, 3, '2026-12-28 08:30:00', 'NAVETTA', 2.50, 50),
(1, 3, '2027-01-03 11:00:00', 'BUS', 5.00, 20),
(4, 5, '2027-01-03 17:00:00', 'NAVETTA', 3.50, 30),
(6, 2, '2027-01-03 09:00:00', 'BUS', 7.00, 20),
(3, 10, '2027-01-03 15:00:00', 'NAVETTA', 2.50, 30),
(5, 1, '2027-01-03 07:00:00', 'BUS', 7.50, 40),
(2, 1, '2027-01-09 08:45:00', 'BUS', 6.50, 50),
(1, 4, '2027-01-09 14:45:00', 'BUS', 4.50, 30),
(7, 6, '2027-01-09 06:45:00', 'TRENO', 2.80, 20),
(2, 9, '2027-01-09 12:45:00', 'BUS', 3.00, 40),
(1, 12, '2027-01-09 18:45:00', 'BUS', 6.00, 30),
(1, 2, '2027-01-15 06:30:00', 'BUS', 6.50, 20),
(3, 1, '2027-01-15 12:30:00', 'BUS', 5.00, 30),
(2, 7, '2027-01-15 18:30:00', 'TRENO', 3.20, 40),
(1, 8, '2027-01-15 10:30:00', 'BUS', 5.50, 20),
(2, 11, '2027-01-15 16:30:00', 'BUS', 3.50, 20),
(8, 3, '2027-01-15 08:30:00', 'NAVETTA', 2.50, 20),
(1, 3, '2027-01-21 11:00:00', 'BUS', 5.00, 30),
(4, 5, '2027-01-21 17:00:00', 'NAVETTA', 3.50, 50),
(6, 2, '2027-01-21 09:00:00', 'BUS', 7.00, 50),
(3, 10, '2027-01-21 15:00:00', 'NAVETTA', 2.50, 40),
(5, 1, '2027-01-21 07:00:00', 'BUS', 7.50, 50),
(2, 1, '2027-01-27 08:45:00', 'BUS', 6.50, 50),
(1, 4, '2027-01-27 14:45:00', 'BUS', 4.50, 40),
(7, 6, '2027-01-27 06:45:00', 'TRENO', 2.80, 40),
(2, 9, '2027-01-27 12:45:00', 'BUS', 3.00, 30),
(1, 12, '2027-01-27 18:45:00', 'BUS', 6.00, 30),
(1, 2, '2027-02-02 06:30:00', 'BUS', 6.50, 30),
(3, 1, '2027-02-02 12:30:00', 'BUS', 5.00, 20),
(2, 7, '2027-02-02 18:30:00', 'TRENO', 3.20, 40),
(1, 8, '2027-02-02 10:30:00', 'BUS', 5.50, 50),
(2, 11, '2027-02-02 16:30:00', 'BUS', 3.50, 40),
(8, 3, '2027-02-02 08:30:00', 'NAVETTA', 2.50, 50),
(1, 3, '2027-02-08 11:00:00', 'BUS', 5.00, 40),
(4, 5, '2027-02-08 17:00:00', 'NAVETTA', 3.50, 20),
(6, 2, '2027-02-08 09:00:00', 'BUS', 7.00, 20),
(3, 10, '2027-02-08 15:00:00', 'NAVETTA', 2.50, 50),
(5, 1, '2027-02-08 07:00:00', 'BUS', 7.50, 30),
(2, 1, '2027-02-14 08:45:00', 'BUS', 6.50, 40),
(1, 4, '2027-02-14 14:45:00', 'BUS', 4.50, 30),
(7, 6, '2027-02-14 06:45:00', 'TRENO', 2.80, 50),
(2, 9, '2027-02-14 12:45:00', 'BUS', 3.00, 50),
(1, 12, '2027-02-14 18:45:00', 'BUS', 6.00, 20);

-- Un ordine di esempio del cliente (id 2), con prezzi "congelati"
INSERT INTO ordine (utente_id, data_ordine, totale, intestatario, email_biglietti, indirizzo_fatturazione, metodo_pagamento, carta_ultime4) VALUES
(2, '2026-11-14 10:15:00', 13.00, 'Mario Rossi', 'mario.rossi@example.com', 'Via Roma 1, 85100 Potenza', 'CARTA', '4242');
INSERT INTO dettaglio_ordine (ordine_id, tratta_id, partenza, arrivo, data_ora_partenza, prezzo_unitario, quantita) VALUES
(1, 1, 'Potenza', 'Matera', '2026-12-10 06:30:00', 6.50, 2);
