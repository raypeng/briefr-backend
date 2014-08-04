$(function(){

    $(document).ready(function(){
        $(".blockShare span").tooltip();
        $(".blockElement").mouseover(function(){
            $(this).children("#collapse").slideDown();
        });

        $(".blockElement").mouseleave(function(){
            $(this).children("#collapse").slideUp();
        });

        $(".blockSource a").mouseover(function(){
            $(this).css("color","blue");
        });
        $(".blockSource a").mouseleave(function(){
            $(this).css("color","#359660");
        });

        $("#biz").click(function(){
            $(".active").attr("class", "");
            $(this).attr("class","active");
        });
        $("#tech").click(function(){
            $(".active").attr("class", "");
            $(this).attr("class","active");
        });
        $("#life").click(function(){
            $(".active").attr("class", "");
            $(this).attr("class","active");
        });
        $("#navbar-fixed-top").headroom();

    });

});
