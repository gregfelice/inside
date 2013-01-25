
//jQuery ->
//        $("#alert-js-file").click ->
//                alert "from the coffeescript file!!! w00t!"
//                return false

$(function() {
    $("#employee_direct_supervisor_tokens").tokenInput("/employees.json", {
	crossDomain: false,
	theme: "facebook",
	propertyToSearch: "full_name",
	prePopulate: $("#employee_direct_supervisor_tokens").data("pre")
    });

    $("#employee_dotted_supervisor_tokens").tokenInput("/employees.json", {
	crossDomain: false,
	theme: "facebook",
	propertyToSearch: "full_name",
	prePopulate: $("#employee_dotted_supervisor_tokens").data("pre")
    });

    $("#employee_subordinate_tokens").tokenInput("/employees.json", {
	crossDomain: false,
	theme: "facebook",
	propertyToSearch: "full_name",
	prePopulate: $("#employee_subordinate_tokens").data("pre")
    });
});


