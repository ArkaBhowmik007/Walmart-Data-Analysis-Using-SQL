/*INTRODUCTION TO FEATURE ENGINEERING*/

/* Q1: Write SQL queries to add a new column in the existing database to specify the period of the time*/

SELECT TIME,(
	CASE 	
		WHEN TIME BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
		WHEN TIME BETWEEN '12:01:00' AND '16:00:00' THEN 'AFTERNOON'
		ELSE
		'EVENING'
END)TIME_OF_DAY
FROM SALES;

ALTER TABLE SALES ADD COLUMN TIME_OF_DAY VARCHAR(50);

UPDATE SALES
SET TIME_OF_DAY=(
	CASE 	
		WHEN TIME BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
		WHEN TIME BETWEEN '12:01:00' AND '16:00:00' THEN 'AFTERNOON'
		ELSE
		'EVENING'
END
);

SELECT * FROM SALES;

/* Q2: Write SQL queries to add a new column in the existing database to specify the day of the week*/

SELECT DATE,TO_CHAR(DATE,'DAY')DAYS FROM SALES;

ALTER TABLE SALES ADD COLUMN DAYS VARCHAR(12);

UPDATE SALES 
SET DAYS=TO_CHAR(DATE,'DAY');

SELECT * FROM SALES;

/* Q3: Write SQL queries to add a new column in the existing database to specify the month of the year*/

SELECT DATE,TO_CHAR(DATE,'MONTH')MONTHS FROM SALES;

ALTER TABLE SALES ADD COLUMN MONTHS VARCHAR(12);

UPDATE SALES 
SET MONTHS=TO_CHAR(DATE,'MONTH');

SELECT * FROM SALES;

/*EXPLANATORY DATA ANALYSIS*/

/* Q4: How many distinct cities are present in the dataset?*/

SELECT COUNT(DISTINCT(CITY))UNIQUE_CITY_COUNT FROM SALES;

/* Q5: In which city is each branch situated?*/

SELECT DISTINCT BRANCH,CITY FROM SALES;

/* Q6: How many distinct product lines are there in the dataset?*/

SELECT DISTINCT(PRODUCT_LINE)FROM SALES;

/* Q7: What is the most common payment method?*/

SELECT PAYMENT,COUNT(PAYMENT)PAYMENT_METHOD FROM SALES
GROUP BY PAYMENT
ORDER BY PAYMENT_METHOD DESC
LIMIT 1;

/* Q8. What is the most selling prduct line?*/

SELECT PRODUCT_LINE,COUNT(PRODUCT_LINE) MOST_SELLING FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY MOST_SELLING DESC;

/* Q9: What is the total revenue by month?*/

SELECT MONTHS,SUM(TOTAL)MONTHLY_REVENUE FROM SALES
GROUP BY MONTHS
ORDER BY MONTHLY_REVENUE DESC;

/* Q10: Which month recorded the highest Cost of Goods Sold (COGS)*/

SELECT MONTHS,SUM(COGS) MAXIMUM_COGS FROM SALES
GROUP BY MONTHS
ORDER BY MAXIMUM_COGS DESC;

/* Q11: Which product line generated the highest revenue?*/

SELECT PRODUCT_LINE,SUM(TOTAL) HIGHEST_REV FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY HIGHEST_REV DESC;

/* Q12: Which city has the highest revenue?*/

SELECT CITY,SUM(TOTAL) CITY_REV FROM SALES
GROUP BY CITY
ORDER BY CITY_REV DESC;

/* Q13: Which product line incurred the highest VAT?*/

SELECT PRODUCT_LINE,(GROSS_INCOME*0.20) VAT FROM SALES
GROUP BY PRODUCT_LINE,GROSS_INCOME
ORDER BY VAT DESC;

/* Q14: Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,'based on whether its sales are above the average.*/

ALTER TABLE SALES ADD COLUMN PRODUCT_CATEGORY VARCHAR(20);

UPDATE SALES
SET PRODUCT_CATEGORY = 
    CASE 
        WHEN TOTAL >= (SELECT AVG(TOTAL) FROM SALES) THEN 'GOOD'
        ELSE 'BAD'
    END;

