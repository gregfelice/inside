# Times People / Inside Edition: Roadmap

## Shipped

### Release 1.0

* Baseline application to replace EmployeeWare

* feature/app-cleanup
  * Parameter files
  * Limited to non-infrastructure compliant changes 

* feature/faster-org-tree
  * Faster query for tree, elimination of worker threads and cache (from 25 seconds to .01 second!)
  * Graph cycle detection (alpha state, important for future work)



## Done, Waiting to be Released (Release 1.1)

* feature/people-project-structures
  * Lays foundation for creation of staffing book & portfolio views. Provides 'who is working on what' view.
  * New people & project structures. People structures need to be put in place and stabilized before finishing work on cycle detection branch.
  * Disable employee/reporting relationship



## In Progress (Release 1.1)

### feature/improved-org-chart
* Critical for supporting multiple supervisor & other complex relationships
* Important for interface evolution
* Org chart printing and PDF support

#### Stories & Tasks
* DONE I want an org chart that explicitly shows all association types (direct, dotted)
* DONE I want an org chart for this person, showing supervisors N levels up, and subordinates N levels down
* DONE I want to select the levels up and down
* DONE I want to an org chart exported as PDF
* Works on all browsers
  * Works on safari (omitting width/height effects svg render)
  * Works on firefox
  * Works on chrome
  * Works on IE 9+
* I want to select what association types to show
* I want to print an org chart for a person on one page
* I want to select what node & edge label details to show

### feature/miscellaneous
* DONE Add Person Floor, Work Location #

## Upcoming (Release 1.2)

* feature/project-portfolio
  * Shows project data
  * Shows who is working on what

* feature/cycle-detection
  * Code currently alpha state, working, needs to be modularized
  * Detects cycles in org trees, needed for complex org structures

## Backlog

* feature/facebook-replacement
  * Replacement of existing facebook/rolodex app
  * Expansion of user base to general staff
  * LDAP login integration
  * Photo uploads

* feature/financial-views
  * Integration to budget and financials data
  * Access control lists

* feature/angular-spike
  * For taking the data entry interface to the next level

* feature/menu-redesign
  * More scalabile menu architecture for easier adding of reports, features


## To Be Sorted
* Internet Explorer support (IE9 required for D3.js)
* Pagination style fix (Bootstrap gem upgrade)


