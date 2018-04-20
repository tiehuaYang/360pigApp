/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
     config.filebrowserUploadUrl="/manage/uploadPic";

     var pathName = window.document.location.pathname;
         //获取带"/"的项目名，如：/uimcardprj
         var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
         if(projectName =="/manage"){
        	 config.filebrowserImageUploadUrl = '/manage/uploadPic'; //固定路径
		}else{
			config.filebrowserImageUploadUrl = projectName+'/manage/uploadPic';
		}
         config.enterMode = CKEDITOR.ENTER_BR;
         config.shiftEnterMode = CKEDITOR.ENTER_P;
         config.font_names='宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;微软雅黑/微软雅黑;'+ config.font_names;
};

$.fn.modal.Constructor.prototype.enforceFocus = function() {
    modal_this = this;
    $(document).on('focusin.modal', function (e) {
        if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length
            && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_select')
            && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
            modal_this.$element.focus();
        }
    })
};