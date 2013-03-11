Vision
======

* Create A Integrated View Of Product, Planning, People, And Financial Dimensions Of An Organization.

# Developer Notes
### Development Branches

* feature/app-cleanup (active)
  * parameter files
  * limited to non-infrastructure compliant changes 

* feature/faster-org-tree (active)
  * faster query for tree, elimination of worker threads and cache (from 25 seconds to .01 second!)
  * cycle detection (working, but parameterization for all input fields is messy, needs to be branched off separate from new tree retrieval)
  * cycle detection is important for future work

* feature/people-project-structures (active)
  * new people & project structures. people structures need to be put in place and stabilized before finishing work on cycle detection branch.

* feature/prettier-org-tree
  * proposed
  * better d3 interactivity
  * important for interface evolution

* feature/angular-spike
  * for taking the data entry inteface to the next level
  * lower priority

* feature/menu-redesign
  * lower priority

# Developers Guide
=======
how does the network structure show continuous updates of beliefs?
how might something like a virus/meme be contained?
how do people plug into the network? 
what other network types are there? technical guilds? product teams?
what SNA does analytics do?
how might we collect information that shows preferences, or dislikes, in a way that could show informal social relationships?

### People
* What formal relationships exist? 
* What informal relationships exist?
* Where are there connections between people?
* What is this person:
  * Working on?
  * Interested in?
* Who is in proximity to whom? What are the benefits of that proximity? How can we foster better interconnections between teams and people?
  * Note: Sit people next to each other for better communication & relationships.
  * Consider indispersing people and teams, so that there is a cross-fertilization.
  * Consider scrum guest attendance on a rotating basis.
* What are the "strongly connected components"?
  * What data will we have to identify strongly connected components?
    * Department reporting
    * Project assignments
    * Guild membership (perhaps attendance at specific meetings)
  * How do we create new connections?
  * Good example: strategy vs product vs project planning
  * How do we connect these without creating strife?
  * Can we identify gatekeepers via SNA?

### Planning
* Where do plans live?
* Are plans aligned?
* When do we make decisions on plans? 
* How long will the project take?
* How much will the project cost?
* Is the project proposed/started/completed/abandoned?
* Show me this person's performance review score.
* What are the business drivers for this plan?
* What are the highest priorities in the portfolio for this year?
* What budgets does this project pull from?
* What is the budget for this plan?
* What is the total cost of ownership for this product, including enabling systems and operations costs?
* What is this person's contact info?
* What open positions does the organization have?
* What open positions does this department have?
* What open positions does this project have?
* What systems does this product depend on?
* What will this product cost us to operate for this year?
* Where does this person sit?
* Which teams enable this team to deliver?
* Who is in this department?
* Who owns this system? Who owns this product?
* Who reports to whom?
* Who will work on this project?

3 most innovative things within vision
--- 
* Align plans
* Express formal and informal relationships, richer understanding of the flows inside the times

The Problem
-----------
* Plans exist at strategic & product level
  * Strategic and product planning not integrated
  * Resource allocation not integrated
* No single view on employees & contractors
* No single view on priorities (getting better)
* Recruiting pipeline
* Career development 
* Morale?

Solution
--------
* Get better at managing people data // contractors & employees in same place
* Reduce costs associated with collecting this kind of information
* Where are my costs?
* What are my products, and what revenue do they bring?
* What skills do we have?
* What's holding us back?
* How does technology strategy marry up with business strategy?
* OK - Metrics drive what do we offer in that area?
  * Product metrics
  * Financial metrics
  * Project metrics

If we look at d3, what is there? what is offered to us in terms of social network analysis?
Where were we before in terms of what Denise wanted, strategy wise?
Tie in different information sources - see what we can end up with

Alternatives
------------
* SAP solutions are not resoponsive or adaptive enough

Features
--------
* DONE Employeeware Port
* Culture Data / Survey Management
   * Culture Decisions Impact
* Portfolio Management
* Strategy Maps / Scorecards
* Governance / Cobit?




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

Developers Guide
================

Revision Control Approach
-------------------------
* Flow Uses Git And [Git-Flow](http:Scottchacon.Com/2011/08/31/Github-Flow.Html) For Version Control.

Experiments
-----------

### Experimental Data Model
* [Using Scaffolding for BOTH Mongoid and ActiveRecord](http:stackoverflow.com/questions/6372626/using-active-record-generators-after-mongoid-installation)

### MongoDB data modeling patterns
* [Data Modeling](http:docs.mongodb.org/manual/core/data-modeling)
* [CRUD Operations](http:docs.mongodb.org/manual/crud/#crud-operations)
* [Trees & Materialized Paths](http:docs.mongodb.org/manual/tutorial/model-tree-structures-with-materialized-paths/)

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
