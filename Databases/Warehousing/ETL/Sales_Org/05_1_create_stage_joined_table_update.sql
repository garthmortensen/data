-- Extract from OLTP and load intl Star Schema
-- We can prototype that here, but to go across 2 databases, we'll need the dataflow tool

-- Sales_Org
use SEIS732_Team_09_Sales_Org;
go

insert into Staged_Joined
	(
	SORG_Domain_ID
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
		SORG_Domain_ID
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
from Extract_Joined;
go





	


