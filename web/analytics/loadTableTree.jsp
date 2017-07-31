<!-- 加载表的菜单  -->
<%@ page contentType="text/html; charset=UTF-8"%>
<SCRIPT type="text/javascript">
$(function(){
	var setting = {
			check: {
				enable: false,
				dblClickExpand: false
			},callback: {
				//onClick: onClick,
				onMouseDown: onMouseDown2
			},edit: {
				enable: false
			}
	};

	function loadDsMenusTree(){
		var id = <%=request.getParameter("id")%>;
		//if(!id || id==""){$("#loadImg2").hide();return;}
		$("#loadImg2 span").text("加载中...");
		$("#loadImg2 img").show();

		$.ajax({
				url:"<%=request.getContextPath() %>/analytics?method=dsMenus&id=<%=request.getParameter("id")%>&linktype=Hbase"+"&dsKeyword="+$("#dsKeywordInput").val(),
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
// 					console.info(data);
					if(data=='error'){
						console.log("data="+data);
						$("#loadImg2 span").text("加载数据失败！");
						$("#loadImg2 img").hide();
						return;
					}
					var zNodes = eval('('+data+')');
					
					$.fn.zTree.init($("#treeDemo2"), setting, zNodes);
					$("#loadImg2").hide();
					$("#treeDemo2").show();
					
					if(false){
						//$("#treeDemo2_1_ul").find("input[class='button ico_docu']").remove();
						$("#treeDemo2_1_ul .ico_docu").remove();
						$("#treeDemo2_1_ul li a span").addClass("tree_add_css");
						
						$("#treeDemo2_1_switch").remove();
						$("#treeDemo2_1_check").remove();
						$("#treeDemo2_1_a").remove();
					}
					
// 					$("span").remove(".ico_docu");
				},
				error:function(){
					console.log("加载数据出错！");
					$("#loadImg2 span").text("加载数据失败！");
					$("#loadImg2 img").hide();
				}
		});
	}
	
	loadDsMenusTree();
	$("#dsSearchKeySpan").click(function(){
		$("#loadImg2").show();
		$("#treeDemo2").hide();
		loadDsMenusTree();
	});
	
	$("#profile-tab").click(function(){
		console.log("点击profile-tab!!!");
		$("#loadImg2").show();
		$("#treeDemo2").hide();
		loadDsMenusTree();
	});

	function onMouseDown2(event, treeId, treeNode) {
		console.log("treeNode");
		console.log(treeNode);
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		zTree.expandNode(treeNode);
		$("#dsKeywordInput").val(treeNode.name);	

		if(treeNode["shared"]){
			console.log("disabled...");
			$("button[name='common_share_buttonOne']").attr("disabled","disabled");	
		}else{
			console.log("not disabled...");
			$("button[name='common_share_buttonOne']").removeAttr("disabled");
		}
	}
	
});
</SCRIPT>
