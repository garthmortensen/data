-- PRODUCT
-- Stage Tables
	-- drop/recreate the staging table
	-- extract from OLTP and load into staging table

-- Why use staging tables?
	-- allows us to get off the production system ASAP
	-- can adjust things if needed
	-- if you need to create SURK, easiest way is to create staging table and create the PK using a SURK

-- Products
use SEIS732_Team_09_Products;
go

-- drop existing tables
drop table if exists Staged_RRV_Instance;
drop table if exists Staged_MMC_Make;
drop table if exists Staged_MMC_Model;
drop table if exists Staged_MMC_Class;
drop table if exists Staged_Color;
drop table if exists Staged_Vehicle_Type;
drop table if exists Staged_FeatureSet;
go

-- create Staged_RRV_Instance
create table Staged_RRV_Instance
	(
	FS_ID						varchar(256)	not null
	, CLR_ID					bigint			not null
	, VT_ID						bigint			not null
	);
go

-- create Staged_MMC_Make
create table Staged_MMC_Make
	(
	MMC_ID						smallint		not null
	--, PRD_Make_Key				bigint			identity(1,1)	not null
	, PRD_Make_Name				varchar(40)		not null
	, PRD_Make_Description		varchar(256)	not null
	--, constraint PK_PRD_Make_Key primary key clustered (PRD_Make_Key ASC)
	);
go

-- create Staged_MMC_Model
create table Staged_MMC_Model
	(
	MMC_ID						smallint		not null
	, PRD_Model_Key				bigint			identity(1,1)	not null
	, PRD_Model_Name			varchar(40)		not null
	, PRD_Model_Description		varchar(256)	not null
	, constraint PK_PRD_Model_Key primary key clustered (PRD_Model_Key ASC)
	);
go

-- create Staged_MMC_Class
create table Staged_MMC_Class
	(
	MMC_ID						smallint		not null
	, PRD_Class_Key				bigint			identity(1,1)	not null
	, PRD_Class_Name			varchar(40)		not null
	, PRD_Class_Description		varchar(256)	not null
	, constraint PK_PRD_Class_Key primary key clustered (PRD_Class_Key ASC)
	);
go

-- create Staged_Color
create table Staged_Color
	(
	PRD_Color_Key				bigint			identity(1,1)	not null
	, PRD_Color_ID				bigint			not null
	, PRD_Color_Name			varchar(40)		not null
	, PRD_Color_Description		varchar(256)	not null
	, constraint PK_PRD_Color_Key primary key clustered (PRD_Color_Key ASC)
	);
go

-- create Staged_Vehicle_Type
create table Staged_Vehicle_Type
	(
	PRD_Model_Year				smallint		not null
	, PRD_VehicleType_ID		bigint			not null
	, PRD_Wholesale_Price		money			not null
	, PRD_MMC_ID				smallint		not null
	);
go

-- create Staged_FeatureSet
create table Staged_FeatureSet
	(
	FS_ID						varchar(256)	not null
	, PRD_Manufacturer_Suggested_Retail_Price	money			not null
	);
go
