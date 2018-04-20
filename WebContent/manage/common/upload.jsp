
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Redirect browsers with JavaScript disabled to the origin page-->
<!--The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload-->

<!--The table listing the files available for upload/download-->

<div class="row fileupload-buttonbar">
	<div class="col-lg-7">
		<!--The fileinput-button span is used to style the file input field as button-->
		<span class="btn btn-success fileinput-button"><i
			class="glyphicon glyphicon-plus"></i>&nbsp;<span>添加图片...</span> <input
			type="file" name="file" multiple="multiple" /> </span>&nbsp; &nbsp;
		<button type="submit" class="btn btn-danger start">
			<i class="glyphicon glyphicon-upload"></i>&nbsp;<span>开始上传</span>
		</button>
		&nbsp; &nbsp;
		<!-- 
                                        <button type="reset" class="btn btn-warning cancel"><i class="glyphicon glyphicon-ban-circle"></i>&nbsp;<span>取消上传</span>
                                        </button>&nbsp; &nbsp;
                                        
                                        <button type="button" class="btn btn-danger delete"><i class="glyphicon glyphicon-trash"></i>&nbsp;<span>删除</span>
                                        </button>&nbsp; &nbsp;
                                         -->
		<!--The global file processing state-->
		<span class="fileupload-process"></span>
	</div>
	<!--The global progress state-->
	<div class="col-lg-5 fileupload-progress fade">
		<!--The global progress bar-->
		<div role="progressbar" aria-valuemin="0" aria-valuemax="100"
			class="progress progress-striped active">
			<div style="width: 0%;" class="progress-bar progress-bar-success"></div>
		</div>
		<!--The extended global progress state-->
		<div class="progress-extended"> </div>
	</div>
</div>

<!--The blueimp Gallery widget-->
<!--
                            <div id="blueimp-gallery" data-filter=":even" class="blueimp-gallery blueimp-gallery-controls">
                                <div class="slides"></div>
                                <h3 class="title"></h3><a class="prev">‹</a><a class="next">›</a><a class="close">×</a>
                                <a class="play-pause"></a>
                                <ol class="indicator"></ol>
                            </div>
                            -->
<!-- The template to display files available for upload-->
<script id="template-upload" type="text/x-tmpl">{% for (var i=0, file; file=o.files[i]; i++) { %}
                                <tr class="template-upload fade">
                                    <td>
                                        <span class="preview"></span>
                                    </td>
                                    <td>
                                        <p class="name">{%=file.name%}</p>
                                    </td>
                                    <td>
                                        <p class="size">Processing...</p>
                                        <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                            <div class="progress-bar progress-bar-success" style="width:0%;"></div>
                                        </div>
                                    </td>
                                    <td>
                                        {% if (!i && !o.options.autoUpload) { %}
                                        <button class="btn btn-primary start hide" disabled>
                                            <i class="glyphicon glyphicon-upload"></i>
                                            <span>Start</span>
                                        </button>
                                        {% } %} {% if (!i) { %}

										<button class="btn btn-warning cancel">
                                            <i class="glyphicon glyphicon-ban-circle"></i>
                                            <span>取消上传</span>
                                        </button>

                                        {% } %}
                                    </td>
                                </tr>
                                {% } %}</script>
<!-- The template to display files available for download-->
<script id="template-download" type="text/x-tmpl">{% for (var i=0, file; file=o.files[i]; i++) { %}
                                <tr class="template-download fade">
                                    <td>
                                        <span class="preview">
                {% if (file.thumbnailUrl) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
                {% } %}
            </span>
                                    </td>
                                    <td>
                                        <p class="name">
                                            {% if (file.url) { %}
                                            <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl? 'data-gallery': ''%}>{%=file.name%}</a> {% } else { %}
                                            <span>{%=file.name%}</span> {% } %}
                                        </p>
                                        {% if (file.error) { %}
                                        <div><span class="label label-danger">Error</span> {%=file.error%}</div>
                                        {% } %}
                                    </td>
                                    <td>
                                        <span class="size">{%=o.formatFileSize(file.size)%}</span>
                                    </td>
                                    <td>
                                        {% if (file.deleteUrl) { %}
                                        <button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}" {% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}' {% } %}>
                                            <i class="glyphicon glyphicon-trash"></i>
                                            <span>Delete</span>
                                        </button>
                                        <input type="checkbox" name="delete" value="1" class="toggle"> {% } else { %}
                                        <button class="btn btn-warning cancel">
                                            <i class="glyphicon glyphicon-ban-circle"></i>
                                            <span>Cancel</span>
                                        </button>
                                        {% } %}
                                    </td>
                                </tr>
                                {% } %}</script>