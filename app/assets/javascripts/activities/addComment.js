$(function(){
    
    console.log($("#comment_district a.comment").attr("href"));
    
    $(".each_comment .expand").hide();
    
    $(".each_comment").hover(function(){
        $(this).children("a.expand").show();
    },function(){
        $(this).children("a.expand").hide();
    });

    $("#comment_district a.expand").on("click",function(){
        var commentlink = $(this);
        commentlink.siblings(".add").show();
        // return false;
    });
    $(document).on("click", ".each_comment .comment", function() {
        var post_data = {
            comment_to_id:$(this).attr("data-test1"),
            content:$(this).siblings("input").val(),
            comment_from_name:$(this).attr("data-cur_u"),
            activity_id:$(this).attr("data-ac_id")
        }
         $.ajax({
            type:"POST",
            url:$("#comment_district a.comment").attr("href"),
            data: post_data,
            complete: function(){
                console.log("----------------complete");
            },
            success: function(data){
                // $("#comment_district").html("<%= escape_javascript(render(partial:'comment_partial', :object => @total))%>")
                //                     .append("<p>good!</p>");
                console.log(data+"---------------good ajax response");
                },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                console.log(XMLHttpRequest.responseText);
                console.log(errorThrown);
                console.log(textStatus);
                
            }
        });
        return false;
    });
    
    
});

