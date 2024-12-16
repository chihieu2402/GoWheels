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
           ('Ferrari 488 GTB.jpg', 'Ferrari F8 Tributo.jpg', 'Aston Martin DB11.jpg', 'Aston Martin DB11.jpg', 'doc5.jpg', 'doc6.jpg', 7),
		     ('Ferrari LaFerrari.jpg', 'Ferrari F8 Tributo.jpg', 'Ferrari 488 GTB.jpg', 'Ferrari F8 Tributo.jpg', 'doc1.jpg', 'doc2.jpg', 2),
           ('Bugatti Veyron.jpg', 'Bugatti Divo.jpg', 'Bugatti Chiron.jpg', 'Bugatti Divo.jpg', 'doc3.jpg', 'doc4.jpg', 3),
           ('Ferrari 488 GTB.jpg', 'Ferrari F8 Tributo.jpg', 'Aston Martin DB11.jpg', 'Aston Martin DB11.jpg', 'doc5.jpg', 'doc6.jpg', 5),
		     ('Ferrari LaFerrari.jpg', 'Ferrari F8 Tributo.jpg', 'Ferrari 488 GTB.jpg', 'Ferrari F8 Tributo.jpg', 'doc1.jpg', 'doc2.jpg', 6),
           ('Bugatti Veyron.jpg', 'Bugatti Divo.jpg', 'Bugatti Chiron.jpg', 'Bugatti Divo.jpg', 'doc3.jpg', 'doc4.jpg', 8),
           ('Ferrari 488 GTB.jpg', 'Ferrari F8 Tributo.jpg', 'Aston Martin DB11.jpg', 'Aston Martin DB11.jpg', 'doc5.jpg', 'doc6.jpg', 9);


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
select * from review
select * from customer
select * from account

-- dữ liệu mới của ben thêm vào
-- account: 12 cái
INSERT INTO [dbo].[account] ([accountid], [username], [password])
VALUES 
(1, 'user_1', 'password123'),
(2, 'user_2', 'password123'),
(3, 'user_3', 'password123'),
(4, 'user_4', 'password123'),
(5, 'user_5', 'password123'),
(6, 'user_6', 'password123'),
(7, 'user_7', 'password123'),
(8, 'user_8', 'password123'),
(9, 'user_9', 'password123'),
(10, 'user_10', 'password123'),
(11, 'user_11', 'password123'),
(12, 'user_12', 'password123');

--customer : 12 cái, email ảo không dùng đc đâu
INSERT INTO [dbo].[customer] ([customerid], [accountid], [customer_name], [email], [phone_number], [gender], [address], [idcard], [license])
VALUES
(1, 1, 'Nguyen Thi Mai', 'mai.nguyen@gmail.com', '+84954885989', 'Female', '123 Hoang Hoa Tham, Hanoi', '123456789012', 'ABC12345'),
(2, 2, 'Tran Minh Tu', 'tu.tran@gmail.com', '+84908747304', 'Male', '45 Le Duan, Hanoi', '234567890123', 'DEF23456'),
(3, 3, 'Pham Minh Thao', 'thao.pham@gmail.com', '+84795234133', 'Female', '99 Tran Duy Hung, Hanoi', '345678901234', 'GHI34567'),
(4, 4, 'Le Thi Lan', 'lan.le@gmail.com', '+84516695139', 'Female', '56 Nguyen Chi Thanh, Hanoi', '456789012345', 'JKL45678'),
(5, 5, 'Hoang Thanh Long', 'long.hoang@gmail.com', '+84336482483', 'Male', '24 Cau Giay, Hanoi', '567890123456', 'MNO56789'),
(6, 6, 'Nguyen Thanh Son', 'son.nguyen@gmail.com', '+84986479599', 'Male', '22 Ba Trieu, Hanoi', '678901234567', 'PQR67890'),
(7, 7, 'Tran Minh Tu', 'tu.tran_7@gmail.com', '+84512638862', 'Male', '10 Phan Boi Chau, Hanoi', '789012345678', 'STU78901'),
(8, 8, 'Vu Thi Lan', 'lan.vu_8@gmail.com', '+84961639558', 'Female', '78 Le Thanh Nghi, Hanoi', '890123456789', 'VWX89012'),
(9, 9, 'Pham Thuy Dung', 'dung.pham9@gmail.com', '+84153674860', 'Female', '89 Hoang Hoa Tham, Hanoi', '901234567890', 'YZA90123'),
(10, 10, 'Ngo Quoc Duy', 'duy.ngo10@gmail.com', '+84983297862', 'Male', '12 Tran Thai Tong, Hanoi', '123012345678', 'BCD12345'),
(11, 11, 'Nguyen Thi Bao', 'bao.nguyen11@gmail.com', '+84986632934', 'Female', '65 Ba Trieu, Hanoi', '456123456789', 'EFG45678'),
(12, 12, 'Do Quang Minh', 'minh.do12@gmail.com', '+84992203076', 'Male', '34 Le Thanh Nghi, Hanoi', '567234567890', 'HIJ56789');

