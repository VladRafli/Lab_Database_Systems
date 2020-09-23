# Lab 1

**Setup SQL Database Environment on Local Computer**

### By ***Raf-Fly***

---

### 1. Download Database Application

Before you can create and modify database, you need to download any available application on the internet. In my knowledge there is a two application that mainstream and can be used to get work in database thing.

For this particular time, I used **XAMPP** to get work with database, to download the application, you can click the download link below

### XAMPP Download Link

[Download](https://www.apachefriends.org/download.html)

### 2. Setting Up XAMPP Application

After you install the application, you need to setup the environment first, the most important thing is to activate Apache Web Service and MySQL

1. Open XAMPP Application with Administrator Previlege (Run as Administrator).
2. See the XAMPP Console below, if there is an error about **Port**, you need to setting the Port in Config, if there is no error, you can skip 4 step below.
3. Open Config.
4. Select Service and Port Settings.
5. Change the Apache Main Port to any number that allowed and not used to be taken (Example: 81 or 9080, [List of Restricted Ports](https://neo4j.com/developer/kb/list-of-restricted-ports-in-browsers/)).
6. You can check any unused port on XAMPP by selecting Netstat.
7. After no error encountered, you can start the services.
8. If you want the services automaticly start, you can select the service you want to auto start by click checkbox left of module names.

### 3. How to open Database View with XAMPP

After you start the Apache Server Service and MySQL Service, now you are set to work in Database. To see the database in XAMPP, you can open your browser, than write this url:

> `localhost/phpmyadmin`

Now you will see the list of databases in your local computer, PHPMyAdmin help you to see the database by giving you a comfortable GUI than use an CLI, so we database admins or users are easily naviagte and see through the tables.

### 4. How to add a database and its table

After you open the url, now you see Database in Conceptual Level, where you are the database administrator.

Now no more word, we'll create the database. PHPMyAdmin gives you an easy way to create database and tables even insert the data too...

To create new database, do these following steps:

1. Click database in the menu, that will show you list of database available on your local computer.
2. To create new database, there is a field called 'Create Database', fill the database name and ignore the right dropdown menu.
3. Click next, and the database was successfully created!
4. To navigate to the newly created database, click the database name on navigation menu left of your screen.

After the database was created, now you need to create the table for insert your data on the database.

To create new table, do these following steps:

1. After you navigate the selected database, now you will see a big field 'Create Table' contains the table name and number of columns, fill the form with the desired name and number of columns you want.
2. Now you just fill the form, the required form to fill is the name, the type. If you want to limit the input to the specific column, just add number in length form.
3. After you finished fill the forms, just click save on near bottom right screen.
4. Now you table are usable to be inputted with data!

### 5. How to insert data to the table

Usually, when to insert data in the table, the data is taken from a website front-end and processed in the back-end, in back-end the data are processed and usually saving some data to the database.

But you can insert a data manually too from the database application. Now here i will show you how to do that.

To insert a data to a table, do these following steps:

1. Navigate to the database
2. You will see list of tables in that database
3. There will some action available next to the table names, click on insert action
4. Now you will see a form to insert the new data, fill all the required form, remember to know your table requirement, like a column with NOT NULL requirement.
5. After you fill all the required form, just click save below.
6. You successfully inserted new data on the table!
7. To see your newly inserted data, just click browse action on table where you inputted the new data.

### 6. How to use query on PHPMyAdmin

Lastly from me, you can use the GUI easily to manage databases, but if you want or more comfortable to use CLI model query input, you can use console in the bottom right to insert your query.

The concept is same, you just write the MySQL query there and then the application will show you the result with UI

With XAMPP, you can see your query result more clear than using CLI because GUI had an User Interface so its more readable than CLI one.

---

Okay, I think thats all the basics how to use PHPMyAdmin and XAMPP aplication to worh with the database. I hope its usefull and thank you for reading this! Hope you stay safe and happy coding!

### **Raf-Fly**

---

### SQL Syntax Refrences or Learn SQL

[W3Schools](https://www.w3schools.com/sql) (Syntax Refrences)

[Codecademy](https://www.codecademy.com/learn/learn-sql) (Learn SQL)

[Khan Academy](https://www.khanacademy.org/computing/computer-programming/sql) (Learn SQL)

And other websites that you can search in google.

---

[<-- Return](https://github.com/VladRafli/Lab_Database_Systems)

[Next Documentation (Basic SQL) -->](https://github.com/VladRafli/Lab_Database_Systems/blob/master/Lab%202/Basic%20SQL.md)