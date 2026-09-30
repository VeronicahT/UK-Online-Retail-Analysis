SELECT COUNT(*) AS total_rows FROM data;

SELECT COUNT(*) AS duplicate_rows
FROM (
    SELECT InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country, COUNT(*) as cnt
    FROM "data"
    GROUP BY InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country
    HAVING cnt > 1
);



DROP TABLE IF EXISTS data_clean;

CREATE TABLE data_clean AS
SELECT DISTINCT
    InvoiceNo,
    StockCode,
    TRIM(Description) AS Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    CASE WHEN CustomerID IS NULL THEN 'Guest' ELSE 'Identified' END AS CustomerType,
    CASE WHEN Quantity < 0 THEN 'Cancellation' ELSE 'Sale' END AS OrderType,
    Country
FROM "data"
WHERE Description IS NOT NULL;

SELECT COUNT(*) FROM data_clean;

SELECT CustomerType, COUNT(*) AS rows, ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM data_clean), 1) AS pct
FROM data_clean
GROUP BY CustomerType;

SELECT OrderType, COUNT(*) AS rows
FROM data_clean
GROUP BY OrderType;

SELECT * FROM data_clean WHERE UnitPrice <= 0 LIMIT 20;

SELECT DISTINCT Description
FROM data_clean
WHERE UnitPrice <= 0
ORDER BY Description;

DELETE FROM data_clean
WHERE UnitPrice <= 0
AND (
    LOWER(Description) LIKE '%damag%' OR
    LOWER(Description) LIKE '%adjust%' OR
    LOWER(Description) LIKE '%lost%' OR
    LOWER(Description) LIKE '%missing%' OR
    LOWER(Description) LIKE '%wrong%' OR
    LOWER(Description) LIKE '%thrown%' OR
    LOWER(Description) LIKE '%throw away%' OR
    LOWER(Description) LIKE '%wet%' OR
    LOWER(Description) LIKE '%crush%' OR
    LOWER(Description) LIKE '%broken%' OR
    LOWER(Description) LIKE '%crack%' OR
    LOWER(Description) LIKE '%mould%' OR
    LOWER(Description) LIKE '%sample%' OR
    LOWER(Description) LIKE '%dotcom%' OR
    LOWER(Description) LIKE '%amazon%' OR
    LOWER(Description) LIKE '%check%' OR
    LOWER(Description) LIKE '%found%' OR
    LOWER(Description) LIKE '%credit%' OR
    LOWER(Description) LIKE '%barcode%' OR
    LOWER(Description) LIKE '%code mix%' OR
    LOWER(Description) LIKE '%test%' OR
    LOWER(Description) LIKE '%sold as%' OR
    LOWER(Description) LIKE '%stock%' OR
    LOWER(Description) LIKE 'fba' OR
    LOWER(Description) LIKE '%ebay%' OR
    LOWER(Description) LIKE '%showroom%' OR
    LOWER(Description) LIKE '%mailout%' OR
    LOWER(Description) LIKE '%john lewis%' OR
    LOWER(Description) IN ('?', '??', '???', '????', 'mia', 'manual', 'display', '?display?', '?lost', '?missing')
);



SELECT DISTINCT Description
FROM data_clean
WHERE UnitPrice <= 0
AND NOT (
    LOWER(Description) LIKE '%damag%' OR
    LOWER(Description) LIKE '%adjust%' OR
    LOWER(Description) LIKE '%lost%' OR
    LOWER(Description) LIKE '%missing%' OR
    LOWER(Description) LIKE '%wrong%' OR
    LOWER(Description) LIKE '%thrown%' OR
    LOWER(Description) LIKE '%wet%' OR
    LOWER(Description) LIKE '%crush%' OR
    LOWER(Description) LIKE '%broken%' OR
    LOWER(Description) LIKE '%crack%' OR
    LOWER(Description) LIKE '%mould%' OR
    LOWER(Description) LIKE '%sample%' OR
    LOWER(Description) LIKE '%dotcom%' OR
    LOWER(Description) LIKE '%amazon%' OR
    LOWER(Description) LIKE '%check%' OR
    LOWER(Description) LIKE '%found%' OR
    LOWER(Description) LIKE '%credit%' OR
    LOWER(Description) LIKE '%barcode%' OR
    LOWER(Description) LIKE '%code mix%' OR
    LOWER(Description) LIKE '%test%' OR
    LOWER(Description) LIKE '%sold as%' OR
    LOWER(Description) LIKE '%stock%' OR
    LOWER(Description) LIKE 'fba' OR
    LOWER(Description) LIKE '%ebay%' OR
    LOWER(Description) LIKE '%showroom%' OR
    LOWER(Description) LIKE '%mailout%' OR
    LOWER(Description) LIKE '%john lewis%' OR
    LOWER(Description) IN ('?', '??', '???', '????', 'mia', 'manual', 'display', '?display?', '?lost', '?missing')
)
ORDER BY Description;

