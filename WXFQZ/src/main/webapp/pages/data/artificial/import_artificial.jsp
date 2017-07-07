<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>人工导入</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
	<link rel="stylesheet" href="${ctxPath}/static/ace/css/bootstrap-duallistbox.css" />
<script src="${ctxPath }/static/source/js/jedate/jedate.js"></script>
<link href="${ctxPath}/static/source/style/stream-v1.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>人工导入</h1>
		</div>
		<div class="detailCondition">
			<form class="form-horizontal" autocomplete="off" role="form" >
				<h4 class="taskTitle">数据信息</h4>
					<div class="form-group">
						<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon">数据源名称：</label>
						<div class="col-sm-9 col-xs-8">
							<input type="text" value="" id="dataSourceName" class="col-xs-12 col-sm-4" onblur="checkInputNull(this)">
							<span class="help-inline col-xs-12 col-sm-6">
							<span class="middle existenceCon" style="line-height:30px">（必填）</span>
						</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >数据源备注：</label>
						<div class="col-sm-9 col-xs-8">
							<textarea class="col-xs-12  col-sm-6 col-md-5" id="dataSourceDec"  rows="5" ></textarea>
							<span class="help-inline col-xs-12 col-sm-6">
								<span class="middle existenceCon" style="line-height:30px"></span>
							</span>
						</div>
					</div>
				<hr>
			</form>
			<form class="form2 form-horizontal" autocomplete="off" role="form" >
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >导入方式：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="checkbox radioUl multiCheck">
							<label>
								<input value="0" name="importType" type="radio" checked class="ace">
								<span class="lbl">格式化导入</span>
							</label>
							<label>
								<input value="1" name="importType" type="radio" disabled  class="ace">
								<span class="lbl" style="cursor:not-allowed">自定义导入</span>
							</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >文件格式：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="checkbox radioUl multiCheck">
							<label>
								<input value="0" name="fileType" type="radio" checked class="ace">
								<span class="lbl">excel</span>
							</label>
							<label class="downloadDemo">
								（<a href="${ctxPath}/static/templates/数据采集模板.xlsx" >下载模板</a>）
							</label>
							<label>
								<input value="1" name="fileType" type="radio" class="ace">
								<span class="lbl">CSV</span>
							</label>
							<label class="downloadDemo">
								（<a href="${ctxPath}/static/templates/数据采集模板.csv" >下载模板</a>）
							</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label no-padding-right">导入文件</label>
					<div class="col-sm-8">
						<div id="i_select_files" style="width:610px;"></div>
						<div id="i_stream_files_queue" >
						</div>
					</div>
				<div class="col-xs-2 col-sm-2 fileSuccess"></div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" > </label>
					<div class="col-sm-9 col-xs-8">
						<span class="creatTaskBtn">提交</span>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="hangyeBottomCeng"></div>
<input type="hidden" id="filePath" value="${path}">
<input type="hidden" id="file_server_ip" value="${fileHttpReciever}">
<input type="hidden" id="xlsjdrId" value="">
<input type="hidden" id="taskNumber" value="">
<input type="hidden" id="finalFilePath" value="">
<script src="${ctxPath}/static/source/js/timeReversal.js"></script>
<script src="${ctxPath}/static/source/js/dragWindow.js"></script>
<script src="${ctxPath}/static/ace/js/jquery.bootstrap-duallistbox.js"></script>
<script src="${ctxPath}/static/source/js/stream-v1.js"></script>
<script>
var dataSourceArray = [];
var dataBaseArray = [];
//上传文件
var uploadData = {
				dataSourceName:"",
				dataSourceDec:"",
				importType:"",
				fileType:""
		};
var submitData = {
		dataSourceName:"",
		dataSourceDec:"",
		importType:"",
		fileType:"",
		fileName:"",
		filePath:"",
		fileSize:"",
};
var fileUploadLock = true;
var formSubmitLock = true;
$(".creatTaskBtn").click(function(){
	if(fileUploadLock==false||formSubmitLock==false){
		Showbo.Msg.alert('信息正在提交中，请稍后再试');
		return;
	}
	uploadData.dataSourceName = $("#dataSourceName").val();//当数据源选择为新增时，数据源名称
	uploadData.dataSourceDec = $("#dataSourceDec").val();//当数据源选择为新增时，数据源描述
	uploadData.importType = $("input[name=importType]:checked").val();
	uploadData.fileType = $("input[name=fileType]:checked").val();
	var CdataSourceName = checkInputNull(document.getElementById("dataSourceName"));
	if(CdataSourceName){
		submitData.dataSourceName = uploadData.dataSourceName;
		submitData.dataSourceDec = uploadData.dataSourceDec;
		submitData.importType = uploadData.importType;
		submitData.fileType = uploadData.fileType;
	}else{
		Showbo.Msg.alert("您有未完善的信息，请返回查看");
		return;
	}
	fileUploadLock = false;
	formSubmitLock = false;
	$(".creatTaskBtn").html("<span class='fa fa-spinner fa-spin bigger-150'></span>");
	_t.upload();
});
$("input[name=fileType]:checked").parent().next().show();
$("input[name=importType]").click(function(){
	if(this.value==0){
		$("input[name=fileType]:checked").parent().next().show();
	}else{
		$(".downloadDemo").hide();
	}
});
var checkFileType=[".xls",".xlsx"];
var fileTypeGroups = [[".xls",".xlsx"],[".csv"]];

$("input[name=fileType]").click(function(){
	checkFileType =fileTypeGroups[parseInt($(this).val())];
	 _t.destroy();_t=null;_t=new Stream(initFile());
	 $(".downloadDemo").hide();
	 if($("input[name=importType]:checked").val()==0){
		 $(this).parent().next().show();
	 }
});

