// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require ckeditor/ckeditor
//= require_tree .


$(function () {    
           
    $('#selected_semester_code').change(function(){
        $(window.location).attr('search',"semester="+this.value);
    });       
           
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
    $('#search_form').submit(function () {  
        $.get($('#search_form').attr('action'),  
        $('#search_form').serialize(), null, 'script');  
        return false;  
    }); 
    
    
    
    $('#observation_course').change(function(){
        $.getScript(this.href);
        return false;
    }
    );
        
    $('#datagrid tbody tr').live('click',function(){
        console.log("sssss");
        $('#datagrid tbody tr').each(function(index){
           $(this).removeClass("market");
        });
        if($(this).find('input:radio').length == 1){
            $(this).addClass("market");
            $(this).find('input:radio').attr('checked', true);
        }
    }); 
    
    $('.dropdown-toggle').dropdown()
})  

