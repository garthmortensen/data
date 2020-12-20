-- Products
-- Join tables together

-- Sales_Org
use SEIS732_Team_09_Products;
go

drop view if exists Extract_MMC_Vehicle_Type;
drop table if exists Staged_MMC_Vehicle_Type;
go

-- create Extract join for MMC and Vehicle_Type
create view Extract_MMC_Vehicle_Type as
select
	
	veh.PRD_Model_Year
	, veh.PRD_VehicleType_ID
	, veh.PRD_Wholesale_Price
	, veh.PRD_MMC_ID

	--, mmck.PRD_Make_Key
	, mmck.PRD_Make_Name
	, mmck.PRD_Make_Description

	, mmcm.PRD_Model_Key
	, mmcm.PRD_Model_Name
	, mmcm.PRD_Model_Description

	, mmcc.PRD_Class_Key
	, mmcc.PRD_Class_Name
	, mmcc.PRD_Class_Description
from Staged_Vehicle_Type						as veh
left join Staged_MMC_Make						as mmck
	on veh.PRD_MMC_ID = mmck.MMC_ID
left join Staged_MMC_Model						as mmcm
	on veh.PRD_MMC_ID = mmcm.MMC_ID
left join Staged_MMC_Class						as mmcc
	on veh.PRD_MMC_ID = mmcc.MMC_ID
;
go

-- Staged_MMC_Vehicle_Type
create table Staged_MMC_Vehicle_Type
	(
	PRD_Model_Year				smallint		not null
	, PRD_VehicleType_ID		bigint			not null
	, PRD_Wholesale_Price		money			not null
	, PRD_MMC_ID				smallint		not null

	--, PRD_Make_Key				bigint			not null
	, PRD_Make_Name				varchar(40)		not null
	, PRD_Make_Description		varchar(256)	not null

	, PRD_Model_Key				bigint			not null
	, PRD_Model_Name			varchar(40)		not null
	, PRD_Model_Description		varchar(256)	not null

	, PRD_Class_Key				bigint			not null
	, PRD_Class_Name			varchar(40)		not null
	, PRD_Class_Description		varchar(256)	not null
	);
go
