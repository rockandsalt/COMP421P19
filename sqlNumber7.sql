

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


