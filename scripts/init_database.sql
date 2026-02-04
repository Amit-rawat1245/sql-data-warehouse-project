/*
==========================================================================================================
Create Database and Schemas 
==========================================================================================================
Script purpose : 
          This scripts creates a new database named 'Datawarehouse' after checking if it already exists .
          If the database exists , it is dropped and recreated . Additionally , the script sets up there schemas within the database : 'bronze','silver','gold'.

Warning :
  Running this script wil drop the entire 'Datawarehouse' database if it exists.
  All the data in the database will be permanently deleted .
  Procerf with caution and ensure you have proper backups before running this script.
*/

USE master;
GO 

-- Drop and recreate the 'Datawarehouse' database
IF EXISTS (SELECT * FROM   sys.databases WHERE name = 'Datawarehouse')
BEGIN 
  ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE Datawarehouse;
END;
GO

-- Create the 'Datawarehouse' database 
CREATE DATABASE Datawarehouse;
GO 
USE Datawarehouse;
GO 
-- Create schemas 
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO 












