# Datawarehousing Notes Half 2
2020.11.03

## Lecture 07

MDM is the model for for organizing FACTs and DATTs. There are many ways to create the model though. **FACTs** are numeric, usually. **DATTs** are text, usually.

Some techniques used in DWEs are:

- per cube aspects, such as **Degenerate Dims** and **Role Playing Dims**
- DWE wide aspects, such as **SCDs**

But some techniques are **architecture specific**

When building a DWE

- The first pass is a high-level of abstraction (usually enterprise wide)

- the second pass is a lower-level of abstraction (usually per-data mart)

The **first pass** is high level fly over. You see **little detail**.

Good approaches to modeling:

- models development lifestyle should be incremental, iterative, spiral, agile, or "agile-like"
- try to minimize the "ripple effects" of enterprise- wide model changes
  - even the definition of Customer is likely to change in the future, Think about Wal Mart selling movie video cartridges, then dvds, then selling online. Definitions change

### 7-b Inmon's World

*5 pages*

07_2 39:00

First Pass:

Inmon refers to this as the start of the DW (**this is in 3NF**)...Nota Bene (**NB**) "this is important, note it well"

A good approach is to follow

- **First pass**

  - it needs to be enterprise-wide to include all the stakeholders

  - prevent **stove-pipes** (aka silo dimension or anti architectures)

    - e.g. 2 different definitions for the same DIM (like Customer = someone who buys product vs who buys product and hasnt returned it)

  - Start with **subject areas** = major category of data relevant to the business. aka subject oriented things

    - such as "physical items, concepts, events, people, and places" that are of interest to the enterprise. **In their language, that they understand.**

      - Customer, Order, Invoice, Shipment, Sales, Employee, Inventory, Pricing, Equipment, Finance, Information Technology..

    - So as an organization, you create a **subject area model**

      - not so long to create. Usually 15-20 subject areas is enough. It's a very high level model

        ![subject_area_model](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\subject_area_model.png)

      - It shows which areas are "related"

      - no detailed information

  - **These models are are used as a guide for everything**

    - All **conceptual** models, which lead to **logical** models, which lead to **physical** models are based on the **subject area model**.
      - basis for all **OLTP** and **DWE** 

  - This prevents stove-pipes. 

  - Like flying over the country, you can see all the states, see the entire continent. Then do multiple passes at lower altitude to see details

In Inmons world, we use the MDM for the datamarts denormalized into star schemas, only for the datamarts.

**Summary**: In the one true DW, we use it in 3NF for the snowflakes. But we're not building that yet bc that's detail. Currently we flying high level. What is a customer? What is a product? Do it incrementally, bc a DW is big. It's the datamarts for all parts of the organization. Then incremental stepwise refinement, filling in details with each additional pass.

If you want to change the definition a customer, you have to change the subject area model, which changes conceptual, which changes logical, physical, all other apps like OLTP, ecommerce site, OLAP like reports, queries, pivots, DWE. That's tough. Metadata synchronization.

How to prevent stovepipe? Stovepipe = different understanding/definition/incompatible for DIM attributes or FACTs. That's why you do enterprise wide analysis, look at all parts of business, models, and base everything on the same understanding of what is a customer, product, etc. Also deeper conversation about "What is an order?". Having that foundation will prevent stovepipes. Also in Inmons world, recognize the way his world works. 

![inmon](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\inmon.png)

7_3

We have the one true DW. There is 1 def of the customer dim, in a giant snowflake. The customers city, state, residential vs corp, in 3NF is the customer DIM. If the customer DIM is connected to more than one FACT table, it's a **constellation**. That one customer DIM is connected to each and every FACT table in our entire enterprise. There can't be two different definitions of customer bc there is only 1 customer DIM in the DW.

**In a nutshell**, we make sure that enterprise wide, we have the same understanding of everything by using subject area models to drive the whole process, by using maturity to conform to these processes, and then by having an architecture where we base everything off of a definition of the one true source for all of our DW info. That's a good way to prevent stovepipes. It's hard though. Lots of overhead. Not all orgs want to do this. There are other ways.

### 7-c Kimball's World

DW is the logical union of all the datamarts.

**First pass** - gather up all the **FACTs** and **DATTs**. Biggest and broadest collection. A datamart is just a clump of facts. Sales facts, inventory facts.

You can use **subject area models** but not required. He uses the matrix instead.

This is the **Matrix**

- The foundation of the **BUS**. It becomes the Guide/Map. Kimball Lifecycle book goes into more detail.
- Simply the identification of which conformed dimensions participate in which Data Marts
  - identifies which DIMs go in which datamarts?

![matrix](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\matrix.png)

At the first level:

- a data mart is a "clump of facts"
- a conformed dimension is
  - simply the "same dimension" shared across multiple data marts
  - when we define a dimension that is shared across two or more data marts, we must use conformed dimensions
    - **Conformed dimension**
      - two identical dimensions
        - Same definition of data (schema) & same content (rows)
      - or related as subset / superset
      - for overlapping parts, they have same definition and content

**Second pass** - project level. This is not enterprise wide, it's in a particular data mart.

- Use matrix as a guide, then focus on details inside an individual data mart

  - define and refine all DATTs inside the DIMs
  - add any newly defined "non-shared" DIMs to the MDM - ?
  - define and refine all FACTs

  **Do everything we've discussed throughout the semester model the FACTs, DATTs, DIMs, HIERs, search for junk dimensions, degenerate dimensions, all of those things.**

  **We create the the first model, the conceptual, the logical, the physical, then implement it. Now you got a schema in a db. The next step is to do some ETL, which is next class discussion. We load the values in. The initial values for all DIMs, FACTs, calc AGGs, then moving forward, load additional values when things change. A new version of customer, product, sale. Then you just repeat that forward.**

### *Analysis and Balancing*

##### Perform **Analysis**

- the Enterprise's **Readiness** for creating a DWE
- the **Business User's view** of the Enterprise
- the **Data System's view** of the Enterprise

Then perform a **Balancing Act**

- is the Enterprise ready to do a DWE?
- what do the Business Users really want vs need?
- what can the Data Systems actually supply?

So you do this, and look for the good and bad signs

Concerning doing this **Analysis** Enterprise-Wide

- ALL "**GOOD**" DWE archetypes **do** this
  - However, it's difficult, time consuming, expensive, a necessary cost, something that must be "done" and "done well", a possible cause for failure, and not a success guarantee. It can fail in other ways as well.
- MANY of the "**BAD**" DWE archetypes **do NOT** do this
  - if we don't do this Analysis Enterprise-Wide, what will happen? We can't provide **stovepipes**. It's not guaranteed. Maturity is doing it consistently

You need to choose between Inmon's or Kimball's world. Here, it is in Kimball's world (Kimball chapter 2)

- Analyze the degree of Readiness for the Enterprise?
  - look at the Enterprise "as a whole"
  - look for "**Bad Scenarios**" (bad)
    - when present, these indicate that we are **not** ready
      - e.g. these (people) patterns
        - **Lone-Zealot** - 1 person is really really excited about DW. We have 1 highly motivated person, but nobody else is. They don't get the resources, have problems with starting/stopping. Project Management issues. If things get tough, and there's only 1 person to give budget, goals, then how do you satisfy stakeholders, who don't even care? This is a long life project.
          - Fix this by finding the zealot some friends. Educate others on it. What is a DW, why do I want one? (education)
        - **Too Much Demand** - everybody wants it, but everyone has conflicting views. Too many people want too many things too soon. So start prioritizing requirements. 
          - Prioritize for realistic expectations and goals (education)
        - **In-Search of Demand** - Lots of people that are interested, but not exactly sure what will be done with it. You don't have a full picture of requirements, so you might be building a worthless DW. How do you know what you're supposed to build, and what are your goals? Requirements = know when to stop, and know when you succeed or fail. 
          - give real business drivers, some achievable goals (education)
  - look for "**Readiness Factors**" (good)
    - when present, these indicate that we **are** ready
      - Strong Business Management Sponsors - this is the **most important**. People willing to give you time, money, training, you can do it. If you have this, and none others, you can grow and make it so.
      - Compelling Business Motivations (ROI) - increase revenue by 5% in first 6 months. feasibility study. cost benefit analysis. increased revenue IR. avoid costs AC. improved service IS. 
      - Good IS / IT / Business User cooperation
      - Current Analytic Culture - if you don't wanna do DW things like market basket analysis, predictive analysis, slicing and dicing
      - General Feasibility - does it seem doable?
  - If bad signs outweigh the good ones - abandon project, or alleviate difficulties. Try again later. Don't do it.

(there was an uninteresting discussion about DW requirements)...

##### How do we Build the DWE for Kimball's world?

- build the Matrix, which is ez after the initial Analysis and Balance
- So then you **plan the Project** (this is a project not a program!)
  - Then...
  - **1st project** is building the schema, the MDM, for 1 data mart
    - Then start Building an MDM for that data mart
  - **2nd project** is to populate it with ETL
  - **3rd project** then query it with pivots, canned reports, pivots
  - Do it again

## Lecture 08

**Domain Studies and Cross Footing**

*7-D, 12 pages*

08_01, 07:30

**Domain Studies** = techniques used to **study the "Domains"**

- study all "potential and actual" values that can "go into" the thing we're looking at
- in math, the **domain** is the **potential inputs** (source). Map from source (set of all potential inputs) to destination. 

You do it with SQL, on any data (OLTP or DWE)

```sql
-- how many discrete (distinct) values are observed?
select count(distinct *) as count
from tbl;

-- what are the lowest observed values and their observed frequency?
-- what are the highest observed values and their observed frequency?
-- what are the most commonly observed values and their observed frequency?
select
	city
	, count(*) as frequency
from tbl
group by city
order by count(*) desc;
-- you can find things like city name typos

-- how many rows have a NULL value observed for a given column? That is, how many are missing?
select
	sum(
        case when city is NULL then 1 
        else 0 end) as cnt_null
from tbl;

-- repeat for mins/max/cardinalities, for more than 1 field
-- this can verify all of the things in our data model. 
-- Does 1 employee work in 1 and only 1 department?
-- every department has 10 > x < 50 employees
```

