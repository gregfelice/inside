
//jQuery ->
//        $("#alert-js-file").click ->
//                alert "from the coffeescript file!!! w00t!"
//                return false

$(function() {
    $("#employee_subordinate_tokens").tokenInput("/employees.json", {
	crossDomain: false,
	theme: "facebook",
	propertyToSearch: "full_name",
	prePopulate: $("#employee_subordinate_tokens").data("pre")
    });
});


