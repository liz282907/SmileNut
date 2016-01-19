$(function() {
    
    
    
   $("body").on("click", "#left-list .tab a", function() {
        var $this = $(this);
        var get_data = {
            tab: $this.attr("data-tab"),
            name: $this.attr("data-name"),
        }
         $.ajax({
            type:   "GET",
            url:    $this.attr("href"),
            dataType:"html",
            data:   get_data,
            complete: function(){
                console.log("-------------user profile");
            },
            success: function(data){
                $("#right-body").html(data);
                $("#left-list a").removeClass("active");
                $this.addClass("active");
                console.log("-================="+data);
                console.log(data.info+"---------------good ajax response");
                },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                console.log(XMLHttpRequest.responseText);
                console.log(errorThrown);
                console.log(textStatus);
                
            }
        });
        return false;
    });
    
    var tab = sessionStorage.getItem("tab");
    switch (tab) {
        case 'info':
            $("#left-list .tab a").eq(0).trigger("click");
            break;
        case 'unread':
            $("#left-list .tab a").eq(1).trigger("click");
            break;
        default:
            $("#left-list .tab a").eq(0).trigger("click");
            break;
    }
   
   
   
   
   
   
});
