// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery2
// require jquery_ujs
//= require_tree .



document.addEventListener('turbolinks:load', function(e) {
    $(".login>div").click(function() {
        $(".background-subscription").addClass('open-background-subscription');
    });
    $(".closed-background-subscription").click(function() {
        $(".background-subscription").removeClass('open-background-subscription');
    });
});


$(document).ready(function() {
    $(".login>div").click(function() {
        $(".background-subscription").addClass('open-background-subscription');
    });
    $(".closed-background-subscription").click(function() {
        $(".background-subscription").removeClass('open-background-subscription');
    });

    $(".closed-background-subscription").click(function() {
        $(".background-subscription").removeClass('open-background-subscription');
    });


    $(document).click( function(event){
        if( $(event.target).closest(".drop-down-list-button-reveal").length)
            return;
        $(".drop-down-list-button-reveal").slideUp("slow");
        event.stopPropagation();
        if($(".button-reveal").hasClass('open-button-reveal')) {
            $(".button-reveal").removeClass('open-button-reveal');
        }
    });
    $('.button-reveal').click( function() {
        $(".drop-down-list-button-reveal").slideToggle("slow");
        if(!$(".button-reveal").hasClass('open-button-reveal')) {
            $(".button-reveal").addClass('open-button-reveal');
        }
        else if($(".button-reveal").hasClass('open-button-reveal')) {
            $(".button-reveal").removeClass('open-button-reveal');
        }
        return false;
    });


    // Панель выбора родителя
    $("#button-parent-yes").click(function() {
        $(".options-for-selecting-parent").css('left', '-100%');
        $(".parent-selection-panel").css('right', '0');
        setTimeout(function() {
            var adjustableHeight = $('.parent-selection-panel').innerHeight();
            $(".choice-of-parent").css('height', adjustableHeight);
        }, 100);

    });
    $("#close-parent-selection-panel").click(function() {
        $(".options-for-selecting-parent").css('left', '0');
        $(".parent-selection-panel").css('right', '-100%');

        var adjustableHeight = $('.options-for-selecting-parent').innerHeight();
        $(".choice-of-parent").css('height', adjustableHeight);
    });
    // При нажатии "Нет"
    $("#button-parent-no").click(function() {
        $(".options-for-selecting-parent").css('left', '-100%');
        $(".add-parent-panel").css('right', '0');
        setTimeout(function() {
            var adjustableHeight = $('.add-parent-panel').innerHeight();
            $(".choice-of-parent").css('height', adjustableHeight);
        }, 100);

    });
    $("#close-add-parent-panel").click(function() {
        $(".options-for-selecting-parent").css('left', '0');
        $(".add-parent-panel").css('right', '-100%');

        var adjustableHeight = $('.options-for-selecting-parent').innerHeight();
        $(".choice-of-parent").css('height', adjustableHeight);
    });

    //таб

    /*$('.cont-category-book>div:not(":first-of-type")').hide(); // прячем
    // добавить data-tab блокам выбора
    $('.category-book>div').each(function(i) {
        $(this).attr("data-tab", 'tab'+i);
    });
    // добавить data-tab блокам контента
    $('.cont-category-book>div').each(function(i) {
        $(this).attr("data-tab", 'tab'+i);
    });

    $('.category-book>div').on('click', function() {
        var dataTab = $(this).data('tab');
        var getWrapper = $(this).closest('.tab-wrapper');

        getWrapper.find('.category-book>div').removeClass('active');

        $(this).addClass('active');

        getWrapper.find('.cont-category-book>div').hide();
        getWrapper.find('.cont-category-book>div[data-tab='+dataTab+']').show();


    });*/


    // цифровые книги/аудиокниг/печатные книги
    var $wrapper = $('.block-related-books'),
        $allTabs = $wrapper.find('.cont-category-book>div'),
        $tabMenu = $wrapper.find('.category-book>div');

    $allTabs.not(':first-of-type').hide();
    $allTabs.addClass('active-tab-category');

    $tabMenu.each(function(i) {
        $(this).attr('data-tab', 'tab'+i);
    });

    $allTabs.each(function(i) {
        $(this).attr('data-tab', 'tab'+i);
    });

    $tabMenu.on('click', function() {

        var dataTab = $(this).data('tab'),
            $getWrapper = $(this).closest($wrapper);

        $getWrapper.find($tabMenu).removeClass('active');
        $(this).addClass('active');

        $allTabs.removeClass('active-tab-category');
        $getWrapper.find($allTabs).hide();
        $getWrapper.find($allTabs).filter('[data-tab='+dataTab+']').show();
        setTimeout(function() {
            $allTabs.addClass('active-tab-category');
        }, 50);
    });

    // открыть меню
    $('.btm-open-menu').click(function () {
        if($('.pop-up-menu').hasClass('open-pop-up-menu')) {
            $('.pop-up-menu').removeClass('open-pop-up-menu');
        }
        else {
            $('.pop-up-menu').addClass('open-pop-up-menu');
        }
    });

    $('.background-menu').click(function () {
        if($('.pop-up-menu').hasClass('open-pop-up-menu')) {
            $('.pop-up-menu').removeClass('open-pop-up-menu');
        }
        else {
            $('.pop-up-menu').addClass('open-pop-up-menu');
        }
    });

});