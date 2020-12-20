# Datawarehousing Notes Half 1
2020.09.15

## OLTP Database Review

- Data Models (ERD types)
  - **Conceptual** Data Model (CDM) - focused on the what. Highest level relations between entities
    - Includes the important entities and the relationships among them
    - No attribute is specified
    - No primary key is specified
    - Contains metadata (MD - data about data)
      - In oracle or SQL server, you find MD in the data dictionary (data about data)
    - Once you have conceptual, you can generate logical
  - **Logical** Data Model (LDM) -  describes the data in as much detail as possible, but ignores physical implementation
    - Focus of this course
    - Includes all entities and relationships among them
    - All attributes for each entity are specified
    - The primary key for each entity is specified
    - Foreign keys (keys identifying the relationship between different entities) are specified
    - Normalization occurs at this level
    - Once you have logical, you can generate physical
  - **Physical** Data Model (PDM)- implementation details. Shows all table structures, including column names, data types, constraints, PK, FK, and table relationships
    - Data types may be $
      - On DB2, that might be "money"
      - On Oracle, might be "dollar"
      - MS SQL Server 2017 might be...

Conceptual model vs Logical model vs Data model

| ERD feature   | Conceptual | Logical  | Physical |
| ------------- | ---------- | -------- | -------- |
| Entity (name) | Yes        | Yes      | Yes      |
| Relationship  | Yes        | Yes      | Yes      |
| Column        |            | Yes      | Yes      |
| Column's Type |            | Optional | Yes      |
| PK            |            |          | Yes      |
| FK            |            |          | Yes      |

- **Is-a inheritance**
- subtype/supertype inheritance
  
- an x/d/o inside indicates
  
  - x - mutually exclusive (x-or) = d - disjoint (same as x)
      - Vehicle to boat / Vehicle to car
        - Vehicles cannot be boats and cats
  
  - o - overlap
      - Person to student / Person to employee
        - People can be students AND employees
  
- Total/partial **participation**

  - google it

- ACID Transactions

  - Atomic
  - Consistent
  - Isolated
  - Durable
  - You don't want to deposit money into a savings account and have the money disappear (inconsistent). 
    - If you have mandatory relationship on both sides, you can't insert rows into 2 different tables at the same time. You need to have a transaction to wrap those into a logical unit of work. It only needs to be consistent when you commit the transaction.
    - For read-write-read-write, you need a lock. Deadlocks and livelocks
    - Serializability. As long as the operations are done in such as way they're equivalent to a serial schedule, it's as if transaction 1 ran before transaction 2, or vice versa. This means no need for locks. 
      - 3NF makes it easier to have serialization

- **3NF** - if one column is partially dependent on another - not 3NF. If you know the value of one column, you might know the value of a another. So, in a single table, you have ZIP code, county, state, you might know higher level in hierarchy, such as country. You'd need to normalize it out by creating a separate tables for county, state, and country.

