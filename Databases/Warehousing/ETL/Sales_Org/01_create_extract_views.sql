-- SALES_ORG
-- Extract Tables
-- Drop/create Views

-- Sales_Org
use SEIS732_Team_09_Sales_Org;
go

-- drop existing views
drop view if exists Extract_Sales_Mgr;
drop view if exists Extract_Sales_Territory;
drop view if exists Extract_Sales_Area;
drop view if exists Extract_Sales_District;
go

-- create Extract_Sales_Mgr
create view Extract_Sales_Mgr as
select
	MGR_ID
	, MGR_First_Name
	, MGR_Last_Name
from Sales_Mgr
;
go

-- create Extract_Sales_Territory = domain
create view Extract_Sales_Territory as
select
	ST_ID				as SORG_Domain_ID
	, SA_ID				as SORG_Zone_ID
	, ST_Name			as SORG_Domain_Name
	, case	when MGR_First_Name is not null and MGR_First_Name is not null
			then CONCAT(MGR_First_Name, ', ', MGR_Last_Name)
			else 'NO MANAGER' end
			as SORG_Domain_Manager_Name
from Sales_Territory terr
left join Extract_Sales_Mgr mgr
	on terr.MGR_ID = mgr.MGR_ID
;
go

-- create Extract_Sales_Area = area
create view Extract_Sales_Area as
select
	SA_ID			as SORG_Zone_ID
	, SD_ID			as SORG_Region_ID
	, SA_Name		as SORG_Zone_Name
	, case	when MGR_First_Name is not null and MGR_First_Name is not null
			then CONCAT(MGR_First_Name, ', ', MGR_Last_Name)
			else 'NO MANAGER' end
			as SORG_Zone_Manager_Name
from Sales_Area area
left join Extract_Sales_Mgr mgr
	on area.MGR_ID = mgr.MGR_ID
;
go

-- create Extract_Sales_District = region
create view Extract_Sales_District as
select
	SD_ID			as SORG_Region_ID
	, SD_Name		as SORG_Region_Name
	, case	when MGR_First_Name is not null and MGR_First_Name is not null
			then CONCAT(MGR_First_Name, ', ', MGR_Last_Name)
			else 'NO MANAGER' end
			as SORG_Region_Manager_Name
from Sales_District dist
left join Extract_Sales_Mgr mgr
	on dist.MGR_ID = mgr.MGR_ID
;
go