This helps us to better understand the "size and shape" of the data. Also, if the quality is bad/dirty, it needs to be cleaned.

- In an OLTP, can data violate NULL, FK constraints?
  - Yes, if you migrate to a new version of the server...constraints can be dropped. they can be added, or even added for only the future. The only valid values are debit/credit/check, but then you could drop that constraint and not update the metadata. You can also load data and ignore constraint checking, since that takes time. It changes from db to db, but all db management systems have the ability to violate referential integrity constraints, or temp add/remove them
  - Yes, sometimes these are only verbal warnings

Some queries can **perform reasonability tests**

```sql
-- what is highest premium paid for clients in Minneapolis?
-- if it's $4,000,000,000, then you know somethings wrong. But this does require domain knowledge

-- standard deviation, means, chi-squared...getting into data mining area here
```

This domain studies technique can be applied during:

- OLTP
- staging in the DWE (load to staging area or physical DW)
- loading a data mart (from staging area or physical DW)

##### Cross Footing

Counts the number of "things" in the source and then in the destination, and then compares them to check if anything was lost, duplicated or incorrectly mapped.

Cross footing is a term that comes from accounting.

Simplest approach:

```sql
-- does the source match the destination?
select count(*) from OLTP_customers;
-- 100,000

select count(*) from customer_DIM;
-- 100,000
-- OK
```

The counts may be off, but still OK. The row count may change due to different definitions between OLTP and OLAP. OLTP may only count customers that bought something, vs bought something or interested in buying. There may be duplicate versions of the same customer, in the bad sense. John Smith 2x. This wouldn't be OK.

Slightly more complicated approach:

You can do the same idea, for not just raw number:

```sql
-- does the source match the destination?
select count(*) from OLTP_customers
where state = 'MN';
-- 10,000

select count(*) from customer_DIM
where state = 'MN';
-- 10,000

-- ...where state = 'IA';
-- ...where state = 'SD';
```

You can also compare to IDD formulas (but not necessarily the actual estimated numbers)

Even more complicated approach. Imagine we have:

- 2 source (OLTP) systems A and B

- 1 destination (MDM) system Z (3NF denormalized)

- situation 1:

  - Source system A is 10,000 # customers

  - Source system B is 10,000 # customers

  - Destination system Z is **10,000** # customers

  - How can this be right? How can 10k + 10k = **10k**

    - A and B could be the same customers. This could be the result of a left right or outer join. Maybe db A has shipping info and db B has billing info, and joining them together gives us the answer.

      What if you have NULLs in your outer join? If value is NULL, replace with st else (NVL, case if...). or specify a default value if it's null. *default '<N/A>'*, or *default '<Unknown Manager>'*

- situation 2:

  - Source system A is 10,000 # customers
  - Source system B is 10,000 # customers
  - Destination system Z is **20,000** # customers
  - How can this be right? How can 10k + 10k = **20k**?
    - All the customers could be different. You could UNION them

- situation 3:

  - Source system A is 10,000 # customers

  - Source system B is 5,000 # customers

  - Destination system Z is **7,500** # customers

  - How can this be right? How can 10k + 5k = **7.5k**?

    - Imagine a Venn Diagram. A bit of overlap between A and B, with 2,500 overlapped. 2,500 customers both residential and corporate

      Or perhaps A has both potential and actual customers. 2,500 are new customers, which adds to the 5,000 actual customers. Or any ratio, and any combination of this and the above factor, or duplicate customers, etc

**It's not important if they match, it's important to know why they don't match.** 

Perhaps do some SQL set operations. Select distinct, select minus, select outer join, where not in (anti join)

#### 8-A, ETL Decisions

*5 pages, 8_1 55:00*

ETL = **Extract, Transform, and Load**. But it's more than just that. It also involves **cleansing**. Can be really simple or complicated. Simple mere transformation (e.g. convert varchar10 into varchar 20, or small int to large int. Or convert NULL into 'not yet available'.) Much more complicated solutions such as making sure address, city and zip code make sense, using a GIS db. Looking at names of streets inside of counties...These might be so complicated they may require different tools, or have its own ETL proces

60-70% of budget goes into ETL

There are ETL **Tool Decisions**: 

- do we Build our ETL tools or Buy them?

There are also ETL **Design Decisions** to make:

- Where to do our **Cleansing** in our DWE architecture and lifecycle? regarding architecture and lifecycle

- Which **Source** should be used for each DATT and FACT in our MDM?

Discussing first general Tool Decisions...

#### 8-B, ETL Tool Decisions

*13 pages, 8_1 1h01m*

ETL tool decision - do we **build or buy**? This question exists for all ETL tools:

- extraction
- transformation
- loading
- cleansing
- perhaps others as well, such as tools for data quality audits

This isn't an all or nothing decision though, you revisit it periodically

But this choice must be made very early in the process. But you need time and budget for making this decision, installing and training for the tool. 

*Emphasis*: You **Do Not start writing Java code** to extract from the source, transform and load into the destination. You build an actual tool. Or you write a library/framework. You don't write code the ETL in a programming language.

##### Building

Build ETL tools then use those tools to implement the actual ETL later

**Build Advantages**

- initial cost 
  - isn't so high. Same cost as writing any other software
  - lower licensing costs
- direct applicability
  - does exactly what you need - no more, no less. no bells and whistles to pay for
- learning curve
  - closer to your system, your language, your apps
- customization
  - if things change, you can adjust it. you can port it to a new platform, fix bugs, add features...
- simplicity
  - metadata management is yours to control, and probably very simple..but it might be too simple, and unable to do many things for you

**Build Disadvantages**

- actual implementation / design
  - projects are often too late, over budget
- efficiency
  - multithreaded? virtual memory? memory mapped files? These are sophisticated techniques to make it fast, but you're likely not gonna get it
- desired features may not be available
  - metadata driven? as opposed to hard coded or manually entered data. E.g. imagine a drag and drop pivot where you can check/uncheck based on attribute names...that's all loaded into the tool. It's very sophisticated and easy to use, but very difficult to make
  - using a descriptive and scriptable GUI? you draw pictures of source and destination, and when you want to map, you draw an arrow. If it's metadata driven, it can generate the code from that
- cleansing and quality
  - "Build" is only as good as the other software we write...

##### Buying

Buying vendor ETL tools and using them to implement the actual ETL

**Buy Advantages**

- MD management
  - especially lineage and transformation details. Lineage details let you track a record step by step through the ETL path. Transformation details are joins, unions, case in null, varchar10 to varchar20
- scalability
  - efficiently using multiple threading, parallel processing, etc. We expect that as our size of data grows, the tool can keep up. These grow very fast, very quickly
  - advanced memory management
  - advanced disk access
- cleansing
  - much more sophisticated than most "Build" implementations. GIS is very specific and handles streets, address, counties, etc. Other tools for ML or datamining is available in a buy situation
- logging
  - errors, success, etc. As we pull from a source and transform, cleansing, loading into destination...any time there's an error, we need to see those logs. But any time is succeeds, how many rows were loaded successfully, etc. But this is just very specific metadata management. Use Windows sys log...db log, etc
- customer support

**Buy Disadvantages**

- initial cost (Expensive)
  - licensing & training
- overall complexity
  - power vs complexity. training isnt a lunch time training event. There are likely courses required.
  - vendor decides on what metadata shows up

Build vs Buy. Kimball would say for most orgs, for his architecture, **BUY**. But, go in with eyes wide open and realize it's an investment. You do enterprise wide analysis and balance, then pick one data mart, then build the schema, then do ETL in separate project, do the reports, then repeat for second, third, then do in parallels. Similarly, the first project you use the ETL on, you won't see improvement on productivity or ROI, or second, or third, but after that, dramatic return. Three projects in is three schemas in, which might be your 9th project. That's a couple years in.

Other experts say the Build is better for more mature enterprises.

#### 8-C, ETL Design: Cleansing Decisions

*17 pages, 8_2 21:00*

![cleanse](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\cleanse.png)

**Where to cleanse?**

Imagine we want to **cleanse some OLTP data**. There's missing and incorrect info in there. There are disadvantages to cleansing here. We don't want business users using the OLTP, since it locks, they're not sophisticated (too many joins, possible cartesian products). If you're cleansing here, you're doing **insert updates deletes**. It's so intensive in the production system. **Cleansing is modifying the values, fixing them**. While that's going on, the **tables are locked**. "Nobody buy anything, I'm cleansing". BAD! Never do it.

In a perfect world, you would cleanse in OLTP, but deadlocks/livelocks. So, you:

1. clone the OLTP
2. then you cleanse the clone
3. then you use this to serve as source for ETL

But every time you pull from OLTP into the replica, and you cleanse them, but then what happens? Over in the OLTP, things change. Alice moved to Wisconsin. The price increases 5%. HQ moves. Now you have a problem. Try to pull it over from the replica. You either have to:

- throw away old replica and recreate it, recleanse
- or merge changes from dirty OLTP into clean replica. But integrating the updates would be really hard! Should Alice have an email address? 

This is 2x the cost and bandwidth, licenses double, hardware doubles, etc, because of the replica. So this is not the way.

Pragmatic approach:

- Probably perform cleansing in different places for different data and data issues
  - e.g. some data cleansing is trivial and can be done quickly and easily, anywhere. Other cleansing is complicated and intensive, and should not be done in certain architectural locations. e.g. too many OLTP transactions per second

**5 places in any DWE to cleanse**

1. In the Source Systems **Arguably best place**
   - typically OLTP, or some legacy system, or "other" systems like EIS, ERP, CRM, etc.
     - what are some advantages to cleansing here?
       - if you cleanse OLTP, everything downstream is clean. imagine a water filter in a river, upstream. everything benefits downstream, down to OLAP
       - it's easy to fix it within the same OLTP db (oracle vs ms sql server)
       - if you can cleanse here, there are a ton of benefits. Everything downstream, the applications themselves, easier for devs who maintain it, the dbas who administer the systems, the ETL programmers who extract from the systems. #1 is really the best but not always possible due to downsides.
     - what are some disadvantages?
     - what are some situation details that would make this place obviously a good or bad decision
   
