# -*- coding: utf-8 -*-
"""
Created on Wed Feb 23 17:37:15 2022

@author: morte

.oPYo. o    o .oPYo. oPYo. o    o      .oPYo. .oPYo.
8    8 8    8 8oooo8 8  `' 8    8      8    8 8    8
8    8 8    8 8.     8     8    8      8    8 8    8
`YooP8 `YooP' `Yooo' 8     `YooP8      8YooP' `YooP8reSQL
:....8 :.....::.....:..:::::....8 oooo 8 ....::....8
:::::8 ::::::::::::::::::::::ooP'......8 :::::::ooP'.
:::::..::::::::::::::::::::::...:::::::..:::::::gm.::

First use pgadmin to import db into db = "dvdrental"
db is available at https://www.postgresqltutorial.com/postgresql-sample-database/
ERD = https://www.postgresqltutorial.com/wp-content/uploads/2018/03/printable-postgresql-sample-database-diagram.pdf
"""


import pandas as pd
from sqlalchemy import create_engine
from pathlib import Path
import os  # for loading env variables
from dotenv import load_dotenv  # for loading env variables. pip install python-dotenv

home = Path.home() / ".env"
load_dotenv(home)
POSTGRES_USERNAME = os.getenv("postgres_username")
POSTGRES_PASSWORD = os.getenv("postgres_password")

# dialect+driver://username:password@host:port/db
engine = create_engine(f"postgresql://{POSTGRES_USERNAME}:{POSTGRES_PASSWORD}@localhost:5432/dvdrental")

query = """
        select
            a.title
            , a.fulltext
            , c.first_name
            , c.last_name
            , a.length
            , a.rating
        from film a
        inner join film_actor b
            on a.film_id = b.film_id
        inner join actor c
            on b.actor_id = c.actor_id
        -- reducing rows for simplicity
        where substring(title, 1, 1) in ('A', 'B')
        order by substring(title, 1, 1)
        """
film_df = pd.read_sql(query, engine)
