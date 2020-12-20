/*
This sql verifies the pivot table: 
Midwest

corp or ind =
'Corporate'
'Independent'

It must be run in SEIS732_Team_09_Star_Schema db
Sql is written by 11900-Garth
*/


-- find regional sales, using appropriate filter conditions
select
	deal.DLR_State						as state
	, deal.DLR_Independent_Or_Corporate	as ind_corp
	, sum(sale.RRV_Transit_Fees)		as Total_Transit_Fees
	, sum(sale.RRV_Handling_Fees)		as Total_Handling_Fees
	, sum(sale.RRV_Processing_Fees)		as Total_Processing_Fees
from RRV_SALES		as sale
inner join DEALER	as deal
	on sale.DLR_Key = deal.DLR_Key
where deal.DLR_State in
	--('AZ', 'CA', 'NM', 'OR', 'WA') -- west
	('IA', 'MN', 'ND', 'SD', 'WI') -- midwest
	--('CT', 'ME', 'NH', 'NY', 'VT') -- east
and deal.DLR_Independent_Or_Corporate = 'Corporate'
group by deal.DLR_State
		, deal.DLR_Independent_Or_Corporate
order by deal.DLR_State
		, deal.DLR_Independent_Or_Corporate
;

