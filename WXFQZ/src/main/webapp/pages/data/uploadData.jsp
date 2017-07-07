<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>导入数据</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<link href="${ctxPath}/static/source/style/stream-v1.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>导入数据</h1>
			<span class="detailGoBack">返回</span>
		</div>
	<div class="alert alert-info">
		<form class="form-horizontal" autocomplete="off"  role="form">
			<div class="form-group newAddDatebase">
				<label class="col-sm-2 col-xs-4 control-label no-padding-right">数据名称</label>
				<div class="col-sm-9 col-xs-8">
					<input type="text" placeholder="数据名称"  name="databaseName1" value="" class="col-xs-10 col-sm-5" />
					<span class="help-inline col-xs-12 col-sm-7">
						<span class="middle" style="line-height:30px"></span>
					</span>
				</div>
			</div>
			<div class="form-group newAddDatebase">
				<label class="col-sm-2 col-xs-4 control-label no-padding-right">描述</label>
				<div class="col-sm-9 col-xs-8">
					<textarea class="col-xs-10 col-sm-5" rows="4"></textarea>
					<span class="help-inline col-xs-12 col-sm-7">
						<span class="middle" style="line-height:30px"></span>
					</span>
				</div>
			</div>
		</form>
		<form class="form2 form-horizontal" autocomplete="off" role="form" >
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right">上传文件</label>
				<div class="col-sm-8">
					<div id="i_select_files"></div>
					<div id="i_stream_files_queue" >
					</div>
				</div>
			<div class="col-xs-2 col-sm-2 fileSuccess"></div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right"> </label>
				<div class="col-sm-8">
					<span class="creatTaskBtn">提交</span>
				</div>
			</div>
		</form>
	</div>
	</div>
	<script type="text/javascript" src="${ctxPath}/static/source/js/stream-v1.js"></script>
	<script type="text/javascript">
	//返回
	$(".detailGoBack").click(function(){
		window.location.href="${ctxPath}/v1/html/data/sampleData/list.do";
	});
	var fileLock = true;
	var esFileServerIp = "192.168.0.33";
	var config = {
			browseFileId : "i_select_files", /** 选择文件的ID, 默认: i_select_files */
			browseFileBtn : "<div>请选择文件</div>", /** 显示选择文件的样式, 默认: `<div>请选择文件</div>` */
			dragAndDropArea: "i_select_files", /** 拖拽上传区域，Id（字符类型"i_select_files"）或者DOM对象, 默认: `i_select_files` */
			dragAndDropTips: "<span>把文件(文件夹)拖拽到这里</span>", /** 拖拽提示, 默认: `<span>把文件(文件夹)拖拽到这里</span>` */
			filesQueueId : "i_stream_files_queue", /** 文件上传容器的ID, 默认: i_stream_files_queue */
			filesQueueHeight : 200, /** 文件上传容器的高度（px）, 默认: 450 */
			messagerId : "i_stream_message_container", /** 消息显示容器的ID, 默认: i_stream_message_container */
			multipleFiles: true, /** 多个文件一起上传, 默认: false */
			onRepeatedFile: function(f) {
				alert("文件："+f.name +" 大小："+f.size + " 已存在于上传队列中。");
				return false;	
			},
			autoUploading: false, /** 选择文件后是否自动上传, 默认: true */
//			autoRemoveCompleted : true, /** 是否自动删除容器中已上传完毕的文件, 默认: false */
//			maxSize: 1000, /** 单个文件的最大大小，默认:2G */
//			retryCount : 5, /** HTML5上传失败的重试次数 */
			postVarsPerFile : { /** 上传文件时传入的参数，默认: {} */
				path1: $("#userNumber").val(),
//				param2: "val2"
			},
//			swfURL : "/swf/FlashUploader.swf", /** SWF文件的位置 */
			tokenURL :esFileServerIp+ "/tk", /** 根据文件名、大小等信息获取Token的URI（用于生成断点续传、跨域的令牌） */
//			frmUploadURL : "/fd;", /** Flash上传的URI */
//			 uploadURL : "/upload", /** HTML5上传的URI */
			simLimit: 1, /** 单次最大上传文件个数 */
			extFilters:[".xls",".xlsx"], /** 允许的文件扩展名, 默认: [] */
			onSelect: function(list) {
				fileUploadFlag = true;
			}, /** 选择文件后的响应事件 */
			onMaxSizeExceed: function(size, limited, name) {
				$("#subBtn").html("上传");
				subLock = true;
				fileUploadFlag = false;
				Showbo.Msg.alert("文件过大，请重新选择文件");
				
			}, /** 文件大小超出的响应事件 */
			onFileCountExceed: function(selected, limit) {
				Showbo.Msg.alert("目前仅允许上传一个文件");
				
			}, /** 文件数量超出的响应事件 */
			onExtNameMismatch: function(name, filters) {
				Showbo.Msg.alert("上传文件不匹配，点击确定按钮重新上传");
				fileUploadFlag = false;
			}, /** 文件的扩展名不匹配的响应事件 */
			onCancel : function(file) {
				$("#subBtn").html("上传");
				subLock = true;
				fileUploadFlag = false;
				Showbo.Msg.alert("文件上传已取消",function(){
					if ($(".btnfocus").val() == "确定"&&formLock) {
						window.location.href="${ctxPath}/v1/html/dataManager/dataUniverse/taskList.do";
					}
				});
				
			}, /** 取消上传文件的响应事件 */
			onComplete: function(file) {
				fileLock=true
				
			}, /** 单个文件上传完毕的响应事件 */
//			onQueueComplete: function() {alert('onQueueComplete')}, /** 所以文件上传完毕的响应事件 */
//			onUploadError: function(status, msg) {alert('onUploadError')} /** 文件上传出错的响应事件 */
//			onDestroy: function() {alert('onDestroy')} /** 文件上传出错的响应事件 */
			onCompleteTk:function(fileInfo){
				//formAjaxSub(fileInfo);
			}
		};
		var _t = new Stream(config);
	</script>
</body>
</html>