SELECT * FROM SALES;

/* Q15: Which branch sold more products than average product sold?*/

SELECT BRANCH,SUM(QUANTITY) QUANTITY_SOLD
FROM SALES
GROUP BY BRANCH
HAVING SUM(QUANTITY)>AVG(QUANTITY)
ORDER BY QUANTITY_SOLD DESC;

/* Q16: What is the most common product line by gender?*/

SELECT PRODUCT_LINE,GENDER,COUNT(GENDER) TOTAL_COUNT
FROM SALES
GROUP BY PRODUCT_LINE,GENDER
ORDER BY TOTAL_COUNT DESC;

/* Q17: What is the average rating of each product line?*/

SELECT PRODUCT_LINE,ROUND(AVG(RATING),2) AVG_RATING
FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY AVG_RATING DESC;

/* Q18: Number of sales made in each time of the day per weekday*/

SELECT DAYS,TIME_OF_DAY,COUNT(INVOICE_ID)CNT_INV_ID
FROM SALES
GROUP BY DAYS,TIME_OF_DAY
ORDER BY CNT_INV_ID DESC;

/* Q19: Identify the customer type that generates the highest revenue.*/

SELECT CUSTOMER_TYPE,SUM(TOTAL) REVENUE
FROM SALES
GROUP BY CUSTOMER_TYPE
ORDER BY REVENUE DESC;

/* Q20: Which city has the largest tax percent/ VAT (Value Added Tax)?*/

SELECT CITY,SUM(TAX_PCT) TAX_PERCENT 
FROM SALES
GROUP BY CITY
ORDER BY TAX_PERCENT DESC;

/* Q21: How many unique customer types does the data have?*/

SELECT CUSTOMER_TYPE,COUNT(DISTINCT(CUSTOMER_TYPE)) 
FROM SALES
GROUP BY CUSTOMER_TYPE;

/* Q22: How many unique payment methods does the data have?*/

SELECT COUNT(DISTINCT(PAYMENT))FROM SALES;

/* Q23: Which is the most common customer type?*/

SELECT CUSTOMER_TYPE,COUNT(CUSTOMER_TYPE)COMMON_CUST_TYPE
FROM SALES
GROUP BY CUSTOMER_TYPE
ORDER BY COMMON_CUST_TYPE DESC;

/* Q24: Which customer type buys the most?*/

SELECT CUSTOMER_TYPE,SUM(TOTAL)TOTAL_SALES
FROM SALES
GROUP BY CUSTOMER_TYPE
ORDER BY TOTAL_SALES DESC

/* Q25: What is the gender of most of the customers?*/

SELECT GENDER,COUNT(GENDER)MOST_GENDER
FROM SALES
GROUP BY GENDER
ORDER BY MOST_GENDER DESC;

/* Q26: What is the gender distribution per branch?*/

SELECT BRANCH,COUNT(GENDER)GENDER_DIST
FROM SALES
GROUP BY BRANCH
ORDER BY GENDER_DIST DESC;

/* Q27: Which time of the day do customers give most ratings?*/

SELECT TIME_OF_DAY,ROUND(AVG(RATING),2)AVG_RATING
FROM SALES
GROUP BY TIME_OF_DAY
ORDER BY AVG_RATING DESC;

/* Q28: Which time of the day do customers give most ratings per branch?*/

SELECT BRANCH,TIME_OF_DAY,ROUND(AVG(RATING),2)AVG_RATING
FROM SALES
GROUP BY BRANCH,TIME_OF_DAY
ORDER BY AVG_RATING DESC;

/* Q29: Which day of the week has the best avg ratings?*/

SELECT DAYS,ROUND(AVG(RATING),2)AVG_RATING
FROM SALES
GROUP BY DAYS
ORDER BY AVG_RATING DESC;

/* Q30: Which day of the week has the best average ratings per branch?*/

SELECT BRANCH,DAYS,ROUND(AVG(RATING),2)AVG_RATING
FROM SALES
GROUP BY BRANCH,DAYS
ORDER BY AVG_RATING DESC;