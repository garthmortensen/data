-- Load Extracts into Views
-- Extract from OLTP using extract_table and load into stage_table
-- using select into

-- Sales_Org
use SEIS732_Team_09_Sales_Org;
go

-- Staged_Sales_Territory
insert into Staged_Sales_Territory
	(
	SORG_Domain_ID
	, SORG_Zone_ID
	, SORG_Domain_Name
	, SORG_Domain_Manager_Name
	)
select
	SORG_Domain_ID
	, SORG_Zone_ID
	, SORG_Domain_Name
	, SORG_Domain_Manager_Name
from Extract_Sales_Territory;
go

-- Staged_Sales_Area
insert into Staged_Sales_Area
	(
	SORG_Zone_ID
	, SORG_Region_ID
	, SORG_Zone_Name
	, SORG_Zone_Manager_Name
	)
select
	SORG_Zone_ID
	, SORG_Region_ID
	, SORG_Zone_Name
	, SORG_Zone_Manager_Name
from Extract_Sales_Area;
go

-- Staged_Sales_District
insert into Staged_Sales_District
	(
	SORG_Region_ID
	, SORG_Region_Name
	, SORG_Region_Manager_Name
	)
select
	SORG_Region_ID
	, SORG_Region_Name
	, SORG_Region_Manager_Name
from Extract_Sales_District;
go
