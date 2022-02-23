# query pg

Code to query postgresql db using sqlalchemy.

```md
.oPYo. o    o .oPYo. oPYo. o    o      .oPYo. .oPYo. 
8    8 8    8 8oooo8 8  `' 8    8      8    8 8    8 
8    8 8    8 8.     8     8    8      8    8 8    8 
`YooP8 `YooP' `Yooo' 8     `YooP8      8YooP' `YooP8 
:....8 :.....::.....:..:::::....8 oooo 8 ....::....8 
:::::8 ::::::::::::::::::::::ooP'......8 :::::::ooP'.
:::::..::::::::::::::::::::::...:::::::..:::::::...::
```

First use pgadmin to import db into db = "dvdrental"
db is available at https://www.postgresqltutorial.com/postgresql-sample-database/
ERD = https://www.postgresqltutorial.com/wp-content/uploads/2018/03/printable-postgresql-sample-database-diagram.pdf

Can probably mix some visualizations into this easily enough.

I should add code to create tables;

```sql
create table aaa as
select
	title
	, length
from film;
```

