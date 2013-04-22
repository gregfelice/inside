<style type="text/css">
  .status {
    color: red;
    font-size: x-small; 
    font-weight: normal; 
    vertical-align: text-top;
  }
  .fineprint {
    color: midnightblue;
    font-size: x-small; 
    font-weight: normal; 
    vertical-align: text-top;
  }
</style>

<span style="font-size: xx-large; color: orange">Times People / Inside Edition</span>

# Shipped

## 4.22.2013

### bug/employment date selects don't go back far enough
* Simpleform: start_year: Date.today.year - 90, / https://github.com/plataformatec/simple_form

### feature/hiring-status 
* Add "unbudgeted / posted" as option

### feature/basic-people-roles
* Basic select field to choose primary job function (developer, infra, pm, etc)
* Supports basic staffing reports
  * Software Engineers
  * Systems Engineers
  * Quality Assurance
  * Project Management
* Allows for replication of Rajiv's staff mix reports
  * Engineers
  * People management
  * Group by budget
  * Group by group
  * Show as chart & table

### feature/facilities-support-basic
* Drop down lists for floor field
* Phone # fields

## 4.19.2013

### feature/practical-reports
* Quick reports for PMO, finance, management
  * Show me people with no supervisors
  * Show me people with more than one supervisor
  * Show me people with no budget
  * More reports to follow

### feature/activity-ticker
* Front page ticker of who updated what, when

### bug/employment date fields don't default to null
* Need to allow for null employment start and end dates

### feature/required-fields
* Temporary disable required fields validation for group, budget, hiring status

## 4.18.2013
### feature/hiring-support
* Support for hiring status, budget, seating type, group fields
* Can filter on any of these, export as excel
* Improved show person page, better handling of growing # of data points

### feature/audit-trail
* As an admin, I can see who has performed what actions in the system
* Visible, filterable via SQL client

## 4.2.2013

### feature/people-project-structures
* Lays foundation for creation of staffing book & portfolio views 
* Provides 'who is working on what' data structures
* Disable employee/reporting relationship

### feature/improved-org-chart
* Critical for supporting multiple supervisor & other complex relationships
* Important for interface evolution
* Org chart printing and PDF support
* I want an org chart that explicitly shows all association types (direct, dotted)
* I want an org chart for this person, showing supervisors N levels up, and subordinates N levels down
* I want to select the levels up and down
* I want to an org chart exported as PDF
* Works on all browsers
  * Works on safari (omitting width/height effects svg render)
  * Works on firefox
  * Works on chrome
  * Works on IE 9+

### feature/miscellaneous
* Add Person Floor, Work Location #
* Internet Explorer support (IE9 required for D3.js)

## 3.13.2013

* Baseline application to replace EmployeeWare

### feature/app-cleanup
* Parameter files
* Limited to non-infrastructure compliant changes 

### feature/faster-org-tree
* Faster query for tree, elimination of worker threads and cache (from 25 seconds to .01 second!)
* Graph cycle detection (alpha state, important for future work)

# Sorted Backlog

### feature/miscellaneous
* Hide resigned people

### feature/role-based-access-control
* Security roles
* Role based access control to fields, functions
* Supports data entry ownership for finance, PMO, location/facilities

### feature/facilities-support-basic
* Load spreadsheet based seating data 
* Drop down lists for floor field
* Phone # fields
* Onboard facilities onto TPIE
* Formalize facilities data entry workflow

### feature/ldap-integration
* Authenticate using LDAP credentials

-------------------------------------------------------------------

### feature/facilities-support-plus
* I want to assign a seat from a autocomplete search
* I want a report on home seat availability
* I want a report on hoteling availability

### feature/orgchart-niceties
* Color coded org chart based on attributes
  * Color by hiring status
* Visualize org chart top-to-bottom (as opposed to left-to-right)

### feature/project-portfolio
* I want to see plans within a portfolio
* I want to see who is working on what
* I want basic, non-sexy forms for data entry
* I want to indicate % utilization for this person on this plan
* I want to allocate resources at the  plan level

### feature/budget-to-resource-allocation
* Affix a specific budget to a resource allocation

### feature/cycle-detection
* As a person, I cannot enter a cyclic relationship

### feature/facebook-replacement
* See: https://github.com/centresource/angularjs_rails_demo
* Replacement of existing facebook/rolodex app
* Where does this person sit?

### feature/director-access
* As a director, I can change my staff's info

### feature/profle-self-service
* As a person, I can change some details of my profile
* As a person, I can upload photos for my profile
* As a person, I can login with my LDAP credentials, so I can update my info
* As a person, I can use search and show tools without logging in

### feature/bulk-updates
* I want to change a specific field, or person association for a bunch of people

### feature/financial-views
* Integration to budget and financials data

### feature/menu-redesign
* More scalabile menu architecture for easier adding of reports, features

### bug/pagination css
* requires Bootstrap gem upgrade, UI tweaks

### capability/systems-catalog
* Records of all system components
* I want to see the owner of a system
* I want to see the lifecycle of a system (draft, in production, sunset, retired)
* I want to see the status of a system
* I want to see the service interface for a system
* I want to see a graph of system interdependencies
* I want to see all tickets for a system
* I want to see tests associated with a system, and their pass/fail status
* I want to see system stats (load, IO)

### capability/value-chain-visualization
* Express the core NYT value chains visually
* Show collaborators
* Show clusters of communication
* Show time through the loop

### Unsorted
* See https://www.ruby-toolbox.com/categories/reporting
* Update xls, csv export to include new fields
<<<<<<< HEAD
* Gravatar integration
* Linkedin integration
=======
>>>>>>> backbone-fun
