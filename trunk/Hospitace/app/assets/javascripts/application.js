// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function () {    
            
    // Sorting and pagination links.  
    $('#datagrid th a, #datagrid .pagination a').live('click',   
        function () {  
            $.getScript(this.href);  
            return false;  
        }  
    );  
    
    // Search form.  
    $('#datagrid_search').submit(function () {  
        $.get($('#datagrid_search').attr('action'),  
        $('#datagrid_search').serialize(), null, 'script');  
        return false;  
    }); 
    
    
    
    $('#observation_course').change(function(){
        $.getScript(this.href);
        return false;
    }
    );
})  