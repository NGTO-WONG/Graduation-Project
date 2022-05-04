$(function () {
    $(".child_nav").show();
    $(".main_nav").click(function () {
        $(this).addClass("current").next(".child_nav").slideToggle(300, function () {
            if ($(this).is(":hidden")) {
                $(this).prev().find("i:last-child").prop("class", "icon-angle-right icon_right");
            } else {
                $(this).prev().find("i:last-child").prop("class", "icon-angle-down icon_right");
            }
        }).siblings(".child_nav").slideUp("slow", function () {
            if ($(this).is(":hidden")) {
                $(this).prev().find("i:last-child").prop("class", "icon-angle-right icon_right");
            } else {
                $(this).prev().find("i:last-child").prop("class", "icon-angle-down icon_right");
            }
        });
        $(this).siblings().removeClass("current");
    });
    $(".column_down").click(function () {
        var id = $(this).attr("data-id");
        $(".child_toggle" + id).toggle();
    });
    $(".role_toggle").click(function (ev) {
        $(this).parent().parent().next().slideToggle(function () {
            if ($(this).is(":hidden")) {
                $(this).prev().find("i").prop("class", "icon-caret-down role_toggle")
            } else {
                $(this).prev().find("i").prop("class", "icon-caret-up role_toggle")
            }
        });
    });
    $(".checks_line").each(function (index) {
        var oldcolor;
        if (index % 2 == 0) {
            $(this).css("background-color", "#f6f6f6");
        } else {
            $(this).css("background-color", "#fff");
        }
    }).hover(
        function () {
            oldcolor = $(this).css("background-color");
            newcolor = $(this).css("background-color", "#e1e9f4")
        }, function () {
            $(this).css("background-color", oldcolor);
        });
    $(".app_nav ul li").mouseover(function () {
        $(this).find(".app_edit").css("display", "block")
    })
    $(".app_nav ul li").mouseout(function () {
        $(this).find(".app_edit").css("display", "none")
    });
    $(".node_content").click(function () {
        $(this).next("ul").slideToggle("fast", function () {
            if ($(this).is(":hidden")) {
                $(this).parent().attr("class", "tree_node");
            }
            else {
                $(this).parent().attr("class", "tree_node open");
            }
        })
    })
    $(".node_content").each(function (index) {
        $(this).parent().attr("class", "tree_node open");
        $(this).next("ul").slideToggle();

        var oldcolor;
        if (index % 2 == 0) {
            $(this).css("background-color", "#f6f6f6");
        } else {
            $(this).css("background-color", "#ffffff");
        }
    }).hover(
        function () {
            oldcolor = $(this).css("background-color");
            newcolor = $(this).css("background-color", "#e1e9f4")
        }, function () {
            $(this).css("background-color", oldcolor);
        });
    var main_right_minheight = document.documentElement.clientHeight || document.body.clientHeight;
    $(".main_right_220").css("min-height", main_right_minheight - 100);
    var role_content_right = document.documentElement.clientHeight || document.body.clientHeight;
    $(".role_content_right").css("min-height", main_right_minheight - 130);
    $(".role_app ul").children("li").click(function () {
        $(this).addClass("role_app_li");
        $(this).siblings().removeClass("role_app_li")
    });
});