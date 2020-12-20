-- Extract from OLTP and load intl Star Schema
-- We can prototype that here, but to go across 2 databases, we'll need the dataflow tool

-- Sales_Org
use SEIS732_Team_09_Star_Schema;
go

-- clear table so you can run this multiple times
--delete from SALES_ORG;

-- create stage table before insert
set identity_insert SALES_ORG on;
go

insert into SALES_ORG
	(
	SORG_Key
	, SORG_Domain_ID
	, SORG_Domain_Name
	, SORG_Domain_Manager_Name
	, SORG_Zone_Key
	, SORG_Zone_ID
	, SORG_Zone_Name
	, SORG_Zone_Manager_Name
	, SORG_Region_ID
	, SORG_Region_Name
	, SORG_Region_Manager_Name
	, SORG_Region_Key
	, SORG_Full_Name
	)
	select
		SORG_Key
		, SORG_Domain_ID
		, SORG_Domain_Name
		, SORG_Domain_Manager_Name
		, SORG_Zone_Key
		, SORG_Zone_ID
		, SORG_Zone_Name
		, SORG_Zone_Manager_Name
		, SORG_Region_ID
		, SORG_Region_Name
		, SORG_Region_Manager_Name
		, SORG_Region_Key
		, SORG_Full_Name
from SEIS732_Team_09_Sales_Org.dbo.Staged_Joined;
go

