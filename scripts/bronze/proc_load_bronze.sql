/*
============================================================================================================
Stored Procedure : Load Bronze Layer (source -> bronze)
============================================================================================================
Script Purpose :
  This stored procedure loads the 'bronze' schema from external CSB files.
  It performs the following actions :
  - Truncates the bronze tables before loading data.
  - Uses the 'BULK INSERT' Command to load data from csv files to bronze tables .
Parameters :
  None 
This stored procedure does not accept any parameters or return any values .

Usage Example :
  EXEC bronze.load_bronze;
============================================================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time datetime,@end_time datetime,@batch_start_time datetime,@batch_end_time datetime;
	BEGIN TRY 
		SET @batch_end_time = GETDATE();
		PRINT'============================================================';
		PRINT'LOADING BRONZE LAYER';
		PRINT'============================================================';

		PRINT'----------------------------------------';
		PRINT'LOADING CRM TABLES';                      
		PRINT'----------------------------------------';
		SET @start_time = getdate();
		PRINT'>>TRUNCATING TABLE: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		from 'C:\Users\amit singh rawat\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
			);

		SET @end_time= getdate ();
		print'>>LOAD DURATION :'+cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar)+'seconds';
		print'---------------------------------'
		SET @start_time = getdate();
		PRINT'>>TRUNCATING TABLE:bronze.crm_prd_info ';
		TRUNCATE TABLE bronze.crm_prd_info

		BULK INSERT bronze.crm_prd_info
		from 'C:\Users\amit singh rawat\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time= getdate ();
		print'>>LOAD DURATION :'+cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar)+'seconds';
		print'---------------------------------'
		SET @start_time = getdate();
		PRINT'>>TRUNCATING TABLE:bronze.crm_sales_details ';
		TRUNCATE TABLE bronze.crm_sales_details
		BULK INSERT bronze.crm_sales_details
		from 'C:\Users\amit singh rawat\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
		PRINT'----------------------------------------';
		PRINT'LOADING ERP TABLES';
		PRINT'----------------------------------------';
		SET @end_time= getdate ();
		print'>>LOAD DURATION :'+cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar)+'seconds';
		print'---------------------------------'
		SET @start_time = getdate();
		PRINT'>>TRUNCATING TABLE:bronze.erp_cust_az12 ';
		TRUNCATE TABLE bronze.erp_cust_az12

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\amit singh rawat\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
		SET @end_time= getdate ();
		print'>>LOAD DURATION :'+cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar)+'seconds';
		print'---------------------------------'
		SET @start_time = getdate();
		PRINT'>>TRUNCATING TABLE :bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\amit singh rawat\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
		SET @end_time= getdate ();
		print'>>LOAD DURATION :'+cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar)+'seconds';
		print'---------------------------------'
		SET @start_time = getdate();
		PRINT'>>TRUNCATING TABLE:bronze.erp_px_cat_g1v2 ';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\amit singh rawat\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
	SET @batch_end_time = getdate();
	print'==================================================='
	print'LOADING BRONZE LAYER IS COMPLETED';
	print'TOTAL LOAD DURATION :'+ CAST (DATEDIFF(second,@batch_start_time,@batch_end_time) as nvarchar ) +'seconds';
	print'==================================================='
	END TRY
	BEGIN CATCH
	PRINT'========================================================'
	PRINT'ERROR OCCUR DURING BORNZE LAYER '
	PRINT'ERROR MESSAGE'+ ERROR_MESSAGE();
	PRINT'ERROR MESSAGE'+ CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT'ERROR MESSAGE'+ CAST(ERROR_STATE() AS NVARCHAR);
	PRINT'========================================================'

	END CATCH
END
