-- Hotel Reservation Analysis with SQL

-- Creating a new database
create database if not exists hotel;

-- using the database
use hotel;

-- Checking the tables in the database
show tables;

-- checking the contents of the table
SELECT 
    *
FROM
    hotel_data;

-- Checking the structure of the table
desc hotel_data;

-- Q1. What is the total number of reservations in the dataset?
SELECT 
    COUNT(Booking_ID) AS total_reservation
FROM
    hotel_data;
-- Insight: there are 700 reservations in the dataset
    
-- Q2. Which meal plan is the most popular among guests? 
SELECT 
    type_of_meal_plan, COUNT(type_of_meal_plan) AS Total_count
FROM
    hotel_data
GROUP BY type_of_meal_plan
ORDER BY Total_count DESC
LIMIT 1;
/* insight: Meal plan 1 is the most popular meal among the guest 
 with the total count of 527 */
 
 -- Q3.What is the average price per room for reservations involving children?
SELECT 
    ROUND(AVG(avg_price_per_room), 2) AS avg_price_per_room_involving_children
FROM
    hotel_data
WHERE
    no_of_children > 0;
-- Insight: average price per room for reservations involving children is ₹144.57

-- Q4. How many reservations were made for the year 2017 ? 
SELECT 
    YEAR(arrival_date) AS Year, COUNT(*) AS reservations
FROM
    hotel_data
WHERE
    YEAR(arrival_date) = 2017
GROUP BY YEAR(arrival_date); 
-- Insight:123 reservations were made for the year 2017

-- Q5. What is the most commonly booked room type? 
SELECT 
    room_type_reserved, COUNT(*) AS total_booking
FROM
    hotel_data
GROUP BY room_type_reserved
ORDER BY total_booking DESC
LIMIT 1; 
-- Insight: Room_type_1 is the most commonly booked room type with total_booking of 534

-- Q6. How many reservations fall on a weekend (no_of_weekend_nights > 0)? 
SELECT 
    COUNT(no_of_weekend_nights) AS weekend_reservation
FROM
    hotel_data
WHERE
    no_of_weekend_nights > 0;
-- Insight: There are 383 weekend reservations

-- Q7. What is the highest and lowest lead time for reservations? 
SELECT 
    MAX(lead_time) AS highest_lead_time,
    MIN(lead_time) AS lowest_lead_time
FROM
    hotel_data;
/* Insights:The range of lead times, from 0 to 443 days, 
suggests diverse booking behaviors among guests. 
Some prefer last-minute reservations, while others plan well in advance.*/

-- Q8. What is the most common market segment type for reservations? 
SELECT 
    market_segment_type, COUNT(*) AS total_count
FROM
    hotel_data
GROUP BY market_segment_type
ORDER BY total_count DESC;
-- Insight: Online is the most common market segment type for reservations

-- Q9. How many reservations have a booking status of "Confirmed"? 
SELECT 
    booking_status, COUNT(*) AS total_count
FROM
    hotel_data
WHERE
    booking_status = 'Not_Canceled'; 
-- Insight: 493 reservations have a booking status of "Confirmed"

-- Q10. What is the total number of adults and children across all reservations? 
SELECT 
    SUM(no_of_adults) AS total_no_of_adults,
    SUM(no_of_children) AS total_no_of_children
FROM
    hotel_data;
/* Insight: The majority of reservations, totaling 1,316, 
involve adult guests, while a smaller number, 69, include children. */

-- Q11. What is the average number of weekend nights for reservations involving children?

SELECT 
    AVG(no_of_weekend_nights) AS Avg_weekend_night_with_children
FROM
    hotel_data
WHERE
    no_of_children > 0;
-- Insight: On average, reservations with children involve a one-night stay on weekends.

-- Q12. How many reservations were made in each month of the year?
SELECT 
    MONTH(arrival_date) AS arrival_month,
    MONTHNAME(arrival_date) AS month_name,
    COUNT(*) AS total_reservations
FROM
    hotel_data
GROUP BY arrival_month , month_name
ORDER BY total_reservations DESC;
/* Insight:October stands out as the peak reservation month (103 total_reservations)
followed by June and September . In contrast, 
January records the lowest number of reservations (11 total_reservations), 
indicating a quieter period. */

-- Q13. What is the average number of nights (both weekend and weekday) spent by guests for each room type? 
SELECT 
    room_type_reserved,
    ROUND(AVG(no_of_weekend_nights + no_of_week_nights),
            2) AS avg_nights_spent
FROM
    hotel_data
GROUP BY room_type_reserved
ORDER BY avg_nights_spent DESC;
/* Insight:Guests staying in Room Type 4 tend to spend the most nights on average (3.80), while 
those in Room Type 5 have the lowest average stay duration (2.50).*/

-- Q14. For reservations involving children, what is the most common room type, 
-- and what is the average price for that room type? 
SELECT 
    room_type_reserved,
    COUNT(*) AS total_reservations,
    ROUND(AVG(avg_price_per_room), 2) AS avg_price_per_room
FROM
    hotel_data
WHERE
    no_of_children > 0
GROUP BY room_type_reserved
ORDER BY total_reservations DESC
LIMIT 1;
/* Insight:For reservations involving children, Room Type 1 is the preferred choice, with an average 
room price of 123.12. */

-- Q15. Find the market segment type that generates the highest average price per room. 
SELECT 
    market_segment_type,
    ROUND(AVG(avg_price_per_room), 2) AS avg_price_per_room
FROM
    hotel_data
GROUP BY market_segment_type
ORDER BY avg_price_per_room DESC
LIMIT 1;
-- insight: Online bookings generate the highest average room price, reaching 112.46