--bill : 5 cái
INSERT INTO [dbo].[bill] ([billid], [customerid], [total_amount], [bill_date])
VALUES
(1, 1, 319, '2024-04-27'),
(2, 2, 454, '2023-11-06'),
(3, 3, 461, '2024-11-22'),
(4, 4, 151, '2024-03-12'),
(5, 5, 283, '2024-12-07');

-- bill_detail: 5 cái
INSERT INTO [dbo].[bill_detail] ([bill_detail_id], [billid], [carid], [price], [quantity])
VALUES
(1, 1, 3, 71, 2),
(2, 2, 5, 56, 1),
(3, 3, 8, 56, 4),
(4, 4, 6, 74, 2),
(5, 5, 10, 86, 5);

--booking: 5 cái
INSERT INTO [dbo].[booking] ([bookingid], [customerid], [carid], [booking_date])
VALUES
(1, 2, 3, '2023-01-23'),
(2, 12, 5, '2023-08-15'),
(3, 3, 6, '2024-07-17'),
(4, 8, 7, '2024-09-04'),
(5, 9, 4, '2023-05-02');

-- car: 20 cái
INSERT INTO [dbo].[car] 
    ([carid], [location], [car_name], [car_type], [car_number], [color], [describe], [fee_limit], [image], [limit], [muctieuthu], 
     [ownership_document], [price_hours_car], [status], [type_fuel], [type_gear], [year_of_manufacture], [car_brandid], [ownerid], [license_id], [reviewid])
