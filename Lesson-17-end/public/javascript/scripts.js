(function($) {
$(function () {

    if ($('select').length) {
        $("select").chosen({
            allow_single_deselect: true,
            disable_search_threshold: 12
        });
    }


    if ($('input[type="checkbox"]').length) {
        $('input[type="checkbox"]').checkbox({
            checkedClass: 'fa fa-check-square-o',
            uncheckedClass: 'fa fa-square-o'
        });
    }


    if ($('[data-datepicker]').length) {
        $('[data-datepicker]').datetimepicker({
            pickTime: false
        });
    }



    var $tis = this,
        $wrapper = $('#wrapper'),
        $navMobile,
        etype = $.browser.mobile ? 'touchstart' : 'click';
        w = $(window).innerWidth();


    if (w <= 975 && !$tis.mobMenuFlag) {

        $('body').prepend('<nav class="nav-mobile"><i class="fa fa-times"></i><h2><i class="fa fa-bars"></i>' + $tis.mobileMenuTitle + '</h2><ul></ul></nav>');

        $('.nav-mobile > ul').html($('.nav').html());

        $('.nav-mobile b').remove();

        $('.nav-mobile ul.dropdown-menu').removeClass().addClass("dropdown-mobile");

        //$('.nav-mobile').css({'min-height': ($('#wrapper').height() + 270) + 'px' });

        $navMobile = $(".nav-mobile");

        $("#nav-mobile-btn").bind(etype, function (e) {
            e.stopPropagation();
            e.preventDefault();

            setTimeout(function () {
                $wrapper.addClass('open');
                $navMobile.addClass('open');
                $navMobile.getNiceScroll().show();
            }, 25);

            $(document).bind(etype, function (e) {
                if (!$(e.target).hasClass('nav-mobile') && !$(e.target).parents('.nav-mobile').length) {
                    $wrapper.removeClass('open');
                    $navMobile.removeClass('open');
                    $(document).unbind(etype);
                    $.waypoints('enable');
                }
            });

            $('>i', $navMobile).bind(etype, function () {
                $navMobile.getNiceScroll().hide();
                $wrapper.removeClass('open');
                $navMobile.removeClass('open');
                $(document).unbind(etype);
                $.waypoints('enable');
            });
        });

        $navMobile.niceScroll({
            autohidemode: true,
            cursorcolor: "#c2c2c2",
            cursoropacitymax: "0.7",
            cursorwidth: 10,
            cursorborder: "0px solid #000",
            horizrailenabled: false,
            zindex: "1"
        });

        $navMobile.getNiceScroll().hide();

        $tis.mobMenuFlag = true;
    }


	
})
})(jQuery);