#Comando de DML Maniupulação

insert into pessoas
(id, nome, nascimento, sexo, peso, altura, nacionalidade)
values
(default, 'Ana', '1895-05-10', 'F', '65.5', '1.67', default);

insert into pessoas values
(default, 'Iasmim', '1659-02-15', 'F', '70', '1.7','Noruega'),
(default, 'Iasmim', '1659-02-15', 'F', '70', '1.7','Noruega'),
(default, 'Iasmim', '1659-02-15', 'F', '70', '1.7','Noruega');

select * from pessoas;
-- =============================================================

alter table gafanhotos
drop column timeFutebol;

alter table gafanhotos
add column estCivil varchar(12) after nascimento;

alter table gafanhotos
modify column estCivil varchar (15) default 'solteiro' after nascimento;

alter table gafanhotos
change column estCivil estadoCivil varchar (15) default 'solteiro' after nascimento;

alter table cursos 
add column idCursos int first;

alter table cursos 
add primary key (idCurso)

alter table amigos
add column timi varchar(15) after nome; //criou coluna timi

alter table amigos
drop column timi; //apagou coluna timi


-- =============================================================
insert into cursos value 
('1', 'HTML5', 'curso de HTML5', '40', '37', '2014'),
('2', 'Algoritmo', 'logica de programação', '20','15','2014'),
('3', 'photoshop', 'dicas de photoshop', '10', '8','2014'),
('4', 'JavaScript', 'curso de JS', '42','36', '2019'),
('5','PHP', 'aulas sobre PHP', '18', '15', '2000');

update cursos 
set nome = 'HTML5 plus'
where idCurso = '1';

update cursos
set nome = 'PhotoShop', ano = '2017' 
where idCurso = '3';

update cursos
set nome = 'MR JS', descricao = 'DOMinando o JavaScript', ano = '2020'
where idCurso = '4';

delete from cursos 
where idCurso = '5';


drop table  //apaga estrutura e dados
truncate table cursos;// apaga os dados
-- =============================================================

show create table amigos;           -> mostra o codigo que gerou a criação da tabela.

-- =============================================================
select * from cursos
order by nome desc;   ->escolha uma coluna para filtro 'ordem alfabetica decrescente'

select nome, carga, ano from cursos 
order by ano desc, nome;    ->filtrou por essas 3 colunas, com ano descrescente e nome crescente.

select nome, carga, ano from cursos
where ano = '2016'
order by nome desc;         -> filtrou as linhas tambem

select nome, descricao, ano from cursos
where ano <= '2015' || ano > 2017
order by ano, nome;

select * from cursos
where ano > 2015 'or  ou  and' totaulas < 30;                  -> ultilizando operadores relacionais


select *from cursos
where totaulas between '20' and '30'
order by ano;               -> entre um valor e outro.


select * from cursos
where ano in (2014, 2016) 
order by ano desc;              -> especifica valores


select * from cursos
where nome like 'p%';       -> seleciona os campos que começam com  P

select * from cursos
where nome  not like '%a%s';    -> selelcionas os campos que nao tenha A em nenhum lugar e nao terminam em S


select * from cursos
where nome  like 'ph%p_';       -> seleciona os camps que começam com ph e tenha obrigatoriamente 
                                alguma coisa no final antecedido por um P.

select distinct nacionalidade from gafanhotos;  -> vai retirar a repetidão de um mesmo registro da lista.

-- ======================(FUNÇÃO DE AGREGAÇÃO)
select count(*) from cursos;        -> função para contar todas as linhas de registro

select max(totaulas) from cursos ;  -> verifica o valor maximo numa coluna
select min(totaulas) from cursos ;  -> verifica o valor minimo numa coluna

select nome, min(totaulas) from cursos;     -> vai selecionar junto com o menor valor, o nome do curso.

select sum(totaulas) from cursos where ano ='2017';     -> somar valores de uma coluna

select avg(totaulas) from cursos where ano ='2017';     -> tira a media aritmetica de uma coluna


-- =============================================================
select nome, carga from cursos
group by carga;                     -> vai agrupar os cursos que tem a mesma carga

select carga, count(carga) from cursos
group by carga;                     -> mostra a quantidade de registro dentro de um grupo




select nome, totaulas, carga, count(*) from cursos where carga > 20
group by totaulas
having count(*) >= 2
order by carga;                     -> vai mostrar dentre os grupos feitos, somente aqueles que atendem o valor do having


select avg (carga) from cursos;        -> media das cargas horarias dos cursos



select carga, ano, count(*) from cursos
where ano > 2015
group by carga
having carga > (select avg(carga) from cursos)
order by ano;
                                            -> vai mostrar os cursos selecionados e agrupados em que os valores da carga seja maior que a media dos cursos.

-- =============================================================

alter table gafanhotos
add foreign key (cursoPreferido)
references cursos(idcurso);         -> cadastrando uma chave estrangeira, com referencia no idcurso em cursos.


select gafanhotos.nome, cursos.nome, cursos.ano 
from gafanhotos join cursos
on cursos.idcurso = gafanhotos.cursoPreferido;          -> sempre tem que usar o ON pra dar sentido, fazer uma ligação da chave primaria com a estrangeira.
(so as tuplas que tem relações)     


select g.nome, c.nome, c.ano 
from gafanhotos as g join cursos as c
on c.idcurso = g.cursoPreferido;          -> forma simplificada de trabalhar com apelidos.

select g.nome, c.nome, c.ano 
from gafanhotos as g right outer join cursos as c
on c.idcurso = g.cursoPreferido;            -> ultilizando outer join para juntar as tabelas e contem tambem os registros vazios.


-- =============================================================
select * from gafanhotos as g
join assistir as a 
on g.id = a.idgafanhoto;            -> juntos os dados de quem assitir com seus respectivos registros.

select g.nome, c.nome from gafanhotos as g
join assistir as a 
on g.id = a.idgafanhoto 
join cursos as c 
on c.idcurso = a.idcurso;           -> juntando 3 tabelas (cria uma nova e junta as outras )


-- =============================================================