'use strict';

// Declare app level module which depends on filters, and services
angular.module('common_share.directives', []);
// angular.module('comp.services', []);
// angular.module('comp.filters', []);
angular.module('common_share.controllers', []);
angular.module('common_share', [
// 'comp.filters',
// 'comp.services',
'common_share.directives', 'common_share.controllers'
]);

angular.module('common_share.directives').directive('commonShare', function() {
	return {
		restrict : 'EA',
		templateUrl : '/resources/common_share.html',
		replace : true,
		controller : function($scope, $element, $compile, $http) {
			console.log("common_share.directives.init..");

			init();

			function init(){
				console.log("common_share.init...");
				var setting = {
					callback:{
						onMouseDown:onMouseDown
					}
				};

				var zNodes =[
					{ name:"组织机构", open:true,
						children: [
							{ name:"技术部",
								children: [
									{ name:"项目组01"},
									{ name:"项目组02"}
								]},
							{ name:"商务部", isParent:true}
						]}
				];

				$http({method:"GET",url:"/org?method=orgTree"})
				.success(function(data, status, headers, config){
					console.log("data:");
					console.log(data);
					zNodes = data;
					$.fn.zTree.init($("#treeDemo_share"), setting, zNodes);
					$.fn.zTree.getZTreeObj("treeDemo_share").expandAll(true);

					//set root selected
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo_share");
					var nodes = treeObj.getNodes();
					// console.log(nodes);
					// console.log(nodes[0]);
					if (nodes.length>0) {
						treeObj.selectNode(nodes[0]);
						onMouseDown(null,null,nodes[0]);
					}

				})
				.error(function(data, status, headers, config){
					alert("加载组织机构数据失败！");
				});

				//set default radio checked
				$scope.shareType = 'shareToOrg';
				
				//bind default event
				$scope.$watch("shareType",function(newValue,oldValue){
					console.log(newValue+","+oldValue);

					if(newValue=='shareToOrg'){
						$scope.checkedAll = true;
						$scope.disabledAll=true;
					}else{
						$scope.checkedAll = false;
						$scope.disabledAll=false;
					}
				});

				console.log("$scope.common_share_buttonOne_class="+$scope.shareConfig.common_share_buttonOne_class);
				
				
				//$("input[name='common_share_buttonOne']").removeAttr("class");
				//$("#common_share_buttonOne").removeAttr("class");
				$("button[name='common_share_buttonOne']").addClass($scope.shareConfig.common_share_buttonOne_class);//"btn btn-success");

			}

			$('#common_share_buttonOne').click(function(){
				console.log("common_share_buttonOne click ");
				$('#myModal').modal('hide');
				$('#myClearModal').modal('show');
			});
			
			function onMouseDown(e,treeId, treeNode){
				console.log("onMouseDown..");
				$scope.users = [];
				if(!treeNode["id"]){
					console.log("onMouseDown.exit.");
					return;
				}
				//$scope.createMark();
				$http({method:"GET",url:"/manage/user?method=getUserByOrgid",
					params:{"orgid":treeNode.id}})
				.success(function(data, status, headers, config){
//					console.log(data);
					/*var checked = undefined;
					if($scope.shareType=='shareToOrg'){
						checked = "checked";
					}
					console.log("checked="+checked);
					for(var i in data){
						if(checked){
							data[i]["checked"] = checked;
							data[i]["disabled"] = "disabled";
						}else{
							data[i]["checked"] = undefined;
							data[i]["disabled"] = undefined;
						}
					}*/
					$scope.users = data;
					//$.unblockUI();
				}).error(function(data, status, headers, config){
					console.log("data"+data+",status="+status+",headers="+headers+",config="+config);
					//$.unblockUI();
				});

				console.log("$scope.shareType="+$scope.shareType);
				// if($scope.shareType=='shareToOrg'){
					// $("input[name='shareUser']").each(function(i,v){
					// 	console.log("aaaa");
					// 	$(v).attr("checked","checked");
					// });
				// }

			}

		}
	}
});

angular.module("common_share.controllers").controller('shareController',
	function($scope, $location, $http, $element) {
		console.log("controllers.init...");

		$scope.initConfig = function(shareConfig){
			$scope.shareConfig = shareConfig;

			console.log("$scope.shareConfig.resources()="+$scope.shareConfig.resources());

			/*if($scope.shareConfig.resources()!=''){
				$scope.title2 = "资源类型:"+shareConfig.type+",资源:"+$scope.shareConfig.resources();	
			}*/
			$scope.title2 = "资源类型:"+$scope.shareConfig.type+",资源:"+$scope.shareConfig.resources();
		};

		$scope.shareFunc = function(){
			// console.log("shareFunc..");
			// console.log($scope.shareConfig);
			
			//if(true){return;}

			var res = $scope.shareConfig.resources();
			if(!res || res==''){
				return;
			}

			var shareUsers = [],shareType = $scope.shareType,orgId=null;
			var shareUsersStr = "";
			$("input[name='shareUser']").each(function(i,v){
				if($(v).prop("checked")){
					shareUsers.push($(v).attr("username"));	
				}
			});

			if(shareType=='shareToUsers' && shareUsers.length == 0){
				alert("请至少选择一个用户！");
				return;
			}

			if(shareType=='shareToUsers'){
				shareUsersStr = shareUsers.toString(",");
			}else{
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo_share");
				var nodes = treeObj.getSelectedNodes();
				console.log(nodes);
				if(nodes.length > 0){
					shareUsersStr = nodes[0].id;
				}else{
					alert("请选择一个组织！");
				}
			}

			var treeObj = $.fn.zTree.getZTreeObj("treeDemo_share");
			var nodes = treeObj.getSelectedNodes();
			console.log(nodes);
			if(nodes.length > 0){
				orgId = nodes[0].id;
			}else{
				alert("请选择一个组织！");
				return;
			}

			$scope.createMark();

			$http({method:"GET",url:"/share?method=save",params:{
				"type":$scope.shareConfig.type,
				"resources":$scope.shareConfig.resources(),
				"shareType":shareType,
				"shareUsers":shareUsersStr,
				"orgId":orgId
			}})
			.success(function(data, status, headers, config){
				console.log(data);
				$.unblockUI();
				/*if(data.shared){
					alert("您已分享过该资源了！");
					return;
				}*/
				if(data.status){
					alert("分享成功！");
					$('#myModal').modal('hide');
				}else{
					alert("分享失败！");
				}
			})
			.error(function(data, status, headers, config){
				console.log("data"+data+",status="+status+",headers="+headers+",config="+config);
				$.unblockUI();
			});
		}

		$scope.createMark = function(){
			if ($.blockUI===undefined) {
				$.blockUI = common.blockUI;
			} 

			$.blockUI({ message: "系统处理中，请等待...",css: { 
		        border: 'none', 
		        padding: '15px', 
		        backgroundColor: '#000', 
		        '-webkit-border-radius': '10px', 
		        '-moz-border-radius': '10px', 
		        opacity: .5, 
		        color: '#fff' 
		    }});
		}
});	

/*var SharePlugin = function(params){

	console.log("SharePlugin...1");

	angular.module("common_share.controllers")
		.controller('compCtrl',function($scope, $location, $http, $element) {

		console.log("SharePlugin...2");
		$scope.shareConfig = params;
	});
	

	function config(){

	}

	return {
		config:config
	}

}*/
