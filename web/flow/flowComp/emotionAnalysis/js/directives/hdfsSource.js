'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('hdfsSource', function() {
    return {
    	restrict: 'EA',
      scope:{
         inputinfo:'='
      },
    	templateUrl: 'emotionAnalysis/partials/hdfs-source.html',
        replace: true,
        controller: function($scope, $element, $compile, statCompConfig,$http) {

        var browerType1=navigator.userAgent
        
        if (browerType1.indexOf("Firefox")>-1) {
          $scope.browserType="Firefox"
        }else if(!!window.ActiveXObject || "ActiveXObject" in window){
          $scope.browserType="IE"
        }else{
          $scope.browserType="other"
        };

    		var self = this;
    		
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

    		function selectTemplates(){
            $.ajax({method:"GET",url:"/dsTemplate?method=selectTemplates",data:{"type":"dataClean"},cache:false})
            .success(function(response){
                
                $scope.safeApply(function(){
                    $scope.templates = response;
                    //手动更新下select的项目，这样不会导致出现多个空格问题
                    $("#tmpSelect").empty();
                    $("#tmpSelect").append("<option></option>");
                    $.each(response,function(index,v){
                      $("#tmpSelect").append("<option value="+v.id+">"+v.name+"</option>");
                    });
                })        
            });
        }

            selectTemplates();

            $($element).find("#cancelbutton").click(function(){
               $($element).find("#templateName").hide()
               $($element).find("#cancelbutton").hide()
               $($element).find("#saveTemplatesBtn").val("另存为模板");
               $($element).find("#templateName").val('')
               
            })

            $("#saveTemplatesBtn").click(function(){

              if ($scope.browserType=="Firefox" || $scope.browserType=="IE") {
                 
                 $($element).find("#templateName").show()
                 $($element).find("#cancelbutton").show()
                 
                 if ($($element).find("#saveTemplatesBtn").val()=="另存为模板") {
                    $scope.saveOrNotSave=false
                 }else{
                    $scope.saveOrNotSave=true
                 };

                 $($element).find("#saveTemplatesBtn").val("保存");
                 var templateName=$($element).find("#templateName").val()
                
                 if ($scope.saveOrNotSave) {
                        if (templateName!=''&&templateName!=null) {
                             var params = {};
                            params['ruleConf'] = JSON.stringify($scope.inputinfo);
                            params['tmpName'] = templateName;
                            params['type'] = 'dataClean';

                            $.ajax({
                                  type   : 'POST',
                                  url    : "/datasources?method=saveToDsTemplateFunc",
                                  data   : params,
                                  dataType: 'json'
                            }).done(function(response){
                                  
                                  if(response=="2"){
                                      layer.msg('保存失败！ 模板重名啦！('+templateName+')');
                                  }else if(response=="1"){
                                      layer.msg('保存失败！');
                                  }else{
                                      layer.msg('保存模板成功 模板名称：'+templateName); 
                                      $($element).find("#templateName").val('')
                                      $($element).find("#templateName").hide()
                                      $($element).find("#cancelbutton").hide()
                                      $($element).find("#saveTemplatesBtn").val("另存为模板");
                                      selectTemplates();
                                  }
                            })
                        };    

                  };

            }else{
                layer.prompt({
                      title: '请输入模板名称',
                      formType: 0 //prompt
                    },function(newName){
                         var params = {};
                         params['ruleConf'] = JSON.stringify($scope.inputinfo);
                         params['tmpName'] = newName;
                         params['type'] = 'dataClean';

                         $.ajax({
                              type   : 'POST',
                              url    : "/datasources?method=saveToDsTemplateFunc",
                              data   : params,
                              dataType: 'json'
                          }).done(function(response){
                              
                              if(response=="2"){
                                  layer.msg('保存失败！ 模板重名啦！('+newName+')');
                              }else if(response=="1"){
                                  layer.msg('保存失败！');
                              }else{
                                  layer.msg('保存模板成功 模板名称：'+newName); 
                                  selectTemplates();
                              }
                          })

                })
                 

            } 
      


            
      })

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
                            $scope.inputinfo = statCompConfig.cloneConfig.inputinfo[0];
                            $scope.inputinfos = [];
                            $scope.inputinfos.push($scope.inputinfo);  
                        }
                    }).error(function(err){
                        console.log(err);
                        alert("删除模板失败！");
                    });
                }
            };

            $scope.changeTemplates = function(){
                console.log("changeTemplates..."+$("#tmpSelect").val());

                if($.trim($("#tmpSelect").val())==''){
                    $("#deleteTempBtn").hide();
                    return;
                }

                $http({method:"GET",url:"/dsTemplate?method=selectById",
                  params:{"id":$("#tmpSelect").val()}})
                .success(function(data, status, headers, config){
                    var rr = angular.fromJson(data.dsInfo.ruleConf);
                    
                    $scope.inputinfo.dataName=rr.dataName
                     $scope.inputinfo.colCount=rr.colCount
                     $scope.inputinfo.colDelimitExpr=rr.colDelimitExpr
                     $scope.inputinfo.colDelimitType=rr.colDelimitType
                     $scope.inputinfo.combineRegex=rr.combineRegex
                     $scope.inputinfo.dataDir=rr.dataDir
                     $scope.inputinfo.dataRange=rr.dataRange
                     $scope.inputinfo.encoding=rr.encoding
                     $scope.inputinfo.dataType=rr.dataType
                     $scope.inputinfo.multilineCombine=rr.multilineCombine
                     
                     $scope.inputinfo.dataRangeDetail.dirnameTimeRule=rr.dataRangeDetail.dirnameTimeRule
                     $scope.inputinfo.dataRangeDetail.filenameMatch=rr.dataRangeDetail.filenameMatch
                     $scope.inputinfo.dataRangeDetail.filenameNotMatch=rr.dataRangeDetail.filenameNotMatch
                     $scope.inputinfo.dataRangeDetail.filenameTimeRule=rr.dataRangeDetail.filenameTimeRule
                     $scope.inputinfo.dataRangeDetail.timeRangeFrom=rr.dataRangeDetail.timeRangeFrom
                     $scope.inputinfo.dataRangeDetail.timeRangeTo=rr.dataRangeDetail.timeRangeTo
                     $scope.inputinfo.dataRangeDetail.timeUnit=rr.dataRangeDetail.timeUnit
                     $scope.inputinfo.colDetail=[]
                     angular.forEach(rr.colDetail,function(value,key){
                         $scope.inputinfo.colDetail.push(value)
                     })
                    
                    $("#deleteTempBtn").show();

                }).error(function(data, status, headers, config){
                    console.log("error..");
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
    		                        {type:'ISO8859-1', name:'ISO8859-1'}
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
