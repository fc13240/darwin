<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.db.bean.UdcInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="com.stonesun.realTime.services.db.UdcServices"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/resources/common.jsp"%>
<div style="min-width:200px;">
	<div id="loadImg3" style="text-align: left;">
		<%
			String udcId = request.getParameter("id");
			//out.println(udcId);
			UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
			List<UdcInfo> udcList = UdcServices.selectUdcHistoryList(udcId);
			request.setAttribute("udcList", udcList);
			request.setAttribute("newestUdc", UdcServices.selectById0(udcId,user1.getId()));
		%>
	</div>
	<table class="table" style="width:600px;">
		<thead>
			<tr>
				<th>
					版本
				</th>
				<th>
					说明
				</th>
				<th>
					选择
				</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					最新版本：${newestUdc.version}
				</td>
				<td>
					${newestUdc.remark}
				</td>
				<td>
					<input type="radio" name="historyversion" value="${newestUdc.version}"/>
				</td>
			</tr>
			<c:forEach var="udc" items="${udcList}">
				<tr>
					<td>
						${udc.version}
					</td>
					<td>
						${udc.remark}
					</td>
					<td>
						<input type="radio" name="historyversion" value="${udc.version}"/>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>	
<SCRIPT type="text/javascript">
$(function(){
	$('input[name="historyversion"]').click(function(){
		window.parent.changeUdcVersion($(this).val());
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	});
});
</SCRIPT>