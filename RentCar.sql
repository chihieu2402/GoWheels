Create database RentCar;
Use RentCar;


GO
-- bảng account
Create database RentCar;
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

ALTER TABLE [dbo].[account]  WITH CHECK ADD CHECK  (([auth_type]>=(0) AND [auth_type]<=(2)))
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

ALTER TABLE [dbo].[bill]  WITH CHECK ADD  CONSTRAINT [FKduvsbt91e079yql89g7io0rt4] FOREIGN KEY([customerid])
REFERENCES [dbo].[customer] ([customerid])
GO

ALTER TABLE [dbo].[bill] CHECK CONSTRAINT [FKduvsbt91e079yql89g7io0rt4]
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

ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK1j4gjgtm2n9gvhmcwsmj00mm7] FOREIGN KEY([carid])
REFERENCES [dbo].[car] ([carid])
GO

ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK1j4gjgtm2n9gvhmcwsmj00mm7]
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

ALTER TABLE [dbo].[car_owner]  WITH CHECK ADD  CONSTRAINT [FK8dr7ig14t1euldtqevqn0f670] FOREIGN KEY([customerid])
REFERENCES [dbo].[customer] ([customerid])
GO

ALTER TABLE [dbo].[car_owner] CHECK CONSTRAINT [FK8dr7ig14t1euldtqevqn0f670]
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

ALTER TABLE [dbo].[customer]  WITH CHECK ADD  CONSTRAINT [FKass5qvmiyb6jsxaqjmk0mj4bw] FOREIGN KEY([accountid])
REFERENCES [dbo].[account] ([accountid])
GO

ALTER TABLE [dbo].[customer] CHECK CONSTRAINT [FKass5qvmiyb6jsxaqjmk0mj4bw]
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

ALTER TABLE [dbo].[image_car]  WITH CHECK ADD  CONSTRAINT [FK5ppiyn9bw9l086xylipo8p3d1] FOREIGN KEY([car_id])
REFERENCES [dbo].[car] ([carid])
GO

ALTER TABLE [dbo].[image_car] CHECK CONSTRAINT [FK5ppiyn9bw9l086xylipo8p3d1]
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

ALTER TABLE [dbo].[payment]  WITH CHECK ADD  CONSTRAINT [FK11qy73js2eheuoa5wlgm9jblw] FOREIGN KEY([billid])
REFERENCES [dbo].[bill] ([billid])
GO

ALTER TABLE [dbo].[payment] CHECK CONSTRAINT [FK11qy73js2eheuoa5wlgm9jblw]
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

ALTER TABLE [dbo].[review]  WITH CHECK ADD  CONSTRAINT [FKry6hyp71d3k629ky7rgl2lnxk] FOREIGN KEY([customerid])
REFERENCES [dbo].[customer] ([customerid])
GO

ALTER TABLE [dbo].[review] CHECK CONSTRAINT [FKry6hyp71d3k629ky7rgl2lnxk]
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


-- insert Dữ liệu
INSERT INTO [dbo].[account]
           ([auth_id]
           ,[auth_type]
           ,[password]
           ,[user_name])
     VALUES
           (0, 0, '123', 'chihieu2402'),
           (0, 1, '123', 'ben123'),
           (0, 2, '123', 'teo123');
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
           ('Ford');
GO
-- insert customer
INSERT INTO [dbo].[customer]
           ([accountid], [address], [customer_name], [gender], [idcard], [phone_number])
