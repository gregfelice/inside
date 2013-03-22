# Times People / Inside Edition


example of cluster dendrogram / http://localhost:3000/experimental/cluster.html
* this shows an assoication that skips levels, but still doesnt have single node with mult parent (yet)

force layout is a true graph: 
* http://bl.ocks.org/mbostock/4062045
* this accepts nodes and edges as parameters. but i cant find one with a cluster layout....

force directed tree
* http://bl.ocks.org/mbostock/1138500

another force directed graph
* http://bl.ocks.org/mbostock/3311124


labeled force layout
* http://bl.ocks.org/mbostock/950642

javascript UMNL edior. nice
* http://www.tikalk.com/js/building-uml-editor-javascript-part-3

brackt layout
* http://bl.ocks.org/jdarling/2503502

building a tree
* http://blog.pixelingene.com/2011/07/building-a-tree-diagram-in-d3-js/


force layout 
* http://flowingdata.com/2012/08/02/how-to-make-an-interactive-network-visualization/

network analysis and representation
* http://dhs.stanford.edu/dh/networks/

metro maps
* https://github.com/ezyang/metromaps

d3 and angular
* http://briantford.com/blog/angular-d3.html

wow. 
* http://flowingdata.com/category/tutorials/

* [Project Roadmap](./roadmap.md)

# Developers Guide

### NYT Infra Guides
* [NYT RVM and Ruby](https://confluence.em.nytimes.com/display/INFR/HOWTO+-+Install+and+use+NYT+built+RVM+and+Ruby)

Anti-Stories
-------------
* I Dont Want To Do Time Entry
* I Dont Want To Do Financial Planning At The Project Level
* I Dont Want To Do Financial Planning At The Theme Level
* I Wont Have Story Level Estimates For Everything Going On In The Company
* I Dont Want To Always Run Agile
* I Dont Want To Take Too Many Surveys

Stories
-------
### Service Portfolio Management
* Tbd

### Product Management
* I Want To See A List Of All Products
* I Want To See A List Of All Themes For A Product
* I Want To See Who Requested Themes
* I Want To See Who Will Use Themes
* I Want To Differentiate Between External And Internal Products

### Project Management
* I Want To See A List Of All Projects
* I Want To See A List Of All Themes For A Project


### Project And Product Management
* I Want To See If A Project/Product Is In Active Feature Development Mode, Or Maintenance Mode
* I Want To See The Resources Dedicated To A Project/Product
* I Want To See The Opportunity Costs Associated With Active Projects, Vs What'S In The Backlog
* I Want To See Cost Of Delay For A Project
* I Want To Take Satisfaction Surveys At The End Of Major Phases Of Work
* I Want A Capacity Planner
* I Want To See Project Health

### Financial Management
* I Want To See The Burn Rate Of Each Department 
* I Want To See The Burn Rate Of Each Project
* I Want To See The Burn Rate Of Active Development Vs Maintenance Projects (This Is Good)
* I Want To See Averages And Outliers For Project Costs
* I Want To See Costs By Portfolio Entry Type (Financial Automation, Crm Services, Decision Support Services, Ecommerce, Web Development)
* I Want To See Costs By Strategic Objective (Quality, Compliance, Revenue Initiative, Cost Reduction)


### Resource Management
* I Want To See Who Reports To Whom
* I Want To See What Skills A Person Has
* I Want To See What Skills We Have In Demand
* I Want To See What Skills We Have In The Hiring Pipeline, And At What Stages (Requested, Approved, Recruiting, Interviewing, Hired)
* I Want To Organize People By Department, Portfolio Entry Type
* I Want To See What Titles People Have For Their Skills
* I Want To See What Roles People Have For Their Skills
* I Want To See What Compensation Packages People Have For Their Titles
* I Want To See Averages & Outliers For Titles To Compensation Packages
* I Want To Take Surveys About General Employee Satisfaction, And Record The Results Over Time
* I Want To Plan Projects For The Next Quarter

Personas
---

### Ceo Persona
* Reports to Stockholders
* Balance Sheet, Income Statement

### Cio Persona
* I Want To Communicate Product Lines
* I Want To Communicate Future Strategic Direction - What The Future Is - What The Plan Is (3 Year Technology Strategy)
* I Want To Communicate Undestanding Of Where My Costs Are
* I Want To Communciate Where My Areas Of Growth Are
* I Want To Translate The Technology Strategy Into A Business Strategy That The Business Understands

### Strategic Planner Persona
* TBD

Data Model
==========

Planning Dimension
------------------

### Portfolios
* There Are Many Portfolios
* Portfolio Has Many Plans

### Plans
* Plans Have Many Milestones

### Milestones
* Milestones Have One Time Period
* Milestones Have One Milestone Status
* Milestones Have Many Resource Allocations

### Resource Allocations
* Resource Allocations Have One Resource Allocation Type
* Resource Allocations Have One Quantity
* Resource Allocations Have One Person

### Plans
* Plans Have Many Budgets
* Plans Have Many Actuals
* Plans Have Many Business Drivers

Financial Dimension
----------------------

### Budgets & Actuals
* Budgets Have Many Plans
* Actuals Have Many Plans

Product Dimension
-----------------

### Products/Systems
* Products/Systems Have Many Product/System Dependencies
* Products/Systems Have Many Themes
* Products Have Revenue

People Dimension
----------------

### People
* People Have Many Types: Open Position, Employee, Contractor, Intern

### Groups
* Groups Have Many Types: Tribe, Squad/Team, Chapter, Guild, Department

### Accountabilities::Generic
* Groups And People Are Parties
* Parties Have Many Parties Through Accountability
* Accountabilities Have Many Types

### Accountabilities::Instances
* People Directly Supervise People
* People Dotted Supervise People
* People Mentor People
* Groups Support Groups
* People Consult For Groups
* People Direct Groups
