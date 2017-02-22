

CREATE VIEW Income
AS
WITH NumPlan as (
    SELECT COUNT(*) as NUM , pname
        FROM Memberships 
        GROUP BY pname) 
SELECT * 
    FROM NumPlan NATURAL JOIN Plans;


SELECT pname, payment_frequency * cost AS YearlyIncome
    FROM Income;


CREATE VIEW ClassPopulation 
AS
WITH ClassPop as (SELECT COUNT(*) as NUM, classID as CId
    FROM ClassEnroll
    GROUP BY CId
)
SELECT  CId, NUM,Cname, CMaxEnroll 
    FROM ClassPop NATURAL JOIN Classes;

SELECT * 
    FROM ClassPopulation
    WHERE (CAST(NUM AS FLOAT)/CMaxEnroll*100.0) = (SELECT MAX(CAST(NUM AS FLOAT)/CMaxEnroll*100.0) FROM ClassPopulation);


