Create database RentCar;
go
Use RentCar;


GO
-- bảng account
CREATE TABLE [dbo].[account](
	[accountid] [int] IDENTITY(1,1) NOT NULL,
	[auth_id] [varchar](255) NULL,
	[auth_type] [smallint] NULL,
	[password] [nvarchar](255) NULL,
	[user_name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[accountid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


--bang bill
CREATE TABLE [dbo].[bill](
	[billid] [int] IDENTITY(1,1) NOT NULL,
	[customer_name] [nvarchar](255) NULL,
	[rental_day] [varchar](255) NULL,
	[return_day] [varchar](255) NULL,
	[status] [bit] NULL,
	[total_price] [float] NULL,
	[customerid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[billid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--bang bill_detal
CREATE TABLE [dbo].[bill_detail](
	[bill_detailid] [int] IDENTITY(1,1) NOT NULL,
	[address] [nvarchar](255) NULL,
	[carid] [int] NULL,
	[phone_number] [varchar](255) NULL,
	[price_hours_bill_detail] [float] NULL,
	[rental_hour] [float] NULL,
	[billid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[bill_detailid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- baag booking
CREATE TABLE [dbo].[booking](
	[bookingid] [int] IDENTITY(1,1) NOT NULL,
	[address] [varchar](255) NULL,
	[carid] [int] NULL,
	[customer_name] [varchar](255) NULL,
	[phone_number] [varchar](255) NULL,
	[rental_day] [date] NULL,
	[return_day] [date] NULL,
	[status] [bit] NULL,
	[total_price] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[bookingid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--- bang car
CREATE TABLE [dbo].[car](
	[carid] [int] IDENTITY(1,1) NOT NULL,
	[location] [nvarchar](255) NULL,
	[car_name] [nvarchar](255) NULL,
	[car_type] [varchar](255) NULL,
	[car_number] [varchar](255) NULL,
	[color] [varchar](255) NULL,
	[describe] [nvarchar](255) NULL,
	[fee_limit] [varchar](255) NULL,
	[image] [varchar](max) NULL,
	[limit] [varchar](255) NULL,
	[muctieuthu] [varchar](255) NULL,
	[ownership_document] [varchar](max) NULL,
	[price_hours_car] [float] NULL,
	[status] [bit] NULL,
	[type_fuel] [varchar](255) NULL,
	[type_gear] [varchar](255) NULL,
	[year_of_manufacture] [int] NULL,
	[car_brandid] [int] NULL,
	[ownerid] [int] NULL,
	[reviewid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[carid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- car_band
CREATE TABLE [dbo].[car_brand](
	[car_brandid] [int] IDENTITY(1,1) NOT NULL,
	[brand_name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[car_brandid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-- car_owenr
CREATE TABLE [dbo].[car_owner](
	[ownerid] [int] IDENTITY(1,1) NOT NULL,
	[customerid] [int] NULL,
	[customer_name] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ownerid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- customer
CREATE TABLE [dbo].[customer](
	[customerid] [int] IDENTITY(1,1) NOT NULL,
	[accountid] [int] NULL,
	[address] [nvarchar](255) NULL,
	[customer_name] [nvarchar](255) NULL,
	[gender] [nvarchar](255) NULL,
	[idcard] [varchar](255) NULL,
	[phone_number] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[customerid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- image_car
CREATE TABLE [dbo].[image_car](
	[vehicle_id] [int] IDENTITY(1,1) NOT NULL,
	[image1] [varchar](255) NULL,
	[image2] [varchar](255) NULL,
	[image3] [varchar](255) NULL,
	[image4] [varchar](255) NULL,
	[img_ownership_certificate1] [varchar](255) NULL,
	[img_ownership_certificate2] [varchar](255) NULL,
	[car_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[vehicle_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- image-pending
CREATE TABLE [dbo].[image_pending](
	[vehicle_id] [int] IDENTITY(1,1) NOT NULL,
	[image1] [varchar](255) NULL,
	[image2] [varchar](255) NULL,
	[image3] [varchar](255) NULL,
	[image4] [varchar](255) NULL,
	[img_ownership_certificate1] [varchar](255) NULL,
	[img_ownership_certificate2] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[vehicle_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-- payment
CREATE TABLE [dbo].[payment](
	[paymentid] [int] IDENTITY(1,1) NOT NULL,
	[amount] [float] NULL,
	[billid] [int] NULL,
	[payment_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[paymentid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- pending_car_post
CREATE TABLE [dbo].[pending_car_post](
	[postid] [int] IDENTITY(1,1) NOT NULL,
	[location] [nvarchar](255) NULL,
	[car_name] [nvarchar](255) NULL,
	[car_type] [varchar](255) NULL,
	[car_number] [varchar](255) NULL,
	[color] [varchar](255) NULL,
	[describe] [nvarchar](255) NULL,
	[fee_limit] [varchar](255) NULL,
	[limit] [varchar](255) NULL,
	[muctieuthu] [varchar](255) NULL,
	[price_hours_car] [float] NULL,
	[status] [bit] NULL,
	[type_fuel] [varchar](255) NULL,
	[type_gear] [varchar](255) NULL,
	[year_of_manufacture] [int] NULL,
	[car_brandid] [int] NULL,
	[customerid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[postid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- review
CREATE TABLE [dbo].[review](
	[reviewid] [int] IDENTITY(1,1) NOT NULL,
	[carid] [int] NULL,
	[customerid] [int] NULL,
	[rating] [int] NULL,
	[review_date] [date] NULL,
	[review_text] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[reviewid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--role 
CREATE TABLE [dbo].[role](
	[id] [int] NOT NULL,
	[name] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
go
--user_role
CREATE TABLE [dbo].[user_role](
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
--after cái gì đó
ALTER TABLE [dbo].[account]  WITH CHECK ADD CHECK  (([auth_type]>=(0) AND [auth_type]<=(2)))
GO


ALTER TABLE [dbo].[bill]  WITH CHECK ADD  CONSTRAINT [FKduvsbt91e079yql89g7io0rt4] FOREIGN KEY([customerid])
REFERENCES [dbo].[customer] ([customerid])
GO

ALTER TABLE [dbo].[bill] CHECK CONSTRAINT [FKduvsbt91e079yql89g7io0rt4]
GO


ALTER TABLE [dbo].[bill_detail]  WITH CHECK ADD  CONSTRAINT [FK480s0ds7f3aqu51t96wmcuxhw] FOREIGN KEY([carid])
REFERENCES [dbo].[car] ([carid])
GO

ALTER TABLE [dbo].[bill_detail] CHECK CONSTRAINT [FK480s0ds7f3aqu51t96wmcuxhw]
GO

ALTER TABLE [dbo].[bill_detail]  WITH CHECK ADD  CONSTRAINT [FK8k2t2g0ijaseny4aj71bupp4n] FOREIGN KEY([billid])
REFERENCES [dbo].[bill] ([billid])
GO

ALTER TABLE [dbo].[bill_detail] CHECK CONSTRAINT [FK8k2t2g0ijaseny4aj71bupp4n]
GO


ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK1j4gjgtm2n9gvhmcwsmj00mm7] FOREIGN KEY([carid])
REFERENCES [dbo].[car] ([carid])
GO

ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK1j4gjgtm2n9gvhmcwsmj00mm7]
GO

ALTER TABLE [dbo].[car]  WITH CHECK ADD  CONSTRAINT [FKcx4d66i0tlqrdi2938u1y3l01] FOREIGN KEY([ownerid])
REFERENCES [dbo].[car_owner] ([ownerid])
GO

ALTER TABLE [dbo].[car] CHECK CONSTRAINT [FKcx4d66i0tlqrdi2938u1y3l01]
GO

ALTER TABLE [dbo].[car]  WITH CHECK ADD  CONSTRAINT [FKf9p93wnsbdy4g44cx4iqhyhes] FOREIGN KEY([reviewid])
REFERENCES [dbo].[review] ([reviewid])
GO

ALTER TABLE [dbo].[car] CHECK CONSTRAINT [FKf9p93wnsbdy4g44cx4iqhyhes]
GO

ALTER TABLE [dbo].[car]  WITH CHECK ADD  CONSTRAINT [FKkevqd6mlo9mjfmo129co282cs] FOREIGN KEY([car_brandid])
REFERENCES [dbo].[car_brand] ([car_brandid])
GO

ALTER TABLE [dbo].[car] CHECK CONSTRAINT [FKkevqd6mlo9mjfmo129co282cs]
GO


ALTER TABLE [dbo].[car_owner]  WITH CHECK ADD  CONSTRAINT [FK8dr7ig14t1euldtqevqn0f670] FOREIGN KEY([customerid])
REFERENCES [dbo].[customer] ([customerid])
GO

ALTER TABLE [dbo].[car_owner] CHECK CONSTRAINT [FK8dr7ig14t1euldtqevqn0f670]
GO


ALTER TABLE [dbo].[customer]  WITH CHECK ADD  CONSTRAINT [FKass5qvmiyb6jsxaqjmk0mj4bw] FOREIGN KEY([accountid])
REFERENCES [dbo].[account] ([accountid])
GO

ALTER TABLE [dbo].[customer] CHECK CONSTRAINT [FKass5qvmiyb6jsxaqjmk0mj4bw]
GO


ALTER TABLE [dbo].[image_car]  WITH CHECK ADD  CONSTRAINT [FK5ppiyn9bw9l086xylipo8p3d1] FOREIGN KEY([car_id])
REFERENCES [dbo].[car] ([carid])
GO

ALTER TABLE [dbo].[image_car] CHECK CONSTRAINT [FK5ppiyn9bw9l086xylipo8p3d1]
GO


ALTER TABLE [dbo].[payment]  WITH CHECK ADD  CONSTRAINT [FK11qy73js2eheuoa5wlgm9jblw] FOREIGN KEY([billid])
REFERENCES [dbo].[bill] ([billid])
GO

ALTER TABLE [dbo].[payment] CHECK CONSTRAINT [FK11qy73js2eheuoa5wlgm9jblw]
GO

ALTER TABLE [dbo].[pending_car_post]  WITH CHECK ADD  CONSTRAINT [FKm3ye1voktw4rqp62tqp1m0f3d] FOREIGN KEY([customerid])
REFERENCES [dbo].[customer] ([customerid])
GO

ALTER TABLE [dbo].[pending_car_post] CHECK CONSTRAINT [FKm3ye1voktw4rqp62tqp1m0f3d]
GO

ALTER TABLE [dbo].[pending_car_post]  WITH CHECK ADD  CONSTRAINT [FKmp0ud2hk07d5fgg7j67rfofs] FOREIGN KEY([car_brandid])
REFERENCES [dbo].[car_brand] ([car_brandid])
GO

ALTER TABLE [dbo].[pending_car_post] CHECK CONSTRAINT [FKmp0ud2hk07d5fgg7j67rfofs]
GO


ALTER TABLE [dbo].[review]  WITH CHECK ADD  CONSTRAINT [FKry6hyp71d3k629ky7rgl2lnxk] FOREIGN KEY([customerid])
REFERENCES [dbo].[customer] ([customerid])
GO

ALTER TABLE [dbo].[review] CHECK CONSTRAINT [FKry6hyp71d3k629ky7rgl2lnxk]
GO


ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FKa68196081fvovjhkek5m97n3y] FOREIGN KEY([role_id])
REFERENCES [dbo].[role] ([id])
GO

ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FKa68196081fvovjhkek5m97n3y]
GO

ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FKlkhooy5w45r7bji6wv27a0wuq] FOREIGN KEY([user_id])
REFERENCES [dbo].[account] ([accountid])
GO

ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FKlkhooy5w45r7bji6wv27a0wuq]
GO


---------

-- insert Dữ liệu
INSERT INTO [dbo].[account]
           ([auth_id]
           ,[auth_type]
           ,[password]
           ,[user_name])
     VALUES
           (0, 0, '123', 'admin'),
           (0, 1, '123', 'ben123'),
           (0, 2, '123', 'teo123'),
		   (0, 3, '123', 'vu123'),
           (0, 3, '123', 'than123'),
           (0, 3, '123', 'hieu123'),
           (0, 3, '123', 'ben123'),
           (0, 3, '123', 'tai123'),
           (0, 3, '123', 'hoang123'),
           (0, 3, '123', 'quan123'),
           (0, 3, '123', 'hung123'),
           (0, 3, '123', 'linh123'),
           (0, 3, '123', 'hung123');
GO

-- Inserting into role table
INSERT INTO [dbo].[role]
           ([id]
           ,[name])
     VALUES
           (0, 'ADMIN'),
           (1, 'OWNER'),
           (2, 'USER');
GO

-- Inserting into user_role table
INSERT INTO [dbo].[user_role]
           ([user_id]
           ,[role_id])
     VALUES
           (1, 0),
           (2, 1),
           (3, 2);
GO

-- insert car_brand
INSERT INTO [dbo].[car_brand]
           ([brand_name])
     VALUES
           ('Ferrari'),
           ('Lamborghini'),
           ('Porsche'),
           ('Toyota'),
           ('Honda'),
           ('BMW'),
           ('Mercedes-Benz'),
           ('Audi'),
           ('Chevrolet'),
           ('Ford'),
		   ('Hyundai');
GO
-- insert customer
INSERT INTO [dbo].[customer]
           ([accountid], [address], [customer_name], [gender], [idcard], [phone_number])
VALUES
           (1, '123 Main St', 'Chi Hieu', 'Male', '123456789', '0909123456'),
           (2, '456 Main St', 'Ben', 'Male', '987654321', '0909765432'),
           (3, '789 Main St', 'Teo', 'Male', '192837465', '0909345678'),
		   (4, '123 Nguyen Trai, Ho Chi Minh', 'Vu', 'Male', '123456781', '0909000001'),
           (5, '456 Le Loi, Ho Chi Minh', 'Than', 'Male', '123456782', '0909000002'),
           (6, '789 Tran Hung Dao, Ho Chi Minh', 'Hieu', 'Male', '123456783', '0909000003'),
           (7, '123 Ly Thuong Kiet, Ho Chi Minh', 'Ben', 'Male', '123456784', '0909000004'),
           (8, '456 Cach Mang Thang 8, Ho Chi Minh', 'Tai', 'Male', '123456785', '0909000005'),
           (9, '789 Pham Van Dong, Ho Chi Minh', 'Hoang', 'Male', '123456786', '0909000006'),
           (10, '123 Vo Van Tan, Ho Chi Minh', 'Quan', 'Male', '123456787', '0909000007'),
           (11, '456 Pham Ngu Lao, Ho Chi Minh', 'Hung', 'Male', '123456788', '0909000008'),
           (12, '789 Dinh Tien Hoang, Ho Chi Minh', 'Linh', 'Female', '123456789', '0909000009'),
           (13, '123 Hai Ba Trung, Ho Chi Minh', 'Hung', 'Male', '123456790', '0909000010');
go
 --inser car_owner
INSERT INTO [dbo].[car_owner]
           ([customerid], [customer_name])
VALUES
           (1, 'Tran Vu'),
           (2, 'Minh Quan'),
           (3, 'Teo');
 go
 -- insert car
 INSERT INTO [dbo].[car]
           ([location], [car_name], [car_type], [car_number], [color], [describe], 
            [fee_limit], [image], [limit], [muctieuthu], [ownership_document], 
            [price_hours_car], [status], [type_fuel], [type_gear], 
            [year_of_manufacture], [car_brandid], [ownerid], [reviewid])
VALUES
           ('To Ky Street, District 12, HCMC', 'Ferrari F8', 'Sports', '30A-12345', 'Red', 'Luxury sports car', 
            '500km', NULL, '500km', '10L/100km', NULL, 500000.0, 1, 'Petrol', 'Automatic', 
            2020, 1, 1, NULL),
           ('Bui Vien Street, District 1, HCMC', 'Lamborghini Huracan', 'Sports', '30A-12346', 'Yellow', 'High-end sports car', 
            '400km', NULL, '400km', '12L/100km', NULL, 5500000.0, 1, 'Petrol', 'Automatic', 
            2021, 2, 1, NULL),
           ('Tran Nao Street, District 2, HCMC', 'Porsche 911', 'Sports', '30A-12347', 'Blue', 'Top-class sports car', 
            '300km', NULL, '300km', '11L/100km', NULL, 6000000.0, 1, 'Petrol', 'Automatic', 
            2022, 3, 1, NULL),
           ('3/2 Street,District 10, HCMC', 'Honda Civic', 'Sedan', '30A-22345', 'Black', 'Reliable sedan', 
            '500km', NULL, '500km', '7L/100km', NULL, 15000000.0, 1, 'Petrol', 'Manual', 
            2020, 5, 2, NULL),
           ('Su Van Hanh Street, District 10, HCMC', 'Toyota Camry', 'Sedan', '30A-22346', 'White', 'Comfortable sedan', 
            '600km', NULL, '600km', '8L/100km', NULL, 2000000.0, 1, 'Petrol', 'Automatic', 
            2019, 4, 2, NULL),
           ('Song Hanh QL22 Street, District 12, HCMC', 'Hyundai Tucson', 'SUV', '30A-22347', 'Gray', 'Versatile SUV', 
            '500km', NULL, '500km', '9L/100km', NULL, 1800000.0, 1, 'Diesel', 'Automatic', 
            2021, 11, 2, NULL),
           ('To Ngoc Van Street, District 12, HCMC', 'Ford Ranger', 'Truck', '30A-32345', 'Red', 'Tough truck', 
            '700km', NULL, '700km', '10L/100km', NULL, 2500000.0, 1, 'Diesel', 'Manual', 
            2020, 10, 3, NULL),
           ('Duong Thi Muoi Street, District 12, HCMC', 'Mazda CX-5', 'SUV', '30A-32346', 'Blue', 'Stylish SUV', 
            '600km', NULL, '600km', '8L/100km', NULL, 2300000.0, 1, 'Petrol', 'Automatic', 
            2021, 8, 3, NULL),
           ('Truong Chinh Street, District 2, HCMC', 'Chevrolet Colorado', 'Truck', '30A-32347', 'Black', 'Durable truck', 
            '800km', NULL, '800km', '12L/100km', NULL, 2800000.0, 1, 'Diesel', 'Automatic', 
            2022, 9, 3, NULL),
			('Pham Van Chi Street, District 6, HCMC', 'Ferrari 488 GTB', 'Sport', '71A-32547', 'Black', 'Luxury', 
            '800km', NULL, '500km', '11L/100km', NULL, 2900000.0, 1, 'Diesel', 'Automatic', 
            2022, 1, 3, NULL),
			('Lac Long Quan Street, District 11, HCMC', 'Porsche 918 Spyder', 'Sport', '71A-80212', 'Gray', 'Luxury car, sports', 
            '600km', NULL, '600km', '10L/100km', NULL, 3600000.0, 1, 'Diesel', 'Automatic', 
            2022, 3, 3, NULL),
			('Le Van Viet Street, District 9, HCMC', 'Lamborghini Sian', 'Sport', '71A-42807', 'Yellow', 'Luxury car for people', 
            '600km', NULL, '600km', '10L/100km', NULL, 3800000.0, 1, 'Diesel', 'Automatic', 
            2022, 2, 3, NULL),
			('Nguyen Xien Street, District 9, HCMC', 'Audi Q8', 'Sport', '59B-24024', 'Blue', 'Sport car', 
            '500km', NULL, '600km', '9L/100km', NULL, 2900000.0, 1, 'Diesel', 'Automatic', 
            2020, 8, 3, NULL),
			('Nguyen Xien Street, District 9, HCMC', 'Ford Everest', 'SUV', '59B-24024', 'White', 'Good car for travel and camping with family or friends', 
            '800km', NULL, '600km', '8L/100km', NULL, 2500000.0, 1, 'Diesel', 'Automatic', 
            2020, 10, 3, NULL);
go
-- insert bill
INSERT INTO [dbo].[bill]
           ([customer_name], [rental_day], [return_day], [status], [total_price], [customerid])
VALUES
           ('Chi Hieu', '2024-01-01', '2024-01-10', 1, 1500000.0, 1),
           ('Ben', '2024-02-01', '2024-02-05', 1, 800000.0, 2),
           ('Teo', '2024-03-01', '2024-03-07', 1, 1200000.0, 3),
		    ('Vu', '2024-01-11', '2024-01-15', 1, 5000000.0, 4),
           ('Than', '2024-01-16', '2024-01-20', 1, 4000000.0, 5),
           ('Hieu', '2024-02-01', '2024-02-10', 1, 9000000.0, 6),
           ('Ben', '2024-02-11', '2024-02-15', 1, 3500000.0, 7),
           ('Tai', '2024-03-01', '2024-03-10', 1, 10000000.0, 8),
           ('Hoang', '2024-03-11', '2024-03-20', 1, 7500000.0, 9),
           ('Quan', '2024-04-01', '2024-04-05', 1, 3000000.0, 10),
           ('Hung', '2024-04-06', '2024-04-15', 1, 6000000.0, 11),
           ('Linh', '2024-05-01', '2024-05-10', 1, 8500000.0, 12),
           ('Hung', '2024-05-11', '2024-05-20', 1, 7000000.0, 13);
go
-- insert bill_detail
INSERT INTO [dbo].[bill_detail]
           ([address], [carid], [phone_number], [price_hours_bill_detail], [rental_hour], [billid])
VALUES
           ('123 Main St', 1, '0909123456', 5000.0, 3, 1),
           ('456 Main St', 4, '0909765432', 1500.0, 5, 2),
           ('789 Main St', 7, '0909345678', 2500.0, 4, 3);
go
-- insert review
INSERT INTO [dbo].[review]
           ([carid], [customerid], [rating], [review_date], [review_text])
VALUES
           (3, 1, 4, '2024-01-20', 'Good car but needs better maintenance'),
           (6, 2, 5, '2024-02-12', 'Great car for family use'),
           (9, 3, 4, '2024-03-18', 'Reliable but fuel consumption is high');
-- insert image_car
INSERT INTO [dbo].[image_car]
           ([image1], [image2], [image3], [image4], [img_ownership_certificate1], [img_ownership_certificate2], [car_id])
VALUES
           ('FerrariF8Tributo.jpg', 'FerrariF8Tributo2.jpg', 'FerrariF8Tributo3.jpg', 'FerrariF8Tributo4.jpg', NULL,NULL, 1),
		   ('LamborghiniHuracan.jpg', 'LamborghiniHuracan2.jpg', 'LamborghiniHuracan3.jpg', 'LamborghiniHuracan4.jpg', NULL, NULL, 2),
		   ('Porsche911.jpg', 'Porsche911_2.jpg', 'Porsche911_3.jpg', 'Porsche911_4.jpg', NULL, NULL, 3),
           ('HondaCivic.jpg', 'HondaCivic2.jpg', 'HondaCivic3.jpg', 'HondaCivic4.jpg', NULL, NULL, 4),
		   ('ToyotaCamry.jpg', 'ToyotaCamry2.jpg', 'ToyotaCamry3.jpg', 'ToyotaCamry4.jpg', NULL, NULL, 5),
		   ('HyundaiTucson.jpg', 'HyundaiTucson2.jpg', 'HyundaiTucson3.jpg', 'HyundaiTucson4.jpg', NULL,NULL, 6),
           ('FordRanger.jpg', 'FordRanger2.jpg', 'FordRanger3.jpg', 'FordRanger4.jpg',NULL, NULL, 7),
           ('MazdaCX-5.jpg', 'MazdaCX-52.jpg', 'MazdaCX-53.jpg', 'MazdaCX-54.jpg', NULL, NULL, 8),
           ('ChevroletColorado.jpg', 'ChevroletColorado2.jpg', 'ChevroletColorado3.jpg', 'ChevroletColorado4.jpg', NULL, NULL, 9),
		   ('Ferrari488GTB.jpg', 'Ferrari488GTB2.jpg', 'Ferrari488GTB3.jpg', 'Ferrari488GTB4.jpg', NULL,NULL, 10),

		   ('Porsche918.jpg', 'Porsche918_2.jpg', 'Porsche918_3.jpg', 'Porsche918_4.jpg', NULL,NULL, 11),
		   ('LamborghiniSian.jpg', 'LamborghiniSian2.jpg', 'LamborghiniSian3.jpg', 'LamborghiniSian4.jpg', NULL,NULL, 12),
		   ('AudiQ8.jpg', 'AudiQ82.jpg', 'AudiQ83.jpg', 'AudiQ84.jpg', NULL,NULL, 13),
		   ('FordEverest.jpg', 'FordEverest2.jpg', 'FordEverest3.jpg', 'FordEverest4.jpg', NULL,NULL, 14);

go

INSERT INTO [dbo].[booking]
           ([address]
           ,[carid]
           ,[customer_name]
           ,[phone_number]
           ,[rental_day]
           ,[return_day]
           ,[status]
           ,[total_price])
     VALUES
            ('123 Main St', 1, 'Chi Hieu', '0909123456', '2024-12-01', '2024-12-05', 1, 3500000.00),
           ('456 Main St', 2, 'Ben', '0909765432', '2024-12-02', '2024-12-06', 1, 4200000.00),
           ('789 Main St', 3, 'Teo', '0909345678', '2024-12-03', '2024-12-07', 0, 2800000.00),
           ('123 Ho Chi Minh', 4, 'Vu', '0911002233', '2024-12-04', '2024-12-08', 1, 5000000.00),
           ('456 Ho Chi Minh', 5, 'Than', '0911223344', '2024-12-05', '2024-12-09', 0, 3100000.00),
           ('789 Ho Chi Minh', 6, 'Hieu', '0911334455', '2024-12-06', '2024-12-10', 1, 4500000.00),
           ('123 District 1', 7, 'Tai', '0911445566', '2024-12-07', '2024-12-11', 1, 3200000.00),
           ('456 District 2', 8, 'Hoang', '0911556677', '2024-12-08', '2024-12-12', 0, 4000000.00),
           ('789 District 3', 9, 'Quan', '0911667788', '2024-12-09', '2024-12-13', 1, 5100000.00),
           ('123 Binh Thanh', 10, 'Hung', '0911778899', '2024-12-10', '2024-12-14', 1, 6000000.00);
GO
INSERT INTO [dbo].[payment] 
           ([amount], [billid], [payment_date])
VALUES
           (250.00, 1, '2024-11-20'),
           (300.50, 2, '2024-11-21'),
           (150.75, 3, '2024-11-19');

           
GO
select * from car

select * from pending_car_post
select * from image_pending
select * from image_car
select * from review
select * from customer
select * from account
select * from document