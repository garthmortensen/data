# Big Data Engineering
Garth Mortensen

## Spark SQL & df

Leverage [Databricks](https://community.cloud.databricks.com/) and Spark to answer some questions regarding an invoice dataset.

First, use the **Dataframes API.** 

Second, use the **SQL API.**

### Reading invoice csv

1. Create a spark cluster in the Databricks console.

2. Read the invoice CSV into a resilient distributed dataset (RDD), then print the first five rows.

```python
invoices = sqlContext.read.csv("/databricks-datasets/online_retail/data-001/data.csv", header=True)
print(invoices.take(5)) 
```

### Invoice data questions using Dataframes API

1. Which customer in the dataset has spent the most on products?  The quantity multiplied by the unit price will give you the total dollar amount spent per invoice line.

   ```python
   import pyspark.sql.functions as sql_fn
   
   # perform row level calc
   df_select = invoices.select((invoices["UnitPrice"] * invoices["Quantity"]).alias("Revenue"), invoices["CustomerID"])
   
   # group by
   df_group_by = df_select.groupBy(df_select["CustomerID"])
   
   # sum
   df_aggregated = df_group_by.agg(sql_fn.sum("Revenue").alias("Revenue"))
   
   # sort by desc
   df_sorted = df_aggregated.sort(df_aggregated["Revenue"].desc())
   
   # show results
   display(df_sorted.take(5))
   ```
   
   ![1](.\images\1_a.png)
   
2. What is the product description for the best selling product in the dataset?  We will define "Best Selling" as the product with the highest quantity sold.

   ```python
   # perform row level calc
   df_select = invoices.select((invoices["Quantity"]), invoices["Description"])
   
   # group by
   df_group_by = df_select.groupBy(df_select["Description"])
   
   # sum
   df_aggregated = df_group_by.agg(sql_fn.sum("Quantity").alias("Quantity"))
   
   # sort by desc
   df_sorted = df_aggregated.sort(df_aggregated["Quantity"].desc())
   
   # show results
   display(df_sorted.take(5))
   ```
   
   ![2](.\images\2_a.png)
   
3. How much has each country spent on products?  The output should have two columns, one being the country and the other being the gross dollar amount spent across all products.  Sort the output by the dollar amount, descending.  Print the entire output, showing a gross dollar amount for each country.

   ```python
   # perform row level calc
   df_select = invoices.select((invoices["UnitPrice"] * invoices["Quantity"]).alias("dollar_amt"), invoices["Country"])
   
   # group by
   df_group_by = df_select.groupBy(df_select["Country"])
   
   # sum
   df_aggregated = df_group_by.agg(sql_fn.sum("dollar_amt").alias("dollar_amt"))
   
   # sort by desc
   df_sorted = df_aggregated.sort(df_aggregated["dollar_amt"].desc())
   
   # show results
   display(df_sorted.take(5))
   ```

![3](.\images\3_a.png)

4. What is the highest-grossing day in the dataset?  Again, use quantity multiplied by unit price to get the revenue per line.

   ```python
   # perform row level calc
   df_select = invoices.select((invoices["UnitPrice"] * invoices["Quantity"]).alias("revenue"), invoices["InvoiceDate"].substr(1,8).alias("InvoiceDate"))  # substr is the trick here
   
   # group by
   df_group_by = df_select.groupBy(df_select["InvoiceDate"])
   
   # sum
   df_aggregated = df_group_by.agg(sql_fn.sum("revenue").alias("revenue"))
   
   # sort by desc
   df_sorted = df_aggregated.sort(df_aggregated["revenue"].desc())
   
   # show results
   display(df_sorted.take(1000))
   ```
   
   ![4](.\images\4_a.png)
   
5. Finally, try out one of Databrick's visualizations.

   ![5](.\images\5.png)

### Invoice data questions using SQL API

Create and test a temp table first.

```python
# create temp table
invoices.createOrReplaceTempView("invoice")

# test temp table
tbl_output = sqlContext.sql("""
  select * from invoice limit 5
  """)

display(tbl_output)
```

![sql_start](.\images\sql_start.png)

1. Which customer in the dataset has spent the most on products?  The quantity multiplied by the unit price will give you the total dollar amount spent per invoice line.

   ```python
   table = sqlContext.sql("""
     select
       customerid
       , sum(quantity * unitprice) as totalrevenue
     from invoice
     where customerid is not null
     group by customerid
     order by sum(quantity * unitprice) desc
     limit 10
   """)
   
   display(table.take(5))
   ```

   ![sql_1](.\images\sql_1.png)

2. What is the product description for the best selling product in the dataset?  We will define "Best Selling" as the product with the highest quantity sold.

   ```python
   table = sqlContext.sql("""
     select
       description
       , sum(quantity) as sum_quantity
     from invoice
     group by description
     order by sum(quantity) desc
     limit 10
   """)
   
   display(table.take(5))
   ```

   ![sql_2](.\images\sql_2.png)

3. How much has each country spent on products?  The output should have two columns, one being the country and the other being the gross dollar amount spent across all products.  Sort the output by the dollar amount, descending.  Print the entire output, showing a gross dollar amount for each country.

   ```python
   table = sqlContext.sql("""
     select
       Country
       , sum(quantity * unitprice) as totalrevenue
     from invoice
     group by Country
     order by sum(quantity * unitprice) desc
     limit 10
   """)
   
   display(table.take(5))
   ```

![sql_3](.\images\sql_3.png)

4. What is the highest-grossing day in the dataset?  Again, use quantity multiplied by unit price to get the revenue per line.

   ```python
   table = sqlContext.sql("""
     select
       substring(invoicedate, 1, 8)
       , sum(quantity * unitprice) as totalrevenue
     from invoice
     group by invoicedate
     order by sum(quantity * unitprice) desc
     limit 10
   """)
   
   display(table.take(5))
   ```

   ![sql_4](.\images\sql_4.png)

5. Finally, try out one of Databrick's visualizations.

   ```python
   table = sqlContext.sql("""
     select
       Country
       , sum(quantity * unitprice) as totalrevenue
     from invoice
     group by Country
     order by sum(quantity * unitprice) desc
     limit 10
   """)
   
   display(table)
   ```

   ![sql_visual](.\images\sql_5.png)



