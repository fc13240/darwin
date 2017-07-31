<%@ page contentType="text/html; charset=UTF-8"%>
<c:if test="${pager.pagerSize != 0}">
<div class="text-left">
	<div class="pagination">
		<ul style="background:#F9FAFB;">
			<pg:pager url="${pager.pagerUrl}" items="${pager.total}"
				export="currentPageNumber=pageNumber"
				maxPageItems="${pager.pageSize}" maxIndexPages="4" isOffset="true">
				
				<c:forEach items="${pager.params}" var="p">
					<pg:param name="${p.key}" value="${p.value}"/>
				</c:forEach>
	
				<pg:first>
					<li style=""><a href="${pageUrl}">首页</a></li>
				</pg:first>
				<pg:prev>
<%-- 					<li style="border-left:1px solid #CCC;"><a href="${pageUrl}">上一页</a></li> --%>
					<li><a href="${pageUrl}">上一页</a></li>
				</pg:prev>
				<pg:pages>
					<c:choose>
						<c:when test="${currentPageNumber==pageNumber}">
							<li class="active"><a href="#">${pageNumber}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${pageUrl}">${pageNumber}</a></li>
						</c:otherwise>
					</c:choose>
				</pg:pages>
				<pg:next>
					<li><a href="${pageUrl}">下一页</a></li>
				</pg:next>
				<pg:last>
					<li><a href="${pageUrl}">尾页</a></li>
				</pg:last>
			</pg:pager>
		</ul>
	</div>
</div>
</c:if>