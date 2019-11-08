# DMIT-1508 In-Class Examples (Jan 2019)

The files in this repository branch are my in-class examples. Additionally, you can find online notes at the course's [Moodle site](https://moodle.nait.ca) and on the unofficial [website notes](https://dmit-1508.github.io). Also be sure to checkout out the [**Learning Outcomes**](https://dmit-1508.github.io/about/LOGs.html) that I use in class.

## Outline

The general topics in this workbook include

- [**Normalization**](Design/)
- SQL statements for 
  - [**DDL**](DDL/) (Data Definition Language) - `CREATE TABLE` etc.
  - [**DML**](DML/) (Data Manipulation Language) - `INSERT INTO` etc.
  - [**Queries**](SQL/) - `SELECT` etc.
  - [**Stored Procedures**](SPROCS/) (sprocs) - `CREATE PROCEDURE` etc.
  - [**Triggers**](Triggers/) - `CREATE TRIGGER` etc.

----

## Software and Resources

Recommended tools for this course include:

- SQL Server 2017, Developer Edition (available through [Microsoft Imagine](https://e5.onthehub.com/WebStore/OfferingDetails.aspx?o=32dd97ce-e6ad-e711-80f7-000d3af41938&ws=3511aead-a58b-e011-969d-0030487d8897&vsro=8))
- [Visual Studio Code](https://code.visualstudio.com)
- [GitHub Desktop](https://desktop.github.com)
- Draw.io ([desktop](https://about.draw.io/integrations/#integrations_offline) and [online](https://draw.io) versions)

Other recommended resources include:

- [Learn Markdown](https://commonmark.org/help/)

USE WestWind
GO
--1.select the shippers who have had more than 700 shipments
--2. Select the shipments that happened in May 2018. Group the results by the order id and display the order id and total freight charges for each order.(You will need to use data functions)
--3.Identify the customer whose individual shipment was the largest. show the customer's Company Name, Contact Name, and Contact Email.
--4.How many products are in each category? Display the Category Name and the number of products.
--5.Add "Bitcoin" as a new payment type.
--6.Display the payment types that have not been used
--7.Dreate a view called OrderShipments that includes the Order ID, Customer ID, RequiredDate, ShippedDate, CompanyName of the Shipper, and the shipment's FreightCharge.
--8.Using the Ordershipments view, select the customer's company name and the total freight charge for shipments to the customer
--9. A shipment lost in an air crash. Delete the manifest items for shipment id 700.
--10. Update the frieght charge for shipment 700 and set it to zero (no charge for lost shipments).