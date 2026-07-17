
SELECT * 
FROM dbo.data

ALTER TABLE dbo.data
DROP COLUMN column15,
            column16,
            column17,
            column18,
            column19,
            column20,
            column21,
            column22,
            column23,
            column24,
            column25
SELECT * 
FROM dbo.data

---Query 1: Top 5 delivered orders by value (SELECT, WHERE, ORDER BY)

SELECT TOP 5
    OrderID,
    Product,
    Quantity,
    UnitPrice,
    TotalPrice,
    OrderStatus
FROM data
WHERE OrderStatus = 'Delivered'
ORDER BY TotalPrice DESC


----Revenue by product category (GROUP BY, SUM, AVG, COUNT)

SELECT PRODUCT, COUNT(*) AS NUMORDERS, SUM(TOTALPRICE) AS TOTALREVENUE,
       AVG(TOTALPRICE) AS AVGORDERVALUE
FROM data
GROUP BY PRODUCT
ORDER BY TOTALREVENUE DESC


----Average order value by payment method, excluding cancellations (WHERE + GROUP BY + AVG)

SELECT PAYMENTMETHOD, COUNT(*) AS NUMORDERS,
       ROUND(AVG(TOTALPRICE),2) AS AVGORDERVALUE
FROM data
WHERE ORDERSTATUS! = 'CANCELLED'
GROUP BY PAYMENTMETHOD
ORDER BY AVGORDERVALUE DESC


-----Order status distribution (GROUP BY, COUNT, computed percentage)

SELECT ORDERSTATUS, COUNT(*) AS NUMORDERS,
       ROUND (100.0 * COUNT(*) / (SELECT COUNT(*) FROM data), 2) AS PCTOFORDERS
FROM data
GROUP BY ORDERSTATUS
ORDER BY NUMORDERS DESC


------High-value orders by referral source (WHERE + GROUP BY + SUM)

SELECT REFERRALSOURCE, COUNT(*) AS NUMORDERS, SUM(TOTALPRICE) AS TOTALREVENUE
FROM data
WHERE TOTALPRICE > 1000
GROUP BY REFERRALSOURCE
ORDER BY TOTALREVENUE DESC

------Yearly order volume and revenue (GROUP BY on derived date part)

SELECT
    YEAR([Date]) AS OrderYear,
    COUNT(*) AS NumOrders,
    SUM(TotalPrice) AS TotalRevenue
FROM Data
GROUP BY YEAR([Date])
ORDER BY YEAR([Date])


------Price range by product (MIN, MAX, AVG)

SELECT PRODUCT, MIN(UNITPRICE) AS MINPRICE, MAX(UNITPRICE) AS MAXPRICE,
       ROUND(AVG(UNITPRICE),2) AS AVGPRICE
FROM data
GROUP BY PRODUCT
ORDER BY AVGPRICE DESC

------Coupon usage and effectiveness (WHERE, GROUP BY, COUNT, AVG)

SELECT COUPONCODE, COUNT(*) AS TIMESUSED, ROUND(AVG(TOTALPRICE),2) AS AVGORDERVALUE
FROM data
WHERE COUPONCODE != 'UNKNOWN'
GROUP BY COUPONCODE
ORDER BY TIMESUSED DESC

----Order status breakdown for two products (WHERE with IN, GROUP BY multiple columns)

SELECT PRODUCT, ORDERSTATUS, COUNT(*) AS NUMORDERS
FROM data
WHERE PRODUCT IN ('LAPTOP','PHONE')
GROUP BY PRODUCT, ORDERSTATUS
ORDER BY PRODUCT, NUMORDERS DESC

--------Repeat customers (GROUP BY, HAVING, COUNT, SUM)

SELECT TOP 5
    CustomerID,
    COUNT(*) AS NumOrders,
    SUM(TotalPrice) AS TotalSpent
FROM Data
GROUP BY CustomerID
HAVING COUNT(*) > 1








