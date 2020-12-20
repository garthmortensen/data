-- Products
-- Extract from OLTP and load intl Star Schema
-- We can prototype that here, but to go across 2 databases, we'll need the dataflow tool

-- Products
use SEIS732_Team_09_Products;
go

-- create stage table before insert
drop view if exists Extract_Products_Final;
drop table if exists Staged_Products_Final;
drop view if exists check_colors_null;
go

-- create Extract join for Staged_MMC_Vehicle_Type and everything else
create view Extract_Products_Final as
select
	mmcvt.PRD_Model_Year
	, mmcvt.PRD_VehicleType_ID
	, mmcvt.PRD_Wholesale_Price
	, mmcvt.PRD_MMC_ID
	--, mmcvt.PRD_Make_Key
	, mmcvt.PRD_Make_Name
	, mmcvt.PRD_Make_Description
	, mmcvt.PRD_Model_Key
	, mmcvt.PRD_Model_Name
	, mmcvt.PRD_Model_Description
	, mmcvt.PRD_Class_Key
	, mmcvt.PRD_Class_Name
	, mmcvt.PRD_Class_Description
	-- sometimes color is null
	, coalesce(color.PRD_Color_Key, 0)				as PRD_Color_Key
	, coalesce(color.PRD_Color_ID, 0)				as PRD_Color_ID
	, coalesce(color.PRD_Color_Name, 'None')		as PRD_Color_Name
	, coalesce(color.PRD_Color_Description, 'None')	as PRD_Color_Description
	, featr.PRD_Manufacturer_Suggested_Retail_Price
from Staged_RRV_Instance				as instc  -- needs VT_ID
left join Staged_FeatureSet				as featr -- YES
	on instc.FS_ID = featr.FS_ID
left join Staged_Color					as color -- YES
	on instc.CLR_ID = color.PRD_Color_ID
left join Staged_MMC_Vehicle_Type		as mmcvt
	on instc.VT_ID = mmcvt.PRD_VehicleType_ID
;
go

-- Create stage (table)
create table Staged_Products_Final
	(
	PRD_Make_Key						bigint			identity(1,1)	not null
	, PRD_Make_Name						varchar(40)		not null
	, PRD_Make_Description				varchar(256)	not null
	, PRD_Model_Key						bigint			not null
	, PRD_Model_Name					varchar(40)		not null
	, PRD_Model_Description				varchar(256)	not null
	, PRD_Class_Key						bigint			not null
	, PRD_Class_Name					varchar(40)		not null
	, PRD_Class_Description				varchar(256)	not null
	, PRD_Color_Key						bigint			not null
	, PRD_Color_ID						bigint			not null
	, PRD_Color_Name					varchar(40)		not null
	, PRD_Color_Description				varchar(256)	not null
	, PRD_Model_Year					smallint		not null
	, PRD_VehicleType_ID				bigint			not null
	, PRD_Manufacturer_Suggested_Retail_Price			money			not null
	, PRD_Wholesale_Price				money			not null
	, PRD_MMC_ID						smallint		not null
	--, constraint PK_PRD_Make_Key primary key clustered (PRD_Make_Key ASC)
	);
go

-- add SURK
--alter table Staged_Products_Final add PRD_Make_Key bigint identity(1,1);
--go
-- i'm adding SURK at this final step because it repeats if added earlier
-- i'm keeping the SURKs for the other columns, since they relate to the original tables. 
-- I am not sure what the correct approach is.


-- check: why do null colors exist?
create view check_colors_null as
select distinct
	instance.CLR_ID								as PRD_Color_ID
from SEIS732_Team_09_Products.dbo.RRV_Instance		as instance
left join SEIS732_Team_09_Products.dbo.Color		as color
	on instance.CLR_ID = color.CLR_ID
where CLR_Name is null
;
go

-- answer: because RRV_Instance table contains color_ids not found in Color table
-- where CLR_ID in (40, 41, 42, 43, 4, 45, 46, 47, 48, 93)

--  then insert into stage