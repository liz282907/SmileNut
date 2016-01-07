$(function(){
    
    var $name = $("#name");
    var $submit = $("#submit");
    var $place = $("#place");
    var $want_join = $("#want_join");
    var $content = $("#content");
    var $tag = $("#tag");
    
    var eleArr = [$name,$place,$tag,$content];
    var error = "<span id='inputSuccess2Status' class='sr-only'>(success)</span>";
    
    resetClass($name);
    
    $("#starttime").datetimepicker({
         format: 'yyyy-mm-dd hh:ii',
         language: 'zh-CN',
         startDate: '2016-01-07'
     });
     
    $("#endtime").datetimepicker({
         format: 'yyyy-mm-dd hh:ii',
         language: 'zh-CN',
         startDate: '2016-01-07'
     });
    
    for(var ele in eleArr){
        console.log(ele+"----"+eleArr[ele]);
        eleArr[ele].on("blur",function(event){
        if( $(this).val()==""||$(this).val()=="不超过10个字")
        {
            resetClass($(this));
            $(this).parents(".form-group").addClass("has-error")
                .end().siblings(".glyphicon").addClass("glyphicon-remove");
            $submit.attr("disabled","disabled");
        }
        else
        {
            resetClass($(this));
            $(this).parents(".form-group").addClass("has-success")
                .end().siblings(".glyphicon").addClass("glyphicon-ok");
            $submit.removeAttr("disabled");
        }
            
     })}
     
     
     
     /*
    $name.on("blur",function(event){
        if($name.val()==""||$name.val()=="不超过10个字")
        {
            $name.parents(".form-group").addClass("has-error")
                .end().siblings("glyphicon").addClass("glyphicon-remove");
            $submit.attr("disabled","disabled");
        }
        else
        {
            $name.parents(".form-group").addClass("has-success")
                .end().siblings("glyphicon").addClass("glyphicon-ok");
            $submit.removeAttr("disabled");
        }
            
    });
    
    */
    
    $("#submit").on("click",function(){
        
        // if(invalidInput()) $submit.attr("disabled","disabled");
        // else
        // {
        //     $submit.removeAttr("disabled");
        // }
        
    })
    
    
    
    
    function invalidInput()
    {
        if($name.val()==""||$name.val()=="不超过10个字"){
            
            return true;
        }
    }
    
    
    
    
    
});

function resetClass(ele)
{
    ele.parents(".form-group").prop("class","form-group has-feedback")
                .end().siblings("glyphicon").prop("class","glyphicon  form-control-feedback");
    console.log(ele.attr("id")+"done");
}

