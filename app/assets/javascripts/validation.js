//Client side validation  

$(document).ready(function() {
  //validation for tasks form
  
    $("#user").validate({
      errorElement:'span',
      rules: {
        "user[email]":{
          required: true
        },
        "user[password]":{
          required: true
        },
        "user[first_name]":{
          required: true
        },
        "user[last_name]":{
          required: true
        },
        "user[nickname]":{
          required: true
        },
        "user[birthday]":{
          required: true
        },
        "user[location]":{
          required: true
        },
        "user[agree]":{
          required: true
        }
                  
      
          },
      messages: {
   "user[email]":{
                required: "Email cannot be blank"
      },

"user[password]":{
                required: "Password is required"
      },

"user[first_name]":{
                required: "Firstname cannot be blank"
      },

"user[last_name]":{
                required: "Lastname cannot be blank"
      },

"user[nickname]":{
                required: "Nickname cannot be blank"
      },

      "user[Birthday]":{
                required: "Choose birthday date"
      },

      "user[location]":{
                required: "Location cannot be blank"
      },

"user[agree]":{
                required: "This checkbox is required"
      }

    
    }
     });
  
     });
  
  

//   ////////////////////

// $(document).ready(function() {
//   //validation for tasks form
  
//     $("#user").validate({
//       errorElement:'span',
//       rules: {
//         "user[email]":{required: true)
//                   }

      
//           },
//       messages: {
//    "user[email]":{
//                 required: "first_name cannot be blank"
//       }
//     }
//      });
  
    
  
// });