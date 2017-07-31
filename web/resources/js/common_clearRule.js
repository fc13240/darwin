'use strict';

angular.module('common_clearRule.directives', []);
angular.module('common_clearRule.controllers', []);
angular.module('common_clearRule', [
'common_clearRule.directives', 'common_clearRule.controllers'
]);

angular.module('common_clearRule.directives').directive('commonClearRule', function() {
	return {
		restrict : 'EA',
		templateUrl : '/resources/common_clearRule.html',
		replace : true,
		controller : function($scope, $element, $compile, $http) {
			console.log("common_clearRule.directives.init..");

			init();

			function init(){
				console.log("clearRule init...");
				
				console.log("$scope.common_clearRule_buttonOne_class="+$scope.clearRuleConfig.common_clearRule_buttonOne_class);
				
				$("button[name='common_clearRule_buttonOne']").addClass($scope.clearRuleConfig.common_clearRule_buttonOne_class);

			}
			
			$scope.safeApply = function(fn) {
		        var phase = this.$root.$$phase;
		        if(phase == '$apply' || phase == '$digest') {
		            if(fn && (typeof(fn) === 'function')) {
		                fn();
		            }
		        } else {
		            this.$apply(fn);
		        }
		    };
			
			$('#common_clearRule_buttonOne').click(function(){
//				console.log("click");
				var fatherValue = $("#anaKeywordInputHidden").val();
				console.log("fatherValue = "+fatherValue);
				if(fatherValue===undefined || fatherValue==''){
					if($scope.clearRuleConfig.type == "hdfs"){
						alert("请选择目录！");
					}else{
						alert("请选择索引！");
					}
					
				}else{
					var dayDB = "无";
					$http({method:"GET",url:"/clearRule?method=select&dir="+fatherValue})
					.success(function(data, status, headers, config){
						console.log("data:");
						console.log(data);
						var status = data.status;
						if (status) {
							dayDB = data.days;
							$("#days").val(dayDB);
						}else{
							$("#days").val(dayDB);
						}
						
						$scope.safeApply(function(){
							$scope.clearDir = fatherValue;
							$scope.days = $("#days").val();
						});

					})
					.error(function(data, status, headers, config){
						alert("加载数据失败！");
					});
					
					$scope.safeApply(function(){
						$scope.clearDir = fatherValue;
						$scope.days = $("#days").val();
					});
					$("#days").attr("data-rule","required;integer[+];range[1~4000];");
   		    		$("#days").removeAttr("novalidate","novalidate");
					$('#clearRuleModal').modal('show');
				}
			});
			$('#clearRuleCancel').click(function(){
//				$(".msg-wrap").remove();
                $("#days").attr("novalidate","novalidate"); 
				$('#clearRuleModal').modal('hide');
				$scope.clearDir = "";
			});
		}
	}
});

angular.module("common_clearRule.controllers").controller('clearRuleController',
	function($scope, $location, $http, $element) {
		console.log("common_clearRule.controllers.init...");

		$scope.initConfig2 = function(clearRuleConfig){
			$scope.clearRuleConfig = clearRuleConfig;

			console.log("$scope.clearRuleConfig.resources()="+$scope.clearRuleConfig.resources());
		
//			$scope.clearRuleConfig.resources();
			$scope.clearDir = $scope.clearRuleConfig.resources();
		};

		$scope.saveClearRule = function(){
			console.log("shareFunc..");
			var day = $scope.days;
//			console.log("day.."+day);
			if(day<=0 || day=='' || day>3999 || day===undefined){
				console.log("err  day.."+day);
				$("#days").focus();
//				$scope.days.focus();
			}else{
				console.log("day.."+day);
				var dirType = $scope.clearRuleConfig.type;
				console.log("dirType.."+dirType);
				$scope.createMark();
				
				var clearDir = $scope.clearRuleConfig.resources();
				$http({method:"GET",url:"/clearRule?method=saveClearRule",params:{
					"type":$scope.clearRuleConfig.type,
					"resources":$scope.clearRuleConfig.resources(),
					"days":day,
					"clearDir":clearDir
				}})
				.success(function(data, status, headers, config){
					console.log(data);
					$.unblockUI();
					if(data.status){
						alert("设置成功！");
						$('#clearRuleModal').modal('hide');
						if(dirType == 'es'){
							window.location.href=window.location.href;
						}
					}else{
						alert("设置失败！");
					}
				})
				.error(function(data, status, headers, config){
					console.log("data"+data+",status="+status+",headers="+headers+",config="+config);
					$.unblockUI();
					alert("设置出现异常！");
				});
				
			}
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
