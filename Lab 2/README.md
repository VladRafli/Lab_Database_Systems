# Lab 2

**Basic SQL Query**

### By ***Raf-Fly***

---

In this documentation, I'll explain some of syntax that I used in this Lab Session Practium.

If you want to see the SQL syntax refrence, you can open this [**link**](https://www.w3schools.com/sql)

### 1. How to create database and table

Firstly, when you want to manage database, you need to create the database first. To do it, write this query

> `CREATE DATABASE ` **Database_Name**

When fill the highlighted text (Bolded) you need to pass the argument with ( ` )

**Example:**

> `CREATE DATABASE 'test_db' `

For the example, we can't use ( ` ) because Markdown Syntax Rule, so for example we use this ( ' ).

Then, after the database was created, you need to select the database where you want to create table within. To do it, write ths query

> `CREATE TABLE` **Table_Name**

**Example**

> `CREATE TABLE 'test_table' `

When you create table with this query, you just create the table, but not the column of the table.

### 2. How to create table with its column or field

Okay, after you know how to create the database and table, now you need to create the table with all the field you need. To do it, write this query

> `CREATE TABLE` **Table_Name** `(`
> 
> **Field_Name** **Data_Type** **Additional_Argument**
>
> `);`

**Example**

> `CREATE TABLE 'test_table' (`
>
> `'id' INT(5) NOT NULL,`
>
> `'fieldOne' CHAR(30),`
>
> `'fieldTwo' DATE`
>
> `);`

You can check list of SQL data types [here!](https://www.w3schools.com/sql/sql_datatypes.asp).

For the additional argument, you can let it empty if you want.

### 3. How to delete table or the database

After you attempt create a database or table, you mistakenly created double database or table or you just to delete the created database or table you created before, you can delete that unwanted things.

To delete a database, write this query

> `DROP DATABASE` **Database_Name**

**Example**

> `DROP DATABASE 'test_db'`

To delete a table, write this query

If you hasn't select a database with `USE`, you can do this

> `DROP TABLE` **Database_Name**.**Table_Name**

If you already select a database with `USE`, you can do this

> `DROP TABLE` **Table_Name**

**Example**

> `DROP TABLE 'test_db'.'test_table'`

**Same as**

> `USE 'test_db'`
>   
> `DROP TABLE 'test_table'`

### 4. Know about changing things with `ALTER`

If you want to change anything from adding new column/field, rename a table or database, adding `CONSTRAINT` (Explained later...), you need to use `ALTER` keyword.

ALTER is keyword to change things in database like I explain above, you can do this syntax **only for one action**, you can't do it like in `CREATE TABLE` or `INSERT`. So you should `ALTER` it one by one.

### 5. How to rename table

When you write, sometimes it can be mistakenly pressed random button, and then you already create the table. Don't worry about that, no need to delete and re-create it again, just `ALTER` the name.

To change the table name, write this query

> `ALTER TABLE` **Table_Name**
>
>  `RENAME TO` **New_Table_Name**

**Example**

> `ALTER TABLE 'test_table'`
>
>  `RENAME TO 'new_table'`

### 6. How to add or delete column/field to table

When you already created table, then you realize "Ahh..., I forgot to input one more column to the table...".

Don't worry! You just need to `ALTER` it by adding new column with `ADD`

To do it, you can write this query

> `ALTER TABLE` **Table_Name**
> 
> `ADD` **Column_Name** **Data_Type** **Additional_Argument**

**Example**

> `ALTER TABLE 'test_table'`
>
> `ADD 'description' VARCHAR(100)`

Done! Your new column will available to be filled.

Then after you create, you realized for once again "Ahh..., I think I don't need this column actually".

Don't worry! You just need to `ALTER` it by delete the specified column with `DROP`

To do it, you can write this query

> `ALTER TABLE` **Table_Name**
> 
> `DROP COLUMN` **Column_Name**

**Example**

> `ALTER TABLE 'test_table'`
> 
> `DROP COLUMN 'description'`

Done! The specified column now gone for good.

### 7. What you need to know about **Primary Key** and **Foreign Key**

So now we going more deep learn about database relationship. In database, you will see much about **Primary Key** and **Foreign Key**.

So actually what is that two? Now I will explain it in shortest way.

#### - **Primary Key**

The **PRIMARY KEY** constraint **uniquely identifies** each record in a table.

**Primary keys** must contain **UNIQUE values**, and **cannot** contain **NULL values**.

A table can have only **ONE primary key**; and in the table, this primary key can **consist of single or multiple columns** (fields).

**PRIMARY KEY** then usually used as reference other table that contain **PRIMARY KEY** stored in as **FOREIGN KEY**

#### - **Foreign Key**

A **FOREIGN KEY** is a key used to **link** two tables together.

A **FOREIGN KEY** is a field (or collection of fields) in one table that **refers** to the **PRIMARY KEY** in another table.

The table containing the foreign key is called the **child table**, and the table containing the candidate key is called the **referenced or parent table**.

### 8. How to add and delete **Primary Key** in table

After you know what is **Primary Key** stands for, now to used it its simple, when you create a table, you can include it like example below.

**Example**

> `CREATE TABLE` **Table_Name** `(`
> 
> `'id' INT(5) NOT NULL,`
> 
> `PRIMARY KEY ('id')`
> 
> `);`

Or you can add it with `ALTER`, the example like below.

**Example**

> `ALTER TABLE` **Table_Name**
> 
> `ADD PRIMATY KEY ('id')`

Done! Your **Primary Key** is ready to be used!

### 9. How to add and delete **Foreign Key** in Table

Okay, if you reach this, you should know that you have **Primary Key** to be used in other table as **Foreign Key**

If you have the **Primary Key** but wait! You need to know your Database Structure, if not it can be mistakenly added unused Keys.

Okay, after you know what you do. Now we learn how to add the **Foreign Key**. If you want to add **Foreign Key** when creating table, you can do it like this example below.

**Example**

> `CREATE TABLE` **Table_Name** `(`
> 
> `'foreignId' INT(5) NOT NULL,
> 
> `FOREIGN KEY ('foreignId') REFERENCES` **Other_Table_Name**`(`**Other_Table_FK**`)`
> 
> `);`

Or you can add it with `ALTER`, the example like below.

**Example**

> `ALTER TABLE` **Table_Name**
> 
> `ADD FOREIGN KEY ('foreignId') REFERENCES` **Other_Table_Name**`(`**Other_Table_FK**`)`

Done! Your **Foreign Key** is ready to be used!

### 10. What you need to know about **Constraint**

> **This section still under construction, because the writer can't use this yet**

### 11. How to add and delete **Constraint**

> **This section is under work, because the writer make mistakes too...**

---

Okay, I think thats all the basics of SQL that used in this Practicum. I hope its usefull and thank you for reading this! Hope you stay safe and happy coding!

### **Raf-Fly**

---

[<-- Return](https://github.com/VladRafli/Lab_Database_Systems)

[Next Documentation (Not Available!) -->]()