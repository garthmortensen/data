use SEIS732_Team_09_Star_Schema;
go

declare @count_SALES_ORG int
select @count_SALES_ORG=count(*) from SALES_ORG
if (@count_SALES_ORG<>72)
begin
declare @MSG as varchar(8000) = concat(char(10),
														'=====================================', char(10),
														'Error: SALES_ORG failed to load all expected values', char(10),
														'Expected count: 72', char(10),
														'Actual count: ', @count_SALES_ORG, char(10),
														'====================================='
);
	throw 50001,@MSG,1;
end

