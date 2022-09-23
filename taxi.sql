select * from nyctaxi


select month_wise,count(*)Trip_count,round(avg(trip_distance),2)Average_distance,
round(avg(passenger_count),2)Average_passenger from (
    select 
    to_char(to_date(lpep_dropoff_datetime,'MM/DD/YYYY HH:SS:MI AM'),'MM') month_wise
    ,trip_distance,passenger_count 
    from nyctaxi
)r
group by month_wise
order by month_wise



b.	Find out the five busiest routes served by the green taxis during 2019. 
The name of start and drop points to be provided.

select lpep_pickup_datetime,lpep_dropoff_datetime ,max(pulocationid) 
over(partition by pulocationid) as busy_location
from nyctaxi
where rownum<=5
order by busy_location desc;
















select * from nyctaxi
select * from lookup

select avg(trip_distance)td avg(passenger_count)pc from nyctaxi
    (select vendorid, lpep_pickup_datetime,trip_distance,passenger_count,
    to_char(to_date(lpep_pickup_datetime,'MM/dd/yyyy HH:MI:SS AM'),'MM')as monthly
    from nyctaxi 
    )
group by td,pc



--a.	Find the month wise trip count, average distance and average passenger 
--count from the trips completed by green taxis in 2019. 
select month1,count(month1)Tcount,round(avg(trip_distance),2)Average_distance,
round(avg(passenger_count),4)Average_passenger from (
    select 
    to_char(to_date(lpep_dropoff_datetime,'MM/DD/YYYY HH:SS:MI AM'),'MM') month1
    ,trip_distance,passenger_count 
    from nyctaxi
)a
group by month1
order by month1





--b.	Find out the five busiest routes served by the green taxis during 2019. The name of start and drop points to be provided.
select * from
(
   with A as
    (
      select
        (L1.Zone || ',' || L1.Borough)PickPoint,(L2.Zone || ',' || L2.Borough)DropPoint          
        from nyctaxi t
        inner join lookup L1 on L1.LocationID = t.PULocationID
        inner join lookup L2 on L2.LocationID=t.DOLocationID
     )
     select PickPoint,DropPoint,count(*)frequency from A
   group by PickPoint,DropPoint
   order by frequency desc
)
where rownum<=5;



--c.	What are the top 3 busiest hours of the day for the taxis?

select * from(
select buzy,count(buzy) busiest_route from(
select to_char(to_date(lpep_pickup_datetime,'MM/DD/YYYY HH:SS:MI AM'),'HH')buzy
from nyctaxi
)
group by buzy
order by busiest_route desc
)
where rownum<=3;




d.	What is the most preferred way of payment used by the passengers?


select * from(

)
where rownum<=3;

 

d.	What is the most preferred way of payment used by the passengers?


select * from(
select payment_type,count(payment_type)fre,rank()over(order by count(payment_type)desc)rn,
case
 when payment_type=1 then 'Credit Card'
 when payment_type=2 then 'Cash'
 when payment_type=3 then 'No Charge'
 when payment_type=4 then 'Dispute'
 when payment_type=5 then 'Unknown'
 when payment_type=1 then 'Voided Trip'
 else 'N/A'
 end as payment_method
from nyctaxi
group by payment_type
)where rn=1;






e.	Write a PL/SQL block to read through each record and update ehail_fee to 0.5 (capture the time taken for execution)



begin
update nyctaxi set ehail_fee = 0.5;
end;
/



--f.	Write a normal update statement to update ehail_fee to 0.75 (capture the time taken for execution)
It takes 156.464 sec

update nyctaxi set ehail_fee='0.75';






--g.	Identify the time taken by e and f and provide your analysis on why each step took more/less time compared to other

When we compare time taken to execute PLSQL and SQL for updating the record
SQL is much faster than PLSQL

This happens only because SQL to PLSQL engine switching takes time. 


ALTER DATABASE DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\UNDOTBS1.DBF' AUTOEXTEND ON MAXSIZE 10g;


set serveroutput on

create or replace PROCEDURE Bubble_sort
IS
    V1 NUMBER;
    i NUMBER;
    swapped BOOLEAN;
    tmp VARCHAR2(10);
    F1 UTL_FILE.FILE_TYPE;

    TYPE numvarr IS VARRAY (100) OF NUMBER;
    numvarr_obj numvarr  :=  numvarr();

BEGIN
    F1 := UTL_FILE.FOPEN('USER_DIR','Number.csv','R');
    i := 0;
    dbms_output.put_line('Numbers Before Sorting:');
    LOOP
    BEGIN
        UTL_FILE.GET_LINE(F1,V1);
        i := i+1;
        numvarr_obj.EXTEND;
        numvarr_obj(i) := V1;
        dbms_output.put_line(numvarr_obj(i));
        EXCEPTION WHEN No_Data_Found THEN EXIT; 
    END;
    END LOOP;
    UTL_FILE.FCLOSE(F1);
    LOOP
        swapped := false;
        FOR j IN 2..numvarr_obj.count
            LOOP
                IF numvarr_obj(j-1) > numvarr_obj(j)
                THEN
                    tmp := numvarr_obj(j);
                    numvarr_obj(j) := numvarr_obj(j-1);
                    numvarr_obj(j-1) := tmp;
                    swapped := true;
                END IF;
            END LOOP;
        EXIT WHEN NOT swapped;
    END LOOP;
    dbms_output.put_line('Numbers After Sorting:');
    FOR j in 1..numvarr_obj.count
    LOOP
        dbms_output.put_line(numvarr_obj(j));
    END LOOP;
END Bubble_sort;
/
EXECUTE Bubble_sort;
OUTPUT






