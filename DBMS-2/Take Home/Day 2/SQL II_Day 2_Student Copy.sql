CREATE SCHEMA IF NOT EXISTS Video_Games;
USE Video_Games;
SELECT * FROM Video_Games_Sales;

# 1. Display the names of the Games, platform and total sales in North America for respective platforms.

select name,platform,sum(NA_Sales) over(partition by platform)
as NA_Sum from Video_Games_Sales;

# 2. Display the name of the game, platform , Genre and total sales in North America for corresponding Genre as Genre_Sales,total sales for the given platform as Platformm_Sales and also display the global sales as total sales .
# Also arrange the results in descending order according to the Total Sales.

select name,platform,genre,global_sales as total_sales,sum(NA_Sales) over(partition by genre) Genre_Sales,sum(global_sales) over(partition by platform)
Platform_Sales from Video_Games_Sales order by total_sales desc;

# 3. Use nonaggregate window functions to produce the row number for each row 
# within its partition (Platform) ordered by release year.

select *,row_number() over(partition by platform order by Year_of_Release)
row_no from Video_Games_Sales;

# 4. Use aggregate window functions to produce the average global sales of each row within its partition (Year of release). Also arrange the result in the descending order by year of release.
   
select name,Year_of_Release,round(avg(Global_Sales) over(partition by Year_of_Release),2)
average_sales from Video_Games_Sales order by Year_of_Release desc;

# 5. Display the name of the top 5 Games with highest Critic Score For Each Publisher. 

with top as
(
select name,publisher,critic_score,
row_number() over(partition by publisher order by critic_score desc) as rankk
from Video_Games_Sales)
select * from top where rankk<=5;

------------------------------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
------------------------------------------------------------------------------------
# 6. Write a query that displays the opening date two rows forward i.e. the 1st row should display the 3rd website launch date

select *,lead(launch_date,2) over(order by launch_date)
lead_launch_date from web;

# 7. Write a query that displays the statistics for website_id = 1 i.e. for each row, show the day, the income and the income on the first day.

select day,income,first_value(income) over() first_day_income
from website_stats
where website_id=1;

-----------------------------------------------------------------
# Dataset Used: play_store.csv 
-----------------------------------------------------------------
# 8. For each game, show its name, genre and date of release. In the next three columns, show RANK(), DENSE_RANK() and ROW_NUMBER() sorted by the date of release.

select name,genre,released,rank() over(order by released) r_rank,
dense_rank() over(order by released) d_rank,
row_number() over(order by released) row_no 
from play_store;
