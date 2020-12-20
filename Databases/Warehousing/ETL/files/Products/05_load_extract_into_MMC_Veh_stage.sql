-- PRODUCT
-- Load Extracts into Views
-- Extract from OLTP using extract_table and load into stage_table
-- using select into

-- this is taken care of by Data Flow Step in Visual Studio

-- Products
use SEIS732_Team_09_Products;
go

-- Staged_RRV_Instance
insert into Staged_MMC_Vehicle_Type
	(
	PRD_Model_Year
	, PRD_VehicleType_ID
	, PRD_Wholesale_Price
	, PRD_MMC_ID

	--, PRD_Make_Key
	, PRD_Make_Name
	, PRD_Make_Description

	, PRD_Model_Key
	, PRD_Model_Name
	, PRD_Model_Description

	, PRD_Class_Key
	, PRD_Class_Name
	, PRD_Class_Description
	)
select
	PRD_Model_Year
	, PRD_VehicleType_ID
	, PRD_Wholesale_Price
	, PRD_MMC_ID

	--, PRD_Make_Key
	, PRD_Make_Name
	, PRD_Make_Description

	, PRD_Model_Key
	, PRD_Model_Name
	, PRD_Model_Description

	, PRD_Class_Key
	, PRD_Class_Name
	, PRD_Class_Description
from Extract_MMC_Vehicle_Type;
go
