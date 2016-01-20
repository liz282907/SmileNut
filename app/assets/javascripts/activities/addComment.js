$(function(){
    
    console.log($("#comment_district a.comment").attr("href"));
    
    // $(".each_comment .expand").hide();
    $("body").on("mouseenter",".each_comment",function() {
         $(this).children("a.expand").show();
    });
    $("body").on("mouseleave",".each_comment",function() {
         $(this).children("a.expand").hide();
    });
    /*
    $(".each_comment").hover(function(){
        $(this).children("a.expand").show();
    },function(){
        $(this).children("a.expand").hide();
    });
*/
    $("body").on("click","#comment_district a.expand",function() {
         var commentlink = $(this);
            commentlink.closest(".each_comment")
                        .find(".add").show();
            // $$(".add").show();
                    // .siblings(".add").show();
    });
    
    $("body").on("click","#comment_district a.cancel",function() {
         var commentlink = $(this);
            commentlink.closest(".add").find("textarea").val("").parent().hide();
    });
   
    $("body").on("click", "#add_comment .commentBtn", function() {
        var $this = $(this);
        var post_data = {
            comment_to_name:$this.attr("data-single_to_name"),
            content:$this.closest("#add_comment").find("textarea").val(),
            comment_from_name:$this.attr("data-single_fromname"),
            activity_id:$this.attr("data-single_ac_id")
        }
         $.ajax({
            type:   "POST",
            url:    $this.attr("href"),
            dataType:"html",
            data:   post_data,
            success: function(data){
                $("#comment_district").html(data);
                $("#comment_district .each_comment").last().toggleClass("highlight");
                // $("#add_comment .commentBtn").siblings("textarea").val("");
                $("#add_comment textarea").val("");
                console.log("-=================done");
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
    
    
    //每一条回复后面的点击操作
    $("body").on("click", ".each_comment .comment", function(e) {
        
        
        var comment_to = ($(e.target).closest(".each_comment").find(".first_name").text().split("回复"))[0];
        console.log("==================="+comment_to);
        // console.log("==================="+$(e.target).closest(".each_comment").find(".first_name").html());
        var post_data = {
            comment_to_name:    comment_to,
            content: $(this).parent().siblings("textarea").val(),
            comment_from_name:$(this).attr("data-cur_u"),
            activity_id:$(this).attr("data-ac_id")
        }
        console.log("-----------post-data"+post_data.content);
         $.ajax({
            type:"POST",
            url:$("#comment_district a.comment").attr("href"),
            dataType:"html",
            data: post_data,
            complete: function(){
                console.log("----------------complete");
            },
            success: function(data){
                // $("#comment_district").html("<%= escape_javascript(render(partial:'comment_partial', :object => @total))%>")
                //                     .append("<p>good!</p>");
                $("#comment_district").html(data);
                $("#comment_district .each_comment").last().toggleClass("highlight");
                console.log("-=================done");
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

