
# Times People / Inside Edition: Roadmap

## Shipped

### Release 1.0

* Baseline application to replace EmployeeWare

### feature/app-cleanup
* Parameter files
* Limited to non-infrastructure compliant changes 

### feature/faster-org-tree
* Faster query for tree, elimination of worker threads and cache (from 25 seconds to .01 second!)
* Graph cycle detection (alpha state, important for future work)

## Done, Waiting to be Released (Release 1.1)

### feature/people-project-structures
* Lays foundation for creation of staffing book & portfolio views. Provides 'who is working on what' view.
* New people & project structures. People structures need to be put in place and stabilized before finishing work on cycle detection branch.
* Disable employee/reporting relationship

### feature/improved-org-chart
* Critical for supporting multiple supervisor & other complex relationships
* Important for interface evolution
* Org chart printing and PDF support

#### Stories & Tasks
* DONE I want an org chart that explicitly shows all association types (direct, dotted)
* DONE I want an org chart for this person, showing supervisors N levels up, and subordinates N levels down
* DONE I want to select the levels up and down
* DONE I want to an org chart exported as PDF
* DONE Works on all browsers
  * DONE Works on safari (omitting width/height effects svg render)
  * DONE Works on firefox
  * DONE Works on chrome
  * DONE Works on IE 9+

### feature/miscellaneous
* DONE Add Person Floor, Work Location #
* DONE Internet Explorer support (IE9 required for D3.js)

## In Progress (Release 1.1)
* None in progress, wrapping up release 1.1 for ship

### Wrap-Up Tasks
* DONE Simplify graph navigation
* DONE Print one page to letter, legal, A3 dimensions
* DONE Clean up graph mode menu
* DONE Remove band field
* DONE Remove hiring status

## Upcoming (Release 1.2)

### feature/project-portfolio
* Shows project data
* Shows who is working on what

### feature/audit-trail
* As a person, I can see who has performed what actions in the system

### feature/cycle-detection
* As a person, I cannot enter a cyclic relationship

## Backlog

### feature/facebook-replacement
* See: https://github.com/centresource/angularjs_rails_demo
* Replacement of existing facebook/rolodex app
* Where does this person sit?

* As a person, I can change some details of my profile
* As a person, I can upload photos for my profile
* As a person, I can login with my LDAP credentials, so I can update my info
* As a person, I can use search and show tools without logging in

Out of Scope
* As a director, I can change some details of my reports

### feature/financial-views
* Integration to budget and financials data
* Access control lists

### feature/angular-spike
* For taking the data entry interface to the next level

### feature/menu-redesign
* More scalabile menu architecture for easier adding of reports, features

## To Be Sorted
* Pagination style fix (Bootstrap gem upgrade)
* Org Chart Related
  * I want to select what association types to show
  * I want to print an org chart for a person on one page
  * I want to select what node & edge label details to show
* Clean up show page for people - getting crowded!!
