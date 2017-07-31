<%@page import="com.alibaba.fastjson.JSON"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
<%-- <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/flatui/css/flat-ui.css" type="text/css"> --%>
		<div style="min-width: 200px;">
			<div id="loadImg3" style="text-align: left;">
				<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
			</div>
			<ul id="treeDemo3" style="display: none;" class="ztree"></ul>
	  	</div>
<input id="compIdHidden" value="${param.compId}" type="hidden"/>
<input id="pathValue" value="${param.pathValue}" type="hidden"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/js/lang/grid.zh-CN.min.js"></script> --%>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.js"></script> --%>
<style type="text/css">
	.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
	.ztree li span.button.icon00_ico_open, .ztree li span.button.icon00_ico_close{margin-right:2px; title:清理规则; background: url(/resources/images/clearRule.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
</style>
<SCRIPT type="text/javascript">
$(function(){
// 	console.log("pathValue = " + $("#pathValue").val());
	var setting = {
		check: {
			enable: false,
			dblClickExpand: true
		},callback: {
// 			onMouseDown: onMouseDown,
			onClick:onClick,
			beforeEditName: beforeEditName,
			beforeRemove: beforeRemove,
			beforeRename: beforeRename,
			onRemove: onRemove,
			onRename: onRename
		},async:{
			enable:true,
			url:"<%=request.getContextPath() %>/config/hdfs?method=getMenus",
			type: "get",
			autoParam:["hdfsPath","shared","rootPath"]
			//otherParam: { "initShowPath":$("#pathValue").val()}
		},edit: {
			enable: true,
			showRemoveBtn: showRemoveBtn,
			showRenameBtn: showRenameBtn,
			editNameSelectAll: true
		},view: {
			addHoverDom: addHoverDom,
			removeHoverDom: removeHoverDom,
			selectedMulti: false
		},data: {
			keep: {
				parent: true,
				leaf: true
			}
		}
	};
	
	var newCount = 1;
	function addHoverDom(treeId, treeNode) {
		//console.log("addHoverDom...");
		//console.log(treeNode);
		if(!treeNode["pId"]){
			return;
		}
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
			+ "' title='add node' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			var zTree = $.fn.zTree.getZTreeObj("treeDemo3");
// 			console.log("treeNode:");
// 			console.log(treeNode["hdfsPath"]);
			var _name = "New Folder";// + (newCount++);
			var _newNode = {id:(100 + newCount), pId:treeNode.id, name:_name,hdfsPath:treeNode["hdfsPath"],isParent:true};
// 			console.log(_newNode);
			
			$.ajax({
				url:"<%=request.getContextPath() %>/config/hdfs?method=mkdir",
				data:_newNode,
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
// 					console.log("data="+data);
					if(data && data!=''){
						_newNode["name"] = data;
						_newNode["hdfsPath"] = treeNode["hdfsPath"] + "/" + data;
// 						console.log("新增目录成功！");
						//zTree.addNodes(treeNode,_newNode);
						
						if(treeNode.open){
							zTree.addNodes(treeNode,_newNode);
						}else{
							zTree.reAsyncChildNodes(treeNode,"refresh");
						}
						
					}else{
// 						console.log("新增目录失败！");
					}
				},
				error:function(){
// 					console.log("新增目录出错！");	
				}
			});
			return false;
		});
	};
	
	function beforeEditName(treeId, treeNode) {
// 		console.log("beforeEditName...");
// 		className = (className === "dark" ? "":"dark");
// 		console.log("[ "+getTime()+" beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
		var zTree = $.fn.zTree.getZTreeObj("treeDemo3");
		zTree.selectNode(treeNode);
// 		return confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？");
	}
	
	var beforeDelete_name;
	function beforeRemove(treeId, treeNode) {
		
// 		console.log("beforeRemove...");
// 		className = (className === "dark" ? "":"dark");
// 		console.log("[ "+getTime()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
		var zTree = $.fn.zTree.getZTreeObj("treeDemo3");
		zTree.selectNode(treeNode);
		beforeDelete_name=treeNode.name;
		return confirm("确认删除 节点 -- " + treeNode.name+ " 吗？");
		
	}
	
	function onRemove(e, treeId, treeNode) {
// 		console.log("onRemove...");
// 		console.log("[ "+getTime()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
		var parentPath = treeNode["hdfsPath"];
		var path = parentPath.substring(0,parentPath.indexOf(beforeDelete_name));
		var deleteData = {};
		deleteData["path"]= path + beforeDelete_name;
// 		console.info("------+"+path+"+------"+beforeDelete_name);
		//console.info(deleteData);
		$.ajax({
			url:"<%=request.getContextPath() %>/config/hdfs?method=delete",	
			data:deleteData,
			type:'post',
			dataType:"text",
			success:function(data,testStatus){
// 				console.log("data="+data);
				if(data && data == "0"){
// 					console.log("delete成功！");
				}else{
// 					console.log("delete失败！");
				}
			},
			error:function(){
// 				console.log("删除出错");
			}
		});
	}
	
	var beforeRename_name;
	function beforeRename(treeId, treeNode, newName, isCancel) {
// 		console.log("newName="+newName);
// 		className = (className === "dark" ? "":"dark");
// 		console.log((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" beforeRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
		if (newName.length == 0) {
			alert("节点名称不能为空.");
			var zTree = $.fn.zTree.getZTreeObj("treeDemo3");
// 			setTimeout(function(){zTree.editName(treeNode)}, 10);
			return false;
		}
		beforeRename_name = treeNode.name;
		return true;
	}
	function onRename(e, treeId, treeNode, isCancel) {
// 		console.log((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
		var editingNode = treeNode;
		var nowName = treeNode.name;
		var parentPath = treeNode["hdfsPath"];
		console.log("beforeRename_name = " + beforeRename_name+",nowName = " + nowName + ",parentPath = " + parentPath);
		var path = parentPath.substring(0,parentPath.indexOf(beforeRename_name));
		console.log("path = " + path);
		var renameData = {};
		renameData["oldPath"] = path + beforeRename_name;
		renameData["newPath"] = path + nowName;
		console.log(renameData);
		$.ajax({
			url:"<%=request.getContextPath() %>/config/hdfs?method=rename",
			data:renameData,
			type:"post",
			dataType:"text",
			success:function(data, textStatus){
				console.log("data="+data);
				if(data && data == "0"){ 
					if (editingNode) {
						console.log(editingNode);
						editingNode["name"] = nowName;
						editingNode["hdfsPath"] = renameData["newPath"];
						console.log(editingNode);
						console.log("rename成功！");
					}
				}else{
					console.log("rename失败！");
				}
			},
			error:function(){
				console.log("重命名出错！");	
			}
		});
		
	}
	
	function getTime() {
		var now= new Date(),
		h=now.getHours(),
		m=now.getMinutes(),
		s=now.getSeconds(),
		ms=now.getMilliseconds();
		return (h+":"+m+":"+s+ " " +ms);
	}
	function showLog(str) {
		if (!log) log = $("#log");
		log.append("<li class='"+className+"'>"+str+"</li>");
		if(log.children("li").length > 8) {
			log.get(0).removeChild(log.children("li")[0]);
		}
	}
	
	function showRenameBtn(treeId, treeNode) {
		if(!treeNode["pId"]){
			return;
		}
		return !(treeNode["level"] == "0");
	}
	function showRemoveBtn(treeId, treeNode) {
		if(!treeNode["pId"]){
			return;
		}
		return !(treeNode["level"] == "0");
	}
	function removeHoverDom(treeId, treeNode) {
// 		console.log("removeHoverDom...");
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
	
	//加载资源菜单树
	function loadMenusTree(roleId){
// 		console.log("loadmenu..");
		$("#loadImg3").hide();
		$("#treeDemo3").show();
		$.fn.zTree.init($("#treeDemo3"), setting);

		var zTree = $.fn.zTree.getZTreeObj("treeDemo3");
		zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");
		
		if(false){		
			$.ajax({
				url:"<%=request.getContextPath() %>/config/hdfs?method=getMenus",
				type:"post",
				dataType:"JSON",
				success:function(data, textStatus){
					$.fn.zTree.init($("#treeDemo3"), setting, data);
					$("#loadImg3").hide();
					$("#treeDemo3").show();
				},
				error:function(){
					console.log("加载数据出错！");
				}
			});
		}
	}
	
	loadMenusTree();
	
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	
	
	
	function onClick(e,treeId, treeNode) {
// 	function onMouseDown(event, treeId, treeNode){
// 		
		var ss = $("#compIdHidden").val();//"compId";
		console.log("ss="+ss);
// 		var pId = treeNode["pId"];
		console.log("onClick.treeNode:");
		console.log(treeNode);
		var hdfsPath = "";
		if(treeNode["pId"]=="0"){
			//hdfspath = treeNode["name"];
		}else{
			//hdfspath = treeNode["pId"] + "/" + treeNode["name"];
		}
		hdfsPath = treeNode.hdfsPath;//["id"]+"";
		console.log("hdfsPath="+hdfsPath);
		parent.$('#'+ss).val(hdfsPath);
		parent.$('#'+ss).blur();
		if (typeof(parent.setPath) == 'function') {
			console.log("here...");
			parent.setPath(hdfsPath,ss);
		}
// 	    parent.layer.tips('Look here', '#parentIframe', {time: 5000});
	    parent.layer.close(index);
	    //ajaxRequest("<%=request.getContextPath() %>/config/hdfs?method=hdfsList&hdfsPath="+treeNode["hdfsPath"],"hdfsList");
	}
	
	function ajaxRequest(_url,tableID){
		$.ajax({
			url:_url,
			type:"post",
			dataType:"json",
			async:true,
			success:function(data, textStatus){
// 				console.log("=========ajax.data===========");
// 				console.log(data);
				if(!data || data==''){
// 					console.log("data is null!!!!!!!!!!!!!!!!!!!!!!");
					return;
				}
				showTable0(data,tableID);
			},
			error:function(){
// 				console.log("加载数据出错！");
			}
		});
	}
	
	function showTable0(localData,tableID){
// 		console.log("showTable0...");
		$("#" + tableID + "_pt_outTab").remove();
		var gridObj = $.fn.bsgrid.init(tableID, {
            pageSizeSelect: false,
            pageAll:true,
            displayBlankRows: false, // single grid setting
            displayPagingToolbarOnlyMultiPages: true, // single grid setting
            localData: localData,
            processUserdata: function (userdata, options) {
                $("#" + tableID + ' tr th').remove();
                var dynamic_columns = userdata['dynamic_columns'];
//                 console.log("dynamic_columns="+dynamic_columns);
                if(!dynamic_columns){return;}
                var cNum = dynamic_columns.length;
//                 console.log("cNum="+cNum);
                for (var i = 0; i < cNum; i++) {
                    $("#"+tableID+' tr').append('<th w_index="' + dynamic_columns[i] + '">' + dynamic_columns[i] + '</th>');
                }
            }
        });
	}
	
});
</SCRIPT>