function submitFormData(file){
	submitData.fileName = file.fileName;
	submitData.filePath = file.filePath;
	submitData.fileSize = file.fileSize;
	$.ajax({
		url:"${ctxPath}/v1/html/data/dataCollect/peopleImport/saveArt.do",
		dataType:"json",
		type:"post",
		data:submitData,
		success:function(data){
			formSubmitLock = true;
			$(".creatTaskBtn").html("提交");
			if(data.result=="ok"){
				$("#xlsjdrId").val(data.values);
				$("#taskNumber").val(data.taskNumber);
				if(fileUploadLock&&formSubmitLock){
					//当文件和表单都提交完成以后执行更新操作
					var xlsjdrId = $("#xlsjdrId").val();
					var taskNumber = $("#taskNumber").val();
					var filePath = $("#finalFilePath").val();
					$.ajax({
						url:"${ctxPath}/v1/html/data/dataCollect/peopleImport/updateArt.do",
						dataType:"json",
						data:{
							xlsjdrId:xlsjdrId,
							taskNumber:taskNumber,
							filePath:filePath
							},
						success:function(data){
							if(data.result=="ok"){
								$("#subBtn").html("上传");
								Showbo.Msg.alert("信息提交成功",function(){
									if ($(".btnfocus").val() == "确定") {
										window.location.reload();
									}
								});
							}else{
								Showbo.Msg.alert(data.errormsg);
							}
						},
						error:function(){
							Showbo.Msg.alert("服务器异常");
						}
					});
				}
			}else{
				Showbo.Msg.alert(data.errormsg);
			}
		},
		error:function(){
			Showbo.Msg.alert("服务器异常");
			formSubmitLock = true;
			$(".creatTaskBtn").html("提交");
		}
	});
}

//信息校验
function checkInputNull(el){
	if(el.value==""){
		el.style.border="1px solid red";
		return false;
	}else{
		el.style.border="1px solid #ccc";
		return true;
	}
}
//文件上传
var fileLock = true;
	var FileServerIp = $("#file_server_ip").val();
function initFile(){
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
				path1: $("#filePath").val(),
//				param2: "val2"
			},
//			swfURL : "/swf/FlashUploader.swf", /** SWF文件的位置 */
			tokenURL :FileServerIp+ "/tk", /** 根据文件名、大小等信息获取Token的URI（用于生成断点续传、跨域的令牌） */
//			frmUploadURL : "/fd;", /** Flash上传的URI */
//			 uploadURL : "/upload", /** HTML5上传的URI */
			simLimit: 1, /** 单次最大上传文件个数 */
			extFilters:checkFileType, /** 允许的文件扩展名, 默认: [] */
			onSelect: function(list) {
				//fileUploadFlag = true;
			}, /** 选择文件后的响应事件 */
			onMaxSizeExceed: function(size, limited, name) {
				fileUploadLock = true;
				$(".creatTaskBtn").html("提交");
				Showbo.Msg.alert("文件过大，请重新选择文件");
				
			}, /** 文件大小超出的响应事件 */
			onFileCountExceed: function(selected, limit) {
				fileUploadLock = true;
				$(".creatTaskBtn").html("提交");
				Showbo.Msg.alert("目前仅允许上传一个文件");
				
			}, /** 文件数量超出的响应事件 */
			onExtNameMismatch: function(name, filters) {
				Showbo.Msg.alert("上传文件不匹配，点击确定按钮重新上传");
				fileUploadLock = true;
				$(".creatTaskBtn").html("提交");
			}, /** 文件的扩展名不匹配的响应事件 */
			onCancel : function(file) {
				fileUploadLock = true;
				$(".creatTaskBtn").html("提交");
				Showbo.Msg.alert("文件上传已取消",function(){
					if ($(".btnfocus").val() == "确定"&&formLock) {
						//window.location.href="${ctxPath}/v1/html/dataManager/dataUniverse/taskList.do";
					}
				});
				
			}, /** 取消上传文件的响应事件 */
			onComplete: function(file) {
				fileUploadLock=true
				if(formSubmitLock&&fileUploadLock){
					var xlsjdrId = $("#xlsjdrId").val();
					var taskNumber = $("#taskNumber").val();
					var filePath = $("#finalFilePath").val();
					$.ajax({
						url:"${ctxPath}/v1/html/data/dataCollect/peopleImport/updateArt.do",
						dataType:"json",
						data:{
							xlsjdrId:xlsjdrId,
							taskNumber:taskNumber,
							filePath:filePath
							},
						success:function(data){
							if(data.result=="ok"){
								Showbo.Msg.alert("信息提交成功",function(){
									if ($(".btnfocus").val() == "确定") {
										window.location.reload();
										//window.location.href="${ctxPath}/v1/html/dataManager/dataUniverse/taskList.do";
									}
								});
							}else{
								Showbo.Msg.alert(data.errormsg);
							}
						},
						error:function(){
							Showbo.Msg.alert("服务器异常");
						}
					});
				}	
				
			}, /** 单个文件上传完毕的响应事件 */
//			onQueueComplete: function() {alert('onQueueComplete')}, /** 所以文件上传完毕的响应事件 */
//			onUploadError: function(status, msg) {alert('onUploadError')} /** 文件上传出错的响应事件 */
//			onDestroy: function() {alert('onDestroy')} /** 文件上传出错的响应事件 */
			onCompleteTk:function(fileInfo){
				$("#finalFilePath").val(fileInfo.filePath);
				submitFormData(fileInfo);
			}
		};
	return config;
}
	
		var _t = new Stream(initFile());
</script>
</body>

</html>