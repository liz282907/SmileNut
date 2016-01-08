$(function(){
    
    $(".each_comment").hover(function(){
        $(this).children("a.expand").show();
    },function(){
        $(this).children("a.expand").hide();
    });
    
    $("#comments a.expand").on("click",function(){
        var commentlink = $(this);
        commentlink.siblings(".add").show();
        return false;
    });
    $(".each_comment .comment").on("click",function() {
        var post_data = {
            comment_to_id:$(this).attr("data-test1"),
            content:$(this).siblings("input").val(),
            comment_from_id:$(this).attr("data-cur_u"),
            activity_id:$(this).attr("data-activity_id")
        }
         $.ajax({
            type:"POST",
            url: $("#comments a.expand").attr("href"),
            data: post_data,
            success: function(){
                
                
                }
        });
        return false;
    });
});

