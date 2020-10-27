DROP DATABASE IF EXISTS yoga;

CREATE DATABASE yoga DEFAULT CHARACTER SET utf8mb4;

USE yoga;

CREATE TABLE adresses (
	id INT UNSIGNED AUTO_INCREMENT,
    rue VARCHAR(38) NOT NULL,
    code_postal CHAR(5) NOT NULL,
    ville VARCHAR(38),
    PRIMARY KEY (id)
);

CREATE TABLE salles (
	id INT UNSIGNED AUTO_INCREMENT,
    nom_salle VARCHAR(30) NOT NULL,
    capacite TINYINT UNSIGNED NOT NULL DEFAULT 10,
    id_adresse INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT salle_to_adresse 
        FOREIGN KEY (id_adresse) REFERENCES adresses(id)
);

CREATE TABLE adherents (
    id INT UNSIGNED AUTO_INCREMENT,
    nom_adherent VARCHAR(30) NOT NULL,
    prenom_adherent VARCHAR(30) NOT NULL,
    email VARCHAR(30) NOT NULL,
    mot_de_passe VARCHAR(30) NOT NULL,
    id_adresse INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT adherent_to_adresse 
        FOREIGN KEY (id_adresse) REFERENCES adresses(id)
);

CREATE TABLE paiements (
    id INT UNSIGNED AUTO_INCREMENT,
    montant DECIMAL(5,2) UNSIGNED NOT NULL,
    date_paiement DATE NOT NULL,
    mode_paiement VARCHAR(30) NOT NULL,
    id_adhesion INT UNSIGNED,
    PRIMARY KEY (id),
    CONSTRAINT paiement_to_adhesion
        FOREIGN KEY (id_adhesion) REFERENCES adhesions(id)
);

CREATE TABLE adhesions (
    id INT UNSIGNED AUTO_INCREMENT,
    date_adhesion DATE NOT NULL,
    tarif DECIMAL(5, 2) UNSIGNED NOT NULL,
    role_adherent VARCHAR(30) NOT NULL,
    id_adherent INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT adhesion_to_adherent 
        FOREIGN KEY (id_adherent) REFERENCES adherents(id)
);

CREATE TABLE cours (
    id INT UNSIGNED AUTO_INCREMENT,
    titre_cours VARCHAR(30) NOT NULL,
    date_cours DATE NOT NULL,
    nb_place TINYINT UNSIGNED NOT NULL,
    id_professeur INT UNSIGNED NOT NULL,
    id_salle INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT cours_to_prof 
        FOREIGN KEY (id_professeur) REFERENCES adherents(id),
    CONSTRAINT cours_to_salle 
    FOREIGN KEY (id_salle) REFERENCES salles(id)
);

CREATE TABLE cours_participation (
    id_cours INT UNSIGNED NOT NULL,
    id_adherent INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_cours, id_participant),
    CONSTRAINT participation_to_adherent
        FOREIGN KEY (id_adherent) REFERENCES adherents(id),
    CONSTRAINT participation_to_cours 
        FOREIGN KEY (id_cours) REFERENCES cours(id)
);


