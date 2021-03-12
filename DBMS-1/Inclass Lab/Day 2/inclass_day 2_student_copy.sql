-----------------------------------------------------
# Datasets Used: cricket_1.csv, cricket_2.csv
-- cricket_1 is the table for cricket test match 1.
-- cricket_2 is the table for cricket test match 2.

# Q1. Find all the players who were present in the test match 1 as well as in the test match 2.
select  player_name
from cricket_1
union
select player_name
from cricket_2;
 
# Q2. Write a query to extract the player details player_id, runs and player_name from the table “cricket_1” who
#  scored runs more than 50

select player_id,runs,player_name
from cricket_1
where runs>50;

# Q3. Write a query to extract all the columns from cricket_1 where player_name starts with ‘y’ and ends with ‘v’.

select player_name
from cricket_1
where player_name like 'y%v';

# Q4. Write a query to extract all the columns from cricket_1 where player_name does not end with ‘t’.

select player_name
from cricket_1
where player_name not like '%t';
 
-- --------------------------------------------------------
# Dataset Used: cric_combined.csv 
-- --------------------------------------------------------
select *
from cric_combined;
# Q5. Write a MySQL query to add a column PC_Ratio to the table that contains the divsion ratio 
# of popularity to charisma .(Hint :- Popularity divide by Charisma)

alter table cric_combined add column pc_ratio decimal(8,2);
update cric_combined
set pc_ratio=round((popularity/charisma),2);

# Q6. Write a MySQL query to find the top 5 players having the highest popularity to charisma ratio.

select pc_ratio
from cric_combined
order by pc_ratio desc limit 5;

# Q7. Write a MySQL query to find the player_ID and the name of the player that contains the character “D” in it.

select player_id,player_name
from cric_combined
where player_name like '%d%';

# Q8. Extract Player_Id  and PC_Ratio where the PC_Ratio is between 0.12 and 0.25.
select player_id,pc_ratio
from cric_combined
where pc_ratio between 0.12 and 0.25;

-- --------------------------------------------------------
# Dataset Used: new_cricket.csv
-- --------------------------------------------------------

select *
from new_cricket;

# Q9. Extract the Player_Id and Player_name of the players where the charisma value is null.
select player_id,player_name
from new_cricket
where Charisma is null;
 
# Q10. Write a MySQL query to display all the NULL values  in the column Charisma imputed with 0.
 
 select ifnull(charisma,0)
 from new_cricket;
 
# Q11. Separate all Player_Id into single numeric ids (example PL1 to be converted as 1, PL2 as 2 , ... PL12 as 12 ).
 
 select substr(player_id,3)
 from new_cricket;
 
 
# Q12. Write a MySQL query to extract Player_Id , Player_Name and charisma where the charisma is greater than 25.

select player_id,player_name,charisma
from new_cricket
where charisma>25;

-- --------------------------------------------------------
# Dataset Used: churn1.csv 
-- --------------------------------------------------------

# Q13. Write a query to display the rounding of lowest integer value of monthlyservicecharges and rounding of higher integer value of totalamount 
# for those paymentmethod is through Electronic check mode.

select floor(monthlyservicecharges),ceil(totalamount)
from churn_details
where PaymentMethod='electronic check';

# Q14. Rename the table churn1 to “Churn_Details”.

alter table churn1 rename Churn_Details;

# Q15. Write a query to create a display a column new_Amount that contains the sum of TotalAmount and MonthlyServiceCharges.

alter table churn_details add column new_amount double;
update churn_details
set new_amount= Totalamount+monthlyservicecharges;

# Q16. Rename column new_Amount to Amount.
alter table churn_details rename column new_amount to Amount;

# Q17. Drop the column “Amount” from the table “Churn_Details”.

alter table churn_details drop amount; 

# Q18. Write a query to extract the customerID, InternetConnection and gender 
# from the table “Churn_Details ” where the value of the column “InternetConnection” has ‘i’ 
# at the second position.

select customerID,Internetconnection,gender
from churn_details
where InternetConnection like '_i%';

# Q19. Find the records where the tenure is 6x, where x is any number.

select *
from churn_details
where tenure like '6%';

# Q20. Write a query to display the player names in capital letter and arrange in alphabatical order along with the charisma, display 0 for whom the charisma value is NULL.
select upper(player_name),ifnull(charisma,0)
from new_cricket
order by player_name asc;