-- PRODUCT
-- Load Extracts into Views
-- Extract from OLTP using extract_table and load into stage_table
-- using select into

-- Products
use SEIS732_Team_09_Products;
go

-- Staged_RRV_Instance
insert into Staged_RRV_Instance
	(
	FS_ID	
    , CLR_ID
	, VT_ID
	)
select
	FS_ID	
	, CLR_ID
	, VT_ID
from Extract_RRV_Instance;
go

-- Staged_MMC_Make
insert into Staged_MMC_Make
	(
	MMC_ID						
    , PRD_Make_Name			
    , PRD_Make_Description
	)
select
	MMC_ID							
	, PRD_Make_Name			
	, PRD_Make_Description
from Extract_MMC;
go

-- Staged_MMC_Model
insert into Staged_MMC_Model
	(
	MMC_ID					
	, PRD_Model_Name		
	, PRD_Model_Description
	)
select
	MMC_ID					
	, PRD_Model_Name		
	, PRD_Model_Description
from Extract_MMC;
go

-- Staged_MMC_Class
insert into Staged_MMC_Class
	(
	MMC_ID					
	, PRD_Class_Name		
	, PRD_Class_Description
	)
select
	MMC_ID					
	, PRD_Class_Name		
	, PRD_Class_Description	
from Extract_MMC;
go

-- Staged_Color
insert into Staged_Color
	(
	PRD_Color_ID			
	, PRD_Color_Name		
	, PRD_Color_Description
	)
select
	PRD_Color_ID			
	, PRD_Color_Name		
	, PRD_Color_Description
from Extract_Color;
go

-- Staged_Vehicle_Type
insert into Staged_Vehicle_Type
	(
	PRD_Model_Year			
	, PRD_VehicleType_ID	
	, PRD_Wholesale_Price	
	, PRD_MMC_ID			
	)
select
	PRD_Model_Year			
	, PRD_VehicleType_ID	
	, PRD_Wholesale_Price	
	, PRD_MMC_ID			
from Extract_Vehicle_Type;
go

-- Staged_FeatureSet
insert into Staged_FeatureSet
	(
	FS_ID						
	, PRD_Manufacturer_Suggested_Retail_Price
	)
select
	FS_ID						
	, PRD_Manufacturer_Suggested_Retail_Price
from Extract_FeatureSet;
go