VALUES
(1, 'Hanoi', 'Toyota Corolla', 'Sedan', '29A-12345', 'Blue', 'Reliable family car', '500km/month', 'Toyota_Corolla.jpg', 'Yes', '7L/100km', 'doc1.pdf', 150, 1, 'Gasoline', 'Automatic', 2020, 1, 1, 101, 201),
(2, 'Hanoi', 'Honda Civic', 'Sedan', '29B-12346', 'Red', 'Sporty and stylish', '600km/month', 'Honda_Civic.jpg', 'No', '6.5L/100km', 'doc2.pdf', 180, 1, 'Gasoline', 'Manual', 2021, 1, 2, 102, 202),
(3, 'HCMC', 'Ford Focus', 'Hatchback', '29C-12347', 'White', 'Compact and efficient', '550km/month', 'Ford_Focus.jpg', 'Yes', '6L/100km', 'doc3.pdf', 170, 1, 'Gasoline', 'Automatic', 2019, 2, 3, 103, 203),
(4, 'HCMC', 'Chevrolet Malibu', 'Sedan', '29D-12348', 'Black', 'Stylish and comfortable', '500km/month', 'Chevrolet_Malibu.jpg', 'No', '7.5L/100km', 'doc4.pdf', 160, 1, 'Gasoline', 'Automatic', 2020, 2, 4, 104, 204),
(5, 'Da Nang', 'Nissan Altima', 'Sedan', '29E-12349', 'Silver', 'Modern design', '600km/month', 'Nissan_Altima.jpg', 'Yes', '7L/100km', 'doc5.pdf', 175, 1, 'Gasoline', 'Automatic', 2021, 3, 5, 105, 205),
(6, 'Da Nang', 'Hyundai Elantra', 'Sedan', '29F-12350', 'Gray', 'Fuel efficient', '650km/month', 'Hyundai_Elantra.jpg', 'No', '6L/100km', 'doc6.pdf', 150, 1, 'Gasoline', 'Manual', 2022, 3, 6, 106, 206),
(7, 'Hanoi', 'Mazda 3', 'Sedan', '29G-12351', 'Blue', 'Elegant and modern', '700km/month', 'Mazda_3.jpg', 'Yes', '6.8L/100km', 'doc7.pdf', 160, 1, 'Gasoline', 'Automatic', 2020, 4, 7, 107, 207),
(8, 'Hanoi', 'Kia Optima', 'Sedan', '29H-12352', 'White', 'Spacious interior', '550km/month', 'Kia_Optima.jpg', 'No', '7.2L/100km', 'doc8.pdf', 165, 1, 'Gasoline', 'Automatic', 2021, 4, 8, 108, 208),
(9, 'HCMC', 'Toyota Camry', 'Sedan', '29I-12353', 'Black', 'Premium and reliable', '500km/month', 'Toyota_Camry.jpg', 'Yes', '6.5L/100km', 'doc9.pdf', 200, 1, 'Gasoline', 'Automatic', 2022, 1, 9, 109, 209),
(10, 'HCMC', 'Honda Accord', 'Sedan', '29J-12354', 'Green', 'Comfortable ride', '600km/month', 'Honda_Accord.jpg', 'No', '7L/100km', 'doc10.pdf', 190, 1, 'Gasoline', 'Automatic', 2020, 1, 10, 110, 210),
(11, 'Da Nang', 'BMW 320i', 'Luxury Sedan', '29K-12355', 'Silver', 'Luxury performance', '800km/month', 'BMW_320i.jpg', 'Yes', '8L/100km', 'doc11.pdf', 350, 1, 'Gasoline', 'Automatic', 2022, 5, 11, 111, 211),
(12, 'Da Nang', 'Audi A4', 'Luxury Sedan', '29L-12356', 'Red', 'Sleek and sporty', '750km/month', 'Audi_A4.jpg', 'No', '7.5L/100km', 'doc12.pdf', 380, 1, 'Gasoline', 'Automatic', 2021, 5, 12, 112, 212),
(13, 'Hanoi', 'Mercedes-Benz A-Class', 'Luxury Sedan', '29M-12357', 'Gray', 'Ultimate luxury', '700km/month', 'Mercedes_A_Class.jpg', 'Yes', '7.2L/100km', 'doc13.pdf', 400, 1, 'Gasoline', 'Automatic', 2022, 6, 13, 113, 213),
(14, 'HCMC', 'Volkswagen Golf', 'Hatchback', '29N-12358', 'Blue', 'Compact and powerful', '650km/month', 'VW_Golf.jpg', 'No', '6.8L/100km', 'doc14.pdf', 220, 1, 'Gasoline', 'Automatic', 2021, 6, 14, 114, 214),
(15, 'Hanoi', 'Honda CR-V', 'SUV', '29O-12359', 'Black', 'Spacious and rugged', '700km/month', 'Honda_CRV.jpg', 'Yes', '7.8L/100km', 'doc15.pdf', 250, 1, 'Gasoline', 'Automatic', 2020, 2, 15, 115, 215),
(16, 'HCMC', 'Toyota RAV4', 'SUV', '29P-12360', 'Red', 'Compact SUV', '650km/month', 'Toyota_RAV4.jpg', 'No', '7.2L/100km', 'doc16.pdf', 260, 1, 'Gasoline', 'Automatic', 2021, 3, 16, 116, 216),
(17, 'HCMC', 'Ford Escape', 'SUV', '29Q-12361', 'Silver', 'Powerful engine', '750km/month', 'Ford_Escape.jpg', 'Yes', '7.5L/100km', 'doc17.pdf', 240, 1, 'Gasoline', 'Automatic', 2021, 2, 17, 117, 217),
(18, 'Da Nang', 'Nissan Rogue', 'SUV', '29R-12362', 'White', 'Stylish SUV', '600km/month', 'Nissan_Rogue.jpg', 'No', '7L/100km', 'doc18.pdf', 230, 1, 'Gasoline', 'Automatic', 2020, 4, 18, 118, 218),
(19, 'Da Nang', 'Chevrolet Equinox', 'SUV', '29S-12363', 'Gray', 'Modern and versatile', '700km/month', 'Chevy_Equinox.jpg', 'Yes', '6.9L/100km', 'doc19.pdf', 220, 1, 'Gasoline', 'Automatic', 2021, 4, 19, 119, 219),
(20, 'Hanoi', 'Mazda CX-5', 'SUV', '29T-12364', 'Blue', 'Stylish and efficient', '800km/month', 'Mazda_CX5.jpg', 'No', '7.1L/100km', 'doc20.pdf', 270, 1, 'Gasoline', 'Automatic', 2022, 5, 20, 120, 220);

