create function check_presenza_coppia_serie () returns trigger as $$
    begin
        if ((select count(*) from composto, composizione_serie where composizione_serie.allenamento_id = composto.allenamento_id and composizione_serie.esercizio_id= composto.esercizio_id) > 0)
        then raise exception 'inserimento invalido, prima inserire la coppia allenamento esercizio';
        end if;
        return new;
    end
$$ language plpgsql;

create function check_presenza_coppia_riscaldamento () returns trigger as $$
    begin
        if ((select count(*) from composto, composizione_riscaldamento where composizione_riscaldamento.allenamento_id = composto.allenamento_id and composizione_riscaldamento.esercizio_id= composto.esercizio_id) > 0)
        then raise exception 'inserimento invalido, prima inserire la coppia allenamento esercizio';
        end if;
        return new;
    end
$$ language plpgsql;