// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


jQuery(function(){
    jQuery("#tabs").tabs();
});

$(function () {    
            
    // Sorting and pagination links.  
    $('#users th a, #users .pagination a, #peoples th a, #peoples .pagination a').live('click',   
        function () {  
            $.getScript(this.href);  
            return false;  
        }  
    );  
    
    // Search form.  
    $('#users_search, #peoples_search').submit(function () {  
        $.get(this.action, $(this).serialize(), null, 'script');  
        return false;  
    });    
    
    $('#users_search input').keyup(function () {  
        $.get($('#users_search').attr('action'),  
        $('#users_search').serialize(), null, 'script');  
        return false;  
    }); 
    
    $('#observation_course').change(function(){
        $.getScript(this.href);
        return false;
    }
    );
})  