-- Extract from OLTP and load intl Star Schema
-- We can prototype that here, but to go across 2 databases, we'll need the dataflow tool

-- PRODUCT
use SEIS732_Team_09_Star_Schema;
go

-- create stage table before insert
-- set identity_insert PRODUCT on;
-- go

insert into PRODUCT
	(
	PRD_Make_Key
	, PRD_Make_Name
	, PRD_Make_Description
	, PRD_Model_Key
	, PRD_Model_Name
	, PRD_Model_Description
	, PRD_Class_Key
	, PRD_Class_Name
	, PRD_Class_Description

	, PRD_Color_Key
	, PRD_Color_ID
	, PRD_Color_Name
	, PRD_Color_Description

	, PRD_Model_Year
	, PRD_VehicleType_ID
	, PRD_Manufacturer_Suggested_Retail_Price
	, PRD_Wholesale_Price
	, PRD_MMC_ID
	)
	select
		PRD_Make_Key
		, PRD_Make_Name
		, PRD_Make_Description
		, PRD_Model_Key
		, PRD_Model_Name
		, PRD_Model_Description
		, PRD_Class_Key
		, PRD_Class_Name
		, PRD_Class_Description

		, PRD_Color_Key
		, PRD_Color_ID
		, PRD_Color_Name
		, PRD_Color_Description

		, PRD_Model_Year
		, PRD_VehicleType_ID
		, PRD_Manufacturer_Suggested_Retail_Price
		, PRD_Wholesale_Price
		, PRD_MMC_ID
from SEIS732_Team_09_Products.dbo.Staged_Products_Final;
go




