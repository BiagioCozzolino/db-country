-- 1. Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq
select * from countries c 
where name like 'P%' 
and area > 1000;

-- 2. Selezionare le nazioni il cui national day è avvenuto più di 100 anni fa

select * from countries c where timestampdiff (year, national_day  , curdate()) >= 100;

-- 3. Selezionare il nome delle regioni del continente europeo, in ordine alfabetico
select  * from regions r
inner join continents c 
on r.continent_id = c.continent_id 
where c.name = 'Europe'
order by r.name ;

-- 4. Contare quante lingue sono parlate in Italia
SELECT COUNT(l.language_id) as num_lingue
FROM `languages` l
INNER JOIN `country_languages` c_l
ON l.language_id = c_l.language_id 
INNER JOIN `countries` c
ON c.country_id = c_l.country_id 
WHERE c.name = 'Italy';

-- 5. Selezionare quali nazioni non hanno un national day
select * from countries c 
where national_day is null ;

-- 6 Per ogni nazione selezionare il nome, la regione e il continente
select c.name as nome_nazione, r.name as nome_regione ,c2.name as nome_continente  from countries c 
inner join regions r 
on c.region_id = r.region_id 
inner join continents c2 
on r.continent_id = c2.continent_id ;

-- 7  Modificare la nazione Italy, inserendo come national day il 2 giugno 1946
update countries c set national_day = '1946-06-02' where c.name = "Italy"

-- 8. Per ogni regione mostrare il valore dell'area totale
select r.name , sum(c.area) as somma_area from countries c 
inner join regions r 
on c.region_id = r.region_id 
group by r.name 
order by somma_area;

-- 9. Selezionare le lingue ufficiali dell'Albania
select c.name,l.`language`  from countries c 
inner join country_languages cl 
on c.country_id = cl.country_id
inner join languages l 
on cl.country_id = l.language_id 
where c.name = "Albania" and cl.official is true ;

-- 10 Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010
select avg(cs.gdp) as media_GDP  from countries c 
inner join country_stats cs 
on c.country_id = cs.country_id 
where c.name = "United Kingdom" and cs.`year` >= 2000 and cs.`year` <= 2010; 

-- 11. Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa
select c.name,l.`language`  from countries c 
inner join country_languages cl 
on c.country_id = cl.country_id
inner join languages l 
on cl.language_id  = l.language_id 
where l.`language` like "Hindi"

-- 12. Per ogni continente, selezionare il numero di nazioni con area superiore ai 10.000 kmq ordinando i risultati a partire dal continente che ne ha di più
select c2.name ,count(c.country_id) as Numero_nazioni_con_area_maggiore_di_10000 from countries c 
inner join regions r 
on c.region_id = r.region_id 
inner join continents c2 
on c2.continent_id = r.continent_id 
where c.area > 10000
group by c2.name 
order by Numero_nazioni_con_area_maggiore_di_10000 desc 

