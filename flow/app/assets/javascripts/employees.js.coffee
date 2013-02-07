jQuery ->
  
  # jquery token input
  $("#employee_direct_supervisor_tokens").tokenInput "/employees.json",
    crossDomain: false
    queryParam: "jqst"
    theme: "facebook"
    propertyToSearch: "full_name"
    prePopulate: $("#employee_direct_supervisor_tokens").data("pre")

  $("#employee_dotted_supervisor_tokens").tokenInput "/employees.json",
    crossDomain: false
    queryParam: "jqst"
    theme: "facebook"
    propertyToSearch: "full_name"
    prePopulate: $("#employee_dotted_supervisor_tokens").data("pre")

  $("#employee_direct_subordinate_tokens").tokenInput "/employees.json",
    crossDomain: false
    queryParam: "jqst"
    theme: "facebook"
    propertyToSearch: "full_name"
    prePopulate: $("#employee_direct_subordinate_tokens").data("pre")

  $("#employee_dotted_subordinate_tokens").tokenInput "/employees.json",
    crossDomain: false
    queryParam: "jqst"
    theme: "facebook"
    propertyToSearch: "full_name"
    prePopulate: $("#employee_dotted_subordinate_tokens").data("pre")

  # ransack / search
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).closest('.field').remove()
    event.preventDefault()
    
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  # collapsing search section
  $("#search-section").hide()
  
  $("#show_search").click ->
    $(this).hide()
    $("#search-section").toggle "slide", 500

  $(".close").click ->
    $("#search-section").toggle "slide", 500
    $("#show_search").show()

  # change employee label to supervisor
  if $('#q_c_0_a_0_name').length > 0 then $('#q_c_0_a_0_name optgroup')[1].label = 'Supervisor'

  # default conditions
  $('#q_c_0_a_0_name').val('full_name')
  $('#q_c_0_p').val('cont')
  $('#q_c_0_v_0_value').val('')
  
  # default sorts
  $('#q_s_0_name').val('full_name')
  $('#q_s_0_dir').val('asc')

