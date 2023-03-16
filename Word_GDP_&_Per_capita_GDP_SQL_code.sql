
           --  ################# world per year Average GDP & average GDP per capitafrom 1960 to 2021   ################ (For Line visualization)

select *
into only_country_GDP                                        -- into ~ create new table/data set 
from [Project 1]..world_country_gdp_usd$                          -- this data don't contain region/continent, sub-continent 
inner join [Project 1]..Country_Continent_Region_final                --- joining continent,sub-continent column
  on world_country_gdp_usd$.[Country Name] = Country_Continent_Region_final.[country_name]
  where [GDP_USD] is not null


select *
from [Project 1]..only_country_GDP


select Distinct ([YEAR]),                                  -- duplicate value handle 
avg([GDP_USD]) over (partition by [YEAR]) as sum_GDP,
avg([GDP_per_capita_USD]) over (partition by [year]) as sum_per_capita         -- partitioning by year 
--,Row_Number() over (order by serial_No) as serial_number
from [Project 1]..only_country_GDP
order by [YEAR]


--select sum([GDP_per_capita_USD])              -- check any one
--from [Project 1]..only_country_GDP
--where [YEAR] =  1965

                                         ---  then in Excel we compute final yearly GDP growth rate by GDP formula = (GDP2-GDP1)/GDP1



         --########################-- every country GDP growth rate  for 2021 from 2020 -- (joining 2021 & 2020)   ################## (Map visualization)

select *	 
from [Project 1]..only_country_GDP

select *
from [Project 1].[dbo].[year_2021]
inner join [Project 1].[dbo].[year_2020]                 -- joining separated contries GDP for the year 2020 & 2021 (to find growth rate per year in Excel)  
  on [year_2021].country_21 = [year_2020].county_20


                                      -- then in excel we compute rate by GDP growth rate formula = (GDP2-GDP1)/GDP1




                                     --- ######################## SIX continent GDP (AVG) from 2017 to 2021 - ######### Bar diagram
 
select *
from [Project 1]..only_country_GDP

select  [continet],  
        [YEAR],
        [GDP_USD],                                                          
'group_year' = case  
	when [year] between 2017 and 2021 then '5_group(17-21)'
end ,
avg(GDP_USD) over (partition by [continet]) as continent_5yr_AVG_GDP           --- partitioning by continent
,avg(GDP_per_capita_USD) over (partition by [Country Name]) as countrywise_AVG_GDP_per
into year_group_avg1_CONTINENT 
from [Project 1]..only_country_GDP
where [year] between 2017 and 2021

select distinct ([continet]),  
        [group_year],
		continent_5yr_AVG_GDP
from [Project 1]..year_group_avg1_CONTINENT

                                 