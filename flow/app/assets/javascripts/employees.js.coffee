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

        $("#employee_subordinate_tokens").tokenInput "/employees.json",
                crossDomain: false
                queryParam: "jqst"
                theme: "facebook"
                propertyToSearch: "full_name"
                prePopulate: $("#employee_subordinate_tokens").data("pre")

        # ransack / search
        $('form').on 'click', '.remove_fields', (event) ->
                $(this).closest('.field').remove()
                event.preventDefault()

        $('form').on 'click', '.add_fields', (event) ->
                time = new Date().getTime()
                regexp = new RegExp($(this).data('id'), 'g')
                $(this).before($(this).data('fields').replace(regexp, time))
                event.preventDefault()
                