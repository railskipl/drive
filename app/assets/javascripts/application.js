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

		var result=confirm("Your 10 point will be deducted.Are you sure to Continue?");
		if (result==true)
		  {
		   ajax_call(status) 
		  }
		else
		  {
		  $("#visibility_status").val("ACTIVE");
		  }

	}
}

function ajax_call(status){
    $.ajax({
              type: "POST",
              url: "/users/change_status",
              data: {"status":status},
              success: function(data){
                 if(data.status==false){
                   $("#visibility_status").val("INACTIVE");
                   $("#visible_mode").attr("src","/assets/offline.gif");
                   $(".earn_credit").html("Earn credits("+data.credit+")");
                 }
                 else
                 {
                    $("#visibility_status").val("ACTIVE");
                    $("#visible_mode").attr("src","/assets/online.png");
                    $(".earn_credit").html("Earn credits("+data.credit+")");
                 }
               },
              dataType: "json"
        });
}










