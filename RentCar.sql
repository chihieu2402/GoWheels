Create database RentCar;
Use RentCar;

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

INSERT INTO [dbo].[car_brand]
           ([brand_name])
     VALUES
           ('Ferrari'),
           ('Lamborghini'),
           ('Porsche');

GO