create database metro_db;
use metro_db;
-- Task 1--
create table Metro_Stations 
( Station_ID  INT  primary key  AUTO_INCREMENT ,
 Station_Name Varchar(30) Unique Not null ,
Zone varchar(20) not null );

alter table Metro_Stations modify column Station_Name Varchar(100);
desc Metro_Stations;

create table Passengers ( 
Passenger_ID int primary key auto_increment ,
Passenger_Name varchar(50) Not Null ,
Phone varchar(13) unique ,
Age int check(Age >=5),
Gender Varchar(10) );

desc Passengers ;

 create Table Tickets (
 Ticket_ID int primary key auto_increment ,
 Passenger_ID int ,
 Source_Station int ,
 Destination_Station int,
 Fare int check(fare>0),
 Travel_Date Date ,
 foreign key(Passenger_ID) references  Passengers(Passenger_ID),
 foreign key (Source_Station) references  Metro_Stations(Station_ID),
 foreign Key (Destination_Station) references  Metro_Stations(Station_ID));
 
 desc Tickets;
 
 Alter table  Tickets add column Ticket_Type varchar(20) not null;  #check(Ticket_Type in ('Single',"Return","Monthly");
 ALTER TABLE Tickets
ADD CONSTRAINT Ticket_Type CHECK (ticket_type IN ('Single','Return','Monthly'));
-- 1. Insert at least 6 stations with different zones
-- 2. Insert 8 passengers with different ages
-- 3. Insert 10 ticket records covering:
	-- o Different routes
	-- o Different ticket types
	-- o Different fares

-- Task2--
insert into Metro_Stations (Station_ID, Station_Name , Zone) values
 (101 ,'Sitaburdi Interchange' ,'Central Zone'),
 (102 ,'Jhasi Rani Metro Station' ,'Central Zone'),
 ( 103,'Institue of Engineering Metro Station' ,'West Zone'),
 ( 104,'Shankar Nagar Metro Station' ,'West Zone'),
 (105,'LAD Square Metro Station' ,'South-West Zone'),
 (106,'Dharampeth College Metro Station' ,'South-West Zone'),
 (107,'Subhash Nagar Metro Station' ,'South-West Zone');
 
 insert into  Passengers (Passenger_ID,Passenger_Name, Phone,Age,Gender) values
 (1, 'John Doe',        '555-0101', 34, 'M'),
 (2, 'Jane Smith',      '555-0102', 28, 'F'),
 (3, 'Ali Khan',        '555-0103', 42, 'M'),
 (4, 'Maria Garcia',    '555-0104', 31, 'F'),
 (5, 'Li Wei',          '555-0105', 26, 'M'),
 (6, 'Sofia Rossi',     '555-0106', 37, 'F'),
 (7, 'James Brown',     '555-0107', 45, 'M'),
 (8, 'Aisha Ahmed',     '555-0108', 29, 'F'),
 (9, 'Carlos Mendes',   '555-0109', 52, 'M'),
 (10,'Emma Johnson',    '555-0110', 22, 'F');



INSERT INTO Tickets (Passenger_ID, Source_Station, Destination_Station, Fare, Travel_Date, ticket_type) VALUES
(1, 101, 102, 20, '2026-05-01', 'Single'),    
(2, 101, 103, 60, '2026-05-02', 'Return'),    
(3, 101, 104, 35, '2026-05-03', 'Monthly'),   
(4, 101, 105, 50, '2026-05-04', 'Single'),    
(5, 101, 106, 120, '2026-05-05', 'Return'),    
(6, 102, 103, 15, '2026-05-06', 'Monthly'),   
(7, 102, 104, 30, '2026-05-07', 'Single'),    
(8, 102, 105, 80, '2026-05-08', 'Return'),    
(9, 102, 106, 45, '2026-05-09', 'Monthly'),   
(10,103,104,20, '2026-05-10', 'Single'),      
(1,  103,105,60, '2026-05-11', 'Return'),     
(2,  103,106,35, '2026-05-12', 'Monthly'),    
(3,  103,107,50, '2026-05-13', 'Single'),     
(4,  104,105,40, '2026-05-14', 'Return'),     
(5,  104,106,25, '2026-05-15', 'Monthly'),    
(6,  104,107,40, '2026-05-16', 'Single'),     
(7,  105,106,40, '2026-05-17', 'Return'),     
(8,  105,107,25, '2026-05-18', 'Monthly'),    
(9,  106,107,20, '2026-05-19', 'Single'),     
(10,101,107,120, '2026-05-20', 'Return');      

