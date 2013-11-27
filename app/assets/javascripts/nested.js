function remove_fields (link) {

 jQuery(link).prev("input[type=hidden]:first").val('1');
   jQuery(link).closest(".fields").remove();


}


function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
      if(jQuery(".fields :input").length < 20 ) {
   jQuery(link).parent().before(content.replace(regexp, new_id)); 
}
 }