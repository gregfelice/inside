
## planning dimension

### portfolios
* there are many portfolios
* portfolio has many plans

### plans
* plans have many milestones

### milestones
* milestones have one time period
* milestones have one milestone status
* milestones have many resource allocations

### resource allocations
* resource allocations have one resource allocation type
* resource allocations have one quantity
* resource allocations have one person

### plans
* plans have many budgets
* plans have many actuals
* plans have many business drivers

## financial dimension

### budgets & actuals
* budgets have many plans
* actuals have many plans

## product dimension

### products/systems
* products/systems have many product/system dependencies
* products/systems have many themes
* products have revenue

## people dimension

### people
* people have many types: open position, employee, contractor, intern

### groups
* groups have many types: tribe, squad/team, chapter, guild, department

### accountabilities::generic
* groups and people are parties
* parties have many parties through accountability
* accountabilities have many types

### accountabilities::instances
* people directly supervise people
* people dotted supervise people
* people mentor people
* groups support groups
* people consult for groups
* people direct groups


anti-stories
---
i dont want to do time entry
i dont want to do financial planning at the project level
i dont want to do financial planning at the theme level
i wont have story level estimates for everything going on in the company
i dont want to always run agile
i dont want to take too many surveys


stories
---
service portfolio management
//
TBD

product management
//
i want to see a list of all products
i want to see a list of all themes for a product

i want to see who requested themes
i want to see who will use themes

i want to differentiate between external and internal products


project management
//
i want to see a list of all projects
i want to see a list of all themes for a project


project and product management
// 
i want to see if a project/product is in active feature development mode, or maintenance mode
i want to see the resources dedicated to a project/product

i want to see the opportunity costs associated with active projects, vs what's in the backlog
i want to see cost of delay for a project

i want to take satisfaction surveys at the end of major phases of work

i want a capacity planner

i want to see project health



financial management
//
i want to see the burn rate of each department 
i want to see the burn rate of each project
i want to see the burn rate of active development vs maintenance projects (this is good)

i want to see averages and outliers for project costs

i want to see costs by portfolio entry type (financial automation, CRM services, decision support services, ecommerce, web development)
i want to see costs by strategic objective (quality, compliance, revenue initiative, cost reduction)


resource management
//
i want to see who reports to whom
i want to see what skills a person has
i want to see what skills we have in demand
i want to see what skills we have in the hiring pipeline, and at what stages (requested, approved, recruiting, interviewing, hired)

i want to organize people by department, portfolio entry type

i want to see what titles people have for their skills
i want to see what roles people have for their skills
i want to see what compensation packages people have for their titles

i want to see averages & outliers for titles to compensation packages

i want to take surveys about general employee satisfaction, and record the results over time



i want to plan projects for the next quarter




backlog
---
employeeware port
culture data / survey management
  culture decisions impact
portfolio management
strategy maps / scorecards
governance / cobit?

todo
--- 
q: do they want more financial discipine around projects?


goals
---
help cio comms up to ceo

