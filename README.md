
# Times People / Inside Edition

# Developer Notes

* HOT [Towards reusable charts](http://bost.ocks.org/mike/chart/)

## Active Development Branches

### feature/people-project-structures
* Lays foundation for creation of staffing book & portfolio views. Provides 'who is working on what' view.
* New people & project structures. People structures need to be put in place and stabilized before finishing work on cycle detection branch.
* Last thing is to rip out employee/reporting relationship. Build person / person association features off of existing features.

#### Tasks:
* Implement person fields on show and form screens

#### Tasks Commit: 8beb579cfeb8129abf6f66c75dc31da70e83e7e1
* DONE Basic scaffolding for people
* DONE Integration of jquery tokens for easy person to person associations
* DONE Proper menu items
* DONE Rework of search (baseline with ransack, no major refactor of search here)
* DONE Export to xls, csv
* DONE Person assocation type (dotted, non-dotted) (see Marc Frons)
* DONE Port of org context chart
* DONE Validate assocation type and person type in set
* DONE Part time/full time attributes (see Steve Ottenstein)
* DONE Person type (employee, contractor, open position) (see Steve Ottenstein)
* DONE Top level org chart off of menu
* DONE People attributes
  * DONE Regular/Temporary                         boolean: temporary
  * DONE HR Status: Active, Resigned               string: active | resigned
  * DONE Full/Part                                 boolean: part_time
  * DONE Band                                      string: 
  * DONE Cost Center                               string:
  * DONE Title                                     string:
  * DONE Business Unit                             string:
  * DONE Hiring Status			      string: open | filled

#### Out of Scope (For a different branch)
* Pagination style fix (upgrade bootstrap gems for this)
* Org chart for person types
* New assocation types: provider|customer, consultant|consultee, mentor|protoge, etc.
* Internet Explorer support

## Completed Development Branches

* feature/app-cleanup (Release 1.0)
  * parameter files
  * limited to non-infrastructure compliant changes 

* feature/faster-org-tree (Release 1.0)
  * faster query for tree, elimination of worker threads and cache (from 25 seconds to .01 second!)
  * cycle detection (working, but parameterization for all input fields is messy, needs to be branched off separate from new tree retrieval)
  * cycle detection is important for future work

## Backlog Development Branches

* feature/cycle-detection
  * code in alpha state
  * detects cycles in org trees, needed for complex org structures

* feature/prettier-org-tree
  * supports multiple supervisor relationships
  * better d3 interactivity
  * important for interface evolution

* feature/project-portfolio
  * shows project data
  * shows who is working on what

* feature/angular-spike
  * for taking the data entry inteface to the next level
  * lower priority

* feature/menu-redesign
  * more scalabile menu architecture for easier adding of reports, features
  * lower priority

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
