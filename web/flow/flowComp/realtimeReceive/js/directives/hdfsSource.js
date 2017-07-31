'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('hdfsSource', function() {
    return {
    	restrict: 'EA',
      scope: { 
         
          modelVal: '=',

      },
    	templateUrl: 'realtimeReceive/partials/hdfs-source.html',
        replace: true,
        controller: function($scope, $element, $compile, cleancompConfig,$http) {
    		
        var self = this;

        function selectTemplates(){
            $http({method:"GET",url:"/dsTemplate?method=selectTemplates",params:{"type":"dataClean"}})
            .success(function(response){
                $scope.templates = response;

                //手动更新下select的项目，这样不会导致出现多个空格问题
                $("#tmpSelect").empty();
                $("#tmpSelect").append("<option></option>");
                $.each(response,function(index,v){
                  $("#tmpSelect").append("<option value="+v.id+">"+v.name+"</option>");
                });

            });
        }

        selectTemplates();
        
        $($element).find("#saveTemplatesBtn").click(function(){
            layer.prompt({
              title: '请输入模板名称',
              formType: 0 //prompt
            },function(newName){
              $http({
                method:"GET",
                url:"/datasources?method=saveToDsTemplateFunc",
                params:{
                  "ruleConf":JSON.stringify($scope.inputinfo),
                  "tmpName":newName,
                  "type":"dataClean"
                }
              })
              .success(function(data, status, headers, config){
                  if(data=="2"){
                      layer.msg('保存失败！ 模板重名啦！('+newName+')');
                  }else if(data=="1"){
                      layer.msg('保存失败！');
                  }else{
                      layer.msg('保存模板成功 模板名称：'+newName); 
                      selectTemplates();
                  }
                  $scope.a3232 = "";
               }).error(function(data, status, headers, config){
                  alert("保存模板失败！");
              });
        })
      })

    		/*$scope.saveTemplates = function(thisObj){
           $("#saveTemplatesBtn").attr("value","保存");
           $("#templateName").show();

           if($.trim($("#templateName").val())==''){
              $("#templateName").focus();
              return;
           }

           $http({
              method:"GET",
              url:"/datasources?method=saveToDsTemplateFunc",
              params:{
                "ruleConf":JSON.stringify($scope.inputinfo),
                "tmpName":$("#templateName").val(),
                "type":"dataClean"
              }
            })
           .success(function(data, status, headers, config){
              if(data=="2"){
                  alert("保存失败！模板名称已存在！");
              }else if(data=="1"){
                  alert("保存失败！");
              }else{
                  alert("保存模板成功！");  
                  selectTemplates();
              }
              $scope.a3232 = "";
           }).error(function(data, status, headers, config){
              alert("保存模板失败！");
          });

    		};
*/
        $scope.deleteTemp = function(){
            if(confirm("确定要删除选中的模板吗？")){
                $http({method:"GET",url:"/dsTemplate?method=deleteById",params:{
                  id:$("#tmpSelect").val()
                }}).success(function(data){
                    
                    if(data.status!="0"){
                        alert("删除模板失败！");
                    }else{
                      $("#deleteTempBtn").hide();
                      selectTemplates();

                      $scope.inputinfo = cleancompConfig.cloneConfig.inputinfo[0];
                      $scope.inputinfos = [];
                      $scope.inputinfos.push($scope.inputinfo);
                    }
                }).error(function(err){
                    alert("删除模板失败！");
                });
            }
        };

        $scope.changeTemplates = function(){
            if($.trim($("#tmpSelect").val())==''){
                $("#deleteTempBtn").hide();
                return;
            }

            $http({method:"GET",url:"/dsTemplate?method=selectById",
              params:{"id":$("#tmpSelect").val()}})
            .success(function(data, status, headers, config){
                var rr = angular.fromJson(data.dsInfo.ruleConf);
                    
                $scope.inputinfo = rr;
                
                $scope.inputinfos = [];
                $scope.inputinfos.push(rr);
                
                $("#deleteTempBtn").show();
            }).error(function(data, status, headers, config){
                alert("查询不到选择的模板！");
            });
        };
      		
          $scope.datatypeitems = [
      		                        {type:'text', name:'文本'},
      		                        {type:'gzip', name:'gzip文件'},
      		                        {type:'binary', name:'二进制'}
      		                        ];
      		$scope.encodingitems = [
      		                        {type:'UTF-8', name:'UTF-8'},
      		                        {type:'GBK', name:'GBK'},
      		                        {type:'GB2312', name:'GB2312'},
    		                          {type:'ISO8859-1', name:'ISO8859-1'},
                                  {type:'Unicode', name:'Unicode'}
      		                        ];
      		$scope.datarange = [
      		                        {type:'dirname_time_rule', name:'目录下目录名符合【时间】规则的文件'},
      		                        {type:'filename_time_rule', name:'目录下文件名符合【时间】规则的文件'},
    		                        {type:'filename_rule', name:'选定目录下所有符合规则的文件'},
      		                      	{type:'dirname_rule', name:'选定目录下所有符合规则的目录'},
      		                      	{type:'all', name:'选定的文件/目录下所有文件'},
      		                        {type:'period', name:'指定周期'}
      		                        ];
      		$scope.timeunit = [
  		                        {type:'second', name:'秒'},
  		                        {type:'minute', name:'分钟'},
		                        {type:'hour', name:'小时'},
  		                      	{type:'day', name:'天'},
  		                      	{type:'week', name:'周'},
		                        {type:'month', name:'月'},
		                      	{type:'year', name:'年'}
  		                        ];
      		$scope.coldelimittype = [
       		                        {type:'FIELD', name:'分隔符'},
      		                        {type:'REGX', name:'正则表达式'}
      		                        ];

       

        

        }

    };
});
