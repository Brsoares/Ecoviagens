SELECT DISTINCT tipo_acomodacao FROM `ecoviagens-486519.projeto.hospedagens` LIMIT 10;

-- Faturamento mensal

SELECT 
      EXTRACT(YEAR FROM r.data_reserva) AS ano,
      FORMAT_DATE("%B", DATE(r.data_reserva)) as nome_mes,
          ROUND(SUM(o.preco * qtd_pessoas ),2) AS total_pago
FROM `ecoviagens-486519.projeto.ofertas` o
INNER JOIN `ecoviagens-486519.projeto.reservas` r 
    ON o.id_oferta = r.id_oferta 
    WHERE UPPER(r.status) = 'CONCLUÍDA'
GROUP BY 
       ano, nome_mes,  EXTRACT(MONTH FROM r.data_reserva) 
ORDER BY ano desc,  EXTRACT(MONTH FROM r.data_reserva) desc;


-- Qual o valor médio gasto por cliente em cada reserva considerando o gasto individual por pessoa?

SELECT h.tipo_acomodacao,
ROUND(SUM(o.preco * r.qtd_pessoas)/SUM(r.qtd_pessoas),2) as media_valor_pago,
FROM `ecoviagens-486519.projeto.ofertas` o
INNER JOIN `ecoviagens-486519.projeto.reservas` r 
  ON o.id_oferta = r.id_oferta 
INNER JOIN `ecoviagens-486519.projeto.hospedagens` h
    ON o.id_oferta = h.id_oferta
    WHERE UPPER(r.status) = 'CONCLUÍDA'
GROUP BY h.tipo_acomodacao;

--
SELECT 
  PERCENTILE_CONT(preco, 0.5) OVER () as mediana_preco
FROM `ecoviagens-486519.projeto.ofertas` 
LIMIT 1;

------------------ Versão otimizada 
SELECT
    m.tipo_acomodacao,
    m.mediana_por_pessoa,
    v.total_reservas,
    v.total_pessoas
FROM (

    -- Mediana por pessoa
    SELECT DISTINCT
      h.tipo_acomodacao,
      ROUND(
        PERCENTILE_CONT(
            o.preco / r.qtd_pessoas,
            0.5
        ) OVER (PARTITION BY h.tipo_acomodacao),
      2) AS mediana_por_pessoa
    FROM `ecoviagens-486519.projeto.ofertas` o
    JOIN `ecoviagens-486519.projeto.reservas` r
      ON o.id_oferta = r.id_oferta
    JOIN `ecoviagens-486519.projeto.hospedagens` h
      ON o.id_oferta = h.id_oferta
    WHERE UPPER(r.status) = 'CONCLUÍDA'

) m

JOIN (

    -- Volume de reservas
    SELECT 
        h.tipo_acomodacao,
        COUNT(*) AS total_reservas,
        SUM(r.qtd_pessoas) AS total_pessoas
    FROM `ecoviagens-486519.projeto.ofertas` o
    JOIN `ecoviagens-486519.projeto.reservas` r
      ON o.id_oferta = r.id_oferta
    JOIN `ecoviagens-486519.projeto.hospedagens` h
      ON o.id_oferta = h.id_oferta
    WHERE UPPER(r.status) = 'CONCLUÍDA'
    GROUP BY h.tipo_acomodacao

) v

ON m.tipo_acomodacao = v.tipo_acomodacao

ORDER BY total_reservas asc;

 -- SEGUNDA POSSIBILIDADE - A casa de hóspedes é nosso principal produto: concentra maior volume com preço competitivo. Chalés têm boa aceitação e margem potencial. Quartos compartilhados, mesmo com menor preço, não convertem bem. Apartamentos cumprem papel premium.


-- Quais tipos de oferta são mais populares entre os viajantes
-- Validar -> consideram popularidade = distribuição das reservas ou tipo de oferta com mais viajante ?

-- Tipo de oferta com mais viajantes:

SELECT o.tipo_oferta as tipo_oferta,
SUM(r.qtd_pessoas) as total_viajantes, 
COUNT(r.id_reserva) as total_reserva
FROM `ecoviagens-486519.projeto.ofertas` o
INNER JOIN `ecoviagens-486519.projeto.reservas` r 
  ON o.id_oferta = r.id_oferta 
  GROUP BY 1;



-- taxa de fidelização 
SELECT
  ROUND(
    COUNT(*) * 100.0 / 
    (SELECT COUNT(DISTINCT id_cliente) 
     FROM `ecoviagens-486519.projeto.reservas` 
     WHERE UPPER(status) = 'CONCLUÍDA'),
  2) AS porcentagem_fidelizacao
FROM (
   SELECT id_cliente
   FROM `ecoviagens-486519.projeto.reservas`
   WHERE UPPER(status) = 'CONCLUÍDA'
   GROUP BY id_cliente 
   HAVING COUNT(id_reserva) > 1
) clientes_fieis;


