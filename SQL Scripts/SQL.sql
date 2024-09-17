
-- Identify Missing Values
SELECT 
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN [Order_ID] IS NULL THEN 1 ELSE 0 END) AS Missing_Order_ID,
    SUM(CASE WHEN [Order_Date] IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Date,
    SUM(CASE WHEN [Ship_Date] IS NULL THEN 1 ELSE 0 END) AS Missing_Ship_Date,
    SUM(CASE WHEN [Ship_Mode] IS NULL THEN 1 ELSE 0 END) AS Missing_Ship_Mode,
    SUM(CASE WHEN [Customer_ID] IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_ID,
    SUM(CASE WHEN [Customer_Name] IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_Name,
    SUM(CASE WHEN [Segment] IS NULL THEN 1 ELSE 0 END) AS Missing_Segment,
    SUM(CASE WHEN [Country] IS NULL THEN 1 ELSE 0 END) AS Missing_Country,
    SUM(CASE WHEN [City] IS NULL THEN 1 ELSE 0 END) AS Missing_City,
    SUM(CASE WHEN [State] IS NULL THEN 1 ELSE 0 END) AS Missing_State,
    SUM(CASE WHEN [Postal_Code] IS NULL THEN 1 ELSE 0 END) AS Missing_Postal_Code,
    SUM(CASE WHEN [Region] IS NULL THEN 1 ELSE 0 END) AS Missing_Region,
    SUM(CASE WHEN [Product_ID] IS NULL THEN 1 ELSE 0 END) AS Missing_Product_ID,
    SUM(CASE WHEN [Category] IS NULL THEN 1 ELSE 0 END) AS Missing_Category,
    SUM(CASE WHEN [Sub_Category] IS NULL THEN 1 ELSE 0 END) AS Missing_Sub_Category,
    SUM(CASE WHEN [Product_Name] IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Name,
    SUM(CASE WHEN [Sales] IS NULL THEN 1 ELSE 0 END) AS Missing_Sales,
    SUM(CASE WHEN [Quantity] IS NULL THEN 1 ELSE 0 END) AS Missing_Quantity,
    SUM(CASE WHEN [Discount] IS NULL THEN 1 ELSE 0 END) AS Missing_Discount,
    SUM(CASE WHEN [Profit] IS NULL THEN 1 ELSE 0 END) AS Missing_Profit
FROM [SalesSuperStore].[dbo].[SalesSuperStore];



-- Check for Entire Row Duplicates
SELECT 
    [Order_ID], [Order_Date], [Ship_Date], [Ship_Mode], [Customer_ID], 
    [Customer_Name], [Segment], [Country], [City], [State], [Postal_Code], 
    [Region], [Product_ID], [Category], [Sub_Category], [Product_Name], 
    [Sales], [Quantity], [Discount], [Profit],
    COUNT(*) AS DuplicateCount
FROM [SalesSuperStore].[dbo].[salesSuperStore]
GROUP BY 
    [Order_ID], [Order_Date], [Ship_Date], [Ship_Mode], [Customer_ID], 
    [Customer_Name], [Segment], [Country], [City], [State], [Postal_Code], 
    [Region], [Product_ID], [Category], [Sub_Category], [Product_Name], 
    [Sales], [Quantity], [Discount], [Profit]
HAVING COUNT(*) > 1;



-- Replace Missing Values (Profit is NULL)
UPDATE [SalesSuperStore].[dbo].[salesSuperStore]
SET
    [Profit] = ISNULL([Profit], 0); -- Replace missing profit with 0



-- Check Data Types
SELECT 
    COLUMN_NAME, 
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'salesSuperStore'
  AND TABLE_SCHEMA = 'dbo';


-- Check Primary Key
  SELECT 
    ku.TABLE_NAME,
    ku.COLUMN_NAME,
    tc.CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS ku
    ON tc.CONSTRAINT_NAME = ku.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
  AND ku.TABLE_NAME = 'salesSuperStore'
  AND ku.COLUMN_NAME = 'ROW_ID'
  AND ku.TABLE_SCHEMA = 'dbo';  -- Adjust schema if necessary


-- Verify Uniqueness (ROW_ID)
SELECT 
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT [ROW_ID]) AS UniqueRowIDs
FROM [SalesSuperStore].[dbo].[salesSuperStore];


-- Creating a Primary Key on ROW_ID
ALTER TABLE [SalesSuperStore].[dbo].[salesSuperStore]
ADD CONSTRAINT PK_salesSuperStore_ROW_ID PRIMARY KEY ([ROW_ID]);



-- Verify Data Consistency

SELECT  * FROM [SalesSuperStore].[dbo].[salesSuperStore];
