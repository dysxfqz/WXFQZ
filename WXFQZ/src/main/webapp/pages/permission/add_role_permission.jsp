<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>添加权限</title>

<script type="text/javascript">
function submit() {
	var roleId=$("#roleId").val();
	var querycheck = "";
	$("input:checkbox[name='module_id']:checked").each(function(){
					if(querycheck == ""){
						querycheck += $(this).val();
					} else {
						querycheck += ","+$(this).val();
					}
			});
	//锁屏图片显示
	$(".loading_chuan").show();
	jQuery.post('${ctxPath}/v1/html/manage/roleManage/create/createRolePermission.do', {roleId:roleId,mids:querycheck}, function(
			data) {
		//锁屏图片隐藏
		$(".loading_chuan").hide();
		if (data.result == 'ok') {
			Showbo.Msg.alert(("保存成功"),function(){
			     if($(".btnfocus").val() =="确定"){
			    	 window.location="${ctxPath}/v1/html/manage/roleManage/query/roleList.do";
					       } 
					});
		} else {
			Showbo.Msg.alert(data.errormsg);
		}
	});
}

function ChildrenCheck(yesCode, noCode, el) {
	//判断权限是否已选中，若选中时
	if (!$(el).is(":checked")) {
		//拆分noCode并存入数组noStr
		var noStr = noCode.split("-");
		for (var i = 0; i < noStr.length; i++) {
			//将checked属性设置为false，即未被勾选
			$("input[code='"+noStr[i]+"']").attr("checked", false);
			$("input[code='"+noStr[i]+"']").prop("checked", false);
		}
	} else {
		//拆分yesCode并存入数组yesStr
		var yesStr = yesCode.split("-");
		for (var i = 0; i < yesStr.length; i++) {
			//将checked属性设置为true，即已经被勾选
			$("input[code='"+yesStr[i]+"']").attr("checked", true);
			$("input[code='"+yesStr[i]+"']").prop("checked", true);
		}
	}
}

</script>
<style>
	.table_model{
/* 		border: 1px solid #ddd; */
	    padding-left: 0 !important;
	    padding-right: 0 !important;
	}
	.fun_title{
	    color: #707070;
	    font-weight: normal;
	    background: #F2F2F2;
	    background-image: -webkit-linear-gradient(top, #f8f8f8 0%, #ececec 100%);
	    background-image: -o-linear-gradient(top, #f8f8f8 0%, #ececec 100%);
	    background-image: linear-gradient(to bottom, #f8f8f8 0%, #ececec 100%);
	    background-repeat: repeat-x;
	    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fff8f8f8', endColorstr='#ffececec', GradientType=0);
		line-height:30px;
		text-align:center;
		font-weight:bold;
	}
	.funItem{
		padding-left:0 !important;
		padding-right: 0 !important;
	}
	.ItemChild{
/* 		border-left: 1px solid #ddd; */
		padding-left:0 !important;
		padding-right: 0 !important;
	}
	.childItem{
/* 		border-right: 1px solid #ddd; */
    	padding: 0 !important;
    	width:210px;
    	float:left;
/*    		border-bottom: 1px solid #ddd; */
	}
	.lastChil{border-right:none;}
	input[type=checkbox].ace + .lbl::before{
		margin-right:10px !important;
	}
	.ItemTitle{width:250px;float:left;text-align:center;}
	.oddo{
		background:#EFEFEF;
	}
</style>
</head>
<body>
	<h1></h1>
	<input type="hidden" value="${roleId }" id="roleId">
	<div class="col-xs-12" style="margin-top:20px;">
<div class="table-header">给 ${roleName} 添加权限</div>
	<div class="col-xs-12 table_model">
		<div class="funItem fun_title col-xs-12">
			<div class="ItemTitle" >
				<span>功能模块</span>
			</div>
			<div class="ItemChild col-xs-9 fun_title">
				<span>描述</span>
			</div>
		</div>
		<c:forEach items="${menuList }" var="bean" varStatus="step">
		<c:if test="${bean.moduleList!=null}">
		<div class="funItem col-xs-12 <c:if test="${(step.index mod 2) != 0}">oddo</c:if>">
			<div class="ItemTitle">
				<div class="checkbox">
					<label>
						<!-- <input name="ids" class="ace ace-checkbox-1 speedcheck"  type="checkbox" /> -->
						<span class="lbl">${bean.name }</span>
					</label>
				</div>
			</div>
			<div class="ItemChild col-xs-9">
			<c:forEach items="${bean.moduleList }" var="pean">
				<div class="childItem">
					<div class="checkbox">
					<label>
						<input  name="module_id" code="${pean.code }" yesCode="${pean.yesCode }" noCode="${pean.noCode }"
							class="ace ace-checkbox-1 speedcheck" onchange="ChildrenCheck('${pean.yesCode }', '${pean.noCode }', this)"
							value="${pean.id }" type="checkbox" <c:if test="${pean.status=='1' }">checked=true</c:if> />
						<span class="lbl">${pean.description }</span>
					</label>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
		</c:if>
		</c:forEach>
	</div>
	
	<input type="button" style="margin:20px;width:115px;" class="btn btn-info" value="Submit" onclick="submit()">
	</div>
	<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
	<script>
</script>
</body>

</html>
