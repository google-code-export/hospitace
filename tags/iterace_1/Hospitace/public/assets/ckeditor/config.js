/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

CKEDITOR.editorConfig = function( config )
{
    /* Toolbars */
    config.toolbar = 'Note';
    config.toolbar_Note =
    [
		{ name: 'document',    items : [ 'NewPage','Preview'] },
                { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
                { name: 'editing',     items : [ 'Find','Replace','-','SelectAll' ] },
                { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
                { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv' ] },
                { name: 'links',       items : [ 'Link','Unlink','Anchor' ] },
                { name: 'insert',      items : [ 'Table','Smiley','SpecialChar' ] },
                '/',
                { name: 'styles',      items : [ 'Styles','Format','Font','FontSize' ] },
                { name: 'colors',      items : [ 'TextColor' ] },
                { name: 'tools',       items : [ 'About' ] }
	];
};