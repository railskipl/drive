// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
function user_status(status){
	if(status == "ACTIVE"){
      	ajax_call(status)
	}
	else{

		var result=confirm("Your 10 point will be deducted.Are you sure to Continue? if credit is not present then buy for inactivating your account.");
		if (result==true)
		  {
		   ajax_call(status) 
		  }
		else
		  {
		  jQuery("#visibility_status").val("ACTIVE");
		  }

	}
}

function ajax_call(status){
    jQuery.ajax({
              type: "POST",
              url: "/users/change_status",
              data: {"status":status},
              success: function(data){
                 if(data.status==false){
                   jQuery("#visibility_status").val("INACTIVE");
                   jQuery("#visible_mode").attr("src","/assets/offline.gif");
                   jQuery(".earn_credit").html("Buy credits("+data.credit+")");
                 }
                 else
                 {
                    jQuery("#visibility_status").val("ACTIVE");
                    jQuery("#visible_mode").attr("src","/assets/online.png");
                    jQuery(".earn_credit").html("Buy credits("+data.credit+")");
                 }
               },
              dataType: "json"
        });
}










