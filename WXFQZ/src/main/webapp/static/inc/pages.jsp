<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="taglib.jsp"%>
<script src="${ctxPath}/static/source/js/jquery.pagination.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPath}/static/source/css/page.css">
<script type="text/javascript">
var pageIndex =0;
var pageCount = 0;
var pageSize=1;
var url;
var hrefUrl=window.location.href;
if(hrefUrl.indexOf("?")>-1){
	url=hrefUrl.substring(0,hrefUrl.indexOf("?"));
	url=url+"?";
}else{
	url=hrefUrl+"?";
}
function aa(){
var param=$("#param").val();
if(param!=""&&param!=undefined){
	url=url+param;
}
}
var initPagination = function() {
	pageIndex=$("#pageIndex").val();
	pageIndex=parseInt(pageIndex)-1;
	pageSize=$("#pageSize").val();
	pageCount=$("#pageCount").val();
    // 创建分页
    $("#pagination").pagination(pageCount,{
    	callback : PageCallback, // PageCallback() 为翻页调用次函数。
		prev_text : "&laquo;",
		next_text : "&raquo;",
		items_per_page : pageSize,
		num_edge_entries :3, // 两侧首尾分页条目数
		num_display_entries : 3, // 连续分页主体部分分页条目数
		current_page : pageIndex, // 当前页索引
    });
};
//翻页调用
function PageCallback(index, jq) {
	pageIndex=parseInt(index)+1;
	pageSize=$("#pageSize").val();
	window.location.href = url+"&pageSize="+pageSize+"&pageIndex="+pageIndex;
}

function gotoPage(){
	pageIndex=$("#pageIndexs").val();
	pageSize=$("#pageSize").val();
	//alert(pageIndex);
	if(parseInt(pageIndex) != pageIndex){
		MessageBox.alert("Please input the number above!");
		return;
	}
	var total =pageCount;
	if(pageIndex > total){
		pageIndex = total;
	}
	window.location = url+"&pageSize="+pageSize+"&pageIndex="+pageIndex;
};


function selChange(obj){ 
	pageSize = $("#selects").val();
	window.location.href=url+"&pageSize="+pageSize;
}
$(function(){
	initPagination();
	aa();
});
</script>
<div class="pages_line">
	<div>
	<input type="hidden" id="pageSize" value="${page.pageSize }"/>
	<input type="hidden" id="pageCount" value="${page.totalRecordCount }"/>
	<input type="hidden" id="pageIndex" value="${page.pageIndex }"/>
	<input type="hidden" id="param" value="${page.param }"/>
	<span class="col-xs-6 col-sm-3 pages_size">
	Display Per Page <select name="selectPage" id="selects"
		onchange="javascript:selChange(this);">
		<option
			<c:if test="${page.pageSize == 5}"> selected="selected" </c:if>>5</option>
		<option
			<c:if test="${page.pageSize == 10}"> selected="selected" </c:if>>10</option>
		<option
			<c:if test="${page.pageSize == 15}"> selected="selected" </c:if>>15</option>
		<option
			<c:if test="${page.pageSize == 20}"> selected="selected" </c:if>>20</option>
		<option
			<c:if test="${page.pageSize == 25}"> selected="selected" </c:if>>25</option>
			
	</select>
	</span>
	<span class="col-xs-6 col-sm-3 pages_size"> ${page.totalRecordCount } rope</span>
	<span class="col-xs-6 col-sm-3 pages_size"> total ${page.pageCount} page</span>
	<sapn class="col-xs-6 col-sm-3 pages_size">
	 <div class="col-lg-6">
            <div class="input-group">
               <input name="text2" type="text" id="pageIndexs" value="${page.pageIndex }" class="form-control"     style="width: 70px;">
               <span class="input-group-btn">
                  <button class="btn btn-default" id="change_pageIndex_btn" onclick="javascript:gotoPage();" type="button">
                     Go
                  </button>
               </span>
            </div><!-- /input-group -->
         </div><!-- /.col-lg-6 -->
		
		</sapn>
	</div>

</div>
<div style="clear:both"></div>
<div id="pagination" class="paginations">

</div>
