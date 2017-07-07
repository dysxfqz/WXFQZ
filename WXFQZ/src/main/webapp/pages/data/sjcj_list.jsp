<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>数据采集</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<style>
#menuList th{min-width:104px;}
</style>
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>数据采集</h1>
		</div>
		<div style="padding-left: 20px;margin-top: 20px;">
		<a href="#" class=" btn btn-app btn-success newTaxBtn" style="margin-bottom:10px;">新建采集</a>
			<span class="conditonList">
				<span class="conditonTitle">金税三期<span class="fa fa-angle-down down-arrow"></span></span>
				<ul>
					<li>
						<label>
						<input class="ace ace-checkbox-1"  type="checkbox"  />
						<span class="lbl">发票信息库</span>
					</label>
					<li>
						<label>
						<input class="ace ace-checkbox-1"  type="checkbox"  />
						<span class="lbl">自然人涉税信息库</span>
					</label>
					<li>
						<label>
						<input class="ace ace-checkbox-1" type="checkbox"  />
						<span class="lbl">法人涉税信息库</span>
					</label>
					<li>
						<label>
						<input class="ace ace-checkbox-1" type="checkbox"  />
						<span class="lbl">税收风险管理信息库</span>
					</label>
					<li>
						<label>
							<input class="ace ace-checkbox-1"  type="checkbox"  />
							<span class="lbl">外部信息库</span>
						</label>
					<li>
						<label>
							<input class="ace ace-checkbox-1" type="checkbox"  />
							<span class="lbl">政策法规信息库</span>
						</label>
					</li>
					<li>
						<label>
							<input class="ace ace-checkbox-1" type="checkbox"  />
							<span class="lbl">机构人员信息库</span>
						</label>
					</li>
				</ul>
			</span>
			<span class="conditonList">
				<span class="conditonTitle">第三方数据<span class="fa fa-angle-down down-arrow"></span></span>
				<ul>
					<li>
						<label>
						<input class="ace ace-checkbox-1"  type="checkbox"  />
						<span class="lbl">政府机关信息库</span>
					</label>
					<li>
						<label>
						<input class="ace ace-checkbox-1"  type="checkbox"  />
						<span class="lbl">银行系统信息库</span>
					</label>
					<li>
						<label>
						<input class="ace ace-checkbox-1" type="checkbox"  />
						<span class="lbl">企业机构信息库</span>
					</label>
				</ul>
			</span>
			<span class="conditonList">
				<span class="conditonTitle">互联网数据<span class="fa fa-angle-down down-arrow"></span></span>
				<ul>
					<li>
						<label>
						<input class="ace ace-checkbox-1"  type="checkbox"  />
						<span class="lbl">新闻网信息库</span>
					</label>
					<li>
						<label>
						<input class="ace ace-checkbox-1"  type="checkbox"  />
						<span class="lbl">招标网信息库</span>
					</label>
					<li>
						<label>
						<input class="ace ace-checkbox-1" type="checkbox"  />
						<span class="lbl">网店信息库</span>
					</label>
					<li>
						<label>
						<input class="ace ace-checkbox-1" type="checkbox"  />
						<span class="lbl">媒体交流信息库</span>
					</label>
				</ul>
			</span>
			<span class="goSearch">查询</span>
		</div>
		<hr>
		<div style="width:100%;overflow-x:auto;">
		<div class="meuListDiv">
		<table id="menuList" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>No.</th>
					<th>数据库类型</th>
					<th>数据库地址</th>
					<th>端口号</th>
					<th>数据库名称</th>
					<th>用户名</th>
					<th>密码</th>
					<th>状态 </th>
					<th>创建人</th>
					<th>创建时间</th>
					<th>更新时间</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${sjcjList}" var="bean" varStatus='status'>
					<tr>
						<td class="center">${status.index +1 }</td>
						<td><c:if test="${bean.sjklx == 0}">mysql</c:if><c:if test="${bean.sjklx == 1}">oracle</c:if></td>
						<td>${bean.sjkdz}</td>
						<td>${bean.dkh}</td>
						<td>${bean.sjkmc}</td>
						<td>${bean.yhm}</td>
						<td>${bean.mm}</td>
						<td><c:if test="${bean.zt == 0}">正常</c:if><c:if test="${bean.zt == 1}">删除</c:if></td>
						<td>${bean.creater}</td>
						<td><fmt:formatDate value="${bean.cjsj }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td><fmt:formatDate value="${bean.gxsj }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
	</div>
	<script type="text/javascript">
	$(function(){
		var oTable1 =$('#menuList').dataTable( {
				bStateSave: true,
				bAutoWidth: false,
				"aaSorting": [],
				"aoColumnDefs": [
					{
					 sDefaultContent: '',
					 aTargets: [ '_all' ]
					  }
					],
		    } );
			$(".meuListDiv").css("width",$("#menuList").width());
	});
	$(".conditonTitle").click(function(){
		$(this).parent().find("ul"). slideToggle();
	});
	</script>
</body>
</html>