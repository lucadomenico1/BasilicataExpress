-- ============================================================
-- Basilicata Express - creazione database e dati di prova
-- ============================================================

DROP DATABASE IF EXISTS basilicata_express;
CREATE DATABASE basilicata_express CHARACTER SET utf8mb4;
USE basilicata_express;

-- ------------------------------------------------------------
-- UTENTE: clienti e amministratori (il campo ruolo li distingue)
-- ------------------------------------------------------------
CREATE TABLE utente (
    email    VARCHAR(100) PRIMARY KEY,
    nome     VARCHAR(50)  NOT NULL,
    cognome  VARCHAR(50)  NOT NULL,
    password VARCHAR(64)  NOT NULL,   -- hash SHA-256 in esadecimale (64 caratteri), mai la password in chiaro
    ruolo    ENUM('cliente', 'admin') NOT NULL DEFAULT 'cliente'
);

-- ------------------------------------------------------------
-- TRATTA: le corse acquistabili (i "prodotti" del catalogo)
-- stato = 'eliminata' e' la cancellazione logica: la tratta non
-- compare piu' nelle ricerche ma resta negli ordini gia' fatti
-- ------------------------------------------------------------
CREATE TABLE tratta (
    id_tratta       INT AUTO_INCREMENT PRIMARY KEY,
    partenza        VARCHAR(60)  NOT NULL,
    arrivo          VARCHAR(60)  NOT NULL,
    data_partenza   DATE         NOT NULL,
    ora_partenza    TIME         NOT NULL,
    prezzo_attuale  DECIMAL(6,2) NOT NULL CHECK (prezzo_attuale >= 0),
    stato           ENUM('attiva', 'eliminata') NOT NULL DEFAULT 'attiva',
    INDEX idx_ricerca (partenza, arrivo, data_partenza)
);

-- ------------------------------------------------------------
-- ORDINE: un acquisto confermato di un cliente registrato
-- ------------------------------------------------------------
CREATE TABLE ordine (
    id_ordine        INT AUTO_INCREMENT PRIMARY KEY,
    email_utente     VARCHAR(100) NOT NULL,
    data_acquisto    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totale_ordine    DECIMAL(8,2) NOT NULL,
    intestatario     VARCHAR(100) NOT NULL,
    metodo_pagamento VARCHAR(30)  NOT NULL,
    FOREIGN KEY (email_utente) REFERENCES utente(email)
);

-- ------------------------------------------------------------
-- DETTAGLIO_ORDINE: le righe dell'ordine (relazione COMPOSTO_DA)
-- prezzo_acquisto "fotografa" il prezzo pagato: se l'admin cambia
-- prezzo_attuale in tratta, gli ordini vecchi non cambiano.
-- Nessun ON DELETE CASCADE: una tratta presente in un ordine
-- non puo' essere cancellata fisicamente (ecco perche' si usa 'stato').
-- ------------------------------------------------------------
CREATE TABLE dettaglio_ordine (
    id_ordine       INT          NOT NULL,
    id_tratta       INT          NOT NULL,
    quantita        INT          NOT NULL CHECK (quantita > 0),
    prezzo_acquisto DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (id_ordine, id_tratta),
    FOREIGN KEY (id_ordine) REFERENCES ordine(id_ordine),
    FOREIGN KEY (id_tratta) REFERENCES tratta(id_tratta)
);

-- ============================================================
-- DATI DI PROVA
-- ============================================================

-- Admin: email admin@basilicataexpress.it / password admin123
-- (SHA2(..., 256) calcola l'hash SHA-256 direttamente in MySQL)
INSERT INTO utente (email, nome, cognome, password, ruolo) VALUES
('admin@basilicataexpress.it', 'Admin', 'Express', SHA2('admin123', 256), 'admin');

-- Cliente di prova: mario.rossi@email.it / password cliente123
INSERT INTO utente (email, nome, cognome, password, ruolo) VALUES
('mario.rossi@email.it', 'Mario', 'Rossi', SHA2('cliente123', 256), 'cliente');

-- Tratte tra comuni lucani; le date partono da oggi, cosi' sono sempre future
INSERT INTO tratta (partenza, arrivo, data_partenza, ora_partenza, prezzo_attuale) VALUES
('Potenza',   'Matera',    DATE_ADD(CURDATE(), INTERVAL 1 DAY), '07:30:00', 6.50),
('Potenza',   'Matera',    DATE_ADD(CURDATE(), INTERVAL 1 DAY), '14:00:00', 6.50),
('Matera',    'Potenza',   DATE_ADD(CURDATE(), INTERVAL 1 DAY), '09:15:00', 6.50),
('Matera',    'Potenza',   DATE_ADD(CURDATE(), INTERVAL 1 DAY), '17:45:00', 6.50),
('Potenza',   'Melfi',     DATE_ADD(CURDATE(), INTERVAL 2 DAY), '08:00:00', 5.00),
('Melfi',     'Potenza',   DATE_ADD(CURDATE(), INTERVAL 2 DAY), '16:30:00', 5.00),
('Potenza',   'Lagonegro', DATE_ADD(CURDATE(), INTERVAL 2 DAY), '10:00:00', 4.50),
('Lagonegro', 'Potenza',   DATE_ADD(CURDATE(), INTERVAL 2 DAY), '18:00:00', 4.50),
('Matera',    'Metaponto', DATE_ADD(CURDATE(), INTERVAL 3 DAY), '09:00:00', 3.50),
('Metaponto', 'Matera',    DATE_ADD(CURDATE(), INTERVAL 3 DAY), '19:00:00', 3.50),
('Matera',    'Policoro',  DATE_ADD(CURDATE(), INTERVAL 3 DAY), '11:30:00', 5.50),
('Potenza',   'Venosa',    DATE_ADD(CURDATE(), INTERVAL 4 DAY), '08:30:00', 5.50),
('Potenza',   'Maratea',   DATE_ADD(CURDATE(), INTERVAL 5 DAY), '07:00:00', 8.00),
('Maratea',   'Potenza',   DATE_ADD(CURDATE(), INTERVAL 5 DAY), '17:00:00', 8.00);

-- ============================================================
-- Controllo rapido (eseguili uno alla volta per verificare)
-- ============================================================
-- SELECT * FROM utente;
-- SELECT * FROM tratta WHERE partenza = 'Potenza' AND stato = 'attiva';