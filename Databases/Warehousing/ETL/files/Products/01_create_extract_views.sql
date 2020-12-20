-- PRODUCT 
-- Extract Tables
-- Drop/create Views

use SEIS732_Team_09_Products;
go

-- drop existing views
drop view if exists Extract_RRV_Instance;
drop view if exists Extract_MMC;
drop view if exists Extract_Color;
drop view if exists Extract_Vehicle_Type;
drop view if exists Extract_MMC_Vehicle_Type;
drop view if exists Extract_FeatureSet;
go

-- create Extract_RRV_Instance
create view Extract_RRV_Instance as
select distinct
	FS_ID
	, CLR_ID
	, VT_ID
from RRV_Instance
; -- for joinining feature set
go

-- create Extract_MMC = make model color
create view Extract_MMC as
select
	MMC_ID
	, MMC_Make_Name					as PRD_Make_Name
	, MMC_Make_Desc					as PRD_Make_Description
	, MMC_Model_Name				as PRD_Model_Name
	, MMC_Model_Desc				as PRD_Model_Description
	, MMC_Class_Name				as PRD_Class_Name
	, MMC_Class_Desc				as PRD_Class_Description
from MMC
;
go

-- create Extract_Color
create view Extract_Color as
select
	CLR_ID							as PRD_Color_ID
	, CLR_Name						as PRD_Color_Name
	, CLR_Description				as PRD_Color_Description
from Color
;
go

-- create Extract_Vehicle_Type
create view Extract_Vehicle_Type as
select
	VT_Model_Year					as PRD_Model_Year
	, VT_ID							as PRD_VehicleType_ID
	, VT_Wholesale_Price			as PRD_Wholesale_Price
	, MMC_ID						as PRD_MMC_ID
from Vehicle_Type
;
go

-- create Extract_FeatureSet
create view Extract_FeatureSet as
select
	FS_ID
	, FS_Retail_Price				as PRD_Manufacturer_Suggested_Retail_Price
from FeatureSet
;
go
