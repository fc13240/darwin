'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('kafkaSource', function() {
    return {
    	restrict: 'EA',
      scope: { 
          modelVal: '=',
      },
    	templateUrl: 'realtimeReceive/partials/kafka-source.html',
        replace: true,
        controller: function($scope, $element, $compile, cleancompConfig,$http) {
        
        var sourceTypeArray=[]

        function getsourceTypeList(){
            //获取sourseType名称
            $.ajax({method:"GET",url:"/sourceType?method=list",cache: false})
                .success(function(response){

                  $scope.safeApply(function(){
                    //获取全部的sourseType
                    $scope.sourseType = response.list;
                    //页面初始化时初始化inputinfo中的columns
                    angular.forEach($scope.sourseType,function(value,key){
                       sourceTypeArray.push(value.name)
                       if (value.name==cleancompConfig.config.inputinfo.sourceType) {
                         $scope.sourseShowInit=$scope.sourseType[key];

                       };
                    })
                    
                    if ($scope.sourseShowInit!==undefined) {
                       $scope.sourceTypeJsonInit=angular.fromJson($scope.sourseShowInit.sourceType)
                       cleancompConfig.config.inputinfo.columns=$scope.sourceTypeJsonInit.columns
                    };
                    
                    //判断该组件是保存的sourceType是否在sourceType列表中
                    if ($.inArray(cleancompConfig.config.inputinfo.sourceType, sourceTypeArray)>=0) {
                        $("#buttonGroup").removeAttr("style")
                    }else{
                        $("#buttonGroup").attr("style",'display:none')  
                    };   

                  })
                      

            });
        }

        getsourceTypeList();
        

        //新增组件时选择选择sourceType后方可编辑，要么新增sourceType
        if (cleancompConfig.config.inputinfo.sourceType=='selectOne') {
            $("#buttonGroup").attr("style",'display:none')
        }


        var browerType1=navigator.userAgent
        
        if (browerType1.indexOf("Firefox")>-1) {
          $scope.browserType="Firefox"
        }else if(!!window.ActiveXObject || "ActiveXObject" in window){
          $scope.browserType="IE"
        }else{
          $scope.browserType="other"
        };
    		
        var self = this;

        $scope.inputinfo=cleancompConfig.config.inputinfo


        if ($scope.inputinfo.isParse) {
          $("#isParse").hide()
          $("#templates").hide()
        }else{
          $("#isParse").show()
          $("#templates").show()
        };



        $scope.isParse=function(){
            if ($scope.inputinfo.isParse) {
              $("#isParse").hide()
              $("#templates").hide()
            }else{
              $("#isParse").show()
              $("#templates").show()
            };
        }


        
        

        $scope.selectColType=function(){

          if (cleancompConfig.config.inputinfo.colDelimitType==='REGX') {
             cleancompConfig.config.inputinfo.colDelimitExpr='(.*)'
          }
        }



        if($("#sourseName option:selected").val()!==''){
            $("#delBtn").removeAttr("style")
        }else{
            $("#delBtn").attr("style","display:none")
        }
        
        //改变sourseType时的事件
        $("#sourseName").change(function(){

          if ($("#sourseName").val()=='' || $("#sourseName").val()==null) {
            $("#buttonGroup").attr("style",'display:none')
            /*$("#openshow").hide()*/ 
          }else{
            $("#buttonGroup").removeAttr("style")
          }


          $scope.sourseName=$(this).val() 
          $("#sourseTypeShow").attr("style","display:none");
          $("#delBtn").removeAttr("style");
          $("#closeshow").hide();
          $("#openshow").show();
          $("#cancelAdd").hide();
          $("#saveSourseType").hide();
          $("#addSourseType").show();
          $("#saveOne").removeAttr("disabled")
          $("#closeXX").removeAttr("disabled")
          angular.forEach($scope.sourseType,function(value,key){
             if (value.name===$scope.sourseName) {
               $scope.sourseShow=$scope.sourseType[key];
             };
          })
           //获取sourseType的格式信息，将格式信息显示到页面上
          $scope.sourceTypeJson=angular.fromJson($scope.sourseShow.sourceType)
          cleancompConfig.config.inputinfo.sourceType=$scope.sourseShow.name;  
          cleancompConfig.config.inputinfo.encoding=$scope.sourceTypeJson.encoding
          cleancompConfig.config.inputinfo.colDelimitType=$scope.sourceTypeJson.colDelimitType
          cleancompConfig.config.inputinfo.colDelimitExpr=$scope.sourceTypeJson.colDelimitExpr
          cleancompConfig.config.inputinfo.columnSize=$scope.sourceTypeJson.columnSize
          cleancompConfig.config.inputinfo.columns=$scope.sourceTypeJson.columns

          cleancompConfig.config.storeinfo.esconfig.timeColumn=''

          angular.forEach(cleancompConfig.config.inputinfo.columns,function(value,key){
            if (value.type_name=='datetime') {
              if (cleancompConfig.config.storeinfo.esconfig.timeColumnType!=='fromAgent'&&cleancompConfig.config.storeinfo.esconfig.timeColumnType!=='fromCurrent') {
                 $("#notimedata").hide();
                 $("#timeFormat").show();
                 $("#format").attr("data-rule","required")
                 $("#format").removeAttr("novalidate","novalidate");
              }  
            };
          })

        })

        //是否显示
        $scope.showOrhide=function(){
           var sourceValue=$("#sourseName option:selected").val();
           $("#sourseTypeShow").removeAttr("style");
           $("#sourseTypeName").attr("disabled","disabled");
           $("#openshow").hide();
           $("#saveSourseType").show();
           $("#addSourseType").hide();
           $("#cancelAdd").show();
           
           $("#closeshow").show();
           $("#saveOne").attr("disabled","disabled")
           $("#closeXX").attr("disabled","disabled")
           angular.forEach($scope.sourseType,function(value,key){
             if (value.name===sourceValue) {
               $scope.sourseShow=$scope.sourseType[key];
             };
           })
           //获取sourseType的格式信息，将格式信息显示到页面上
           $scope.sourceTypeJson=angular.fromJson($scope.sourseShow.sourceType)
           cleancompConfig.config.inputinfo.sourceType=$scope.sourseShow.name;  
           cleancompConfig.config.inputinfo.encoding=$scope.sourceTypeJson.encoding
           cleancompConfig.config.inputinfo.colDelimitType=$scope.sourceTypeJson.colDelimitType
           cleancompConfig.config.inputinfo.colDelimitExpr=$scope.sourceTypeJson.colDelimitExpr
           cleancompConfig.config.inputinfo.columnSize=$scope.sourceTypeJson.columnSize
           cleancompConfig.config.inputinfo.columns=$scope.sourceTypeJson.columns
        }

        

        //关闭显示
        $scope.closeshow=function(){
           $("#cancelAdd").hide();
           $("#saveSourseType").hide();
           $("#addSourseType").show();
           
           $("#openshow").show();
           $("#closeshow").hide();
           $("#sourseTypeShow").hide();
           $("#saveOne").removeAttr("disabled")
           $("#closeXX").removeAttr("disabled")

        }

        $scope.changeTopic=function(){
          cleancompConfig.config.inputinfo.topic=$("#kafkaTheme").val()
        }

        $scope.addSourseType=function(){
            $("#innerForm").validator({
               rules: {
                  mobile: function(element, param, field) {
                             return /^[a-z].*$/.test(element.value) || '以小写字母开头';
                          }
                      },
               fields: {
                  sourceType: 'required;length[1~25];mobile',
                  colCount:   'required',
                  
               }
            })
            $("#sourseTypeShow").removeAttr("style");
            $("#sourseTypeName").removeAttr("disabled");
            $("#saveSourseType").removeAttr("style");
            $("#addSourseType").attr("style","display:none");
            $("#saveOne").attr("disabled","disabled")
            $("#closeXX").attr("disabled","disabled")
            $("#cancelAdd").show();
            cleancompConfig.config.inputinfo.sourceType=''

      
        }

        $scope.cancelAdd=function(){
            $("#closeshow").hide();
            $("#openshow").show();
            $("#addSourseType").removeAttr("style");
            $("#saveSourseType").attr("style","display:none");
            $("#sourseTypeShow").hide();
            $("#cancelAdd").hide();
            $("#saveOne").removeAttr("disabled")
            $("#closeXX").removeAttr("disabled")
 
        } 


        function changeFormat(){
            angular.forEach(cleancompConfig.config.inputinfo.columns,function(value,key){
              if (cleancompConfig.config.storeinfo.esconfig.timeColumn===value.column_name) {
                  cleancompConfig.config.inputinfo.columns[key].dateFormat=value.dateFormat
                  cleancompConfig.config.storeinfo.esconfig.format=value.dateFormat
               }
            })
            angular.forEach(cleancompConfig.config.config.filterDetail,function(value,key){
               angular.forEach(value.resultArr,function(v,k){
                  if (timeCol===v.resultName) {
                      cleancompConfig.config.config.filterDetail[key].resultArr[k].isTime=true
                      cleancompConfig.config.config.filterDetail[key].resultArr[k].dateFormat=v.dateFormat
                      cleancompConfig.config.storeinfo.esconfig.format=v.dateFormat
                  }
               }) 
              
            })
        }


        function saveSourceTypeFun(addid,name){

              $('#innerForm').isValid(function(v){
                if(v){
                      $("#openshow").show();
                      $("#closeshow").hide();
                      /*$("#cancelAdd").hide();*/
                      $("#saveOne").removeAttr("disabled")
                      $("#closeXX").removeAttr("disabled")
                      $scope.isExist=false
                      angular.forEach($scope.sourseType,function(value,key){
                        if ($("#sourseTypeName").prop("disabled")==true) {
                            $scope.isExist=false
                        }else{
                            if (value.name===$scope.inputinfo.sourceType) {
                              alert("sourseType名称重复,请重新输入");

                              $scope.isExist=true;
                              showOrhide();

                              /*$("#sourseTypeShow").show();*/
                            }
                        };
                      });
                      $("#addSourseType").removeAttr("style");
                      $("#saveSourseType").attr("style","display:none");
                      $("#sourseTypeShow").attr("style","display:none");
                      if ($scope.isExist!==true) {
                          var sourseTypeName=$("#sourseTypeName").val()
                          var data={}
                          data["name"]=name
                          data["encoding"]=$scope.inputinfo.encoding
                          data["colDelimitType"]=$scope.inputinfo.colDelimitType
                          data["colDelimitExpr"]=$scope.inputinfo.colDelimitExpr
                          data["columnSize"]=$scope.inputinfo.columnSize
                          data["columns"]=$scope.inputinfo.columns 
                          var dataString=angular.toJson(data);


                          var params = {};
                          params['sourceType'] = dataString;
                          params['name'] = name;
                          params['id'] = addid;

                          var url="/sourceType?method=save"
                          
                          $.ajax({
                              type         : 'POST',
                              url         : url,
                              data         : params,
                              dataType     : 'json'
                          }).done(function(response){
                              if(response.status==false){
                                layer.msg('保存sourseType失败！');
                              }else{
                                layer.msg('保存sourseType成功'); 
                                
                                changeFormat()

                                //将soouceType显示到页面上
                                cleancompConfig.config.inputinfo.sourceType=$scope.inputinfo.sourceType

                                cleancompConfig.config.inputinfo.topic=$scope.inputinfo.topic
                                $("#buttonGroup").removeAttr("style")
                                $("#delBtn").removeAttr("style")
                                $("#cancelAdd").hide();
                                
                                getsourceTypeList();
                               
                              }  
                          })
                          
                      };  

                }else {
                   alert("保存sourseType时必填项没有添加,请检查");
                }
                return;
            });
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
    
        $scope.saveSourseType=function(){

            var addid;
            
            if ($("#sourseTypeName").prop("disabled")) {
               addid=$scope.sourseType[$("#sourseName option").index($('#sourseName option:selected'))].id
            }else{
               addid=0
            };

            var sourceName=$("#sourseTypeName").val()
            var compId=$("#compId").val()

            $http({method:"GET",url:"/sourceType?method=checkUsed",params:{'name':sourceName,'compId':compId}})
            .success(function(data){
                if (addid!=0) {
                  if (data==0) {
                      alert("sourceType名称正在被其他组件使用，请另存sourceType")
                      $("#sourseTypeName").removeAttr("disabled")
                    
                  }else{
                    //新增sourceTye时保存
                    
                    saveSourceTypeFun(addid,sourceName)
                    $scope.inputinfo.sourceType=$("#sourseTypeName").val()
                  };
                 
              }else{
                    //新增sourceTye时保存
                    saveSourceTypeFun(addid,sourceName)
              };
                    
            })

            
        }

        $scope.deleteSourseType=function(){

           var sourceValue=$("#sourseName option:selected").val();
           if(confirm("是否要删除当前的sourseType"+sourceValue+"吗？")){
               $("#closeshow").hide();
               $("#openshow").show();
               $("#sourseTypeShow").hide()
               $("#saveSourseType").hide();
               $("#cancelAdd").hide();
               $("#addSourseType").show();
               var id=$scope.sourseType[$("#sourseName option").index($('#sourseName option:selected'))].id
               var url="/sourceType?method=deleteById&id="+id;
               //删除一个已有的sourseType
               $http({method:"GET",url:url})
                    .success(function(response){
                      if(response.status=="false"){
                          layer.msg('删除sourseType失败！');
                      }else{
                         layer.msg('删除sourseType成功');
                         $("#buttonGroup").attr("style",'display:none')
                         cleancompConfig.config.inputinfo.sourceType=""
                         
                         //删除后重新获取一遍sourseType名称
                         getsourceTypeList();
                      }      
               });
           }else{
              
           }
           
          
        }

        function selectTemplates(){
            $.ajax({method:"GET",url:"/dsTemplate?method=selectTemplates",data:{"type":"realtimeReceive"},cache:false})
            .success(function(response){

                $scope.safeApply(function(){
                  //获取全部的sourseType
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
              $scope.temporary=$scope.inputinfo.sourceType
              $scope.saveSourceType=$scope.inputinfo.sourceType
              $scope.saveTopic=$scope.inputinfo.topic
          /*    $scope.inputinfo.sourceType='';
              $scope.inputinfo.topic=''*/
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
                            params['type'] = 'realtimeReceive';

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
                                      $scope.inputinfo.sourceType=$scope.saveSourceType
                                      $scope.inputinfo.topic=$scope.saveTopic
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
                         params['type'] = 'realtimeReceive';

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
                                  $scope.inputinfo.sourceType=$scope.saveSourceType
                                  $scope.inputinfo.topic=$scope.saveTopic
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
                      console.log("删除成功")
                      $("#deleteTempBtn").hide();
                      
                      selectTemplates();

                      $scope.inputinfo = cleancompConfig.config.inputinfo;
                      $scope.inputinfo.columnSize=5
                      
                      /*$scope.inputinfos = [];
                      $scope.inputinfos.push($scope.inputinfo);*/
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
/*                console.log(data.dsInfo.ruleConf)*/
                var rr = angular.fromJson(data.dsInfo.ruleConf);
                $scope.inputinfo = rr;
                
                var keepSourseTypeName=$("#sourseTypeName").val()
                var keepTopic=$("#kafkaTheme").val()
            
               
                $scope.inputinfo.sourceType=keepSourseTypeName;
                $scope.inputinfo.topic=keepTopic;

                $scope.inputinfo.encoding=rr.encoding
                $scope.inputinfo.colDelimitType=rr.colDelimitType
                $scope.inputinfo.colDelimitExpr=rr.colDelimitExpr
                $scope.inputinfo.columnSize=rr.columnSize
                $scope.inputinfo.columns=rr.columns
                angular.forEach(rr.columns,function(value,key){
                    $scope.inputinfo.columns[key].column_name=value.column_name
                    $scope.inputinfo.columns[key].id=key
                    $scope.inputinfo.columns[key].type_name=value.type_name
                    $scope.inputinfo.columns[key].dateFormat=value.dateFormat
                    $scope.inputinfo.columns[key].isTime=value.isTime
                });
                
                
                $scope.inputinfos = [];
                $scope.inputinfos.push(rr);
                
                $("#deleteTempBtn").show();
            }).error(function(data, status, headers, config){
                alert("查询不到选择的模板！");
            });
        };



        $scope.mouseenter = function () {  
          $(".propmt").popover({
                 trigger:'hover',
                 placement:'bottom',
                 html: true
                 });
        }
      		
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
