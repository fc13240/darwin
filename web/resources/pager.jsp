<%@ page contentType="text/html; charset=UTF-8"%>

<!-- 分页标签 -->
<%-- ${pager}<br> --%>
<%-- ${pager.total}<br> --%>
<%-- ${pager.pagerSize}<br> --%>
<%-- ${pager.offset}<br> --%>
	
<c:if test="${pager.pagerSize != 0}">
<div class="text-center">
	<div class="pagination">
		<ul>
			<pg:pager url="${pager.pagerUrl}" items="${pager.total}"
				export="currentPageNumber=pageNumber"
				maxPageItems="${pager.pageSize}" maxIndexPages="4" isOffset="true">
				
				<c:forEach items="${pager.params}" var="p">
					<pg:param name="${p.key}" value="${p.value}"/>
				</c:forEach>
	
				<pg:first>
					<li class="previous"><a href="${pageUrl}">首页</a></li>
				</pg:first>
				<pg:prev>
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
					<li class="next"><a href="${pageUrl}">尾页</a></li>
				</pg:last>
			</pg:pager>
		</ul>
	</div>
</div>
</c:if>