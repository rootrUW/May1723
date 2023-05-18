/**************************************************************
Title: Order By View Issues
Desc: Shows how using Top with percent causes 
 issues in the order by clause
Change Log: (When, Who, What)
1/31/21,RRoot,Created Script
**************************************************************/

Select CompanyName, Country From Customers
Where Country in ('USA', 'Canada')
Order By Country, CompanyName; -- Works!
Go

Create or Alter View vTest
As
Select Top 100 Percent -- When this it...
CompanyName, Country From Customers
Where Country in ('USA', 'Canada')
Order By Country, CompanyName; -- Does Not Work!
Go
Select * From vTest;
Go

Create or Alter View vTest
As
Select Top 100000 -- When this it...
CompanyName, Country From Customers
Where Country in ('USA', 'Canada')
Order By Country, CompanyName; -- Works!
Go
Select * From vTest;
Go

Create or Alter View vTest
As
Select Top 99 Percent -- When this it...
CompanyName, Country From Customers
Where Country in ('USA', 'Canada')
Order By Country, CompanyName; -- Works, but you could lose rows!
Go
Select * From vTest;
Go

Create or Alter Function fTest()
Returns Table
As
Return (
Select Top 100 Percent -- When this it...
CompanyName, Country From Customers
Where Country in ('USA', 'Canada')
Order By Country, CompanyName -- Does Not Work!
);
Go
Select * From fTest();
Go

Create or Alter Function fTest()
Returns Table
As
Return (
Select Top 100000 -- When this it...
CompanyName, Country From Customers
Where Country in ('USA', 'Canada')
Order By Country, CompanyName -- Works
);
Go
Select * From fTest();