-- car_brand : 5
INSERT INTO [dbo].[car_brand] ([car_brandid], [brand_name])
VALUES
(1, 'Toyota'),
(2, 'Honda'),
(3, 'Ford'),
(4, 'Chevrolet'),
(5, 'Mazda');

--car_owner : 5
INSERT INTO [dbo].[car_owner] ([owner_id], [customerid], [carid])
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

--document : 5
INSERT INTO [dbo].[document] ([license_id], [bhx], [gtx])
VALUES
(1, 'BHX123', 'GTX321'),
(2, 'BHX124', 'GTX322'),
(3, 'BHX125', 'GTX323'),
(4, 'BHX126', 'GTX324'),
(5, 'BHX127', 'GTX325');


--payment: 5
INSERT INTO [dbo].[payment] ([paymentid], [amount], [billid], [payment_date])
VALUES
(1, 319, 1, '2024-04-28'),
(2, 454, 2, '2023-11-07'),
(3, 461, 3, '2024-11-23'),
(4, 151, 4, '2024-03-13'),
(5, 283, 5, '2024-12-08');

--pending_car_post : 5
INSERT INTO [dbo].[pending_car_post] ([postid], [location], [car_name], [car_type], [car_number], [color], [describe], [fee_limit], [limit], [muctieuthu], [price_hours_car], [status], [type_fuel], [type_gear], [year_of_manufacture], [car_brandid], [customerid])
VALUES
(1, 'Hanoi', 'Toyota Corolla', 'Sedan', '29A-12345', 'Blue', 'Car in good condition, clean interior.', '500k/day', '500km', 'Eco', 100, 1, 'Petrol', 'Automatic', 2020, 1, 1),
(2, 'Ho Chi Minh', 'Honda Civic', 'Sedan', '29B-12346', 'Red', 'Well-maintained, no accidents.', '400k/day', '450km', 'Eco', 110, 1, 'Petrol', 'Manual', 2021, 2, 2),
(3, 'Da Nang', 'Ford Focus', 'Hatchback', '29C-12347', 'White', 'Recently serviced, new tires.', '450k/day', '400km', 'Eco', 95, 0, 'Petrol', 'Automatic', 2019, 3, 3),
(4, 'Hanoi', 'Chevrolet Malibu', 'Sedan', '29D-12348', 'Black', 'Family car, very spacious.', '600k/day', '550km', 'Eco', 120, 1, 'Diesel', 'Automatic', 2020, 4, 4),
(5, 'Hue', 'Nissan Altima', 'Sedan', '29E-12349', 'Silver', 'Good for long drives, low fuel consumption.', '550k/day', '500km', 'Eco', 115, 1, 'Petrol', 'Automatic', 2021, 5, 5);

