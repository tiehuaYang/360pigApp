$(function () {

	var uploader = $("#fileupload");
	$('#fileupload').fileupload({
        disableImageResize: false,
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
        url: '/argCom/manage/saveCatePicture',
        done: function (e, data) {
	            toastr['success'](data.result.msg, "");
	    }
    });
	
	uploader.fileupload({
		url: '/argCom/manage/saveCatePicture',
	    dataType: 'json',
	    autoUpload: false,
	    disableImageResize: /Android(?!.*Chrome)|Opera/
            .test(window.navigator.userAgent),
	    acceptFileTypes:  /(\.|\/)(gif|jpe?g|png)$/i,
	    maxFileSize: 5000000
	    
	});
	uploader.find("input:file").removeAttr('disabled');

});