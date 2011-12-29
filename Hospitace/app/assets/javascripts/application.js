// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(function () {    
            
    // Sorting and pagination links.  
    $('#datagrid .pagination a').live('click',   
        function () {  
        	console.log($.getScript(this.href));
            $.getScript(this.href);  
            return false;  
        }  
    ); 
    
    $('#datagrid th').live('click',   
        function () {  
            $.getScript($(this).find("a")[0].href)  
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
        
    $('#datagrid tbody tr').live('click',function(){
        $('#datagrid tbody tr').each(function(index){
           $(this).removeClass("market");
        });
        if($(this).find('input:radio').length == 1){
            $(this).addClass("market");
            $(this).find('input:radio').attr('checked', true);
        }
    }); 
    
    
})  