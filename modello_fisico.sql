create table utente (
    id serial primary key,
    nome text not null,
    cognome text not null,
    data_nascita date not null,
    email text not null unique,
    password text not null
);

create domain tipologie varchar(20)
    check (value in ('massa muscolare', 'dimagrimento', 'tonificazione'));

create domain difficolta_possibili varchar(20)
    check (value in ('principante', 'intermedio', 'avanzato'));

create table scheda (
    utente_id serial primary key references utente(id),
    tipologia tipologie,
    difficolta difficolta_possibili,
    obiettivo text,
    data_inizio date not null,
    data_fine date not null
);

create table allenamento (
    id serial primary key,
    data date not null,
    durata interval not null
);

create table contiene (
    scheda_id serial references scheda(utente_id),
    allenamento_id serial references allenamento(id),
    primary key (scheda_id, allenamento_id)
);

create domain gruppi_muscolari varchar(20)
    check (value in ('petto', 'dorso', 'spalle', 'bicipiti', 'tricipiti', 'gambe e glutei', 'addome'));

create table esercizio (
    id serial primary key,
    nome text not null,
    descrizione text,
    gruppo_muscolare gruppi_muscolari
);

create table composto (
    allenamento_id serial references allenamento(id),
    esercizio_id serial references esercizio(id),
    primary key (allenamento_id, esercizio_id)
);

create table esercizio_serie (
    esercizio_id serial primary key references esercizio(id),
    numero smallint not null,
    intervallo interval,
    carico real,
    durata interval,
    nome_strumento_utilizzato text,
    peso_strumento real
);

create table riscaldamento (
    esercizio_id serial primary key references esercizio(id),
    durata interval not null
);

create table ripetizione (
    esercizio_serie_id serial primary key references esercizio_serie(esercizio_id),
    numero smallint not null
);


