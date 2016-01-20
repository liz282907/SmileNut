$(function(){
    changeActiveNav();
    $.ajax({
        type:   "Get",
        url: "/account/showUnreadMessage",
        dataType: "json",
        success: function(data){
            var messages = data.message_num;
            if (messages>0){
                var insert = '<span class="badge">'+messages+'</span>';
                $(insert).insertBefore(".caret");
                $(".li_unread").append(insert);
            }
            
        },
        error:  function(data){
        },
    })
    
    $(".tab li").eq(window.currentTab).siblings().removeClass("active")
                                    .end().addClass("active");
                                      
    $("body").on("click",".dropdown-toggle",function(){
        $(this).dropdown('toggle');
    });
    
    $("body").on("click",".unread",function() {
        sessionStorage.setItem("tab", "unread");
    });
    $("body").on("click",".info",function() {
        sessionStorage.setItem("tab", "info");
    });
    
    $("body").on("click","li",function() {
        window.currentTab = $(this).index();
    });
    
    
});

function changeActiveNav(){
    $(".nav-lis li").removeClass("active");
    var pathname = window.location.pathname;
    if(pathname.indexOf("activites")!=-1)
        $(".tab li").eq(1).addClass("active")
    else if(pathname.indexOf("hole")!=-1)
        $(".tab li").eq(2).addClass("active")
    else
        $(".tab li").eq(0).addClass("active")
}