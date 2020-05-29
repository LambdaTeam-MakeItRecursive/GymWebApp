create trigger check_tripla_serie
    before insert on composizione_serie
    for each row execute procedure check_presenza_coppia_serie();

create trigger check_tripla_riscaldamento
    before insert on composizione_riscaldamento
    for each row execute procedure check_presenza_coppia_riscaldamento();