-- SALES_ORG
-- Stage Tables
	-- drop/recreate the staging table
	-- extract from OLTP and load into staging table

-- Why use staging tables?
	-- allows us to get off the production system ASAP
	-- can adjust things if needed
	-- if you need to create SURK, easiest way is to create staging table and create the PK using a SURK

-- Sales_Org
use SEIS732_Team_09_Sales_Org;
go

-- drop existing tables
drop table if exists Staged_Sales_Mgr;
drop table if exists Staged_Sales_Territory;
drop table if exists Staged_Sales_Area;
drop table if exists Staged_Sales_District;
go

-- create Stage_Sales_Territory = domain
create table Staged_Sales_Territory
	(
	SORG_Domain_ID						smallint		not null	-- ST_ID
	, SORG_Zone_ID						smallint		not null	-- SA_ID
	, SORG_Domain_Name					varchar(60)		not null	-- ST_Name
	, SORG_Domain_Manager_Name			varchar(120)	not null	-- created in extract
	);
go

-- create Stage_Sales_Area = area
create table Staged_Sales_Area
	(
	SORG_Zone_ID						smallint		not null	-- SA_ID
	, SORG_Region_ID					smallint		not null	-- SD_ID
	, SORG_Zone_Name					varchar(60)		not null	-- SA_Name
	, SORG_Zone_Manager_Name			varchar(120)	not null	-- created in extract
	, SORG_Zone_Key						bigint			identity(1,1)	not null
	, constraint PK_Stage_Zone			primary key clustered (SORG_Zone_Key asc)
	);
go

-- create Stage_Sales_District = region
create table Staged_Sales_District
	(
	SORG_Region_ID						smallint		not null	-- SD_ID
	, SORG_Region_Name					varchar(60)		not null	-- SD_Name
	, SORG_Region_Manager_Name			varchar(120)	not null	-- created in extract
	, SORG_Region_Key					bigint			identity(1,1)	not null
	, constraint PK_Stage_Region		primary key clustered (SORG_Region_Key asc)
	);
go
