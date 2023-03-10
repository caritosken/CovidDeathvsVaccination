create database portfolio;

select * from asia;
select * from asiav;

/* data exploration year 2021 - 2022 COVID DEATHS */

select location, date, total_cases, total_deaths, new_cases, population
from asia;

/* Asian Country with most number of Mortality from covid19 */
 
select location, avg(total_deaths) as average_deaths, max(total_deaths) as total_deaths, population
from asia
group by location
order by total_deaths desc;

/* Asian Country with most Mortality% from 2021-2022 by covid19 */

select location, (max(total_deaths)/max(total_cases))*100 'death_percentage', population
from asia
group by location ,population
order by death_percentage desc;

/* minimum number of deaths for each country */

select location , max(total_deaths) 'Least_Death' from asia
group by location
order by Least_Death;

/* Mortality rate per country due to covid */

select location, (max(total_deaths)/population)*1000 as Mortality_rate
from asia
group by location
order by Mortality_rate;

/* Top 10 Asian Country with most number of deaths from covid19 */

select location, max(total_deaths) 'Total_deaths', (max(total_deaths)/max(total_cases))*100 as 'death_percentage', population
from asia
group by location
order by total_deaths desc
limit 10;

create view top_death_count as 
select location, max(total_deaths) 'Total_deaths', (max(total_deaths)/max(total_cases))*100 as 'death_percentage', population
from asia
group by location
order by total_deaths desc
limit 10;

/*  Mortality rate during covid 19 */

select location, (max(total_deaths)/population)*100 mortality_percentage
from asia
group by location
order by mortality_percentage desc;

/* Asian Country's daily Moratality movement*/

select location, date, new_deaths, sum(new_deaths) over(partition by location order by location, date) 'Mortality_movement'
from asia
order by location;

create view death_movement as 
select location, date, new_deaths, sum(new_deaths) over(partition by location order by location, date) 'Mortality_movement'
from asia
order by location;

/* How each country perform Vaccination/booster that impacts Mortality */

select *
from asia a 
join asiav av on a.date = av.date
and a.location = av.location;

select a.location, max(av.people_fully_vaccinated) 'Total_fully_vaccinated',
max(av.total_boosters) ' Total_Boosted', max(a.total_deaths) 'Total_death'
from asia a 
join asiav av on a.date = av.date
and a.location = av.location
group by location
order by Total_deaths desc;

/* Vaccination rollout per country*/

select a.location, a.date, a.population, av.new_vaccinations,
sum(av.new_vaccinations) over(partition by a.location order by a.location, a.date) 'Vaccination Rollout movement'
from asia a
join asiav av on a.date = av.date
and a.location = av.location
order by location, date;

select a.location, a.date, a.population, av.new_vaccinations,
sum(av.new_vaccinations) over(partition by a.location order by a.location, a.date) 'Vaccination Rollout movement'
from asia a
join asiav av on a.date = av.date
and a.location = av.location
order by location, date;

create view vax_rollout_country as
select a.location, a.date, a.population, av.new_vaccinations,
sum(av.new_vaccinations) over(partition by a.location order by a.location, a.date) 'Vaccination Rollout movement'
from asia a
join asiav av on a.date = av.date
and a.location = av.location
order by location, date;