-- review: 5
INSERT INTO [dbo].[review] ([reviewid], [carid], [customerid], [rating], [review_date], [review_text])
VALUES
(1, 1, 1, 4, '2024-04-28', 'Car runs smoothly, comfortable for city rides.'),
(2, 2, 2, 5, '2023-11-07', 'Great car! Fuel-efficient and very reliable.'),
(3, 3, 3, 3, '2024-11-23', 'Decent car, but not as powerful as I expected.'),
(4, 4, 4, 4, '2024-03-13', 'Nice car, although it could use a little more legroom.'),
(5, 5, 5, 5, '2024-12-08', 'Excellent condition and very spacious. Highly recommend!');

--user_role: 5
INSERT INTO [dbo].[user_role] ([user_id], [role_id])
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

--role: 5
INSERT INTO [dbo].[role] ([id], [name])
VALUES
(1, 'Admin'),
(2, 'Manager'),
(3, 'Customer'),
(4, 'Driver'),
(5, 'Support');


--image_car : 20
INSERT INTO [dbo].[image_car] ([image1], [image2], [image3], [image4], [img_ownership_certificate1], [img_ownership_certificate2], [car_id])
VALUES
('Toyota_Camry/1.jpg', 'Toyota_Camry/2.jpg', 'Toyota_Camry/3.jpg', 'Toyota_Camry/4.jpg', 'Toyota_Camry/1.jpg', 'Toyota_Camry/2.jpg', 1),
('Honda_Civic/1.jpg', 'Honda_Civic/2.jpg', 'Honda_Civic/3.jpg', 'Honda_Civic/4.jpg', 'Honda_Civic/1.jpg', 'Honda_Civic/2.jpg', 2),
('Mazda_3/1.jpg', 'Mazda_3/2.jpg', 'Mazda_3/3.jpg', 'Mazda_3/4.jpg', 'Mazda_3/1.jpg', 'Mazda_3/2.jpg', 3),
('Hyundai_Sonata/1.jpg', 'Hyundai_Sonata/2.jpg', 'Hyundai_Sonata/3.jpg', 'Hyundai_Sonata/4.jpg', 'Hyundai_Sonata/1.jpg', 'Hyundai_Sonata/2.jpg', 4),
('Ford_Focus/1.jpg', 'Ford_Focus/2.jpg', 'Ford_Focus/3.jpg', 'Ford_Focus/4.jpg', 'Ford_Focus/1.jpg', 'Ford_Focus/2.jpg', 5),
('Nissan_Altima/1.jpg', 'Nissan_Altima/2.jpg', 'Nissan_Altima/3.jpg', 'Nissan_Altima/4.jpg', 'Nissan_Altima/1.jpg', 'Nissan_Altima/2.jpg', 6),
('Chevrolet_Malibu/1.jpg', 'Chevrolet_Malibu/2.jpg', 'Chevrolet_Malibu/3.jpg', 'Chevrolet_Malibu/4.jpg', 'Chevrolet_Malibu/1.jpg', 'Chevrolet_Malibu/2.jpg', 7),
('Kia/1.jpg', 'Kia/2.jpg', 'Kia/3.jpg', 'Kia/4.jpg', 'Kia/1.jpg', 'Kia/2.jpg', 8),
('Volkswagen_Passat/1.jpg', 'Volkswagen_Passat/2.jpg', 'Volkswagen_Passat/3.jpg', 'Volkswagen_Passat/4.jpg', 'Volkswagen_Passat/1.jpg', 'Volkswagen_Passat/2.jpg', 9),
('BMW/1.jpg', 'BMW/2.jpg', 'BMW/3.jpg', 'BMW/4.jpg', 'BMW/1.jpg', 'BMW/2.jpg', 10),
('MercedesBenz_CClass/1.jpg', 'MercedesBenz_CClass/2.jpg', 'MercedesBenz_CClass/3.jpg', 'MercedesBenz_CClass/4.jpg', 'MercedesBenz_CClass/1.jpg', 'MercedesBenz_CClass/2.jpg', 11),
('Audi_A4/1.jpg', 'Audi_A4/2.jpg', 'Audi_A4/3.jpg', 'Audi_A4/4.jpg', 'Audi_A4/1.jpg', 'Audi_A4/2.jpg', 12),
('Lexus_ES/1.jpg', 'Lexus_ES/2.jpg', 'Lexus_ES/3.jpg', 'Lexus_ES/4.jpg', 'Lexus_ES/1.jpg', 'Lexus_ES/2.jpg', 13),
('Subaru/1.jpg', 'Subaru/2.jpg', 'Subaru/3.jpg', 'Subaru/4.jpg', 'Subaru/1.jpg', 'Subaru/2.jpg', 14),
('Toyota_Corolla/1.jpg', 'Toyota_Corolla/2.jpg', 'Toyota_Corolla/3.jpg', 'Toyota_Corolla/4.jpg', 'Toyota_Corolla/1.jpg', 'Toyota_Corolla/2.jpg', 15),
('Honda_Accord/1.jpg', 'Honda_Accord/2.jpg', 'Honda_Accord/3.jpg', 'Honda_Accord/4.jpg', 'Honda_Accord/1.jpg', 'Honda_Accord/2.jpg', 16),
('Mazda/1.jpg', 'Mazda_3/2.jpg', 'Mazda_3/3.jpg', 'Mazda_3/4.jpg', 'Mazda_3/1.jpg', 'Mazda_3/2.jpg', 17),
('Ford_2/1.jpg', 'Ford_2/2.jpg', 'Ford_2/3.jpg', 'Ford_2/4.jpg', 'Ford_2/1.jpg', 'Ford_Mustang/2.jpg', 18),
('Ford_3/1.jpg', 'Ford_3/2.jpg', 'Ford_3/3.jpg', 'Ford_3/4.jpg', 'Ford_3/1.jpg', 'Chevrolet_Camaro/2.jpg', 19),
('Dodge_Charger/1.jpg', 'Dodge_Charger/2.jpg', 'Dodge_Charger/3.jpg', 'Dodge_Charger/4.jpg', 'Dodge_Charger/1.jpg', 'Dodge_Charger/2.jpg', 20);


