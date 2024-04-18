-- Use the Project DataBAse...
use Proect02_Shark_Tank_Season_01;

-- See the DataBase..
select * from dataset_01 ; 

-- Numbers of ROws..98
select count(*) from dataset_01 ; 

-- Total Numbers of Episode   -- 30..
select max(ep_No) from dataset_01 ; 

--TOtal Numbers of  Pitches That are Given..
select count (distinct brand ) from dataset_01 ; 

--Numbers of StartUp That Get Money
-- Total 98 pitches were given but 40 people not get money...
--that means out of 98 pitches 98-40 = 58 Pitches were get investment..
select count(*) as Total_Numbers_of_Pithces , 
( count(*) - sum(Getting_Money_or_not) ) as Numbers_of_people_getting_Money , 
sum(Getting_Money_or_not) as Numbers_of_people_who_are_not_given_money 
from (select * , 
case when deal = 'No Deal' then 1  
else 0 
end as Getting_Money_or_not
from Dataset_01 ) A ;  

-- Success Percantage of People Who are Getting INvestments..
select Total_Numbers_of_Pithces , Numbers_of_people_getting_Money , Numbers_of_people_who_are_not_given_money , 
( Numbers_of_people_getting_Money/Total_Numbers_of_Pithces)* 100 as Success_Percantage , 
(( Numbers_of_people_who_are_not_given_money/Total_Numbers_of_Pithces)* 100 )as Failure_percantage
from (
select cast(count(*)as float) as Total_Numbers_of_Pithces , 
cast(( count(*) - sum(Getting_Money_or_not) ) as float) as Numbers_of_people_getting_Money , 
cast(sum(Getting_Money_or_not) as float) as Numbers_of_people_who_are_not_given_money 
from (select * , 
case when deal = 'No Deal' then 1  
else 0 
end as Getting_Money_or_not
from Dataset_01 ) A ) B ;

-- Total Male  Participated in Shark Tank
select sum(male) as Total_Numbers_Of_Male from Dataset_01  ; 


-- Total FeMale  Participated in Shark Tank
select sum(Female) as Total_Numbers_Of_Male from Dataset_01  ; 

-- Gender Ratio
select (sum(Female) / sum(male)) * 100 as Gender_Ratio from Dataset_01 ;

--Total Investment Amount
select sum(Amount_Invested) as Total_Amount_INvested_In_Lakhs  from Dataset_01 ; 

-- Average Equity Taken..
select avg(Equity_Asked) as Avg_Equity_Taken 
from (select * from Dataset_01 where deal != 'No Deal') A

--Highest Amount That Was Invested
select max(amount_invested) as Highest_Amount_Invested from Dataset_01 ; 

--Details Of company That Taken Highest Amounts...
select *
from Dataset_01 
order by Amount_Invested desc
offset  0 rows fetch next 1 rows only ; 

--Sharks Details That are invested in these compnay
select Brand , Location , Deal , Equity_Taken , Partners
from Dataset_01 
order by Amount_Invested desc
offset  0 rows fetch next 1 rows only ; 

--Top 10 Company That Taken Highest Inestment..
select Ep_No , brand , Location, Idea , Sector , Deal, Partners
from (select * , DENSE_RANK() over(order by amount_invested desc) as Rnks
from Dataset_01) A
where Rnks < 11 ;

-- Highest Equity Taken of Any Company
select *
from  Dataset_01
where Equity_Taken = (select max(Equity_Taken) as Highest_Taken from Dataset_01) ; 

-- One More Method
select *
from Dataset_01
order by Equity_Taken desc
offset 0 rows  fetch next 1 rows only ; 

-- All Pitches That Have Atleast 1 Womens
select count(female) as Numbers_of_Pitches_In_Which_Women_Available from Dataset_01 where female > 0; 

-- All Pitches That Have Atleast 1 Mens
select count(Male) as Numbers_of_Pitches_In_Which_Men_Available from Dataset_01 where Male > 0;

--Pitches That Take Money And In Which Atleast 1 Womens Present
select count(*) as Numbers_of_Pitches_In_Which_Women_Available 
from Dataset_01 where deal != 'No Deal' and female > 0;

--  Average Team Members of All Episode..
select avg(Team_members) as Average_Team_Members
from Dataset_01 ; 

--  Average Team Members of Episode That Will Take Moeny..
select avg(Team_members) as Average_Team_Members
from Dataset_01
where deal != 'No Deal'; 


-- Average Amount Invested Per Deal...
select avg(Amount_Invested) as Avg_Amount_Invested from Dataset_01 where deal != 'No Deal'; 


--Numbers of Founder BAsed on their Age
select Avg_age , count(Avg_age) as Numbers_Of_Founders
from Dataset_01
group by Avg_age
order by Numbers_Of_Founders desc; 

--Numbers of StartUp BAsed on thier Locations
select Location , count(Location) as Numbers_of_StartUp_From_Location
from Dataset_01
group by Location
order by Numbers_of_StartUp_From_Location desc ; 


--Numbers of Money Taken BAsed on thier Locations
select Location , count(Location) as Numbers_of_StartUp_From_Location , 
sum(Amount_Invested) as Money_Taken ,
avg(Amount_Invested) as Average_investments
from Dataset_01
where Deal != 'No Deal'
group by Location
order by Money_Taken desc ; 

--Sector Wise StartUps
select Sector , COUNT(Sector) as Numbers_of_Company
from Dataset_01 
group by Sector
order by Numbers_of_Company desc ; 

--Sector Wise StartUps Who got Investments
select Sector , COUNT(Sector) as Numbers_of_Company
from Dataset_01 
where Deal != 'No Deal'
group by Sector
order by Numbers_of_Company desc ; 


--Sector Wise StartUps Total Investments
select Sector , COUNT(Sector) as Numbers_of_Company , 
sum(Amount_Invested) as Total_Investment
from Dataset_01 
where Deal != 'No Deal'
group by Sector
order by Total_Investment desc ; 

-- Top 5 Companies
select *
from (select * , DENSE_RANK() over(order by Total_Investment desc) as Dense_Rnks
from (select Sector , COUNT(Sector) as Numbers_of_Company , 
sum(Amount_Invested) as Total_Investment 
from Dataset_01 
where Deal != 'No Deal'
group by Sector) A  ) B 
where Dense_Rnks < 6 ;


--Collaboaration of Sharks
select deal , Partners
from Dataset_01 
where deal != 'No Deal'; 


-- Each Shark Total Investments..
select isnull(sum(Ashneer_Amount_Invested), 0) as  Total_Ashneer_Amount_Invested ,
isnull(sum(Aman_Amount_Invested),0) as Total_Aman_Amount_Invested , 
isnull(sum(Namita_Amount_Invested),0) as Total_Namita_Amount_Invested , 
isnull(sum(Anupam_Amount_Invested),0) as Total_Anupan_Amount_Invested , 
isnull(sum(Vineeta_Amount_Invested),0) as Total_Vineeta_Amount_Invested 
from Dataset_01 ; 


select * from Dataset_01 ; 