DELETE FROM data_clean
WHERE UnitPrice <= 0
AND (
    LOWER(Description) LIKE '%damag%' OR LOWER(Description) LIKE '%dagamed%' OR
    LOWER(Description) LIKE '%adjust%' OR LOWER(Description) LIKE '%lost%' OR
    LOWER(Description) LIKE '%missing%' OR LOWER(Description) LIKE '%wrong%' OR
    LOWER(Description) LIKE '%thrown%' OR LOWER(Description) LIKE '%wet%' OR
    LOWER(Description) LIKE '%crush%' OR LOWER(Description) LIKE '%broken%' OR
    LOWER(Description) LIKE '%crack%' OR LOWER(Description) LIKE '%mould%' OR
    LOWER(Description) LIKE '%sample%' OR LOWER(Description) LIKE '%dotcom%' OR
    LOWER(Description) LIKE '%amazon%' OR LOWER(Description) LIKE '%check%' OR
    LOWER(Description) LIKE '%found%' OR LOWER(Description) LIKE '%credit%' OR
    LOWER(Description) LIKE '%barcode%' OR LOWER(Description) LIKE '%code mix%' OR
    LOWER(Description) LIKE '%test%' OR LOWER(Description) LIKE '%sold as%' OR
    LOWER(Description) LIKE '%stock%' OR LOWER(Description) LIKE 'fba' OR
    LOWER(Description) LIKE '%ebay%' OR LOWER(Description) LIKE '%showroom%' OR
    LOWER(Description) LIKE '%mailout%' OR LOWER(Description) LIKE '%john lewis%' OR
    LOWER(Description) LIKE '%mix up%' OR LOWER(Description) LIKE '%mixed up%' OR
    LOWER(Description) LIKE '%unsaleable%' OR LOWER(Description) LIKE '%faulty%' OR
    LOWER(Description) LIKE '%smashed%' OR LOWER(Description) LIKE '%breakage%' OR
    LOWER(Description) LIKE '%given away%' OR LOWER(Description) LIKE '%put aside%' OR
    LOWER(Description) LIKE '%sale error%' OR LOWER(Description) LIKE '%rcvd%' OR
    LOWER(Description) LIKE '%mystery%' OR LOWER(Description) LIKE '%website fixed%' OR
    LOWER(Description) LIKE '%incorr%' OR LOWER(Description) LIKE '%cant mamage%' OR
    LOWER(Description) LIKE '%oops%' OR LOWER(Description) LIKE '%cargo order%' OR
    LOWER(Description) LIKE '%returned%' OR LOWER(Description) LIKE '%online retail order%' OR
    LOWER(Description) LIKE '%historic computer%' OR LOWER(Description) LIKE '%can''t find%' OR
    LOWER(Description) IN ('?', '??', '???', '????', 'mia', 'manual', 'display', '?display?', '?lost', '?missing', '20713', 'counted', 'sold in set?')
);


SELECT COUNT(*) FROM data_clean;

SELECT InvoiceDate FROM data_clean LIMIT 5;

ALTER TABLE data_clean ADD COLUMN InvoiceDateClean TEXT;

UPDATE data_clean
SET InvoiceDateClean = 
    substr(InvoiceDate, 7, 4) || '-' ||
    substr('0' || substr(InvoiceDate, 1, instr(InvoiceDate,'/')-1), -2) || '-' ||
    substr('0' || substr(substr(InvoiceDate, instr(InvoiceDate,'/')+1), 1, instr(substr(InvoiceDate, instr(InvoiceDate,'/')+1),'/')-1), -2)
    || ' ' || substr(InvoiceDate, instr(InvoiceDate,' ')+1);


SELECT InvoiceDate, InvoiceDateClean FROM data_clean LIMIT 5;

SELECT 
    Description,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM data_clean
WHERE OrderType = 'Sale'
GROUP BY Description
ORDER BY revenue DESC
LIMIT 20;

SELECT 
    Description,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM data_clean
WHERE OrderType = 'Sale'
AND Description NOT IN ('DOTCOM POSTAGE', 'POSTAGE', 'Manual', 'CARRIAGE', 'AMAZON FEE')
GROUP BY Description
ORDER BY revenue DESC
LIMIT 20;

SELECT 
    Country,
    COUNT(DISTINCT InvoiceNo) AS orders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue,
    ROUND(SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo), 2) AS avg_order_value
FROM data_clean
WHERE OrderType = 'Sale' AND Country != 'United Kingdom'
GROUP BY Country
ORDER BY revenue DESC;


SELECT 
    CustomerType,
    COUNT(DISTINCT InvoiceNo) AS orders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue,
    ROUND(100.0 * SUM(Quantity * UnitPrice) / (SELECT SUM(Quantity * UnitPrice) FROM data_clean WHERE OrderType = 'Sale'), 1) AS pct_of_revenue
FROM data_clean
WHERE OrderType = 'Sale'
GROUP BY CustomerType;


