select*
from PortfolioProject..coviddeaths$
order by 3,4

select*
from PortfolioProject..covidvaccinations$
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..coviddeaths$
order by 1,2

select location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..coviddeaths$
order by 1,2

looking at likelyhood of death when contracting covid 19

select location, date, total_cases,total_deaths, (cast(total_deaths as int)/cast(total_cases as float))*100 as DeathPercentage
from PortfolioProject..coviddeaths$
order by 1,2

looking at likelyhood of death when contracting covid 19 in united states

select location, date, total_cases,total_deaths, (cast(total_deaths as int)/cast(total_cases as float))*100 as DeathPercentage
from PortfolioProject..coviddeaths$
where location like '%states%'
order by 1,2

shows what percentnof population got covid19

select location, date, population, total_cases, (total_cases/population)*100 as populationinfectionpercentage
from PortfolioProject..coviddeaths$
where location like '%states%'
order by 1,2

looking at countries with high infection rate

select location, population,max(total_cases) as highestinfectioncount, max((total_cases/population))*100 as populationinfectionpercentage
from PortfolioProject..coviddeaths$
--where location like '%states%'
group by location, population
order by populationinfectionpercentage desc

showing countries with highest death count per population

select location, max(cast(total_deaths as int)) as totaldeathcount
from PortfolioProject..coviddeaths$
--where location like '%states%'
where continent is not null
group by location, population
order by totaldeathcount desc

 breaking down by continetnt

select continent, max(cast(total_deaths as int)) as totaldeathcount
from PortfolioProject..coviddeaths$
--where location like '%states%'
where continent is not null
group by continent
order by totaldeathcount desc

showing continents with highest deathcount

select location, max(cast(total_deaths as int)) as totaldeathcount
from PortfolioProject..coviddeaths$
--where location like '%states%'
where continent is null
group by location
order by totaldeathcount desc

looking at total population vs vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location
, dea.date)
from PortfolioProject..coviddeaths$ dea
join PortfolioProject..covidvaccinations$ vac
   on dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null
order by 2,3
