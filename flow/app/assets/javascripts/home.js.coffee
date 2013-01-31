$ ->
  "use strict"
  $(".gantt").gantt
    source: [
      name: "CMS - Scoop"
      desc: "Modernization"
      values: [
        from: "/Date(1320193000000)/"
        to: "/Date(1322401600000)/"
        label: "System Decom"
        customClass: "ganttRed"
      ]
    ,
      name: " "
      desc: "Unification"
      values: [
        from: "/Date(1322611200000)/"
        to: "/Date(1323302400000)/"
        label: "Scoping"
        customClass: "ganttRed"
      ]
    ,
      name: "Infrastructure"
      desc: "Data Center"
      values: [
        from: "/Date(1323802400000)/"
        to: "/Date(1325685200000)/"
        label: "Development"
        customClass: "ganttGreen"
      ]
    ,
      name: " "
      desc: "EC2 Infrastructure"
      values: [
        from: "/Date(1325685200000)/"
        to: "/Date(1325695200000)/"
        label: "Showcasing"
        customClass: "ganttBlue"
      ]
    ,
      name: "Business Intelligence"
      desc: "Web Analytics"
      values: [
        from: "/Date(1326785200000)/"
        to: "/Date(1325785200000)/"
        label: "Development"
        customClass: "ganttGreen"
      ]
    ,
      name: " "
      desc: "Data Tracking"
      values: [
        from: "/Date(1328785200000)/"
        to: "/Date(1328905200000)/"
        label: "Showcasing"
        customClass: "ganttBlue"
      ]
    ,
      name: "Human Resources"
      desc: "Staff Goals"
      values: [
        from: "/Date(1330011200000)/"
        to: "/Date(1336611200000)/"
        label: "Discovery"
        customClass: "ganttOrange"
      ]
    ,
      name: " "
      desc: "HR Systems"
      values: [
        from: "/Date(1336611200000)/"
        to: "/Date(1338711200000)/"
        label: "Deployment"
        customClass: "ganttOrange"
      ]
    ,
      name: " "
      desc: "Culture"
      values: [
        from: "/Date(1336611200000)/"
        to: "/Date(1349711200000)/"
        label: "Warranty Period"
        customClass: "ganttOrange"
      ]
    ]
    navigate: "scroll"
    scale: "weeks"
    maxScale: "months"
    minScale: "days"
    itemsPerPage: 10
    onItemClick: (data) ->
      alert "Item clicked - show some details"

    onAddClick: (dt, rowId) ->
      alert "Empty space clicked - add an item!"

    onRender: ->
      console.log "chart rendered"  if window.console and typeof console.log is "function"

  $(".gantt").popover
    selector: ".bar"
    title: "Financials"
    content: "$5.34MM"
    trigger: "hover"

  prettyPrint()

