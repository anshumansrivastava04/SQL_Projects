EXEC bronze.load_bronze;
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
      BEGIN TRY
            SET @batch_start_time = GETDATE(); 
            PRINT '================================';
            PRINT 'Loading Bronze Layer';
            PRINT '================================';

            PRINT '--------------------------------';
            PRINT 'Loading CRM Tables';
            PRINT '--------------------------------';

            SET @start_time = GETDATE();
            PRINT 'TRUNCATE TABLE: bronze.crm_cust_info';
            TRUNCATE TABLE bronze.crm_cust_info;
            PRINT 'INSERT DATA INTO : bronze.crm_cust_info';
            BULK INSERT Bronze.crm_cust_info
            FROM '/var/opt/mssql/data/import/Datasets/source_crm/cust_info.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ','
            );
            SET @end_time = GETDATE();
            PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
            PRINT '--------------------------------';
           
            SET @start_time = GETDATE();
            PRINT 'TRUNCATE TABLE: bronze.crm_prd_info';
            TRUNCATE TABLE bronze.crm_prd_info;
            PRINT 'INSERT DATA INTO : bronze.crm_prd_info';
            BULK INSERT Bronze.crm_prd_info
            FROM '/var/opt/mssql/data/import/Datasets/source_crm/prd_info.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ','
            );
            SET @end_time = GETDATE();
            PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
            PRINT '--------------------------------';

            SET @start_time = GETDATE();
            PRINT 'TRUNCATE TABLE: bronze.crm_sales_details';
            TRUNCATE TABLE bronze.crm_sales_details;
            PRINT 'INSERT DATA INTO : bronze.crm_sales_details';
            BULK INSERT Bronze.crm_sales_details
            FROM '/var/opt/mssql/data/import/Datasets/source_crm/sales_details.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ','
            );
            SET @end_time = GETDATE();      
            PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';  
            PRINT '--------------------------------';
           

            PRINT '--------------------------------';
            PRINT 'Loading ERP Tables';
            PRINT '--------------------------------';

            SET @start_time = GETDATE();
            PRINT 'TRUNCATE TABLE: bronze.erp_loc_a101';
            TRUNCATE TABLE Bronze.erp_loc_a101;
            PRINT 'INSERT DATA INTO : bronze.erp_loc_a101';
            BULK INSERT Bronze.erp_loc_a101
            FROM '/var/opt/mssql/data/import/Datasets/source_erp/LOC_A101.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ','
            );
            SET @end_time = GETDATE();
            PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
            PRINT '--------------------------------';
           
            SET @start_time = GETDATE();
            PRINT 'TRUNCATE TABLE: bronze.erp_cust_az12';
            TRUNCATE TABLE Bronze.erp_cust_az12;
            PRINT 'INSERT DATA INTO : bronze.erp_cust_az12';
            BULK INSERT Bronze.erp_cust_az12
            FROM '/var/opt/mssql/data/import/Datasets/source_erp/CUST_AZ12.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ','
            );
            SET @end_time = GETDATE();
            PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
            PRINT '--------------------------------';

            SET @start_time = GETDATE();
            PRINT 'TRUNCATE TABLE: bronze.erp_px_cat_g1v2';
            TRUNCATE TABLE Bronze.erp_px_cat_g1v2;
            PRINT 'INSERT DATA INTO : bronze.erp_px_cat_g1v2';
            BULK INSERT Bronze.erp_px_cat_g1v2
            FROM '/var/opt/mssql/data/import/Datasets/source_erp/PX_CAT_G1V2.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ','
            );
            SET @end_time = GETDATE();
            PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
            PRINT '--------------------------------';
            SET @batch_end_time = GETDATE();
            PRINT '================================';
            PRINT 'Loading Bronze Layer is Completed';
            PRINT '  - Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
            PRINT '================================';  
        END TRY
        BEGIN CATCH
        PRINT '================================';
        PRINT 'ERROR OCCURRED WHILE LOADING BRONZE LAYER';
        PRINT 'ERROR MESSAGE:' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER:' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR MESSAGE:' + CAST (ERROR_STATE() AS NVARCHAR);
        PRINT '===============================';
        END CATCH


END;