truncate Table Tickets;
-- Task 3 --
select * from Metro_Stations;
select * from Passengers;
select * from Tickets;
select Passenger_Name , Fare from Tickets T join Passengers P on T.Passenger_ID = P.Passenger_ID;
select * from Tickets where Travel_Date = "2026-05-24";

-- Task 4 --
select Passenger_Name from Passengers where Age >50;
select * from Tickets where Fare>50;
select Ticket_Type from Tickets order by Travel_Date;

-- Task 5 --
select * from Tickets order by Fare desc;
select * from Tickets order by Fare desc limit 3;
select * from Passengers order by Age;
 
-- Task 6 --
select sum(Fare) as Revenue_Collected from Tickets;
select avg(Fare) As Average_Fare from Tickets;
select max(Fare) As Max_Fare , min(Fare) as Min_Fare from Tickets;
select Ticket_Type ,count(*) as Ticket_Count from Tickets group by Ticket_Type;
select MS.Zone,count(*) as Passenger_Count from Passengers P Join Metro_Stations MS group by MS.Zone;

-- Task 7 --
select P.Passenger_Name , T.Source_Station , T.Destination_Station , T.Fare 
from Passengers P join Tickets T on
P.Passenger_ID = T.Passenger_ID ;

select P.Phone ,T.Ticket_ID, T.Passenger_ID , T.Source_Station , T.Destination_Station , T.Fare ,T.Travel_Date, T.Ticket_Type
from Passengers P join Tickets T on
P.Passenger_ID = T.Passenger_ID ;


 
 SELECT T.*,
       S.Station_Name AS Source_Station,
       D.Station_Name AS Destination_Station
FROM Tickets T
JOIN Metro_Stations S ON t.Source_Station = s.Station_ID
JOIN Metro_Stations D ON t.Destination_Station = d.Station_ID;

-- Task 8 --
update Tickets T set T.Fare =  (T.Fare+10) where (T.Fare<30);

update Tickets set Ticket_Type ='Return' where Passenger_ID = 6;
select * from Tickets;
Delete from   Tickets where Travel_Date="2026-05-07";

-- Task 9 --
select P.Passenger_Name, P.Passenger_ID, T.Fare from Passengers P join Tickets T on
P.Passenger_ID = T.Passenger_ID where T.Fare > (select avg(Fare) from Tickets);

SELECT s.Source_Station
FROM (
  SELECT Source_Station, COUNT(*) AS Ticket_Count
  FROM Tickets
  GROUP BY Source_Station
) s
JOIN (
  SELECT MAX(Ticket_Count) AS MaxCount
  FROM (
    SELECT Source_Station, COUNT(*) AS Ticket_Count
    FROM Tickets
    GROUP BY Source_Station
  ) x
) m ON s.Ticket_Count = m.MaxCount;

select Passenger_ID from 
(select Passenger_ID,count(Passenger_ID) Ticket_Count from Tickets group by Passenger_ID) s
where Ticket_Count>1 ;

-- Task 10 --
create view Revv as select T.Travel_Date , Sum(T.Fare) from Tickets T join Passengers P on T.Passenger_ID = P.Passenger_ID group by T.Travel_Date;
select * from Revv;
-- Task 11 --
Update Tickets T join Passengers P on T.Passenger_ID=P.Passenger_ID set T.Fare = T.Fare - (T.Fare*0.2)  where P.Age>60;
