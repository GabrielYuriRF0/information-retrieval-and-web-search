/*--QUESTÃO 04
- Foram retornados 2 registros;
- CODA
- Drive My Car 
*/
SELECT title FROM best_films
WHERE description LIKE '%she%';

/*QUESTÃO 05
- Foram retornados 2 registros:
- CODA
- Drive My Car
*/
SELECT title FROM best_films
WHERE description LIKE '%She%';

/*QUESTÃO 06
- Foram retornados 3 registros:
- CODA
- Don't Look Up
- Drive My Car
 */
SELECT title FROM best_films
WHERE description ILIKE '%She%';

/*
QUESTÃO 07
- Foram retornados 3 registros:
- Belfast
- Don't Look Up
- Drive My Car

*/
SELECT title FROM best_films AS bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','directs');

/*
QUESTÃO 8
- A última consulta só retornou 1 registro, enquanto as outras duas retornaram 3
*/
SELECT title FROM best_films AS bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','direct');
SELECT title FROM best_films AS bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','directed');
SELECT title FROM best_films AS bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','director');

/*
QUESTÃO 9
Eu entendi que após executar essa função, é retornado na maioria dos casos, o radical da palavra passada como parâmetro.
*/
SELECT to_tsquery('english','director');

/*
QUESTÃO 10
Ele cria um conjunto de valores para cada uma das palavras presentes em todos os livros e atribui a elas um valor que talvez seja usado para comparar
o grau de relação das palavras entre si.
*/
SELECT to_tsvector('english', bf.description) FROM best_films as bf ;

/*
QUESTÃO 11
As 3 consultas retornaram o mesmo resultado já que todas elas não são case sensitive.
*/
SELECT title FROM best_films AS bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','drama');
SELECT title FROM best_films AS bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','Drama');
SELECT title FROM best_films AS bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','DRAMA');


/*
QUESTÃO 12
Eu entendi que o ts_tsquery é case insesitive, já que no final, ele deixa a palavra toda em miníscula.
*/
SELECT to_tsquery('english','drama');
SELECT to_tsquery('english','Drama');
SELECT to_tsquery('english','DRAMA');

/*
Questão 13
*/
--a
SELECT title FROM best_films AS bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','drama & family');
--b
SELECT title FROM best_films AS bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','drama | family');
--c
SELECT title FROM best_films AS bf WHERE to_tsvector('english', bf.description) @@ to_tsquery('english','!drama');