- Data Model Tools

  - [Erwin](https://erwin.com/)
  - [PowerDesigner](https://www.sap.com/products/powerdesigner-data-modeling-tools.html)

## Git Review

- distributed version control and git
- fundamental terms
  - commit
  - repository
  - bare repository
  - branch
- basic operations
  - check in
  - check out
  - branching
  - merging
- git specifics
  - HEAD
  
  - branch
  
  - init
  
  - push
  
  - fetch - downloads commits, files, and refs from a remote repo into your local repo. Use fetch to **see what everybody else has been working on**. **It doesn’t force you to actually merge the changes into your repo.** 
  
    `git pull` and `git fetch` download content from a remote repo. `git fetch` the 'safe' version. It downloads the remote content, but **doesn't update your local repo's working state**, leaving your current work intact. `git pull` is the more aggressive alternative; it will download the remote content for the active local branch and immediately execute `git merge` to create a merge commit for the new remote content.

## Lecture 01

### 01-A - None

### 01-B - Big Picture

*15 pages*

- why do a Data Warehousing Environment (DWE)?

  > - Business users often ask simple questions that require complex processing to answer
  >   - Companies can have information buried across different databases (marketing on Oracle, sales on DB2), each with their own data models. You might have 40k customers in marketing, 60k in sales. This gives an opportunity to game the system. See next question.
  >
  > 

- what do companies without a DWE do now?

  > They use OLTP. See next question.

- why is OLTP not the "right way" for business users to try to answer their "simple questions"

  > Imagine you're asked to answer "how many blue cars were sold in the midwest." How do you define midwest? Ok, let's say ND, SD, WI, MN, IA. But what is sales? Sales by dealer in those states? Or if the customer live in those states? 
  >
  > ```sqlite
  > select clname, count(*)
  > from tbl_sales
  > (now join from tbl_color to tbl_RRV_Instance to tbl_Allocated to tbl_Sold)
  > where state is in (....)
  > and month is in "year(2020)" and "month*(9)"
  > and ...
  > and ...
  > order by state
  > ```
  >
  > 4 tables, 3 joins. If you forgot one of the joins, you get cartesian product (1 row for every row in first table by every row in second table). Result:
  >
  > 1. Will lock the tables and take a very long time to run. That might mean no sales can be entered into Sales table for the entire time.
  > 2. Could crash the system
  > 3. Wrong answer, but you might not know, resulting in a terrible decision.
  >
  > It's a lot of hop scotch. Typical business user might not be able to do it.
  >
  > What if the **question is modified**? The SQL would need to be edited. You need to be very careful of changing values, cartesian products, additional joins. Region is user-defined, which means changing definition. Other definitions are up to the person answering the question as well.
  >
  > What about the **buying a competitor**? They won't have the same database with same data model. Two people asked to draw a tree will draw very different trees. Same goes with database creation. 
  >
  > You can't join SQL Server to DB2 and Oracle db. 
  >
  > What about **international company**? Different currencies, euro exchange rates over time, time zones, metric vs imperial. Now write your query.
  >
  > What about **database being accessible**? Write a large query and company has to wait for it to finish? Unacceptable.
  >
  > What if a **customer moves from WI to TX to MN**? Try to count sales now. One row per customer. If the customer bought something in each state, and you rerun the report in 2006 and 2009, the values will change. You lose your history.
  >
  > OLTP is not user friendly. USA country code might be integar 23, since it is smaller in size.
  >
  > **This is unmanageable**. 
  >
  > So? Use a Multi-Dimensional Model (MDM).
  >
  > In summary, **OLTP is not ideal** for answering questions.
  >
  > 	1. There will be several different models.
  > 	2. They will be modeled incompatibly.
  > 	3. They'll have different:
  > 	  	1. names
  > 	  	2. cardinalities
  > 	  	3. rules
  > 	  	4. data formats
  > 	       	1. physical formats (Oracle, SQL Server, DB2)
  > 	       	2. logical formats (flat file dbs vs object oriented dbs vs relational dbs)
  > 	  	5. good luck joining across disparate dbs that span space and time
  > 	  	6. you need to deal with international companies dealing with unit conversions
  > 	  	7. overwrites are not the ideal way of doing things. If a customer moves 3 or 4 times in a traditional OLTP db (like class 630), all sales that were done in the past will be tied to their current address. MN sales are not reflected as TX sales. We've lost all history.
  >
  > **So how to improve model? How do we fix the issues?**
  >
  > We have to play hop scotch to join.
  >
  > We have to call functions to convert serial datetime to year month day values.
  >
  > We need to save versions to track when a customer moves. Sales should follow the version of the customer.
  >
  > **01-C - What is a Data Warehouse - is the answer to this question.** This gives us the better system for answering business questions.

### 01-C

*16 pages*

- this has a lot of important foundational concepts that we use throughout the course

- the first brief introduction to two different architectures for an DWE
  - Bill Inmon's world

    > Bill Inmon is the father of DW. His definition:
    >
    > > *"A data warehouse is a subject-oriented, integrated, time-variant, non-volatile collection of data in support of management's decisions."*
    > >
    > > *"A data warehouse is the central point of data integration for business intelligence and is the source of data for the data marts, delivering a common view of enterprise data."*
    >
    > **subject-oriented** = "From the Business User's Point of View" as opposed to Application-Oriented. The 630 models are great for running models, but not useful for business users to understand the business. Subject oriented is from the business users point of view. Imagine doing the a 7-join hop scotch.
    >
    > **integrated** = Combine and Cleanse data from different (and dirty) sources. We have different databases that we need to combine, but it requires transforming the state MN in db1 and Minnesota in db2 into the same value. Two dbs could have different member addresses.  
    >
    > **time-variant** = (not often seen in OLTP). each data value has an associated time - we are capturing a data as a **snapshot** in time. See the value of an attribute at any time. 
    >
    > Looking at the table below, you would say "use CKey 123 from Jan to July 2007 and 124 from July to Dec 2020."
    >
    > Where did Alice live July 2010? Time-variant gives you the ability to answer this.
    >
    > **non-volatile** = (not often seen in OLTP). not real-time--new data is a supplement not a replacement. Instead of doing Insert Update and Delete in DW, we're going to create new versions instead. Alice v1, Alice v2, Alice v3. Like version control over time. Don't update in place, **append**!
    >
    > | CKey | CID  | CName | CState |
    > | ---- | ---- | ----- | ------ |
    > | 1    | 1    | Alice | MN     |
    > | 2    | 1    | Alice | WI     |
    >
    > We add CKey in and it creates a new version of the same row. this is a slowly changing dimension (SCD) type 2. This is like version control for data.
    >
    > **Non-volatile means data does not get overwritten.** 
    >
    > BUT now if you reference CID1 in a join, you get a partial-cartesian product. That defeats the subject-oriented (business user friendly) approach, so this isn't how we actually do it. You would need to attach a timestamp to overcome this, for example.

    - What is a Datamart then?

    > - "mini-data warehouse" - NOT enterprise wide
    > - Might be specific to "Sales"
    > - Smaller schema and smaller data contained. Perhaps the entire DW has sales, billing, manufacturing. The datamart might just be sales, and perhaps only midwest sales 2018.
    >
    > You need a DW to look across the enterprise and combine sales with inventory and billing. But sometimes you just want to focus on subset such as midwest sales over past 3 years.

  - Ralph Kimball's world

    >> *"A Data Mart is a subject-oriented, integrated, time-variant, non-volatile collection of data used to support the strategic decision-making process for the enterprise"*
    >
    >This is the same definition of Inmon's DW, but replace DW with DM, basically.
    >
    >> "A DW is merely the collection (union) of all Data Marts in the Enterprise"
    >
    >Logical union, not physical. You have to build the DM correctly so they can be meaningfully be put together. They must be logically compatible. 
    >
    >Imagine you need to build a big computer.
    >
    >Inmon would build a big computer by building a mainframe or a supercomputer. One big all knowing thing. You also need to have dumb terminals though, bc people can't use the supercomputer. These datamarts are the interfaces.
    >
    >Kimball would build a cluster or a cloud. It's hundreds or thousands of commodity computers. This requires difficult architecture, configuration, admin, networking. In the same way, you can't just combine many together. If you took all the DM away, there would be no DW.
    >
    >In Inmon's world, there's actually a physical machine you can point to and say "that's the DW". Not so in Kimball's world.
    >
    > 

- **the four defining characteristics of a DWE**

  > If we ignore the knitty gritty details, the overlapping concept is: subject-oriented, integrated, time-variant, non-volatile. See above.


## Lecture 02 Multidimensional Modelling
This has a lot of important foundational concepts that we use throughout the course.

An MDM is like 630, where when we built the db we said "talk to the stakeholder. Find out about the thing you're trying to build the db after. Look for the:

1. nouns (**entities**)
2. adjectives (**attributes**)
3. verbs (**relationships**). 

Then you start building ERD, doing normalization.

In DW, you're not looking for entities, attributes and relationships. Instead, you're looking for:

1. Facts (**FACT**, measures) - simplified, a value that is observed or measured. You can't know it ahead of time, but you want to analyze. It's possibly unpredictable or changeable, so we want to measure it. 
2. Dimensional attribute (**DATT**) - a contextual detail that applies to facts. 

Same tools as 630, used in a different way.

### 02-A

*34 pages*

- **DATTs** are grouped together. 
  - Groupings are called **DIMs** (dimensions).
    - State, city, zip code (customer address dimension)
    - Color, make, model (product dimension)
- **FACTs** are grouped together into a fact table.
- **AGGs** are summarized facts, using aggregated functions. 

We build up our model using these tables. From FACTs and DATTs into fact and dimension tables.

<img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\pivot.png" alt="pivot" style="zoom: 75%;" />

You can visualize these as a pivot table. Above, we see Product dimension and Sales Date dimension. FACT is sales amount, which is AGGed together here.

You can visualize these as a data **Cube**.

![cube](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\cube.png)

In a cube, 

* **DIMs** are the axes
* **FACTs** and **AGGs** live inside the cells.

Each cell can contain one or more FACT and one ore more AGG. You can imagine each of these is an array.

```python
sales[0][0][0].sales_amount
```

So how do you answer questions? Just find the coordinate.

![cube_slice](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\cube_slice.png)

The **grain** is the smallest **DIM**.

Year -> Month -> **Day**
Make -> Model -> **Item**
Region -> State -> **City**

Per day, per item, per city.

By "freezing" specific values for some DIMs and "spanning" all values for some other DIMs, we can **Slice and Dice** the cube. When we load our model into the DWE, we can calc ahead of time and store them. Or calc on the fly. Or calc on the fly and save it for future use (best). In 2020, values from 2009 aren't going to change, so just cache it. This lets us control the time (processing) vs space (memory) trade-off.

Now, instead of writing 5-hop join query, we just write a very simple query that fills in that cell. If the question changes, easy to adjust! 

We can **roll up** or **drill down** to find the details supporting the AGG results. We're only limited by the **level of the granularity.**

**Hypercube** (aka tesseract) is a 4D cube. You can increase to ND. Kline bottle.

Long discussion on splitting dimensions. Split it from YYYYMMDDHH to a YYYY, MM, DD, HH and the data size reduces dramatically. 

Finally, here is a visual of what a **Star Schema** is. The **Fact** table is in the center, and **Dims** surround it.

![star](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\star.png)

### 02-B

*8 pages*

- OLTP versus OLAP

  - OLTP (Online Transaction Processing) - the focus of 630 db design. 
    - Models created to be efficient for processing transactions by the applications that we write. 
    - Tend to use small names for tables, columns, etc. 
    - Efficient data types (dates stored as 32-bit integer epoch, bools for true/false).
    - Support ACID
    - Normalization (3NF or higher), serializability (underlying transactions be interleaved, but still return a schedule that is logically equivalent to serialized), avoid locking.
  - OLAP (Online Analytical Processing) - focus to support the business user.
    - efficiently access business info that's been transformed from raw data into a dimensional view of the enterprise.
    - provide a and consistent results to queries and reports, using the vocabulary of the multidimensional model.
    - It's built for slicing and dicing, as well as rollups and drilldowns.

- Transactional versus Analytical

  - **Transactional**

    - Relational
    - SQL-based
    - Accesses **row-at-a-time**
      - WHERE name = "John" searches row by row.
    - transactions
      - **millions** of them
      - very small, **atomic** level row by row basis. A transaction might have thousands of rows affected.
    - These are **application-oriented** transactional systems.

    Also, concerning transactional:

    - Built to automate business transactions
    - **historical** info typically **unnecessary**
    - mission critical systems, **running our business**
    - mostly **writes**

  - **Analytical**

    - Multidimensional vocab
    - Multidimensional languages like **MDX** (Multidimensional expressions, XMLA)
    - summary/aggregate level (**daily totals**, city averages)
    - transactions
      - concerned with historical values
      - no updates, but rather **Append** on load
      - mostly **read-only**

    Also, concerning analytical:

    - Built to understand business
    - Built for **human understanding**
    - **historical info** is crucial
    - for **understanding our business**, not running it

- how they are similar, how they are different, and why this is so

<img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\OLTPvsOLAP.png" alt="OLTPvsOLAP" style="zoom:50%;" />


## Lecture 03 
### 03-A

*28 pages, class 3_1 21:00*

- focus on the General DWE Architecture
- DWE
  - what is it?
    - It's a lose term that stands for an environment which has 4 characteristics: 
      - **subject-oriented** - in the language of the business user 
      - **integrated** - combined from multiple different sources and probably needs to be cleansed
      - **time-variant** - usually having at least 1 datetime dimension
      - **non-volatile** - don't overwrite, append. This provides copies of everything
    - It also contains some culture around it. In this particular world, we follow some rules pertaining to: specific systems, applications, attitudes, and lifecycle activities
    - An analytical, information system built from several data systems, but separate from any particular existing data system
      - It's not the OLTP system
      - It's **built for analysis!**
    - Comprised of various tools
      - administer - SQL Management Studio as dba
      - populate - ETL using Data Tools
      - query/report - SQL Server Reporting Services or excel pivot tables connected to db
      - analyze - SQL Management Studio
  - what is it for?
    - It's **main purpose** is to provide **a single, consistent source of truth.**
      - What were total sales in MN in 2008?
        - If you get 2 different answers, DWE is broken. E.g. if Alice moves, past sales should attribute to previous addresses
    - minimal impact on existing on OLTP db
      - "Nobody run a query, mine is processing for the next 5 hours"
    - scale as the data grows
      - datetime grows continuously. 
        - Depending on how you model things, you would have 
          - 1 date dimension, 1 time dimension would grow slowly
          - vs datetime, 1 new row for every second, so would grow very very quickly, since it's multidimensional. Combine that with non-variant and time-variant, and it balloons quickly
    - **It answers business questions**
      - business users can use it themselves
      - provide the "right" information
        - provide it quickly enough, for the right people (midwest sales team), and at the right granularity 

- DWE has two information system types:
  - Strategic "data at rest" systems
    - You feed these systems
    - Data warehouse/data mart
  - Tactical "real-time" systems
    - Usually contain the word "**operational**"
      - Operational Data Stores (ODS) and Operational Data Marts (ODM). If it doesn't contain the O word, it's strategic.
      - These can be part of the DWE. They are not required, but they are allowed

<img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\DWE_Operational.png" alt="DWE_Operational" style="zoom:67%;" />



- Two "**Good**" DWE Architectures are **Kimball** and **Inmon**

  - **Kimball** - aka *"Business dimensional lifecycle or Matrix approach."* The **logical union of** all the organizations **data marts**. The cluster/cloud approach to DW
    - The DW is the data marts
    - all info is **always** stored in MDM
      - that is, DM is always denormalized (usually 1NF or 2NF)
      - usually using ROLAP (relational OLAP) e.g. a **star-schema**
      - No **Physical** DW. No server rack, just logical
    - How to build it?
      - data's extracted from **operational** sources
      - loaded into a "**distributed staging area**"
      - then loaded into 1 or more dimensional  model (DM/DW)
      - both **atomic** and **summary** info gets stored in the dimensional models
        - i.e. **facts and aggs** are stored in **denormalized**, MDM format (in a **star-schema**)

  <img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\kimball.png" alt="kimball" style="zoom:67%;" />

  

  - **Inmon** - aka *"Corporate Information Factor (CIF)."*  We focus on the first version of his architecture - DW 1.0, since DW 2.0 isn't often used.

    - a DW is (merely) **one part** of a CIF business intelligence system
    - The **"one real" source of all the information** in the data marts
      - You can build from this special purpose data marts, which are created and decommissioned as needed. 
    - There are Operational Data Stores (ODS) as a tactical system. These can be loaded much more quickly, perhaps daily, hourly or by the minute.

    ![inmon](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\inmon.png)

    - "**data at rest**" is periodically extracted from the operational sources (OLTP) then loaded **into the "real" data warehouse**. There is no staging area, like in Kimball's architecture.
      - You could use a staging area, but it's not required due to Kimball's requirements.
        - the real DW is ROLAP in 3NF or better. That means we don't have 1 table for customer, but several. Separate Country from state, state from county, etc in the customer dimension. This is very efficient for loading, but bad for querying. The one true DW is not used for querying. 
        - the real DW does usually NOT contain AGGs
          - Nobody is going to query it. They query the data marts.
      - The 1 true DW is just there for loading. It's not a staging area, but it's used for the same purpose. That's why it contains no staging area. It's already in a form that's easy to load - it's already normalized.
    - "**real-time**" data is "**streamed**" into one or more **operational** data store
      - ODS are "mostly normalized" but can contain a mixture or "evolution" normalized data to denormalized information
    - You don't connect tactical to strategic, that doesn't work. You load the ODSs, then eventually you load from real time systems/original systems into the strategic system. 
      - The OTLP refreshes every 3-4 seconds, it updates then in ODS. Then end of day, load into strategic DW. Gives more time to cleans and integrate. It's strategic, not tactical.
      - Periodically, you load from real data warehouse into data marts
        - atomic FACTs found in DW
        - summary AGGs stored in data marts
      - Data marts are usually MDM denormalized in 1NF or 2NF, since that's easier to query.

Inmon says:

- the DW is a real physical thing and the data marts are created from it

- The DW is normalized and doesn't have AGGs (check)

Kimball says:

- the DW is the logical union of data marts

- The DW is denormalized and has AGGs (check)

Inmon weaknesses:

- did not address metadata as well as it should

- did not address unstructured (tweets, emails) and semi-structured data (xml, json)

- did not scale as well as needed. With regard to size, growth, demand. After several decades, the DW is too large...but it takes awhile to scale too large.

- did not cope with changing enterprise requirements very well. If we change the def of a customer, for example.

In Kimball's world these can be handles better bc distributed. We can just create a new version of those DIMs in the data marts and the meshing doesn't have to be direct. Inmon tried to address these by creating DW 2.0. Still the CIF, but an evolution

### 03-B

*34 pages*

- metadata (MD)
  - what is it? 

    - Inmon: is everything about data needed to promote its administration and use
    - Kimball: all the information that defines (DDL) and describes (description, comment) the structures (schema), operations (ETL, data staging), and contents (any data in OLTP, datamart, DW) of the DW/BI system

    All the details about the purpose, goals, rationale, architecture, design, implementation, use, reuse, testing, quality, success, and failure of the data. Data about data. Everything except the data. Like the 630 data dictionary, but so much more

  - why do we care? 

    - Return On Investment (ROI). If you do it right, it'll have a big ROI. If you do it wrong, it'll cost you a lot more than it gives

    - Simply finding things - where to find customer table?

    - Understanding things - what is a customer?

    - How long does it take to run? How often is it used?

    - How many values are outside the valid range of values?

    - Consider **MD driven** activities:

      Drop all temp tables for ETL. If you named all temp tables as "temp_"

      ```SQL
      select *
      from user.tables
      where table_name like "temp_%"
      ```

      for each of those rows, drop table

      But, you need the MD to do this!

    - Capture who created a table or column, so before they leave a company, you can see what they should document

  - how do we better understand it? Through modeling. One model is to split it into:
    - **front room vs back room**
    
      - **Back Room** = closer to the data
    
        - technical in nature (details on PK/FK, cardinality, classes, programs, data models, dbs, ETL)
        - useful for dbas, modelers, devs
    
      - **Front Room** = closer to the user
    
        - descriptive and informative, often includes semantic details ("does this include tax? what does this mean?")
        - query/report/pivots related
        - useful to anyone who runs queries/reports
    
        Take the data dictionary. What format is it in? In the backroom, it might be sys objects table. It's in a db table. People who use it are extremely comfortable with SQL. In the frontroom, it's saved as a spreadsheet, or an online help, a wiki, user manual.
    
    - **B-A-T** (Business, Administration, Technical) these are mutually exclusive and total participation.
    
      - Business - provides business context for data
        - usually text
        - mostly manually entered because you can't write a program that tells what a customer is. It comes from human side analysis.
        - It then moves/replicated throughout the DW. Other MD is can be generated from it.
        - think of it as a requirement
      - Administration - anything pertaining to administration
        - mostly automatically entered
        - version information, issue tracking details, tested / deployed / retired, created, modified, proposed by
      - Technical - tech details
        - usually auto generated
          - network addresses, ports, data types, precisions, scales, min/max cardinalities, identifying, dependent, URLs. Null, pk, fk
    
      There is overlap between these. Not all tech data is backroom. Tech MD in both front and backroom. Null vs non null. 
    
      **BAT** lets us think about the data we're managing. 
    
      **Front room/backroom** lets us think about the user of the data, and how we can better serve them.
    
  - MD quality is important

    - *populated* (if it's empty, its useless), *accurate* (an employee is someone who bought our product), *current* (if it changes but it's not current), *synchronized* (if in the data model across OLTP to OLAP, but customer has different name from one version to another)

    - meaningful (contributes to understanding. code comments such as:

      ```python
      # a equals b plus c
      a = b + c
      ```

    - available/accessible (you must be able to reach it! What if server goes down?)

  - All DWE, DMs, etc contain MD.

    - But that means whatever software the db is on, the MD was determined by the vendor.
      - Oracle vs MS SQL Server...they all decide their own MD standards. They don't want you to share MD between each other. Also, it's tough to share MD from one MS tool to another.
        - This is a problem bc we want MD to move through the DWE.
    - Sharing it is tough! Sometimes MD is moved:
      - **generated** (somehow based upon something else). Defined as what a customer is
      - **replicated** (identical and synchronized). All tables with customer column should be made identical
      - **duplicated** (like "copy and paste"). Less fancy, simple. Not as synched
      - **percolated** (more complex propagation). Like ETL with integration combining and integrating
    - The tool's vendor decides how easy it is. If it's not provided, you gotta do it yourself...unless it's hidden by the vendor. 

    <img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\MD.png" alt="MD" style="zoom: 50%;" />
    
    
    
    Bottom right corner is data that the vendor contains, but doesn't share. It's in the diagram, but when you export the xml, it's not there. Imagine PK is listed in the ERD, but when you export, there is no PK indicator. To fix this, you would have to manually create your own extract. Open the spreadsheet and manually edit the PK in. In perfect world, bottom right corner should be empty.
    
  - 2 opposing forces on MD

    - MD needs to be synched and shared. But how?

      - versioning and controls like Git. Or Db locking techniques. Or send an email that customer tble has changed.
      - But if someone/something is using the software, they need access to MD right now. Available now/editable now. "Nobody run a report, I'm querying"

    - But what if it's not automated? People will become overwhelmed and frustrated. In immature orgs, they make all their changes at once and NOT updating the shared MD until 1 month later. That unsynched MD isn't up to date, not being communicated to db users, and therefore useless and no ROI from MD effort. 

    - How to make it easier? **Metadata Exchange (MDE)**

      - Not all MDE is equal. It's a buzzword vendors use to signal they have it, but they may be very minimal MDE, while others might be very rich. MDE doesn't necessarily mean complete, easy, automated. MDE doesn't solve bottom-right corner. It only makes the bottom-right corner available.

        MDE examples: UDDI, web services, json, xml

        - Ask vendor to support open MDE
        - Write your own utilities to fill the gaps
        - create an MD Catalog, which is your own model which serves as data dictionary. Under Kimball, you can create many small Catalogues. Little MD servers in front and back rooms.
        - Appoint someone to manage the MD

  - MD is possibly harder than DW. There are no real standards. If you're good at DW, you should be ok at MD

  - MD is possibly just as big or bigger than DW


## Lecture 04 - many important concepts

### 04-a

*20 pages*

- FACTs - "Details"
  - usually "**numeric**", sometimes non-numeric 
  - usually NOT knowable "in advance". That is, total bill for tomorrow night's dinner
  - sometimes you can model a FACT ahead of time. That is, payment will be made by cash/check/debit
  - Use them for numerical analysis
  - Imagine the cube. Facts go in the cells
  - Best FACT
    - numeric, continuous, fully-additive, or partially-additive
    - bc if all these are satisfied, you can do any AGG, build any pivot, any SQL agg

If it's not a FACT, it's a DATT.

- DATTs (Dimensional Attributes)
  - are contextual details that surround fact
  - usually descriptive
  - usually textual
  - can be numeric (zip code, ssn, phone numbers, dates..what's the average zip code?)

![fact_dim](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\fact_dim.png)

- AGGs - "Summaries" 
  - like SQL aggregate functions. sum, count, average, median, mean...
  - Inmon's world DW stores Facts but not Aggs
  - Kimballs world DW stores both Facts and Aggs
  - they're calculated ahead of time and stored in the "target db" (where you cache aggs), or calced on the fly.
  - You get AGGs via 1 or more slice and dice operation
    - dice = group by, or break down by DATT values
    - slice = filter by, or filter out by using DATT values
    - drilling down from month down to day or rolling up from day to month.
  - Not FACTs or DATTs.

- MDM multidimensional model is our model for how to organize these FACTs and DATTs

- DIM - dimension. A set of attributes that cohesively belong together

  - a set of related DATTs surrounding the Fact table. We create these collections of cohesive DATTs
    - Each collection is called a DIM
  - DIMs are modeled differently by Kimball and Inmon
    - In Kimball, Data Marts store MDM denormalized, 1 table per DIM
    - In Inmons, the Data Marts look the same as they do in Kimballs, but the 1 true DW stored everything in 3NF. This means 1 table for year, 1 table for month, 1 table for day. In the 1 date DIM, there would be 3 tables in the one true DW. 
    - Hence, there's "1 or more DIM table for each DIM"
  - look at things surrounding the FACT table. Dealership city, dealership country, dealership name, dealership region...these are all cohesively related to the Dealership. So in Inmon, they're all be normalized out in 3NF, so there'd be multiple tables for 1 DIM. If we're in the data mart in either world, there would be 1 dimensional, denormalized table. 

- Some **calculations** and **groupings** may be **invalid** for some FACTs

  - This depends on the FACT's **Additivity**

  - Additivity is **PER FACT!**

  - Additivity is technical metadata bc not null, or pk...this is technical

  - ***Can you sum across All/Some/No DIMs?***
  
  - FACTs belong mutually exclusively to:

    Consider if it makes sense to aggregate (e.g. sum) the fact

    - Fully-Additive - valid across **all** dims
  - Partial-Additive (aka Semi-Additive) - valid across **only some** dims
    - Non-Additive - valid across **no** dims

    These only apply to FACTs!

    Makes sense, it means summing would not change the essential meaning of the FACT or AGG, and it doesn't violate any math rules. 
  
    <img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\additivity.png" alt="additivity" style="zoom:67%;" />
  
    Imagine % Participating in elections. Many surveys that calculating % of population participating. You can't sum these percentages. It would result in greater than 100%. 
  
    **Additivity is per FACT**. 
  
  - DATTS have no additivity (even if numeric. you don't calc AGGs of DATTs)

### 04-B

*21 pages*

**Granularity**

- Grain of DIM = the lowest level in a DIM (smallest hashmark on its Axis)

- Grain of the MDM = "grain of the cube" = "grain of the fact table"

  - these 3 grains are always equivalent bc
    - MDM is the model of this multidimensional thing
    - the cube is our way of visualizing the MDM. It's a metaphor for the mode
    - the fact table is how we actually implement it - conceptually, logically and physically. It's the heart (literally) of the cube
  - However, MDM grain != DIM grain
    - single DIM is 1D, so the grain is 1D
    - MDM is ND, so grain is multidimensional

  <img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\grain.png" alt="grain" style="zoom:75%;" />

  - imagine a star schema. The central FACT table has dimensions like product, dealership, date which originate in DIM tables that connect to it. Meanwhile, the date DIM table has 1 grain of "day"

  ![terminology](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\terminology.png)

  In image below, 

  - DIMs = axes
  - HIERs = "different rulers" (e.g. English vs. Metric)
  - LVLs = units in a given ruler (e.g. inches vs centimeters)
  - MBRs = positions along the edge of a ruler

  <img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\fact_agg.png" alt="fact_agg" style="zoom:75%;" />

  ```python
  # imagine arrays as a metaphor
  name[0]
  address[0]
  ```

- If you have a 12D cube, you have a 12D grain

  <img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\grain_1.png" alt="grain_1" style="zoom: 50%;" />

<img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\grain_2.png" alt="grain_2" style="zoom:50%;" />

**Granularity mismatch** - if you store a FACT or an AGG in a cell with a different grain of FACT or AGG? e.g. total sales in 2008 for Fords in **MN**, but stored in a cell with grain **per-city**

<img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\grain_3.png" alt="grain_3" style="zoom:75%;" />

When the grain of the fact != grain of the cube

Granularity mismatch solutions

- Recalc the FACT into its "lower level" pieces
  - like dividing "Monthly Facilities Cost" FACT by ""# days Facilities used" to determine the "Effective Daily Facilities Cost" FACT
  - or estimate the daily facilities cost. total cost / 31. or weight by M-F (divide by 20)
- Remove the FACT
  - dont put monthly facts in daily cube. create a new monthly cube
- deal with it yo, give people a fair warning "Be Careful!"

## Lecture 05 

### 05-A Fact table grain patterns

*28 pages*

A software pattern is something recognizable, just a guideline. It's a hint. It looks like this, that, and that. It's a way to abstract. These are all variations on this one pattern. You abstract away the details. Think Model View Controller, Visitor Pattern, Builder Pattern...same thing as in DW.

**Most of the time**, **data marts** will use a **FACT** table that roughly fits one of **4 patterns**

1. **Transactional Grain Pattern**

   what is the grain of the business process, what is the grain of transactional system, what is the grain of the MDM? If they're the same level, then it's transactional. Generally, if you're at the finest level of granularity, then you're at the transactional.

   - Build the MDM using the finest granularity available
     - based on the OLTP's grain. Look at the values - are they per day, per sale, store, per person - is that grain you're storing it at the same as the grain that you're going to build the cube?
     - grain of the business process itself. A person goes to a store and makes a order. OLTP should be at least as fine as the business process. If MDM grain is on par, then Transactional Grain Pattern.

   e.g. 1 **student** enrolls in 1 **section** of 1 **course** from 1 **instructor** on 1 **campus** in 1 **classroom** in 1 **semester** and earns 1 **final-grade**. Could be 1 DIM for course-section, or 2 DIMs as separate DIMs. 

   - FACTs often tend to be fully (highly likely) or partially additive when they're numeric
     - if lab-fees are (per student, per semester), but not per classroom, per instructor or per course, then fees would be partially additive. e.g. monthly facilities cost vs cost per day. fees should be at same level of granularity as the cube, then they might be partially additive.
   - perhaps the best bc simpler, easier to use

2. Line-Item Oriented Grain Pattern

    Feels like building the MDM at a "lower level", finer) granularity than the business process. That is, some FACTs exist at a "higher" grain than the "line item". Some facts are at line litem level like burger or fries, but otherwise you can have order level such as "total order cost."

    Named after line order in an order. If it came out today, with amazon, it would be items-in-shopping-cart. items on a sales slip going through drive through.

    - Process is at the per cart or per order grain. When you go through drive through, you dont buy hamburger, then buy fries, then buy coke. Some things are at /cart or /order level, and some things at finer level. 
      - FACTs and AGGs at /cart or /order are **partially additive**. You can't add them up within the same order. But some FACTs and AGGs are at the finer level.

    <img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\order_form.jpg" alt="order_form" style="zoom:50%;" />

    See the **Line items** on the **Order form**?

    ![line_item](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\line_item.png)

- notice many-to-many relationship in bottom right. that will be replaced by an "associative entity"

You look at the business process and OLTP process and decide what level you want to analyze things at

- **Line-items Oriented Grain Pattern**

  Look at the business process, OLTP system, the cube and determine if you're at the granularity of the business process. The grain of the OLTP and MDM (OLAP) should be compatible. 

  - often tend to have some partially additive FACTs
  - This is bc of the granularity mismatch
    - if we take the Order Total and add it across items in the same Order DIM, WRONG.
    - solutions are available, but for line item oriented, we tend to leave it in there, and act carefully
  - complications
    - usually will have Degenerate Dimensions (more later). It's a DIM modeled as a non-numeric FACT. There should be at least one. 
    - can have heterogeneous (different) products
      - Amazon sells food, furniture, electronics
        - So in a table, you get a large number of attributes specific to each one
  - **The grain of the business process is more coarse. The OLTP and OLAP is finer than the actual business process**
  - This is radically different from Transaction pattern

  Just because it has a degenerate dimension, and just because it's partially additive, doesn't mean it's a Line-Item Oriented pattern.

  - The FACTs/AGGs at the per cart/per order grain = partially additive - you can't add them up within the same order

  - But there are also FACTs/AGGs at the per-item (per-line) grain = fully additive

- **Periodic Snapshot Grain Pattern** (coarser)

  - Build the MDM as a "snapshot" that we periodically update
  - The grain is often **coarser** than what is available in OLTP. 
    - Instead of daily, it would be modeled at monthly. E.g. using a monthly level grain for this MDM when the process has weekly, daily, hourly, or even finer transactional granularity
  - The **grain** here is **one row "per time defined period"**
    - if weekly snapshot, 1/week
  - This is a type of "*Summary DM*" or "*Aggregate DM*"

  This coarser grain comes with required changes...take the DIM out

  	- some DIMs might be removed (customer may disappear from a daily snapshot because HH:MM:SS was removed)
   - Some DIMs might be "coarser". Or move the DIM granularity
     	- instead of just per month, use per month per state
   - FACTs tend to be **partially additive**, which comes with problems:
     	- Granularity Mismatch
        	- Multivalued Dimensions (MVD)

  So why use Periodic Snapshot?

  - If you have inventory fact table, it would be very dense. You probably don't care about who bought what at what store...you just want periodic sales info. 

- **Accumulating Snapshot Grain Pattern** - the most bizarre, and a bit rare. You may see for some parts of the DW

  A **single row** represents the complete history of some thing or event. grain is 1 row per lifetime

   - manufacturing. First gather raw material, then form it, then laminate, then set, then box it. 1 row/product

   - student admissions - one row is prospective student. first application, then acceptance, then approval for financial aid, then...1 row/student. 

   - often uses many **role playing dimensions** for date

      - imagine a cheesy B-movie where 1 actor plays multiple roles. Same person playing multiple roles. Same here.

        ![rp_dim](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\rp_dim.png)

        9 dimensions all for date

     - FACTs typically include counters, unit conversions, and lag-time facts (see 05-a, slide 27)

     - Fact rows are UPDATED IN PLACE

       - Each row is revisited when something "interesting" happens for the FACTs in that row. e.g. a student is accepted into the college, now time to move onto financial aid application

     This partially violates:

      1. time-variant - bc same values for some attributes in the FACT table across multiple times, so you don't know when they were last updated since you may change them in place, and they may not have a time associated with them

      2. non-volatile - bc you're updating, not appending

         As a result, both the FACTs and the foreign keys can and will CHANGE.

         So how to represent something that hasn't yet happened? Something that happens in the future....don't use date of sale "9/9/9999". Don't use null...it's not subject oriented. Don't use "date value", use Surrogate key (**SURK**). Usually you're just changing the FKs, since you don't want to change PKs.

**AGAIN, most of the time**, **data marts** will use a **FACT** table that roughly fits one of those **4 patterns**

### 05-B - look at the models Star, Snowflake, Constellation

*12 pages*

claiss5_2.mp4, 41:00

1. **Star schema** - each DIM is **denormalized**

   - **Strict** star - Each DIM is in ONLY one table

     Kimball's style

     ![strict_star_conceptual](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\strict_star_conceptual.png)

     We can tell this is Strict Star bc fact table in middle (it has the many relationships). Dims are 1 and 1 only, unless you have multivalue dims. 1 fact table in a star, others by definition are DIMs. You have 3 DIMs and 1 DIM per table, so it's a strict star, completely denormalized. Everything in Product table is a product, everything in Date table is a date, everything in Store table is a store. All the info is denormalized in their one DIM. You gotta look at the semantics.

     Here, grain of MDM (aka grain of fact table, grain of cube) = 1 row per day, per individual product (SKU) per individual store.

     **Which of the 4 grain patterns?**

     It is not accumulating snapshot pattern. 1 row in the sales table doesn't represent the lifetime of a sale. Only 1 date dim, no lagtime facts, no conversion facts.

     Probably not Line Item Oriented. 1 product per sale here...no order or degen dim. nothing at a different level of granularity than the others. In fact table, sales amount, tax amount, quantity purchased, is per product - not per order. No lines per order. There's no order dimension. No line item level vs order level fact.

     Probably not Periodic. We have no customer...we could have gotten rid of customer, so might be periodic.

     More likely transactional bc we dont track customer, just cash only ice cream sales.

2. **Snowflake schema** - each DIM is at least partially normalized

   - **Strict** snowflake - Each DIM is 3NF or better

     This is Inmon's 1 true datawarehouse CIF. 

     ![snowflake](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\snowflake.png)

     We know this is a snowflake bc we're in 3NF or better. Each of the tables is in 3NF. 

     How many DIMs above? 3! It's the same model as in the Star. It's just normalized.

     Grain = per day, per SKU, per individual store. Same grain...normalized or not. If you took apart a 300 lbs statue to ship it, the pieces would still add up to 300 lbs.

     **Interesting:**

     In the CIF, everything is loaded first into the one true DW where it must be stored in 3NF. So, we must create it as a snowflake. That makes ETL better because its easier to do Inserts/Updates/Deletes when it's in 3NF (as seen in OLTP). It doesn't have a staging area, so load it directly into the snowflake for all DIMs and all Cubes in enterprise. 

     **Why have a star?** A business user would have a hard time querying a snowflake. DMs are denormalized for quicker and more efficient qeurying. 

     **Why have a snowflake?** Inmon's one true DW is normalized bc it makes ETL easy and efficient. 

     In Kimbals world, we have only stars. Inmon's world, we have both.

3. **Constellation schema** - more than 1 FACT table/MDM/star/snowflake

   ![constellation](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\constellation.png)

   There are 2 Fact tables here. The tables with all the many relationships, Sales and Inventory. 4 DIMs, where warehouse is only used by Inventory.



### 05-C - Hiers inside the DIMs

*25 pages*

DIMs contain subgroups, DATTs. There are often cohesive relationships between the DATTs in a DIM. You can look for relationships, looking for some sort of meaning that would be useful for business user. These are NOT shown in the ERD. For a Strict star schema, there's 1 table per DIM. This is not normalization. It's stored in the metadata.

The ways to find relationships:

1. functional dependencies
   * When one column determines another. An employee ID tells us their name, earnings, address. Everything in the table depends on the key, the whole key and nothing but the key, so help me Codd. This can be a basis for finding these subgroups, even though we're denormalized.
2. Semantic interdependencies
   - Relationship based on model semantics. We have a pay scale and a skill rating. You can be high skill but low pay bc low xp points. You can have high xp and high pay...it's not dependent on each other, but it's suggestive. kind of weak.
3. Generic associations
   - Data has a relationship, but not based on rule. Coupling and cohesion. Maybe you do one thing first, then another thing. Eh...
4. Simple Containment or Combinatorics
   - Containment - one exist within the other
     - October 13th belongs to October. October belongs to 2020 bc it's the year. Cities in state, states in country.
   - Combinatorics - merely enumerating all possible combinations.
     - In person, you can use cash, debit or credit. Online it's debit or credit. Different combinations. This is the weakest grouping form.  

Why are we doing this? **We're looking for ways to slice and dice**. The hashmarks along the axes that we wanna use to **group or filter** things. 

- When we're looking for **DATT types**, it's an **Intentional view**. This is looking at things in the **schema**

  - These grouping types are **levels (LVLs)**. Year level, month level, day level. The levels are then within each other. Day is in week, week in quarter. 

    It's like subtypes for inheritance. 

    ![intentional](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\intentional.png)

- When we're looking for DATT values, it's an **Extensional view**. This is looking at things in the **Instance**

  - These grouping types are members **(MBRs)**

    All of the specific Day members (2012/10/01, 2012/10/02) are within a Week member (2012-week-39)

    Like numbers along number line. Like saying you're at a coordinate. I'm a 6 feet 2 inches. The type groupings are the inches and feet.

    ![extensional](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\extensional.png)

Imagine a ruler. The **hashmarks** are the **types**. Year vs month vs day. Foot vs inch. The **levels**

Talking about the number line, 2010, 2011, 2012. January, February...Jan 1, Jan 2. these are the **members**, the instances. Knowing the number of values for these things is helpful when planning size and shape of things

**Hierarchies** - There are multiple ways to create and arrange meaningful subgroups 

- Each "way" is a **DIM Hierarchy (HIER)**

  - Not creating new DATs, but we are creating a hierarchical reordering of them

  - *Imagine looking at the Date table. It's like we but field Year above Month and Month above Day.* It's just reordering the columns. Or if you're looking at EDD view,

    ```sql
    select *
    from dates
    order by year, month, day
    ```

    It's just reorganizing, but HIERs are useful bc they're the way we want to slice and dice our info, how we will build our AGGs

Hierarchies are a reordering inside of a DIM. 

"**Grain of the DIM**" = the finest level of granularity

- the lowest level for ALL HIERs
- the "meaning" of the smallest hash-mark on the Axis
- the "meaning" of one row in the DIM table of a strict star schema
- the "meaning" of one member (instance) of the lowest level in the DIM

Rules for **HIER** creation

- each DATT is in one and only one LVL in the HIER. It's just a reordering, you can't reorder and put it in 2 spots.

- we create a single "chain of 1-M relationships" connecting all the LVLs in the HIER a straight line. Every month has many weeks, every week has many days.

- we connect all these 1-M relationships are with the "M side" closer to the fact table than the "1 side". We're getting to a finer level of detail as we approach the fact table. The finest level is what attaches to the FACT table.

- We now have levels that form a **Dimension Hierarchy**

- We can also create an **"Improper" HIER**

  - Improper bc only 1 level. You can create a windows folder and put all files inside. C:\ and everything goes in that

- **the DIM grain is equal to the lowest level of every hierarchy.**

- **INVERTED HIER** = fewer MBRs in a child LVL than in its parent LVL

- ** Hierarchies** are only conceptual, must have names, and defined and used for only 1 DIM

  - You can also create an ALL hier to capture everything.

  <img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\all.png" alt="all" style="zoom:50%;" />

- **Levels** are conceptual, must have names, and defined and used by only 1 HIER

  - every level must have a Member Key (**MBR KEY)**

    - set of one or more properties PROPs

    - usually a single PROP from this LVL

    - uniquely identifies a MBR

      - unique in just level
      - unique in level and hier
      - unique in level hier and dimension

      Think of city names. Springfield is not unique for a city. You need country and state to identify. 

  **Member name** = a business friendly name to go along with the key

- the **lowest LVL** in the HIER

  - is the grain of the DIM
  - must be the same grain for all HIERs in the same DIM

- each **MBR**

  - is an instantiation of a LVL (or all of the DATTs)

- HIERs and LVLs are viewable

  - intentionally (Schema AKA "Types")
    - using an **Intentional Dimensional Diagram (IDD)**

- HIERs and MBRs are viewable

  - extensionally (Instance AKA "Values")
    - using an **Extensional Dimensional Diagram (EDD)**

- both the IDD and the EDD show:

  - only one HIER of one DIM
  - estimated cardinalities for LVLs
  - assumptions / notes
  - each DIM Name, HIER Name, and LVL Name
  - also indicate each LVL's PROP, MBR KEY, and MBR NAME 

- **IDD** does NOT show any DATT **values**. e.g. DAT_Year

- **EDD** does show all DATT **types** and **values**. You can't show the value in isolation. e.g. DAT_Year: 2008

![IDD](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\IDD.png)

## Lecture 06

### 06-A - Degenerate and Junk DIMs - they sound bad but are not

*19 pages*

6_1 1h02m

**Degenerate Dimension (DD)** - when a single DATT is left on its own, with no appropriate DIM to cohesively relate to. E.g. Order # DATT in a Line Item Oriented Pattern.

- Fix a DD by:
  - model it as a **textual** FACT in the Fact Table
  - Mark it as "DD" to indicate that it's actually a DIM
    - DIM is actually ORDER, but DATT is SAL_Order_Num

![degen](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\degen.png)

This dedicated DIM for Order is wasteful, so just tag it into the Sales_Fact table. Model it as a FACT in the FACT table. That line-oriented pattern is a common cause of this.

**Junk Dimensions (JD)** -  when several DATTs:

1. have few values (low cardinality...)

2. business users want to slice and dice with them

3. <u>have NO appropriate DIM to cohesively relate to</u> (customer city, customer name, customer state = customer DIM..this isn't junk. If they belong together, it's a DIM we forgot to do. If they don't belong together, or to any other preexisting DIMs, then Junk)

   e.g. flags in scientific process...what were values when wind was low vs high? Bools. Payment_format (cash, debit credit) has nowhere to go

   **Solution:**

   You are basically bundling all the DATTs into a new DIM (the junk dim). The DIM is often named something vague because its difficult to group. "Sales details"...they do not fit together cohesively. "Sales_junk". If you have a good name, it's probably junk.

   ![junk](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\junk.png)

   This junk dimension contains many columns. It's not a single column sort of thing.

   Best practices discussed. Basically, give good values in the fields. Not 0, 1. Use "First time customer" and "not first time customer".

### 06-B Keys

6_2

1. Primary Keys

   - Cant be duped, cant change, must be unique, numeric, efficient, not null, order the row
   - every Relational Data Model (RDM) has these sometimes we see the term used in non-RDM when the concept is analogous

2. Foreign Keys - another tables key, (usually PK). Used for lookups. Can change, can be null.

3. Composite Keys - composed of other columns. Unique, but if you leave off part of the component and join, cartesian product.

4. **Natural Keys** not so great. 

   - choosing column(s) that have "real meaning", and using them as the key. 
   - Bad examples
     - SSN (these get recycled). first_name, last_name, birthdate (redundant)
   - Better examples
     - customer number (customer 1 is #1), order number (order 1 is #1), SKU (track dept-manufacturer-model-item)
   - They are bad to use in DW bc it's only **unique in a single db**

5. **Smart Keys** (SMAK) bad practrice in OLTP and OLAP

   - single key made by concatenating values of other attributes
     - emp_key = <fname> + ',' <lname> + '@' + <job_title> + '/' + <dno>
     - = "alice,smith@sw_eng/12", "bob,jones@dba/12", "cindy,cho@ceo/90"
   - BUT, a "Smart" dev tries to parse the key value instead of fetching associated column values
     - If Alice changes email address, Smart key doesn't change...PK cant change

6. **Surrogate Keys (SURK)** - not necessarily a PK

   - named for the way you create them
     - we create a new key column, then use some technique to ensure that we can generate a unique value
     - They're not random, they are merely unique, semantically independent values
     - e.g. uuid, sequential values (tho first customer as #1 has meaning, so not surk)

7. MBR KEYs - discussed above

   - must be:
     - unique in just level (at least)
     - or unique in level and hier
     - or unique in level hier and dimension
   - imagine customer dimension

8. **Production Keys** - a key imported from the OLTP db (production system)

   - OK to use as "regular columns", as long as we never use them as a key in the DWE

   - use them for:

     - DATTs, FACTs, PROPs, or even MBR NAMEs

   - don't use them as:

     - a MBR KEY
     - a PK or FK in the MDM's ERD

     A SURK used in OLTP is good, but when you import it into the DWE, it's no longer a key. It's just a unique value, and it also has a meaning. Bring it on in, but it's **NOT a key**

### 06-C Slowly Changing DIMs. Type 1, 2, 3

*26 pages*

6_3 13:00

**Slowly Changing Dimensions (SCDs)** - DIMs are not always "independent" of each other

- There are ways to handle DIMs that SLOWLY change over time (the DATE / TIME DIM)

  - If they're NOT SLOW, then use other techniques (Rapidly Changing DIMs)

- Customer changes over time:

  - change name, job
  - customers may merge, or marry
  - a customer may split up
  - they may move away or die

  In its **strict form**, SCD is defined for the entire DIM (applies to each and every DATT across all HIERs). It doesn't matter if you change the hierarchy/reorganize them.

  Determine the SCD when you CREATE the conceptual model, not after! You can't change it later, easily. You may have to create a schema to support it.

1. **SCD Type 1** - "*Overwrite*". If you want to make it into a type 1, np. just ensure minimal rules. Most easily used, but least valuable since you lose history and violated 2 DW requirements.

   - Ensure level keys are unique, check for inverted hierarchies, etc
   - Why choose this? When we don't need history, not worth it. When most modifications the result of fixing typos, errors. We don't need to analyze our typos. The history has no real value. Also, if the other types are more expensive, meh, don't bother.
   - **So to implement?** During **ETL, overwrite old values** with new values for the DATTs. **remove old values** if needed. That is, in relational OLAP, use **update/delete**. e.g. if the weekday for a given date was wrong (typo), just update!

   ```sql
   UPDATE Date_table
   SET weekday = 'Tuesday'
   WHERE weekday = 'Mardi';
   ```

   This **violates** DW requirement **Volatile** and **Time-variant** (no date and time associated with it)

   Your **AGGs** will change as a result and must be **recalculated**. You can change the past.

   - We would **want to use type 1 for** DIMs like

     - Date and Time DIMs - they would only ever change if we made a mistake
     - Junk DIMs - they already contain all possible value enumerations
     - Degenerate DIMs - it just has the production key, which we would only ever change if we got it wrong. What are sales under wrong order number? No. What are sales under correct order number.

     If it's not one of those scenarios, go with Type 2.

2. **SCD Type 2** - "*New record*" most of the time. When you care about history

   - when keeping the **"old values" has "value-added“** to the MDM

   - **MUST use a surrogate key** (SURK) for all the applicable keys inside this DIM

     - **each** LVL KEY within **each** HIER
     - the PK of the **DIM** itself
     - Because, **we need to have very fine control** when we create a new version of things
     - Often include the production key in the MDM as a non-key DATT. Because? IT helps us answer a very basic question - if you have 10 rows in customer table, do you have 10 customers, or 5 customers, 2 versions of each? Or other combination? The production key tells you how many customers you have. If you count rows for that one production key, it tells how many versions you have for that customer. Distinguish how many customers vs how many customer versions. Easier for reporting. 

   - best when changes are SLOW - compared to the FACT table. If gas price changes once every 24 hours...per customer per date, per time, per location, per payment method, that back table is moving way faster than any one DIM table, so if it changes once every 24 hours, it's still moving extremely quickly, for that 1 value, that 1 day. We compare our speed to transactional or line-item oriented speed.

   - **So to implement?** During ETL, **create a new DIM MBR**

     - NEW value for MBR key
     - NEW values for the "changed" DATTs
     - OLD values for "unchanged" DATTs

     Insert a new row in table when any DATT changes. If things didn't change, reuse old row but be careful about how you create MBR Keys. 

     ![SCD_type2](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\SCD_type2.png)Interesting discussion at 6_4 40:00.

     **Type 2 recap**
     
     To avoid inverted hierarchy, when MN population changes you update MN SURK and population, and you still need to update St Paul city SURK. That's the case even though St Paul had no changes. We need to be able to create a new version of a member sometimes, even when none of the actual dimensional attributes in that member have changed. That name of the state didnt change, the population did. The name of the city didn't change, but you still need to update the city.
     
     This allows us to automatically partition our history - customer v1, customer v2 will have all sales associated with it's updates version. It partitions the cube.
     
     It does make things a bit more complicated though. Be careful when counting. 
     
     ```sql
     select count(*)
     from customers  -- doesn't show actual customer count
     
     select count(distinct customer_number)
     from customers  -- does show actual customer count
     ```
     
     Add production key as a non-key attribute, so you can select count distinct customer IDs so you can see how many customers, as opposed to customer versions (see image above, last table).
     
     **It needs to be an SCD though!** Otherwise this blows up.

3. **SCD Type 3** - not very useful. We use it for hybrid techniques or things that aren't SCD.

   - For 1 attribute, 1 value of history. We either:
     - store current and original value and forget everything in between (n and 1)
     - or store current version and the previous version (n and n-1)
   - Store these in separate columns, and add a date field to know when to use each column

### 06-D Three Strike Rule

*15 pages*

7_1 16:00

Important but no very difficult.

So we try to build these MDMs, especially star-schemas, by having as few DIMs as possible. There are guidelines for when we may want to split a DIM into more than 1. There are **no rules for merging, but there are for splitting**. There's an impact on SCD though.

Some DIMs change faster than others. Consider how often a member changes address vs when they become gold_membership or silver_membership...these change at different rates. If they're different enough, maybe they don't belong in the same DIM at all. 

You could pull them out into a separate attached table. But this makes things more complicated, whether it be 1-to-many or many-to-1, but avoid it because the simplicity for the user is destroyed. The star schema design is botched. You could do it, but really should do it most of the time. It's a common situation.

Kimball's **Mini-Dimension** solution:

- We have a group of attributes within the DIM that are different from another group of attributes within the same DIM. A subset of the DIM that acts differently. 

  - if the DATTs change at **different rates**. e.g. corporate vs residential as opposed to changing cities/states

  - if the DATTs change by **different business processes** e.g. same as above

  - if the DATTs for **different reasons or semantics**

  - if the change in the DATTs has **different semantics after the change happens**

    In all of these cases, might want to split into separate DIM. 

    A Mini DIM is just recognizing that when we look at the SCD aspect, there might be a reason to suspect we should be doing something differently with them.

    ![minidim](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\minidim.png)

    See how many of attributes in the image above are **Location**? If vendor is Best Buy, the vendor city is the HQ. Vendor location is the store location, for which there are many. The locations are different from HQ. Same goes with vendor HQ in Minneapolis, but locations are all over the country. **These attributes change at different rates**. It **almost** looks like the below:

    ![minidim_2](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\minidim_2.png)

    If in the Vendor table the attribute Vendor Parent company HQ changes (which is does every few decades), there are tons of repercussions such as changing business cards, relocating employees, changing financial tax calcs...but if a target store opens a new location, which is does all the time, no problemo. Add in Wal-Mart, Target, Best Buy, this Vendor Location table changes very frequently...but Vendor table? Not often.

    **Solution**

    - Create a new dimension for that mini dimension
    - recognize there's a relationship implied but not shown
      -  There's an associated entity (lookup table between 2 tables) between them...

    Now we want to **strive for as few DIMs as possible**, even if that means the **DIMs would be very large** (many DATTs)

    **Three Strike Rule** - Rule of Thumb

    - if we have two groups of DATTs in the same DIM that
      - fit together hierarchically, within each group, but not hierarchically across the groups
        - e.g. Year-Quarter-Week-Day (they don't all fit together - put all month info down into day level)
        - vs. Year-Month-Day - put all quarter and week info down to the day level
        - they dont fit together hierarchically = this is **Strike ONE**. Having 2 HIERs doesn't necessarily mean we should split, but it's a maybe. 
      - have different SCD 
        - the SCD changes for the DATTs within each group the same, but SCD changes are different across groups
          - e.g. the Vendor_HQ DIM and the Vendor_Location DIM. moving Target headquarters vs moving a Target branch, are radically different. different rate, different meaning, different semantics, different business processes - especially if these two groups are the same that didn't fit together hierarchically in Strike one.
          - **Strike TWO**
      - We want to view/query orthogonally/perpendicular. i.e. independently or "perpendicular to each other in the cube"
        - e.g. Do you sell more in Morning or Afternoon? "for last month", "for last quarter", "for last year".
        - **Strike THREE**
        - **This is the most powerful reason to split**

    So consider the rate of change for splitting Date and Time. Splitting will stop their huge growth. Spitting dimensions changes the cube dimensions

    Other implication discussed at 1:00:00

    **I should really, really review from 1:00:00 on. I just didn't absorb this material at all, but it was a fantastic review of DW from start to SCD**

    ![SCD_impact](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\SCD_impact.png)

### 06-E Role Playing Dimensions

*7 pages*

7_2 7:00

Simple but very powerful.

**Role Playing Dimension (RPD)** - when we have the same concept used for different semantic purposes in the same MDM

- use the **same DIM Types** (schema / structure / SCD Type / etc.) and **same DIM Values** (content)
  - e.g. conformed dimensions. The product DIM is the same across the cube whether you're looking at sales or inventory. Customer is the same for sales, returns, billing. It's like this idea, but we're going to do it in the same MDM. 
- Best example = Date DIMs. We reuse the schema, structure and content. Look at the grain pattern for Accumulating, where we had 9 Date DIMs. Like the B-movie where actor plays many roles.
- Benefit is that you:
  - reuse the schema, structure and content. You load it once in ETL and can replicate it for sales, billing, birthdays
- E.g.
  - Dates, Person
    - purchasing_customer, customer_reporting_issue, customer_contact. Might be the same person who bought it, reported the problem, and you contact the same person when you find a fix

**Be careful when using RPDs.** Consider "location" as being across Dealers, Factories, and Customers. This is not the same schema and same data being reused for the location. Dealership has sales tax issues, employees, advertising factors. Changing a factory doesn't happen often, tons of implications. You need room to warehouse thousands of product. The business process is radically different. And Customers? Consider the rate of change of customers vs factories. They represent different details.

**A RPD is literally a copy of the DIM, but we know we don't have to do any extra work. We just clone it.**

Dealerships are in city centers. Factories are where land is cheap. Customers live in rural and urban locations, but they DO NOT live at the factory or dealership. **We're not reusing the same values!** Plus we need other attributes about customers - age, gender, income. Factories don't have those attributes, but rather employee count, productivity, costs. For all non-location details you still need Customer location, Dealership location, and Factory location DIMs. You just can't reuse this info between each other.

**Only use when it's a reuse situation. Same Schema, same values.** 