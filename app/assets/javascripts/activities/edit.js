$(function(){
    
    var activity_info = $("form").attr("data-activity-info");
    $("#starttime").datetimepicker({
        format: 'yyyy-mm-dd hh:ii',
        language: 'zh-CN',
        initialDate:activity_info["start_date"]
    });
    $("#endtime").datetimepicker({
        format: 'yyyy-mm-dd hh:ii',
        language: 'zh-CN',
        initialDate:activity_info["end_date"]
    });
    var temp = JSON.parse(activity_info);
    console.log(temp["start_date"]);
    
});