--image_pending: 20
INSERT INTO [dbo].[image_pending] ([image1], [image2], [image3], [image4], [img_ownership_certificate1], [img_ownership_certificate2], [vehicle_id])
VALUES
('Toyota_Camry/1.jpg', 'Toyota_Camry/2.jpg', 'Toyota_Camry/3.jpg', 'Toyota_Camry/4.jpg', 'Toyota_Camry/1.jpg', 'Toyota_Camry/2.jpg', 1),
('Honda_Civic/1.jpg', 'Honda_Civic/2.jpg', 'Honda_Civic/3.jpg', 'Honda_Civic/4.jpg', 'Honda_Civic/1.jpg', 'Honda_Civic/2.jpg', 2),
('Mazda_3/1.jpg', 'Mazda_3/2.jpg', 'Mazda_3/3.jpg', 'Mazda_3/4.jpg', 'Mazda_3/1.jpg', 'Mazda_3/2.jpg', 3),
('Hyundai_Sonata/1.jpg', 'Hyundai_Sonata/2.jpg', 'Hyundai_Sonata/3.jpg', 'Hyundai_Sonata/4.jpg', 'Hyundai_Sonata/1.jpg', 'Hyundai_Sonata/2.jpg', 4),
('Ford_Focus/1.jpg', 'Ford_Focus/2.jpg', 'Ford_Focus/3.jpg', 'Ford_Focus/4.jpg', 'Ford_Focus/1.jpg', 'Ford_Focus/2.jpg', 5),
('Nissan_Altima/1.jpg', 'Nissan_Altima/2.jpg', 'Nissan_Altima/3.jpg', 'Nissan_Altima/4.jpg', 'Nissan_Altima/1.jpg', 'Nissan_Altima/2.jpg', 6),
('Chevrolet_Malibu/1.jpg', 'Chevrolet_Malibu/2.jpg', 'Chevrolet_Malibu/3.jpg', 'Chevrolet_Malibu/4.jpg', 'Chevrolet_Malibu/1.jpg', 'Chevrolet_Malibu/2.jpg', 7),
('Kia_Optima/1.jpg', 'Kia_Optima/2.jpg', 'Kia_Optima/3.jpg', 'Kia_Optima/4.jpg', 'Kia_Optima/1.jpg', 'Kia_Optima/2.jpg', 8),
('Volkswagen_Passat/1.jpg', 'Volkswagen_Passat/2.jpg', 'Volkswagen_Passat/3.jpg', 'Volkswagen_Passat/4.jpg', 'Volkswagen_Passat/1.jpg', 'Volkswagen_Passat/2.jpg', 9),
('BMW_3Series/1.jpg', 'BMW_3Series/2.jpg', 'BMW_3Series/3.jpg', 'BMW_3Series/4.jpg', 'BMW_3Series/1.jpg', 'BMW_3Series/2.jpg', 10),
('MercedesBenz_CClass/1.jpg', 'MercedesBenz_CClass/2.jpg', 'MercedesBenz_CClass/3.jpg', 'MercedesBenz_CClass/4.jpg', 'MercedesBenz_CClass/1.jpg', 'MercedesBenz_CClass/2.jpg', 11),
('Audi_A4/1.jpg', 'Audi_A4/2.jpg', 'Audi_A4/3.jpg', 'Audi_A4/4.jpg', 'Audi_A4/1.jpg', 'Audi_A4/2.jpg', 12),
('Lexus_ES/1.jpg', 'Lexus_ES/2.jpg', 'Lexus_ES/3.jpg', 'Lexus_ES/4.jpg', 'Lexus_ES/1.jpg', 'Lexus_ES/2.jpg', 13),
('Subaru_Impreza/1.jpg', 'Subaru_Impreza/2.jpg', 'Subaru_Impreza/3.jpg', 'Subaru_Impreza/4.jpg', 'Subaru_Impreza/1.jpg', 'Subaru_Impreza/2.jpg', 14),
('Toyota_Corolla/1.jpg', 'Toyota_Corolla/2.jpg', 'Toyota_Corolla/3.jpg', 'Toyota_Corolla/4.jpg', 'Toyota_Corolla/1.jpg', 'Toyota_Corolla/2.jpg', 15),
('Honda_Accord/1.jpg', 'Honda_Accord/2.jpg', 'Honda_Accord/3.jpg', 'Honda_Accord/4.jpg', 'Honda_Accord/1.jpg', 'Honda_Accord/2.jpg', 16),
('Mazda_MX5/1.jpg', 'Mazda_MX5/2.jpg', 'Mazda_MX5/3.jpg', 'Mazda_MX5/4.jpg', 'Mazda_MX5/1.jpg', 'Mazda_MX5/2.jpg', 17),
('Ford_Mustang/1.jpg', 'Ford_Mustang/2.jpg', 'Ford_Mustang/3.jpg', 'Ford_Mustang/4.jpg', 'Ford_Mustang/1.jpg', 'Ford_Mustang/2.jpg', 18),
('Chevrolet_Camaro/1.jpg', 'Chevrolet_Camaro/2.jpg', 'Chevrolet_Camaro/3.jpg', 'Chevrolet_Camaro/4.jpg', 'Chevrolet_Camaro/1.jpg', 'Chevrolet_Camaro/2.jpg', 19),
('Dodge_Charger/1.jpg', 'Dodge_Charger/2.jpg', 'Dodge_Charger/3.jpg', 'Dodge_Charger/4.jpg', 'Dodge_Charger/1.jpg', 'Dodge_Charger/2.jpg', 20);
