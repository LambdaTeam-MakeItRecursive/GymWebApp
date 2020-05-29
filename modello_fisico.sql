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
);

create table gruppo_muscolare (
    id serial primary key,
    nome gruppi_muscolari unique
);

create table esercizio_gruppo (
    esercizio_id serial references esercizio(id),
    gruppo_muscolare_id serial references gruppo_muscolare(id),
    primary key (esercizio_id, gruppo_muscolare_id)
);

create table esercizio_serie (
    id serial primary key,
    numero smallint not null,
    intervallo interval not null,
    durata interval,
    nome_strumento_utilizzato text,
    peso_strumento real,
    unique(numero, intervallo)
);

create table composizione_serie (
    allenamento_id serial references allenamento(id),
    esercizio_id serial references esercizio(id),
    esercizio_serie_id serial references esercizio_serie(id),
    primary key (allenamento_id, esercizio_id, esercizio_serie_id)
);

create table dati_esercizi_serie (
    esercizio_serie_id serial primary key references esercizio_serie(id),
    carico real not null,
    serie_corrente smallint not null unique
);

create table riscaldamento (
    id serial primary key,
    durata interval not null
);

create table composizione_riscaldamento (
    allenamento_id serial references allenamento(id),
    esercizio_id serial references esercizio(id),
    riscaldamento_id serial references riscaldamento(id),
    primary key (allenamento_id, esercizio_id, riscaldamento_id)
);

create table ripetizione (
    esercizio_serie_id serial primary key references esercizio_serie(id),
    numero smallint not null
);

create table composto (
    esercizio_id serial references esercizio(id),
    allenamento_id serial references allenamento(id),
    primary key (esercizio_id, allenamento_id)
);