VALUES
           (1, '123 Main St', 'Chi Hieu', 'Male', '123456789', '0909123456'),
           (2, '456 Main St', 'Ben', 'Male', '987654321', '0909765432'),
           (3, '789 Main St', 'Teo', 'Male', '192837465', '0909345678');
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
           ('Hanoi', 'Ferrari F8', 'Sports', '30A-12345', 'Red', 'Luxury sports car', 
            '500km', NULL, '500km', '10L/100km', NULL, 5000.0, 1, 'Petrol', 'Automatic', 
            2020, 1, 1, NULL),
           ('Hanoi', 'Lamborghini Huracan', 'Sports', '30A-12346', 'Yellow', 'High-end sports car', 
            '400km', NULL, '400km', '12L/100km', NULL, 5500.0, 1, 'Petrol', 'Automatic', 
            2021, 2, 1, NULL),
           ('Hanoi', 'Porsche 911', 'Sports', '30A-12347', 'Blue', 'Top-class sports car', 
            '300km', NULL, '300km', '11L/100km', NULL, 6000.0, 1, 'Petrol', 'Automatic', 
            2022, 3, 1, NULL),
           ('Hanoi', 'Honda Civic', 'Sedan', '30A-22345', 'Black', 'Reliable sedan', 
            '500km', NULL, '500km', '7L/100km', NULL, 1500.0, 1, 'Petrol', 'Manual', 
            2020, 4, 2, NULL),
           ('Hanoi', 'Toyota Camry', 'Sedan', '30A-22346', 'White', 'Comfortable sedan', 
            '600km', NULL, '600km', '8L/100km', NULL, 2000.0, 1, 'Petrol', 'Automatic', 
            2019, 5, 2, NULL),
           ('Hanoi', 'Hyundai Tucson', 'SUV', '30A-22347', 'Gray', 'Versatile SUV', 
            '500km', NULL, '500km', '9L/100km', NULL, 1800.0, 1, 'Diesel', 'Automatic', 
            2021, 6, 2, NULL),
           ('Hanoi', 'Ford Ranger', 'Truck', '30A-32345', 'Red', 'Tough truck', 
            '700km', NULL, '700km', '10L/100km', NULL, 2500.0, 1, 'Diesel', 'Manual', 
            2020, 7, 3, NULL),
           ('Hanoi', 'Mazda CX-5', 'SUV', '30A-32346', 'Blue', 'Stylish SUV', 
            '600km', NULL, '600km', '8L/100km', NULL, 2300.0, 1, 'Petrol', 'Automatic', 
            2021, 8, 3, NULL),
           ('Hanoi', 'Chevrolet Colorado', 'Truck', '30A-32347', 'Black', 'Durable truck', 
            '800km', NULL, '800km', '12L/100km', NULL, 2800.0, 1, 'Diesel', 'Automatic', 
            2022, 9, 3, NULL);
go
-- insert bill
INSERT INTO [dbo].[bill]
           ([customer_name], [rental_day], [return_day], [status], [total_price], [customerid])
VALUES
           ('Chi Hieu', '2024-01-01', '2024-01-10', 1, 15000.0, 1),
           ('Ben', '2024-02-01', '2024-02-05', 1, 8000.0, 2),
           ('Teo', '2024-03-01', '2024-03-07', 1, 12000.0, 3);
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
           ('Ferrari LaFerrari.jpg', 'Ferrari F8 Tributo.jpg', 'Ferrari 488 GTB.jpg', 'Ferrari F8 Tributo.jpg', 'doc1.jpg', 'doc2.jpg', 1),
           ('Bugatti Veyron.jpg', 'Bugatti Divo.jpg', 'Bugatti Chiron.jpg', 'Bugatti Divo.jpg', 'doc3.jpg', 'doc4.jpg', 4),
           ('Ferrari 488 GTB.jpg', 'Ferrari F8 Tributo.jpg', 'Aston Martin DB11.jpg', 'Aston Martin DB11.jpg', 'doc5.jpg', 'doc6.jpg', 7);
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
           ('123 Main Street', 1, 'John Doe', '1234567890', '2024-11-21', '2024-11-25', 1, 200.50),
           ('456 Elm Street', 2, 'Jane Smith', '0987654321', '2024-11-22', '2024-11-26', 1, 300.75),
           ('789 Oak Avenue', 3, 'Michael Brown', '1112223334', '2024-11-23', '2024-11-27', 0, 150.25),
           ('321 Pine Lane', 4, 'Emily Davis', '2223334445', '2024-11-24', '2024-11-28', 1, 400.00),
           ('654 Maple Blvd', 5, 'Chris Wilson', '3334445556', '2024-11-25', '2024-11-29', 0, 250.50);
GO
INSERT INTO [dbo].[payment] 
           ([amount], [billid], [payment_date])
VALUES
           (250.00, 1, '2024-11-20'),
           (300.50, 2, '2024-11-21'),
           (150.75, 3, '2024-11-19')
           
GO

select * from car
select * from pending_car_post
select * from image_pending
select * from image_car