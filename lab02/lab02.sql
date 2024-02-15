/*
Questão 1
Quando você coloca o idioma diferente do texto, ele não consegue encontrar o radical das palavras.
*/

SELECT to_tsvector('english','drama');
SELECT to_tsvector('portuguese','drama');
SELECT to_tsvector('english','Esse é um exemplo de brinquedo');
SELECT to_tsvector('portuguese','Esse é um exemplo de brinquedo');


/*
Questão 2
Foram retornados 2 livros: Belfest e CODA

*/

SELECT * FROM best_films as bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','family & drama');

/*
Questão 3
O livro CODA foir retornado
<-> Esse operador procura as palavras de maneira sucessiva.
*/
SELECT bf.title FROM best_films as bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','family <-> drama');

/*
Questão 4
O resultado é TRUE, pois ambos os métodos vão remover as stopwords e ficar somente com 2 radicais,
sendo eles: 'drama' e 'famili'.
*/
SELECT to_tsvector('english', 'this is a family drama') @@ to_tsquery('english', 'drama & of & a & family');

/*
Questão 5
Sim

*/

SELECT bf.title from best_films as bf WHERE to_tsvector('english', description) @@ to_tsquery('english','fame<->about<->fortunes');

/*
Questão 6
*/
/*6.1*/
SELECT bf.title from best_films as bf WHERE to_tsvector('english', description) @@ to_tsquery('english','fame<1>about<1>fortunes');

/*6.2*/
SELECT bf.title from best_films as bf WHERE to_tsvector('english', description) @@ to_tsquery('english','serious<1>warnings<4>media');

/*
Questão 7
Sim, a função phraseto_tsquery procura exatamente a frase passada como parâmetro
*/
SELECT bf.title from best_films as bf WHERE to_tsvector('english', description) @@ phraseto_tsquery('english', 'serious warnings during');
SELECT bf.title from best_films as bf WHERE to_tsvector('english', description) @@ phraseto_tsquery('english','serious warnings media');

/*
Questão 8
*/
/*8.1*/
ALTER TABLE best_films 
ADD COLUMN description_ts tsvector 
GENERATED ALWAYS AS (to_tsvector('english', description)) STORED;

/*8.2*/
CREATE INDEX best_films_search_idx 
ON best_films 
USING GIN (description_ts);


/*8.3*/
SELECT bf.title from best_films as bf WHERE description_ts @@ phraseto_tsquery('english','serious warnings during');

/*
Questão 9
*/

SELECT title, ts_rank(description_ts, to_tsquery('english', 'family & drama')) AS rank_value 
FROM best_films 
WHERE description_ts @@ to_tsquery('english', 'family & drama')
ORDER BY rank_value DESC;



