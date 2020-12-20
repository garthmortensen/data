-- Join tables together

-- Sales_Org
use SEIS732_Team_09_Sales_Org;
go

-- join Staged tables
drop view if exists Extract_Joined;
go

create view Extract_Joined as
select
	terr.SORG_Domain_ID
	, terr.SORG_Domain_Name
	, terr.SORG_Domain_Manager_Name
	, area.SORG_Zone_Key
	, area.SORG_Zone_ID
	, area.SORG_Zone_Name
	, area.SORG_Zone_Manager_Name
	, dist.SORG_Region_Key
	, dist.SORG_Region_ID
	, dist.SORG_Region_Name
	, dist.SORG_Region_Manager_Name
	, concat(dist.SORG_Region_Name, '-', area.SORG_Zone_Name, '-', terr.SORG_Domain_Name)	as SORG_Full_Name
from Staged_Sales_Territory 				as terr
left join Staged_Sales_Area					as area
	on area.SORG_Zone_ID = terr.SORG_Zone_ID
left join Staged_Sales_District 			as dist
	on dist.SORG_Region_ID = area.SORG_Region_ID
;
go


-- create stage table before insert
drop table if exists Staged_Joined;
go

create table Staged_Joined
	(
	SORG_Key							bigint			identity(1,1)	not null
	, SORG_Domain_ID					smallint		not null
	, SORG_Domain_Name					varchar(60)		not null
	, SORG_Domain_Manager_Name			varchar(120)	not null
	, SORG_Zone_Key						bigint			not null
	, SORG_Zone_ID						smallint		not null
	, SORG_Zone_Name					varchar(60)		not null
	, SORG_Zone_Manager_Name			varchar(120)	not null
	, SORG_Region_ID					smallint		not null
	, SORG_Region_Name					varchar(60)		not null
	, SORG_Region_Manager_Name			varchar(120)	not null
	, SORG_Region_Key					bigint			not null
	, SORG_Full_Name					varchar(180)	not null
	, constraint PK_SORG_Key			primary key clustered (SORG_Key asc)
	);
go