2. In the ETL processes (on the fly - no memory, doing it SQL in-line code). Part of the SELECT statement, or part of the view. Can use NVL, case if null, casts, converts, month(datetime value)
   - advantage
     - Might be the best place, but not always possible
     - easy to change for trivial things, like missing values, stripping whitespace, uppercase
     - good for simple things
   - disadvantage
     - since it's on the fly, it doesnt store anything. it's a lot of overhead on ETL.
     - bad if you gotta repeat everytime
   
3. In the "1st" Destination System Loaded (inmon or kimball **specific**, because inside the DWE)

   - Kimballs world

     - first place the data lands is the distributed **staging area**, then into the DWE.

       - the staging area is on several different dbs, several computers, a json, a csv. 

       - Benefit is you can save the tables. It's partially denormalized...

       - Bad news is that if you cleanse in a Oracle system, you pay licensing. SQL Server another license. Time constraint is must be done during ETL process.

       - Looks very similar to source system...

       - but at the end, you get denormalized, very similar to final dimensions

         If you can't get it done before now, this is arguably best place to cleanse. **Practically the best**. Getting it done in the prod system is just often not possible. 

   - Inmon's world

     - first place the data lands is the **one true DW**, already in 3NF
       - business users are not allowed in the DW, only in the data marts
       - **This is the best place for Inmon**, but for Inmon, this is the one true DW (3NF, business users cant use). This is one big box. This is one big DW on one big server. This could overwhelm the db

4. In the "Ultimate" Destination System Loaded (inmon or kimball **specific**, because inside the DWE)

   - The data source for OLAP (the data mart). It's good because there is still some downstream room. But we're doing it after the staging area - which means we stage it, so we have 1 copy of the Customer Dim with incorrect information, and then we replicate it to *every single data mart* with a Customer Dim in it, then we go to each of these and fix it there. Mucho work. 
     - Kimballs world
     - Inmons world
       - After 1 true DW, it goes to the data marts, which are just a subset of the 1 true data warehouse. That's all a DW is in Inmons. Take that snowflake, turn it into a star, and if you like, select a subset "midwest sales". You never change the DW by changing the data marts.
       - cleansing here would be a bad idea. Better than doing it in the report, but a bad place nonetheless.
       - The data marts are denormalized, strict star schema. You'd have to cleans it in every data mart that had the customer DIM. Better do it further upstream.


1. In the Report / Query - canned report, pivot, or whatever reporting method you're using. **Arguably worst place**
   - doing as part of the data marts, part of the star schema
   - if there's a prob in the dimension (product has wrong price), you gotta be clear to explain what you're doing.
   - advantages
     - everything downstream gets benefit, but downstream is only whoever is reading the report
   - disadvantages
     - star schema data model has 1 fact and several DIM tables, 1 dimensional table per dimension - we're denormalized. But to fix this in the report - you gotta fix for every row. Error in population? Gotta fix it for all 20,000 rows, and as part of the query. It's still worse. You fix in end of month report, then in end of quarter report, then end of year report. You need to fix it for every report! Imagine customer dimension needs fix - now any data mart that uses that table, and every report that uses it. This is the worst place to do it.
   - you find a problem. MN Population wasn't updated. Report is due tomorrow. So fix it in the report, and maybe the other 10. Temporary fix, then go back to normal change management process, and fix it at the right place in the system (OLTP or ETL, or other step)

So what's best? What's worst? You need to fix the problem up front, instead of constantly putting out the fie. It's good to do it upfront, but try to fix the problem anyways. Fix upstream if possible, it's just easier. If you cleansed up front, if all systems had correct info, fantastic. You clean in #1, and you clean the very business system (OLTP) itself. 

#### 8-D, ETL Design Mapping Decisions: Definitive Source

*15 pages, 8_3 20:00*

Before doing any ETL, you first need to **decide what you'll use as the source of the ETL**. And you do it for each star schema.

There are **two primary mapping approaches**

1. **Definitive Source Mapping** - Determine the source and destination for each DATT and FACT. e.g. product or customer is in this data model and that data model. What about customer state? Customer city? 
2. Candidate Source Mapping

Identify data mappings from 1+ sources into the integrated model

- which Data Model(s) should we extract information from? So take it from Sales OLTP, or Shipping OLTP...
- which Data Server(s) should be used? The same data model can appear on multiple dbs. You specificy the db on a specific server
- what information should be extracted? which columns, which rows?
- how do we filter? customers from 2018, or from midwest
- what if there are conflicts? Alice lives in MN, but other source says WI
- what if there are system failures? what if there's a timeout on the server?
- frequency and duration concerns? when was it last updated? How long will it run for? It might determine which source to use/
- system load considerations? How busy is the system? 

For each DATT and FACT, we identify a specific source for the content. This source is typically a single column, from a single table, in a single data model deployed on a single database instance. 

**Easiest scenario: If there is 1 db, 1 data model, single table, single column, that has all info you need, Done!**

So, for each DATT and FACT, specify,

- Data Model: 
- Physical Servers: 
- Tables: 
- Columns: (could be concat(fname, lname))

So again, Definitive Source Mapping = identifying the source means documenting the set of potential dbs, tbls, and cols used for each DATT and each FACT. It's about "**what columns", not "how"** to combine columns.

**Example:**

We have a db named **MN_DB** which contains an OLTP table named **Dealer**, which contains column **Deal_nm**. It's all midwest dealerships. But you need all the dealerships, so you gotta keep filling in.

We also have a db named **Oth_DB**, which has dealer names stored in OLTP table named **Deal**, which column **d_name**.

These 2 combined are the definitive source. You UNION midwest and non-midwest together to get all dealers.

**Do this for every attribute in every dimension, and every fact in the fact table.**

![definitive](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\definitive.png)

You can do this as a table or spreadsheet, etc. 

**It answers the question** "where do I load the dealer_name dimensional attribute from" and it says "it will come from exactly this db table and column, or this db tbl and column". **It's only one of those, that's why it's definitive.** 

**There is no Why. There is now How (union)**.

Benefits:

- acts as a ETL design guide
-  helps plan ETL effort and complexity
- helps report writers and readers understand things like, "where did this come from?"
- if our ETL implementation changes, we need to ensure that this metadata is updated

Think of a case where all DATTs and DIMs coming from one column...date. In OLTP, date is 32 bit integer epoch. From that one value, you obtain day, month, week, etc. Same goes for time.

Finally, **what if there are multiple alternatives** to choose from? If 2 possible sources exist. You gotta pick one of them and make it the definitive source. Choose by looking at reasons above. Maybe db speed, db availability. db license cost, quality of each. last updated time? completeness/null counts?

Candidate Source Mapping = instead of choose a definitive source, you have a ranked source. My first choice is this, my second is this, my third is this...you have alternatives you can choose from. 

## Lecture 09

#### 8-D, ETL Design Mapping Decisions: Definitive Source

Review: Identify the source and destination for every FACT and DATT.

Definitive Source: We pick particular data model, a particular db, and decide what to extract and filter, what to do if there are conflicts. What to do if there are more than 1 alternative locations (Alice lives in MN and also she lives in WI - what to do?), determine what to do if server is down. Examine how frequently info is loaded, when it was last updated. Currently, how busy is the system right now? Maybe pick a server that's less busy.

This is all *meta data*.

#### 8-E, ETL Design Mapping Decisions: Candidate Source

**Definitive says pick 1, whereas Candidate says rank them.**

...

How to pick candidate source? You pick the best candidate, then next best, then next best. What is the db? What is the db platform? What is the availability? Just like in Definitive style, you use this same style to determine which sources are best, and how to rank them. **Definitive says pick 1, whereas Candidate says rank them.**

If you can't use your first choice choice, then use second, and if you can't use this, use third, repeat.

![candidate](C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\candidate.png)

How should we implement Definitive Source / Candidate Source in our ETL?

Well, don't just hardcode it. "Go select from this db, select this table, this column, union it with this, etc". No. You want the code to use for first candidate, or else use your second, or else your third. 

Suppose your doing some stages, and you creating temp tables. They're named staged_temp_(something). If you do that naming convention, you can use the metadata.

```sql
drop table where tble_name like "staged_temp_%"
```

Or drop tables that were created in the past hour.

You can create a table that stores metadata. Whenever you create a staging table, create a table that stores___....

Using this metadata to drive your ETL process is called **Metadata Driven**. It's driven by the metadata. Drop tables using simple technique like looking up in data dictionary, or use little data models to ensure you drop tables in reverse order you created them.

So if you can do that, you can do the above.

Why is this better than hardcoding? Hardcode it, and a year from now, you lose the license for MN db. Also losing NY db bc it's not going to be ported. Now rewrite the sql code.

OR...update the metadata in a table, then read from this table, and tell me the name of the column table_name, and you can dynamically bring in the info. Just update the metadata and the code would still run. Pass in parameters and the code still works. When things change, you get really powerful reuse. If db changes, np.

#### 9-A, Issues and Techniques

*48 pages, 9_1*

50-60% of your budget, time, frustration goes into ETL.

ETL - Extraction Transformation and Loading. 

When you load data into Inmon's 1 true DW, or into data marts, even streaming data, it's the tool for all of that. It's not a cure or a silver bullet. It's just the name of the process, like software development or data engineering. To do it properly, much is required.

- requires experts in
  - the problem domain (health insurance claims)
  - the underlying technology (both OLTP and ETL side, and MDM side)
  - the data models (source and destination)

##### Transformation and Cleansing

Extracting and Loading are important but relatively simple (at least by comparison)

Transformation is where the real work starts. Some is as simple as varchar(20) into varchar(30). ez. 

Transformation and Cleansing attempt to

- But really, combined is where you're doing the integration of dirty data from different sources into a unified dataset. That means dealing with questions like "What is a customer?" or "what about invalid dates?"
- identify semantic impedance
- address semantic impedance issues
- identify / quantify data quality (quantify the level of quality)
- address data quality issues (case when NULL)

**Semantic Impedance (SIM)** - measure of opposition to exchanging data (both meaning and content) between two systems

When this **opposition is "large"** enough, we say there is Semantic Impedance Mismatch (SIM). 

