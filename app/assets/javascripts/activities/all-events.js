$(function(){
    $("#previous a").trigger("click");
    
    $("body").on("click","#page-division .page",function(){
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
    $("body").on("click","#next a",function(){
        enableClick($("#previous a"))
        $(".page").each(function(index,ele){
            var val = parseInt($(ele).text())+1;
            $(ele).text(val);
        })
    });
    $("body").on("click","#previous a",increasePage);
    
    $("body").on("click","#activity_info .ui-link",function() {
        var $this = $(this);
        var cur_name = $this.attr("data-name");
        var activity_id = $this.attr("data-acid");
        var send_type = $this.attr("data-type");
        
        console.log("----------------"+activity_id+"---"+send_type);

       
            var post_data = {
                type: send_type,
                acid: activity_id,
            };
            console.log("----------------"+post_data);
             $.ajax({
                type:   "POST",
                url:    $this.attr("href"),
                dataType: "JSON",
                data:   post_data,
                success: function(data){
                    $this.text(data.data);
                    //只准每个用户对每个活动一次赞
                    // setLocalStorage(cur_name,activity_id,send_type);
                   
                       
                    console.log("-=================done");
                    console.log("---------------good ajax response");
                    },
                error: function(XMLHttpRequest, textStatus, errorThrown){
                    console.log(XMLHttpRequest.responseText);
                    console.log(errorThrown);
                    console.log(textStatus);
                    
                }
            });
   
            
        return false;
        
        
       
    });
    
    
    
    
    
    
    
    
})
//{name:{recommend:[],want_join:[]}}
//{recommend:{name:[],},want_join:{}}
function setLocalStorage(name,activity_id,type){
    
    var person_dic = localStorage.getItem(name);
    if(person_dic)
    {
        var type_arr = person_dic.getItem(type);
        if(type_arr){type_arr.push(activity_id);}
        else{
            type_arr = [activity_id];
        }
        person_dic[type] = type_arr;
    }
    else
    {
        person_dic = {type:[activity_id]};
    }
    localStorage.setItem(name,person_dic);
}

function hasRecommendOrJoin(name,activity_id,type){
    
   
    var person_dic = localStorage.getItem(name);
    // var type_arr = person_dic.getItem(type);
    return (person_dic && person_dic.getItem(type) && (person_dic.getItem(type).indexOf(activity_id)!=-1))
}


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