-- Avaliação média das ofertas 


SELECT o.id_oferta, o.titulo, ROUND(AVG(nota),2) as media_nota

 FROM `ecoviagens-486519.projeto.ofertas` o
  INNER JOIN `ecoviagens-486519.projeto.avaliacoes` a
    ON o.id_oferta = a.id_oferta  
    LEFT JOIN `ecoviagens-486519.projeto.reservas` f
     ON o.id_oferta = f.id_oferta and UPPER(f.status) = 'CONCLUÍDA'
          GROUP BY 1,2
    LIMIT 100
    ;

-- OU 


SELECT o.id_oferta, o.titulo, ROUND(AVG(nota),2) as media_nota,
 CASE 
   WHEN COUNT(DISTINCT f.id_reserva) = 0 THEN 'Sem reserva concluída'
   WHEN COUNT(DISTINCT f.id_reserva) > 0 AND COUNT(DISTINCT f.id_reserva) = 0 THEN 'Reserva foi concluída sem avaliação'
   ELSE 'Reserva com avaliação presente'
   END AS cor_pesquisa
 FROM `ecoviagens-486519.projeto.ofertas` o
  LEFT JOIN `ecoviagens-486519.projeto.avaliacoes` a
    ON o.id_oferta = a.id_oferta  
    LEFT JOIN `ecoviagens-486519.projeto.reservas` f
     ON o.id_oferta = f.id_oferta and UPPER(f.status) = 'CONCLUÍDA'
          GROUP BY 1,2
    LIMIT 100
    ;

-- Indice de adoção de práticas sustentáveis (qtd de ofertas com prática / total de ofertas)


SELECT 
  ROUND(COUNT(DISTINCT op.id_oferta) / (
  SELECT COUNT(DISTINCT id_oferta)
   FROM `ecoviagens-486519.projeto.ofertas` o
),2) *100  as indice_sustentavel
  FROM `ecoviagens-486519.projeto.oferta_pratica` op;


-- Quais práticas mais populares entre as reservas

SELECT 
  ps.nome, 
  COUNT(r.id_reserva) AS total_reservas

FROM `ecoviagens-486519.projeto.praticas_sustentaveis ` ps
INNER JOIN `ecoviagens-486519.projeto.oferta_pratica` op
  ON ps.id_pratica = op.id_pratica 
INNER JOIN `ecoviagens-486519.projeto.reservas` r
  ON op.id_oferta = r.id_oferta 
  AND UPPER(r.status) = 'CONCLUÍDA'

GROUP BY ps.nome
ORDER BY total_reservas DESC;


-- identificar com que frequência os clientes fiéis fazem novas reservas


WITH reservas_filtradas as ( -- Filtrar clientes fiéis (clientes que fizeram mais de uma reserva concluída)
 
 SELECT id_cliente,
    data_reserva
   FROM `ecoviagens-486519.projeto.reservas`
   WHERE UPPER(status) = 'CONCLUÍDA'and
   id_cliente IN(
    SELECT id_cliente
       FROM `ecoviagens-486519.projeto.reservas`
       WHERE UPPER(status) = 'CONCLUÍDA'
       GROUP BY id_cliente
       HAVING COUNT(id_reserva) > 1)
  
),

diffs as ( -- calcular a diferença de tempo entre as reservas
  SELECT id_cliente,
  DATE_DIFF(data_reserva,
  LAG(data_reserva) OVER (PARTITION BY id_cliente ORDER BY data_reserva),DAY
  ) AS diff_dias, data_reserva
  FROM reservas_filtradas
)

SELECT id_cliente, -- -- calcular a média dos intervalos encontrados
AVG(diff_dias) AS tempo_medio_entre_reservas
 FROM diffs
 WHERE diff_dias IS NOT NULL
 GROUP BY id_cliente
 ORDER BY tempo_medio_entre_reservas;

-- Desempenho médio dos operadoradores por categoria de oferta (avaliações, ofertas, reservas e operadores)


WITH reservas_concluidas as (
 SELECT DISTINCT id_oferta as id_oferta
       FROM `ecoviagens-486519.projeto.reservas`
       WHERE UPPER(status) = 'CONCLUÍDA'
       )

SELECT op.nome_fantasia, 
  o.tipo_oferta,
   ROUND(AVG (a.nota),2) as media_avaliacao
    FROM `ecoviagens-486519.projeto.operadores` op
      INNER JOIN `ecoviagens-486519.projeto.ofertas` o 
         ON op.id_operador = o.id_operador
      INNER JOIN `ecoviagens-486519.projeto.avaliacoes` a
         ON o.id_oferta = a.id_oferta
      INNER JOIN reservas_concluidas c
         ON a.id_oferta = c.id_oferta
GROUP BY 1,2
ORDER BY media_avaliacao desc;