Occurs when one system has either an **inadequate** or an excessive ability to accommodate the input from another. e.g. suppose you have an OLTP model from 630, such as 1-to-many between a department and an employee. Every employee works for only 1 dept, while dept has 1 or more employees. In another db, you have a model for departments, not just a single table, but a really big nuanced model containing subtypes, total participation, 1-to-many, maybe many-to-many, internal managers, external ones, etc. If we have a super simple OLTP model in the other db, we lose much of the info. We don't have the same level of understanding as to what a department is. If you take from super simple and load into complex model, much of the data is lost (**excessive**). Conversely from complex to simple, much of the data is lost (inadequate). This is SIM. Different schema, types, definitions. If SIM is big enough, then we say there's a mismatch.

This is bidirectional. From A to B is not equal to from B to A.

Not all SI can be eliminated. There are always going to be differences

*(This was a very lengthy discussion that i zoned out on)*

SI exists across different:

- SI / SIM as a result of the data modeling technologies/languages
  - our source systems aren't just relational, 3NF dbs. There are mainframes, graph, json based, etc.
- data model types
- data models (everyone draws a tree differently)

**Examples of data modeling technologies / languages** (these are different languages):

- network data model (from the mainframe world)

  - the model uses:

    - record types, data items, and set types - it doesn't have tables and columns, it doesn't have relationships

    - repeating, group, & repeating group data items - like arrays

    - owners and members - not parent-child

    - multimember sets (multi-type relationships) - employee works for dept but so can a company)

    - linking / dummy members

    - no M-M relationships (must use 2 sets and 1 record)

    - ordered relationships - you know what the first, second, third ordered relationship is

    - pointers - just like in a programming language

      <img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\network_model.png" alt="network_model" style="zoom:67%;" />

      There is no DDL. This is not SQL or cmd, this is just some mainframe language.

      ```
      SCHEMA NAME IS SALES_ORG
      
      RECORD NAME IS DEALER
      
      DUPLICATES ARE NOT ALLOWED FOR DLR_CODE
      DLR_ZIP TYPE IS CHARACTER 10
      DLR_CODE TYPE IS CHARACTER 15
      DLR_PHONE TYPE IS CHARACTER 20
      
      SET NAME IS IN
      OWNER IS METROPOLITAN_STATISTICAL_AREA
      ORDER IS SORTED BY DEFINED KEYS
      MEMBER IS DEALER
      KEY IS ASCENDING DLR_CODE
      ```

      This model is actually similar to hashbased indices used in big data like hbase/hive.

- hierarchical data model - tree, not a graph

  - the model uses:
    - record types
    - parent-child-relationship (PCR) types
    - parent-child hierarchy -> trees not graphs!
    - ordered siblings
    - virtual pointers (VP) - so you can connect multiple branches together
    - virtual PCR types (uses VP for M-M)

- relational data model

- object-oriented data model

- multidimensional data model (star and snowflake based)

  <img src="C:\gdrive\01_StThomas\10_DataWarehousing\05_slides\images\hier.png" alt="hier" style="zoom:75%;" />

  ​		Like json or xml.

**So you see how wildly different these models are? Imagine converting from network or hierarchical to relational model. That's very different. That's semantic impedance.**

*(This was a very lengthy discussion that i zoned out on)*

9_3

When we're looking at these data models, the semantics are not always clear. The metadata may be out of synch, maybe the business data is incorrect, or maybe the original document writer left and nobody understands what they meant. These are the reasons why we must be very critical in ETL. We ask questions to stakeholders. But the semantics should make it fairly clear. The technical metadata is useful...but not everything.

There are differences in data modeling techs, levels, models, implementation, tools, there are physical, logical and conceptual differences.

**SI/SIM Causes**

- different languages within CDM / LDM / PDM
- conceptual vs. logical vs. physical constructs
- application Oriented vs. Subject Oriented models
- OLTP vs. OLAP models

Even if we have the same type of model:

- different significance for the same concept
  - in some models, the dimension of a manufacturing plant may be a simple code of where it was made. Another model may have many tables, relationships for factories, quality control, electricity costs, etc. Moving data from one model into another causes issues. Either too much info or too little.
- different understandings of the same concept
  - human understandings of the concept. Stovepipes - different definitions between different business units. Customer vs Prospective Customer.
- different abilities to capture the concepts
  - how good were the people at creating these things?
  - performance considerations - maybe you denormalize or normalize
  - a customer at wal mart 1985 vs 2020 (electronic)

SI (and possibly SIM) exists across different:

- data modeling technologies / languages (from relational to object oriented. From SQL to GSQL)
- data model types
- data models
- Non-Technical factors
  - corporate mergers and acquisitions
  - changing staff
  - customer relationship management (CRM) initiatives
  - multiple applications with data about same customer
  - migration from legacy systems to enterprise resource planning (ERP) systems
  - use of external data sources

Enough of these issues can cause a mismatch.

**SI/SIM Considerations**

There are **Relationship aspects**

- optional vs. mandatory
- maximum and minimum cardinalities
- inheritance
- identifying and non-identifying relationships
- type-less and "N-array"

There are **Attribute aspects**

- domains
  - data types (encoding) and formats (pictures) - e.g. 123 East Street vs 123 E St.
  - precisions and scales, lengths, defaults, units
- optional vs. mandatory (a.k.a. is NULLABLE?)
- scalar (Singular) vs. aggregate (Plural)
- simple vs. complex
- constraints and indexes?
- identifying? unique? any interdependencies?

There are **Entity aspects**

- what are the identifiers?
- what are the candidate keys? as opposed to actual keys
- is it Normalized? or denormalized?
- what are the functional dependencies?

##### General Techniques

Whenever bringing together 2 sets of information:

- are the entities semantically compatible?
- are their keys mutually exclusive? you may have 2 customers in 2 different customer tables. Are they the same customer? Do they have the same value for their customer key? PK is unique only in a db, but not across db. Do their key values have the same values?
- are their attributes mutually exclusive?
- are the instances mutually exclusive? If not, this customer says Alice lives in WI. That db says Alice lives in MN. But one of those states are wrong, so which do we go with?
  - if not then precedence rules are very important
  - e.g. suppose the same customer is in two systems with a different value for the address, phone, or payment status…
  - is this an omission? or bc customer says "i broke my phone, no more phone number"...then it's not an omission.
  - is this the result of an update / requested change?
  - how do we integrate?

## review last 30 minutes of class, or so. Diagrams...hard to take notes on.

Consider a scenario. 

- 2 source systems, one at Site-X, other at Site-Y (OLTP on RDBMS)
- there are two (2) source tables
- there is one (1) destination system (Site-Z)
  - staging or "DW" on RDBMS
- there is one (1) destination (DIM) table

Merge these together into one dimensional model on site Z.

#### Merging Data Scenario 1

## Lecture 10

09-A-ETL_Issues_And_Techniques.pdf, slide 37

Start by talking about Scenario #3.

...

SI / SIM Issues and Causes
potential factors:

- lack of data management
- denial of complexity
- aging documentation
- cultural bias and resistance to change - we don't do things that way
- expert attrition - people leave, get promoted, retire, downsized

Recommend you follow some guidelines when working on a project:

Be thourough, skeptical (the author of a query might have been wrong), systematic & scientific (use domain studies, cross footing), persistent (there are models out there in the data dictionary, for the application, implicit, inside the business model - it simply says "never enter the same id value for the customer id", without constraint).

Look at formats (varchars, ints), lengths, and constraints (referential integrity, primary keys). When things aren't clear, you need to analyze, question, experiment, test, DOCUMENT. Feel for the next person who inherits this project. Did you figure out a problem? Write down the solution, otherwise, you have to resolve it.

