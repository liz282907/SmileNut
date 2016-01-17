$(function(){
    $("#previous a").trigger("click");
    
    $(document).on("click","#page-division .page",function(){
        var page_id = $(this).text();
        $.ajax({
            url:"/activites/all-events",
            data:{page: page_id},
            dataType:"html",
            success:    function(data){
                console.log("--------------"+data);
                $(".activity_cards").html(data);
            },
            error:  function(data){
                console.log(data.responseText);
            }
        })
    });
    $(document).on("click","#next a",function(){
        enableClick($("#previous a"))
        $(".page").each(function(index,ele){
            var val = parseInt($(ele).text())+1;
            $(ele).text(val);
        })
    });
    $(document).on("click","#previous a",increasePage);
})

function disableLink($link) {
     //设置href属性
     $link.removeAttr("href")
            .parent()
            .attr("disabled","disabled")
            .addClass("disabled");
     //设置disabled属性
     $(document).on("click",$link[0],function() {
         return false;
     });
 }
function enableClick($link) {
     //设置href属性
     $link.removeClass("disable_link");
     $link.prop("href","#anchor")
            .parent()
            .removeAttr("disabled")
            .removeClass("disabled");
     //设置disabled属性
 }
 
function increasePage(e){
        if($(".page").first().text()<=1)
        {
            $("#previous a").addClass("disable_link");
            return false;
        }
        $("#previous a").removeClass("disable_link");
        $(".page").each(function(index,ele){
            var val = parseInt($(ele).text())-1;
            $(ele).text(val);
        });
}