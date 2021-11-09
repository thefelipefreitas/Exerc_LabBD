USE ESCOLA;

-- 1
-- NATURAL JOIN
select distinct depto.nome
from depto natural join horario h natural join predio 
where h.anoSem = 20021 
	and predio.nome = 'Exatas' 
    and h.numSala = 101;
    
-- THETA JOIN
select distinct depto.nome 
from depto, horario h, predio 
where depto.codigo = h.codDepto
	and h.anoSem = 20021 
    and h.codPred = predio.codigo
    and predio.nome = 'Exatas' 
    and h.numSala = 101;


-- 2
select distinct depto.nome, (case
								when di.credito > 3 
								then di.credito
								else null 
								end) as nome
from depto natural left join disciplina di;

select a.nome_disc, x.num_disc_pre_req  
from disciplina a join (select * 
						from disciplina b
						natural join pre_req) as x 
where x.num_disc_pre_req = a.num_disc;


-- 3
-- THETA
select a.nome_disc, x.num_disc_pre_req 
from disciplina a,
    (select num_disc_pre_req 
     from disciplina b, pre_req 
     where b.num_disc = pre_req.num_disc) as x
     where a.num_disc = x.num_disc_pre_req;

-- NATURAL
select a.nome_disc, x.num_disc_pre_req  
from disciplina a
    join (select * 
		  from disciplina b natural join pre_req) as x 
		  where x.num_disc_pre_req = a.num_disc;	