Create current documentation, the metadata. You can reverse engineer from the data dictionary and it'll draw a diagram. Create **translations** (where you're looking at something you dont understand, compare it to something you do understand. Think data models like hierarchical data model, relational data model. sketch it into relational model, rough translation) and **cookbooks** (chef is an automated tool for it. It's a collection of recipes. Just algos. Steps of directions to do something. E.g. how to restart the db. How to stop the db. Document the steps. Create a script to do it. How do i do an inner join? How about an outer join?). Use version control. A review process (have someone ELSE look at it, in order to avoid blind spots, typos, bad habits, inferior techniques). And communicate!

Use special techniques like 

- create mapping definitions

- SQL views - a virtual table. You share it, and others think it's a table. They're usually temp tables. 

  ```sql
  create view extract_prod as
  select product, name
  from prod
  where ...
  ```

  Behind the scenes, they see extract_prod, and they think it's a table. They're saved/parameterized queries. When you run a query, and you say in another process

  ```sql
  select * from extract_prod
  ```

  It literally gets replaced by

  ```sql
  select * from 
      (select product, name
      from prod
      where ...)
  ```

  It is created from a query. It is reexecuted each time, which is good because it gets latest values, instead of being stale.

  It's also good for security. If you're selecting from an employee table, you can give them access to certain table fields, but not other fields. If you don't allow access to see the pk, they can't insert into the table (pk constraint). You can also prevent SQL injections, bc you can't select all columns. You can't update the entire row without knowing about them.

  Important for our use case, views are excellent for:

  ```sql
  create view
  extract_prod (product, color) -- this renames the columns
  as
  select product, color
  ```

  So now what you can do is use metadata to drive the process. If you have a source and destination, and connect them in the tool, the tool is smart enough to say any columns that have the same name, A gets mapped to A, B to B, C to C.

- **cross footing and domain studies** (simple select queries) - **review lecture**. Most important technique.

Different data models will model identify and represent concepts differently within the same business area / process. What are the odds that everyone draws a tree the same way? There are always differences.

The enterprise-wide, integrated view of these business areas and processes is (by definition) an attempt to achieve consensus across these different models while retaining as much added value as possible. We have to make some compromises. Potential customer vs actual customer. Either populate and fill in with "not applicable" or remove the inapplicable attributes. Analysis and balance relates to the consensus. See file SEIS732_Fall_2020_PBO.pdf. This is what you would have after talking with Marketing, Sales, Management, etc. This enterprise wide view is what the data model is based on. There's always some degree of difficulty when taking from OLTP model, loading, cleansing, into the DW. 

### 10_A Tools

- Open source
  - JFreeReport - Open Source Reporting
  - Kettle - Open Source Data Integration (E.T.T.L.)
    - The "extra T" stands for "Transport" (going across many computers, but this is silly buzzword)
  - Pentaho - Comprehensive Open Source BI Suite
  - Weka - Open Source Data Mining
  - [Mondrian](http://sourceforge.net/projects/mondrian) - Open Source OLAP Server
  - [JPivotTable](http://jpivot.sourceforge.net/)

- Non open source
  - Oracle
    - Data Warehouse Builder,
    - Data Miner
    - OLAP
- Academic Alliance (DreamSpark / Imagine) is a good place to find commercial for educational purposes

For this course **SQL Server 2017**

- DE is EE for development only
  - EE/DE have more support for scalability and distributed environment (more instances, replication, scalability)
- SSE is the "simplest"

It has multiple components (we will use the bolded)

- Reporting Service (SSRS)
  - uses a Web Server (IIS) - it can be a security risk, especially if you connect to public wifi
- **Analysis Service (AS)** - the engine we use behind the scenes. It's for data mining, but we won't use it for that. We use it for milestone 3, in MOLAP bc we connect to it with pivot tables. Behind the scenes it'll use XMLA to talk to that MOLAP version. 
  - used for OLAP and Data Mining
  - XMLA over SOAP
  - OLE DB for OLAP
  - ADO MD (and ADO MD Dot Net) - for multi dimensional, but doesn't use SQL. It uses a multidimensional language.
- **Integration Service (SSIS)** - milestone 2 and 3.
  - AKA SQL Server Integration Services (SSIS)
  - AKA "the new and improved Data Transformation Services (DTS)"
  - AKA ETL
- Notification Service - allows services to talk to each other. Imagine metadata exchange. This would be used to implement it.
  - used to connect the components and subsystems implicitly and explicitly
- Replication Service - behind the scenes can be used to replicate datamarts, dimensions, etc. We'll only be working on 1 datamart though.
  - transactional, merge, and snapshot flavors
- **Relational Database Engine** - the DBMS we'll be using the most.
  - Fallback - from 630 if you're running a query and the power goes out, it rolls back. you have backups
  - Recovery - we'll be creating and recreating, so we wont be using this like in a production env
  - Data Storage
  - Indexing
  - Security
- Service Broker - behind the scenes. It's cool bc it's one thing you can use to implement reliable asynchronous messaging. Reliable messaging...not just TCP/UDP...think of all components in DW environment. Several datamarts and db in staging area. These things need to talk, tell statuses. They msg each other. If these are like people talking to each other. Imagine email. A can send to B, even if B is down and not reading email. But this unreliable messaging can cause problems. If you send multiple emails between people, problems may be that you ask someone to do something, and then an email that says "Dont do that!". What if they arrive out of sequence? Trouble.  What if you ask the whole group to send the customer a bill, and everyone does it? Everyone tries to drop a table at once. Problem. Worse, out of sequence, processed by multiple people, OR, messages don't even arrive. Check is in the mail. Router goes down, firewall blocks message 4 out of 5. Or you get message 3 multiple times. Reliable asynchronous messaging resolves this. You're guaranteed messages transmit once and only once, and they're read in proper order. It uses the db to implement a persistent queue. Very powerful tool, bc all DW are distributed, by definition. 
  - Reliable, Asynchronous Messaging (implemented using the RDBMS)

### 10_B Data Tools

**solution**

- the data tools allows you to create a **solution** (just the name it gives to the directory with all the files and subdirectories it needs to create your ETL
- a solution can contain one or more packages
- each package can be created independently
- when you create a connection to a source or destination database, it has a server instance, username, password, and database. This is given a PK. if you tried to copy things from one package to another, it might not work correctly

tasks

- are simply components that perform work
- have a technology "flavor"
- can use connection managers / connections of a particular flavor
  - as Sources
  - as Destinations
  - as Both Sources and Destinations
- only same flavor will work with each other



## Lecture 14

11-A-ETL_Data_Storage_Overview_and_Controversy.pdf, 27 pages

There's a controversy between data lakes and ETL. 

Later, tactical systems are discussed.

Extraction Transformation and Loading (ETL) - is the name used to describe the tools and technologies behind all the tasks and activities needed to get data from the operational source systems into the data warehousing environment's data stores. It's all of the things needed to convert it...

- there are many different types of source systems - flat file, relational, object oriented,
- there are also different possible destination data stores - different versions of dbs, diff platforms, diff data models (xml, json, big data systems)

- ETL is a big world. Kimball dedicates 2 chapters to ETL - "34-subsystem" view Kimball is discussed in Chapter 9

We'll use a simpler approach. We focus on what ETL MUST do, and HOW to do it.

There are 2 types of ETL

	1. Initial (historic) load
	2. Incremental load (alice moved from MN to WI)

In our project, we do the initial load.

Data Staging - this term has no formal definition. Staging means "prepping data for ETL". Like moving boxes from 3rd floor to 1st floor - you could move all boxes out of office, then load in front of door, then everything down elevator. Small stepwise refinement. It's preparing, transforming, cleansing data.

This means creating tables (not all on-the-fly views that need to be rebuilt each time). So create some stored procedures, some tables, some views. 

#### Kimball's World

"Data Staging" usually refers to the Distributed Staging Area within his architecture. This is a collection of as few or many systems as we need. Many machines, db servers as we need. It's super flexible. Can include csv, db contructs like tables, views, or xml/json. This is distributed, so it can be on diff OS, dbms, hosts, file servers...

### The Distributed Staging Area (DSA)

- the DSA resides in the back room
- business users are not allowed to query the DSA directly. Don't do it - it violates Kimball's directions! 
- The reason is bc this is the ETL dev's area. Dev's should be able to reimplement and edit as they want. They shouldn't need to worry about breaking front room reports. similar to how we used views to protect the tables in our OLTP / 630 databases
- This is in other words information hiding, encapsulation, loose coupling. It supports black box behavior, but you can do glass box editing.

By analogy, the back room DSA vs front room Data Mart

- white box vs black box in testing
- private implementation vs public interfaces

Be careful when changing the MDM (the public view of data marts and DW). We can change the DSA with much less difficultly, but we still need to look at impacts, but they are confined to back room

The DSA is like scratch paper - like temp variables.

DSA models are not constrained, but typically

- we would see initial models (or parts of a model) that look very similar to the source systems. These are usually 3NF, application-oriented
- Later models (or parts) look like the MDM destination because they're denormalized, subject-oriented, dimensional

This gives us greater flexibility - we can transition on or off a mainframe to big data, from Oracle to MS. 

#### Inmon's World

There is no formal staging area. In the data model, Inmon's 1 true DW is in 3NF. One big set of snowflakes. Several tables for each DIM. 

Why does he do that? 3NF allows you to load the data better - you can make an update for the engineering dept more easily. Just update the 1 row in the dept table, then all 1k employees are updated. 

ETL is mainly insert update delete. 

### ETL Overview

- Always has Extraction from the Source. 
- There are *usually transformations*
  - small varchar 10 to varchar 20 (upcast)
  - varchar 20 to varchar 10 (downcast)
    - do your domain studies - and determine it's ok to change
  - convert Minnesota to MN 
- *often (but not always) has Cleansing*
  - case when NULL...
  - NVL replace null date with "has not happened". a nice subject oriented value like this is easier to deal with.
- *always has Loading into the Destination*

**ETL**

- is the most risky, uncertain, and expensive part of a DWE
- approximately **60-70%** of your budget (also effort and time, blood sweat tears frustration). Effort vs time (labor vs schedule)
  - effort (labor) is measured in person-hours. a 24-hour person task might not take 24 hours. You can split it across people. you could get 24 person hours done in 1 day, or split it across people, or across days of the week. Suppose you have a DW project that takes X hours to complete an MDM cube. From Kimball's approach, 6 person-months to get it done (for each ETL). Not just 1 person working 6 months...but 2 people might not get it done in 3 months, since there are inefficiencies. 24 people in 1 week? No. You can't do everything in parallel due to communication and other overhead. 
  - 
- effort = about **6 person-months** per business-process / MDM / DM
  - a 5D cube with 10 DIMs vs 24D cube with 500 DIMs. It's just a rough estimate, and you need to consider detailed factors.
- is plagued by issues
  - several issues can only be discovered during the ETL process (semantic impedence mismatch)
  - often unexpected issues. You try, you figure it out by doing. Bugs in the db
  - difficult to anticipate or estimate accurately
  - These issues can be discovered at different points in the process. Design, implementation, or execution. 

ETL is crucial for:

- data mining (looking for unexpected things)
- online analytical processing (OLAP)
- metadata (MD)
- our data and information quality
- the DWE implementation - this is where we populate the data, transforming it from OLTP into subject oriented, non-volatile time variant DW.
- the DWE's success: (ETL implements these and more)
  - **data latency** (how long before we see the data in the DWE) how much time passes before st happens in source system before you see it in DW.
  - **data lineage** (how did the data get to the DWE). keeping track of every step along the way.
  - the four defining characteristics of a DWE! non volatile is done when we do changing dim type 2. 
    - REVIEW THAT, IT WAS GOOD. 5 minutes
  - ultimately, the single version of truth! ETL is responsible when it fails, quite often. Due to stovepipes, silos - 2 diff answers to the same question. Multibillion 8 ball - shake and get random answer.

### ETL Controversy

***See recommended video for class prep***

Some people don't like it due to shortcomings. Instead, let's do ELT. ELT is supposed to be a new approach - reorder the letters - but it's not that simple. Extract Load Transform. Cleansing and Staging is included as well. First Extract, then you Load. Don't transform. Load it likely into staging area. Now you can use precleansed data or simple transformations. This is what we use to do operational analysis. Eventually, you load into DW. 

There's another more aggressive approach. Create lookup tables to join the tables you've loaded. Use lookup tables which transform it on the fly. Like cleansing on the fly #2...don't bother loading it into DW environment. The transformational lookup table is 

- recent trends claim "**ETL** is Dead, Long Live **ELT**!"
- the term ELT is meant to imply a "new approach"
- for example:
  - extracting
  - loading (into a "staging area")
  - potentially using the "pre-transformed and cleansed" data as the
  - source for operational analysis
  - and eventually transforming into the "data warehouse"
- alternative example:
  - using "transformation lookup tables" within the "staging area" and "never" actually transforming the data

Let the user convert 23 to Minnesota, 24 to Montana using a lookup table. 

ETL Claims (***missed some of this after break***)

- ELT is better for (and commonly used with) "data lakes"
  - loosely speaking a data lake is a "big data pool" of data
  - usually unstructured or semi-structured
- ELT is better because traditional ETL "destroys" all staging and has to "redo" all the work
- ELT is better because traditional ETL takes too long. In particular, this is more an argument from business standpoint from tech standpoint. "It's taking too long to run on the server" - so just buy a faster server. No, they mean from a business standpoint. "We wanna do an analysis in order to make a decision" "sure" "but it'll take us 6 months...give me until September." Unacceptable. ELT can be done quicker.
- ELT is better because traditional ETL prevents operational (operational = tactical) analysis because traditional takes too long from a business standpoint, is too cumbersome, and just does not work right
- ***Review what he said after the break***
- ETL is bad for tactical decisions. ETL latency and query performance is too slow. Not as current. More time to make the decision. Better for strategic. 
- ELT is good for shorter term decisions, using less history.

### Defusing controversy

ETL: defusing the controversy

- **claim**: ELT is a new ordering of the steps in ETL

  - first of all: re-ordering ETL into ELT is NOT necessary because "traditional ETL" can be a multi-phase process, with steps in any order we choose
    - for example, we could do Transform-Extract-Load (TEL) or Extract-Load-Transform(ELT) or even more complex arrangements of these basic steps (e.g. )
    - *But that's not really true. Traditional ETL is before a multiphase process. We don't load it all at once, we do several steps. Send from site X to Y to Z, union, join, create view...It's a multistep multistage process. That's an ELT. It''s more like E-L-T-E-T-L-T-E-L* . You don't use a waterfall model - extract everything, then load everything then transform everything. It's all intermingled. 
  - therefore merely reordering ETL to be "ELT" is not by itself a real change…

- **claim**: ELT is better for (and commonly used with) "data lakes"

  - data lake = big pool of data, in a distributed cloud/cluster. You can use any data model you want - relational, network, obj oriented, hierarchical. Data lake is fine, tho ETL was around before data lakes. ELT isnt the only thing that gets to use data lakes.
  - nothing in ETL that prevents us from using a data lake. Nobody has ever said a data lake is incompatible with ETL. 
    - data lake could be used as a primary source, just like a relational could be
    - data lake could be an intermediate source
    - data lake could be used as a "staging area" (for Kimball or anybody else's world)
  - therefore, using data lakes does not necessarily mean we cannot do ETL and potentially do it well

- **claim**: ELT is better because traditional ETL "destroys" all staging and has to "redo" all the work

  **That's actually partially true**. *For our project, you do the initial load, and that is what you would typically do. You need to use the right version of staging tables, stored procs, etc. You wanna make sure that you didn't manually do something, and ETL runs correclty on your machine, but doesn't work on someone elses because they don't have the same edits. Best Practice is to destroy and load the data.* 

  - traditional ETL typically has two flavors: the initial load and the periodic update
  - while the initial load will often destroy and restage data, it is not a strict requirement
  - similarly, the periodic update does NOT necessarily destroy and restage
    - as a best practice, it will do this for some circumstances; but this is a physical consideration and NOT universally done for the entire DW!

- **claim**: ELT is better because traditional ETL "destroys" all staging and has to "redo" all the work

  *The periodic updates are usually just appends. Sure if you have SCD type 1, and it changes in place, you have to recreate all AGGs. You'd need to destroy and recreated. But that's rare. You usually just append.*

  - for ROLAP data marts and "physical data warehouses", the periodic update is usually a simple append of ONLY the information that has changed
  - caveat: recall our discussions of SCD types and the impact on AGGs
    - e.g. if we have any changes for SCD type 1 DIM members, we might need to overwrite rows and destroy / re-calculate some AGGs

- **claim**: ELT is better because traditional ETL takes too long

  *A little more concerning. It just takes too long to do. It's more of a software dev process - get approval, launch, execute, etc.* 

  *ETL takes too long...but if ETL loads the 1 true DW in inmon's work - business users aren't supposed to go back there. That's for the backroom.* 

  - more from a business process standpoint than electronic process execution…
  - possibly from a software process standpoint too…
  - but the question of "what is a data warehouse?" is very important to these claims
  - e.g. are we comparing ETL loading the "one true physical data warehouse in Inmon's world" or ETL loading one or more data mart in "anybody's world"?

  - In My Humble Opinion (IMHO) this is a strawman argument

    - they claim we are doing tactical analysis
    - they claim traditional ETL in our strategic systems is too slow
    - they claim therefore traditional ETL takes to long for tactical analysis

  - BUT they are doing it wrong!

    *Notice what happens here tho - DW and data marts are strategic systems. The 1 true DW is a strategic system, not tactical. If you try to use a strategic system to answer tactical question - mismatch. Talk about DW or data mart and complain ETL is too slow. In inmon's world, they should use ODS for tactical questions. Kimball's does something else. Kimball has a special kind of data mart called "operational data mart". It's designed for tactical questions. Using a hammer as a saw isn't going to work. Use the right tool for the right job.* 

    - the one true data warehouse and "normal" data marts are strategic systems NOT tactical

  - IMHO, this is a strawman argument -- we will discuss this further in the next lecture, but for now:
    - Inmon uses an operational data store (ODS) for tactical analysis NOT the one true data warehouse or a "normal" data mart
    - Kimball creates a special kind of data mart called an operational data mart (ODM) for tactical analysis reporting
    - traditional ETL in an ODS or ODM is NOT supposed to take a "long time" for the business or software processes!

- **claim**: ELT is better because traditional ETL prevents operational (tactical) analysis because traditional takes too long, is too cumbersome, and just does not work right

  *Possibly true! But if this is true, it's not always true, and not true by design. ETL is not supposed to be taking too long. If you have this problem with tactical analysis, it might reflect a deeper problem. Consider the balance - are you ready? Are the kings and queens ready? Does the business user want to support it? If you can't get it done in time, then you weren't ready, mature enough, and maybe lifecycle implementation isn't sound. *

  - while it is possible that this might be true for YOUR DWE, it is certainly not always true for all data warehouse environments
  - In My Humble Opinion: if ETL has these issues for tactical analysis, it would indicate much deeper problems with the DWE
  - E.g. issues with enterprise readiness, maturity, or life cycle implementation

- performing analysis against staging is not considered best practices by most "good DWE approaches"

  - if you need to be more operational / tactical then create a "operational / tactical" system in the DWE and use it! That would be a better solution

- ELT (is also not-standardized)

  - some versions of ELT are definitely "bad practice". It's not a standardized term. e.g. some ELT versions out there have big disadvantages.

    *You create a big pool of data - a data lake. You might transform it or leave it behind and create another big lake of data. If you keep doing this, never actually transforming, integrating, bringing it together - this is where data goes to die. You're building a data graveyard. It's a data swamp, data bog. You end up with multiple versions of unsynchronized data, you end up with silos or stovepipes. What is a customer? What is an actual customer? If stovepipes never get brought together, you get large pools of separate data.*

    - leading to a "Data Graveyard", multiple "versions" of unsynchronized data–"silos / stovepipes in the staging area"

  - other versions of ELT are compatible with what I have seen in "traditional ETL", in which case they are not really an alternative

- we **watched one video** that claimed "data lake vs DWE" was more a matter of "open-mindedness" vs "orderliness"

- IMO

  *DWE's are definitely orderly, (grains, dimensions, hierarchies) but I have some issues with the data lake claiming to be "a consistent source of truth". It might not really be a consistent source of truth. Any time you load data, whether to transform before during or after analysis - if you're doing multivariable analysis, you're doing multidimensional analysis, which means additivity, grain, granularity mismatch issues, stovepipes, etc matter. During that analysis, you think through it, you document, you make good decisions.* 

  - however, since the video made a point of emphasizing that the data lake "creates schema on extract" we should think about that carefully…

    If you have several people writing similar reports, different people treat the same data differently, and some choices may be wrong. Do meta analysis and you're comparing apples to oranges. "This person double-counted sales price." With big data, you need to verify it. 

- my concern…

  - is there any way in a data lake / ELT world for us to verify that we are not doing "bad things", such as the issues we discussed previously
    - e.g. additivity issues, (like potential-customer vs actual-customer), etc.

- discussion: what are your thoughts on this?

Are we doing things the right way? The business users don't get to determine that. DW gives you a way of visualizing it, to think about these issues - even if you're not doing DW. Multivariable analysis is multidimensional. 

**11-B-Tactical_DWE_DataStores.pdf**, 15 pages

There are 2 main types of tactical systems - ODS and ODM.

ODS are radically different from data marts. 

#### What is an Operational Data Store (ODS)? This is Inmon's creation, from the start.

- in General, an ODS is *somewhat similar to any DW / DM / DWE*
  - it is subject oriented = for the business user, but not as much as DW
  - it is integrated = combined from multiple dirty sources, so transformations and cleansings. but not as much as DW
  - it is something used for analysis and decision support
- any ODS is also:
  - It is not the OLTP Systems or OLTP Storage. You're not running analysis against the OLTP db. 
    - i.e., it is NOT the same as the Virtual DW DWE!
  - frequently loaded - much more than DW or data mart
  - focused more on detailed information than summarized information. ODS is more focused on detailed info = FACTs (at the grain of the fact table), not the summarized = AGGs. FACTs are more relevant in tactical analysis.

**According to Inmon**, an ODS is

- **subject oriented** - this is what a sale is, this is what a customer is

  - …means the same as it did for DW / DM / DWE

- **integrated** - combined from more than 1, probably dirty, systems. You need to do ETL, extra transform load cleanse.

  - …means the same as it did for DW / DM / DWE

- **volatile** - An ODS is Volatile- the opposite of DW non volatile (whenever you make a change, you append).

  - regularly updated - 

    ```sql
    UPDATE INPLACE
    INSERT
    DELETE
    ```

- **current valued** - not time variant. It's "nearly current", depending on network speed, CPU speed and "ODS Type" (diff types of ODS have diff levels of being current). We don't need to be time variant, though we could be. DW is strategic, so it's updated less often. Perhaps it's 15 days out of date, but if you're using 5 years of history, that's fine. "Nearly current" means more current than that. 

- Inmon quote:

  - "Containing Only Corporate Detailed Data" 

    more detailed than summary. DW has details, data marts have summaries. ODS is more like the 1 true DW than a datamart - focused on details, has to be updated quickly, but doesn't have the AGGs. So the data model looks more like the DW. They are more normalized than not. 

- caveats:

  - these defining characteristics are NOT absolute!
    - not all ODSs will have the same degree of compliance with these things…

- discussion:

  - recall: what do "detail" and "summary" mean for a DWE?
  - based on this distinction, which of the (other) two architectural data storage types in Inmon's world, is an ODS more like?

- **according to Kimball** there are "two interpretations" of ODS

  - interpretation-1: (Transactional) - if you have an operational data store and you use it to do transactional things - to run your business - it's an integrated system you basically do OLTP on. 

    - something "outside" the DW (not part of the DWE)

      - an integrated system used for OLTP
      - i.e., a potential source system like any ERP / EIS (enterprise info system).

      **That's fine!**

    - interpretation-2: (if you're using ODS to write reports)

      - this is the "front edge" of the DW—something that should be migrated (become part of) the DW. get rid of the ODS - since it's an integrated system you're using to do OLAP
      - i.e., in the past this was Inmon's ODS but it should be re-implemented as an Operational Data Mart (ODM)

      **Don't do analysis on ODS, do it on ODM**

- according to Kimball an **ODM** is a Data Mart!

  - **subject oriented**, integrated, non-volatile and time variant

  ODM has some special handling. 

- an ODM is also:

  - frequently augmented
    - regularly appended (non vol time variant)
  - focused on detailed data - more likely at lower level granularity such as transactional level. 
    - at the business / operational system transaction level used for a special purpose / using special handling
      - e.g. we can archive old data (and move it off-line). It's not a replacement, it's just loaded more quickly, without all the AGGs. 
      - e.g. we can be less focused on AGGS

- let's focus on ODS (not ODM)

  - ***an ODM is somewhere in between an ODS and a "normal" DM so we don't need to focus on it separately here…Not as tactical, not as dirty, not as overwritten, but still not a traditional data mart***

- an ODS provides a common view

  - application independent
  - possibly integrated and cleansed?

- an ODS provides a independent storage. Not as much time to do cleansing and integration, so maybe a little bit cleansed, little integrated. Maybe not so clean.

  - less impact on production systems. We won't be doing decision queries against OLTP (transactions are running, server is busy). But you can query this one!
  - other benefits = backups, replication, subject oriented

- an ODS can (but does not necessarily):

  - focus on tactical (not strategic) decisions
    - what's the difference? It's built for tactical - quick decisions. Less time to make the decision, so less processing time. Smaller part of the data, bc a larger amount of data wouldn't really be helpful. 20 year old history is irrelevant. 
    - what does this imply? Less time to cleanse, etc.
  - use normalized or denormalized data models (or somewhere in between). Normalize when you must, but as it gets slower, not as current, you can be more denormalized like a star schema. It's partway between norm and denorm. You might have profit as calced from sales - cost. You don't have to store that, you can calc it. Don't do too much - can't do many AGGs. 
    - include some derived data and some summary data

- Sort-of "**in between OLTP & OLAP**"

  - this can vary based on the ODS Type, the implementation, and other factors…
  - some ODSs will be more "OLTP-like"
  - other ODSs will be more "OLAP-ish"

- **when the ODS is "more like" an OLTP system**

  - the data model looks more OLTP-like
  - we cannot do as much integration and cleansing
    - i.e., the loading will be easier, cheaper, and faster, but we will NOT get any benefits that integration and cleansing can provide

- So, there's less support for OLAP-ish features

  - i.e., consider all the criticisms Kimball raised against using E/R for dimensional modeling. Don't do normalization for OLAP. Use star schemas.
  - i.e., NOT VERY GOOD for AGG, MINING, MD, pivoting, drag-and-drop authoring, etc. It's an ODS that's very similar to an OLTP system.

- **when the ODS is "more like" an OLAP system**

  - the data model looks more OLAP-ish
    - like a star, snowflake, etc.
  - we can do more integration and cleansing
    - i.e., the loading will be harder, more expensive, and slower but we WILL get the benefits that integration and cleansing can provide. You have better quality data as a result.
    - but there is probably still less support for OLAP-ish features than a DM / DW would provide
  - we can discuss four distinct ODS Types (archetypes) that divide this range of possibilities

### The Four ODS Types: 

Type I (Type 1) - "*Updated and Synchronized*". Update these on a fairly regular basis. Think Airline flight information - landing time, takeoff time, but after it's landed, who cares? Can load it into strategic system, but not on a real time basis. This is the **steaming data**, coming in quickly, need to make decisions on. Most rapidly changing synchronized. 

- 2-3 second delay before OLTP reflected in ODS. Every time something changes in OLTP system, it's reflected 2-3 seconds later in ODS, repeat over and over.
- usually populated using Message-Oriented-Middleware (MOM) and DBMS Triggers. MOM = set of tools/api that allows you to send messages from ODS to OLTP. "go get the changes". It uses DBMS Triggers to capture those changes. An event fires the trigger. A special stored procedure that gets called when theres an update delete insert. You can see changes in virtual tables that show old value and new value
- little if any transformation and integration is done
- high performance
- little if any summary data available - you don't need to recalculate annual totals every few seconds - when are you gonna use it?

- examples:
  - an airline flight delayed status ODS. Ever been to the airport and see flight from chicago was 15 minutes late. now 30 minutes. no actually 5 minutes late. The time is always changing. The gate numbers change. Then the return flight begins. The ODS is there to help us determine when, where the plane will land...but an hour after landing - who cares about the time of landing, the gate? These are useless for tactical info. But for strategic, you may want to know how many were late this year. Sure, it doesn't have the time, but you don't care either.

Type 2 - "Store and Forward". Updated less often than type 1. Maybe 1-2/day, or slower. The loads will take a lot longer since you loading 1 full day of data. Might take 15-120 minutes to load. Do the load during off peak hours. Think corporate bank account. 

- not as immediate as Type I
- updated less often (approx. once a day)
- refresh takes 15-min to number of hours
- usually populated using MOM and DBMS Triggers
- more transformation and integration can be done
- maybe some summary data is available
- examples:
  - a corporate bank accounts ODS

Type 3 - "Most Asynchronous So Far". Doesn't have to be every second or every day. You trap info in OLTP and update perhaps once a day, or less often when you're busy (weekends). Usually an overnight batch job, and it's a larger set of info so you have more time to process. So you might use db logs (undo and redo logs, same way as replication). You  have more time for transformation and integration, more time for AGGs and OLAP cubes, star schemas. You can make it fairly tactical, fairly OLAPish. This is the most commonly used type.

- most commonly used of all 4 types!
- typically, data is trapped in OLTP systems and the ODS is updated daily
- batch / snapshot run over night
- using RDBMS logs and MOM
- much more transformation and integration can be done
- much more summary data can be available
- perhaps there are even some OLAP Cubes, Star Schemas, etc. available

Type 4 - Very similar to type 3, but analysis is from DW for supplementing ODS. You can fill in the details like year to date, monthly totals, other things you wouldn't load in ODS that are in DW. 

- analysis data from a data warehouse (or some data marts) is used to supplement the ODS
- otherwise very similar to Type III
- updates can be at either regular or irregular intervals
- this is the only ODS Type that requires a Data Warehouse (or a Data Mart) in addition to the ODS
- more complex than the other types, but there are benefits…

**Type 1 2 and 3 can be used with a DW. Type 4 must interact with a DW.**

These are the **tactical systems**:

Type 1
extremely current, NOT very clean, integrated, more like OLTP 3NF, more application oriented

Type 2
Moving towards OLAP. not as current as Type I, but cleaner than Type I

Type 3
**most commonly used** ODS Type
more detailed than Type I or Type II as well as more AGGs, since it's loaded less frequently, more time to do calcs.
cleaner than Type I or Type II

Type 4
a Type III that is supplemented with info from the DWE.

**In Kimball's world, you can use these ODS. It;s just a data mart you load more frequently but do less integration cleaning or AGGs.**

## Lecture 12 - from here on, it's no longer about loading, but querying the data

### The Curse of Dimensionality (TCD) and (light) Data Mining (MINING)

12-A-TCD_and_Data_Mining.pdf

### Mining Overview

It's not really a new concept, but with DWEs and other advances in technology it is becoming more useful and practical

**Mining** = is a set of tools, techniques, algorithms, and activities used to discover **meaningful**, **new** correlations / patterns trends by examining / analyzing **large** amounts of data. This includes Machine Learning & AI aspects, predictive analysis. Bc it includes new, meaningful, large, we need **automation**.

That is - you search in a large amount of data for something that is meaningful to our business users, so they can make a decision (practical) and a stats way as well. Also new relationships, patterns, info. DW are big expensive long living systems. If you want to do data mining off this, you don't need to build a multi million DW environment, you don't need this to discover peanut butter sells well with jelly. You're looking for new things, across the business areas across our business. Also large in terms of history as well as size of data, and also the variety and velocity of data comes into play. You need help for this - you **can't do this manually**.

This includes a focus on what we need to do with our DW in order to help mining.

Methods:

- not a mining technique bc manual. Look at Inmon's Corporate Information Factory. The top right, 03-A.pdf, slide 20, top right, Exploration Warehousing. This is exploring - looking around, like surfing the web. Discovery is a bit more guided. Navigation is more focused on moving from one set of findings to another. This is finding the lay of the land before going into the mining. These are important enough that Inmon built sepereate warehouses to support these efforts.
  - Manual Exploration
  - Manual Navigation
  - Manual Discovery
- Not strictly data mining. It's what you see in predictive analysis or ML. This is about seeding the data to do a better job. Improve data mining by feeding it the right set of data, the right sample. Do this before or after mining, rather than during the mining itself.
  - Data Farming
  - Data Cultivation

**Mining** is highly automated set of activity, uses sophisticated tools and techniques, recommend you use DW data, though any data would work. It's a good idea to do it in ODS, DW, Data mart bc you have everything pre-joined in a star schema. It would be hard to do it in OLTP system because you would need to do data cleaning. The raw data might need to be cleansed. There is one unified view in the OLAP system. Integration work - business users may write runwaway cartesian products. Metric vs Imperial data. OLAP has a consensus in the data. You have metric and imperial in one. USD and EUR is not controlled OLTP. You're not gobbling up the OLTP system resources either. You can create a special purpose DW, and denormalize as you like. You can also benefit from DW subject oriented, user friendly data. String text instead of integers. 

**Mining Output** is not necassarily complete, correct, or statistically significant (meaning p-value, imagine bell curve. go out 1 or 2 standard deviations, and you choose how confident you want to be from the p-value. From data quality - six sigma - this is the standard deviation, 6 std dev out on the tail. You're odds of finding a problem is 99.9997 pct likely not to find that value. You're confident you're not going to find a problem. You determine how probable you'll find your result. You determine the confidence level). Just bc you're doing data science with fancy tool - the method may be bad. You can proof anything with a 50% confidence level. You need higher confidence.  

And relevant, valid, meaningful, or useful - so the business can make tactical or strategic decisions. 

You still must **manually** analyze the results, but this is a higher-level of analysis than what the mining did. You search for unexpected relationships. Market basket analysis of kwikimart you find evidence that people buy diapers and beer. They prove it's statistically significant, and not random. 

**How do you look for unexpected things**? Look at everything and sift for gold? Impossible. You can't analyze relationships between all items. That is, it's not practical or perhaps possible. bc NP-hard and / or NP Complete…(NP=non-deterministic polynomial time). 

Look at the Big-O. O(n^2), O(n log n), ...etc. It represent the increased computation time, or steps. It's a counting function of say (5n^2 + 3x + 5). You look at highest exponential term of n, and ignore the multiplier 5. As you move to infinity, the 5 is irrelevant.  O(2^n). This is not possible, not enough time to compute. There are many processes that fall into these NP-hard categories. If you can solve a single NP-hard problem, many other problems would be solvable, billion dollar solutions. This is polynomial time. 

Non-deterministic because you can't predict the outputs using the inputs. There are variables. It's not a clean mapping. If you introduce a bit of chaos or noise, it's not deterministic. It might be deterministic, i think, if it's O(5+x), but other more complex functions could fuck it up.

#### TCD - The Curse of Dimensionality

This effects data mining and data warehousing as well

>  "There is an exponential growth in complexity (time and space) with any linear growth within a dimension and the rate of this exponential growth increases as the number of dimensions increases." Richard Bellman (1961), because multidimensional is abstract and complicated for most humans to understand, let's perform some simple thought experiments…

If you have a linear growth in the size of your problem with regards to 1 dimensions, it's an exponential growth in terms of complexity, and this gets worse if dimension count increases. In DW, you want as few dimensions as you need. 

Bc multidimensional is abstract and complicated, you perform some simple **thought experiments**…

Setup a "**base case**" to compare with later scenarios (when the dimensions have grown, and the number of dimensions have increased)

**See slides 9 onward for this.**

------

Underlying Technology & Techniques

**Due to Curse of dims, we don't use brute force.** Classes and clusters are the 2 main groups.

4 types of relationships are sought (generally):

- Classes - search for classes.

  - we predetermine groups.
  - we define the characteristics.

  Define classes on age, geography. all customers over 45 in midwest. You don't know how many customers there are that satisfy this class.

- Clusters - kind of the opposite. Let the data mining form the groups. Set n = 7 groups, and the algo does it. 

  - logical groups formed by MINING
  - we predetermine number of clusters
  - system defines the characteristics

  k-means.

- Associations

  - relationships between clusters or classes

- Sequential Patterns

  - **trends**, possibly with rate of change considerations. Rate of change considertations. pattern matching for splines. linear/nonlinear interpolation. 

TCD says there are 14,3,432,42,42,3423,4,234,23 combos - you can't handle it. Instead of looking at all of these - break customers into a smaller set of things. Divide all customers into 4 groups - high profit young customers, high profit old cust, low prof young cust, low prof old cust. Or look at a simple subset of customers. You can use these techniques over and over. Look at how many high prof cust bought product on weekend in Midwest. 

Then look at trends of these over time. Did you sell more last year on black friday to high tech low credit score young college educated? 

In general, data is analyzed using traditional Mathematical & Statistical Techniques or AI. 

You're trying to find significant relationships, patterns (trends, groupings). You want to identify, clarify and communicate important relationships within the data. "Did you realize we sell more red pop tarts in bad weather?" With high confidence level, you have effectively proven it. 

## Lecture 13 - OLAP

13-A-Agg_Pop_and_Storage.pdf, 46 pages

AGG Overview, Inflation Factor & The Curse of Dimensionality, OLAP Data Storage Tradeoff

**Inflation Factor** is like Big O, but for data warehousing. It's a ratio between leaves and nodes - how bush the tree hierarchy is.

total number / input across all dimensions...measures proportionality between leaves (grain) and nodes. It measures it in a multidimensional volume. Years vs Days (node vs leaf), Country vs City (node vs leaf), combined.

AGGs can be requested and optionally stored

- for any combination of DIMs and FACTs
  - total sales per dealership, or total sales per customer
- for any combination of HIERs within those DIMs
- for any combination of LVLs within those HIERs
  - do data minining and find any combinations of sales per state territory city
- for any FACT in the fact table
  - BEWARE if the FACT is not ADDITIVE for the DIMS used!
    - fully additive, np
    - partially additive - make sure you sum up things correctly. Don't sum total cost on each line item.
- for any valid "filtering" or "reshaping" of the Cube
  - possibly for any set of particular DATT or FACT values
  - possibly using functions and operations on these values (add substract multiple or more sophisticated)
- i.e., OLAP operations (high (drilling up or down) or low (slicing and dicing))
  - pivoting, rolling, drilling, slicing and dicing!

AGGs are like FACTs but not quite the same…you cant know them ahead of time

- every OLAP query / report / pivot / operation returns at least one value that is either a FACT or an AGG
- AGGs are not "pre-existing" values like DATTs - they must be observed after being populated.
- AGGs need to be "observed / measured" after all the FACTs they are based upon have been collected
- Think of them as ____

implications are:

we can calculate any AGG value by defining an algorithm that passes ALL the required FACTs as input parameters (operands) to one or more operations

We can calculate AGGs in three basic ways
option 1: cached ahead of time
option 2: on the fly
option 3: on the fly the first time, cached after that

assuming we want to use caching (1 or 3), we define algorithms for calculating the following AGGs:
Total Sales for:
Sales_Per_Day
Sales_Per_Month
Sales_Per_Year

-----

13-B-Intro_to_OLAP.pdf, 38 pages

BI Concepts, OLAP Concepts, OLAP Operations, OLAP & MDM Terminology

### BI Concepts

BI = 

> "Business intelligence (BI) is a set of methodologies, processes, architectures, and technologies that transform raw data into meaningful and useful information".

Or =

> the methods and technologies that gather, store, report, and analyze business data to help people make business decisions

Or, transforming data or business data, which can be "unfriendly" to business users into meaningful, and actionable understanding / insights / decisions / information

BI encompasses the DWE and might include other systems like Big Data systems.

It's primary focus is on the end-results





## Lecture 14 - Data Warehousing / Business Information Quality
14-A-Data_Warehousing_Quality.pdf, 65 pages

Much of this material is based on and quoted from the work of **Larry P. English** (ISBN 0-471-25383-9)

Quality is actually a very complicated concept

- parts of it are subjective, parts are objective
- parts of it are practical, parts are theoretical
- it relies on standards, but standards are not enough (various ISO standards, six sigma)
- it relies on processes, but processes are not enough (ANSI SQL)
- it relies on "attitudes, aptitudes, and culture" - quality is a culture
  
  - but once again, these are not enough
- it relies on sophisticated models and methodologies, but again, merely "having one" is not enough…
  
- there are many quality management methodologies to choose from, such as ISO 9000, Six Sigma, Total Quality Management, and many more…
  
- A "quality model" includes

  - a data model
  - a business process model
  - and perhaps even a lifecycle model, and more...

  this would capture everything about the model...



We get good quality of information from:

**Good Q(Data)** = F(Q(Definition), Q(Presentation)Good Q(Information))

data is quality enough, its accurate, populated enough, up to date enough. definition is clear enough, i understand what it means. presentation is clear enough, i know what im looking at.

But just because good quality information, it doesnt mean you'll make the right choices. 

Knowledge = F(Experienced people, assigned significance, information)

Info within context, understanding significane of info, value added to information by an experienced person understand of the information.

**Good Q(Knowledge)** = F(Q(Experienced people), Q(assigned significance), Q(information))

Wisdom is applied knowledge.

**Good Q(Wisdom)** = F(Q(Accessibility), Q(Empowered_Action), Q(Knowledge))

People with knowledge can access the data and take action. Empowered_Action = you're empowered to make it work the way you want it to. You can solve the problem in another way. You're reacting, getting the job done despite system limitation. Accessibility is in time or physically accessible. 

These are business processes now. 

Good Q(Wisdom) = F(Q(Accessibility), Q(Empowered_Action), Q(Knowledge), Q(Experienced people), Q(assigned significance), Q(information, Q(Definition), Q(Presentation)Good Q(Information)). Wisdom depends on everything prior.

Work towards the goal of good quality wisdom. If you can achieve good quality wisdom, things can still go wrong, but it's less likely!

This is a way to rank problems, and help you work through the evolution. Shows you what to improve first, then second, then improve third, etc.



Steward vs owner. Very cool. You serve the data, protect it's quality, for the good of the data and user. Owner tries to politicize, mystify the information, dominate it, for power and security. So you take this idea, and you apply it not to data but to code as well. Write clean, commented, clear code in and serve as a steward, not the code owner.