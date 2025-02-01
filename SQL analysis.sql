create database pizzadashboard;

create table pizza_sales (
pizza_id int primary key,	
order_id int,
pizza_name_id	varchar(20),
quantity int,
order_date	date,
order_time timestamp, 
unit_price	float, 
total_price	float,
pizza_size	varchar(2),
pizza_category	varchar(10),
pizza_ingredients	varchar(100),
pizza_name varchar(50)
);

drop table pizza_sales;

create table pizza_sales (
pizza_id int,	
order_id int,
pizza_name_id	varchar(20),
quantity int,
order_date	date,
order_time time, 
unit_price	float, 
total_price	float,
pizza_size	varchar(2),
pizza_catpizza_salesegory	varchar(10),
pizza_ingredients	varchar(100),
pizza_name varchar(50)
);

#Total Revenue
select round(sum(pizza_sales.total_price),1) as Total_Revenue
from pizza_sales;

#Average Order Value
select round(sum(pizza_sales.total_price)/count(distinct pizza_sales.order_id), 2) as average_order_value
from pizza_sales;

#Total Pizzas sold 
select sum(pizza_sales.quantity) as total_pizzas_sold
from pizza_sales;


#Total orders
select count(distinct pizza_sales.order_id) as total_orders
from pizza_sales;

#Average pizzas per order 
select round(sum(pizza_sales.quantity)/count( distinct pizza_sales.order_id),2) as average_pizzas_per_order
from pizza_sales;

#Daily Trend for total orders 
select date_format(pizza_sales.order_date, '%m-%d') as order_date, count( distinct pizza_sales.order_id) as Total_Orders
from pizza_sales
group by 1;

# Day trend for total orders
select dayname(pizza_sales.order_date) as order_day, count( distinct pizza_sales.order_id) as Total_Orders
from pizza_sales
group by 1;


#Hourly trend for total orders 
select hour(pizza_sales.order_time), count( distinct pizza_sales.order_id) as total_orders
from pizza_sales
group by 1
order by 1;

#Percentage of sales by pizza category 
select pizza_sales.pizza_catpizza_salesegory, round(sum(pizza_sales.total_price),2) as total_sales,
round((sum(pizza_sales.total_price)/(select sum(pizza_sales.total_price) from pizza_sales))*100, 2) as perc_sales
from pizza_sales
group by 1 
order by perc_sales desc;


#Percentage of sales by pizza size 
select pizza_sales.pizza_size, round(sum(pizza_sales.total_price),2) as total_sales,
round((sum(pizza_sales.total_price)/(select sum(pizza_sales.total_price) from pizza_sales))*100, 2) as perc_sales
from pizza_sales
group by 1 
order by perc_sales desc;


#Total Pizzas sold by pizza category 
select pizza_sales.pizza_catpizza_salesegory as pizza_category, round(sum(pizza_sales.quantity),2) as total_pizzas_sold,
round((sum(pizza_sales.quantity)/(select sum(pizza_sales.quantity) from pizza_sales))*100, 2) as perc_pizzas_sold
from pizza_sales
group by 1 
order by perc_pizzas_sold desc;

#Top 5 best sellers by total pizzas sold
select pizza_sales.pizza_name, sum(pizza_sales.quantity) as total_quantity
from pizza_sales
group by 1
order by 2 desc
limit 5;


#Bottom 5 worst sellers by total pizza sold 
select pizza_sales.pizza_name, sum(pizza_sales.quantity) as total_quantity
from pizza_sales
group by 1
order by 2
limit 5;