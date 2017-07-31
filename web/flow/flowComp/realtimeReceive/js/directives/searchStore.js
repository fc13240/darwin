'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('searchStore', function() {
    return {
    	restrict: 'EA',
      scope: {    
          modelVal: '=',
          esIndex:"@",
          compId:'@'
      },
    	templateUrl: 'realtimeReceive/partials/search-store.html',
        replace: true,
        controller: function($scope, $element,$http, $compile, cleancompConfig) {
    		var self = this;

          /*$scope.columes=cleancompConfig.config.inputinfo.columns*/
          /*$scope.filterDetail=cleancompConfig.config.config.filterDetail*/
          
          $scope.esIndexList=[]
          $scope.esIndexList1=$scope.esIndex.replace("[","").replace("]","").split(",");
          angular.forEach($scope.esIndexList1,function(value,key){
             $scope.esIndexList.push(value.replace(" ",""))
          })

       
       $(function(){

          if (cleancompConfig.config.storeinfo.esconfig.timeColumnType=='fromAgent') {
              $("#timeFormat").attr("style","display:none");
          }else if (cleancompConfig.config.storeinfo.esconfig.timeColumnType=='fromCurrent') {
              $("#timeFormat").attr("style","display:none");
          }else{
              $("#timeFormat").removeAttr("style");
          };

         /* if (cleancompConfig.config.storeinfo.esconfig.isOpenAdvanSet==false) {
              $("#advancedSet").attr("style","display:none");
          }else{
              $("#advancedSet").removeAttr("style");
          };*/

         $scope.timeColumns=[]
         angular.forEach(cleancompConfig.config.storeinfo.escolumns,function(value,key){
             if (value.type_name=='datetime') {
                $scope.timeColumns.push(value)
             };     
         })
        
        
         //页面加载完成之后的回显操作
         angular.forEach(cleancompConfig.config.storeinfo.escolumns,function(value,key){
               if (value.isTime===true) {
                  cleancompConfig.config.storeinfo.esconfig.timeColumn=value.column_name
                  $("#timeFormat").removeAttr("style");
                  return false;
               }
         })
       })




      $scope.selectTable=function(){
          $scope.timeColumns=[]
             angular.forEach(cleancompConfig.config.storeinfo.escolumns,function(value,key){
                 if (value.type_name=='datetime') {
                    $scope.timeColumns.push(value)
                 };     
          })

          var timeCol=$("#changeTime option:selected").val();
            
             angular.forEach(cleancompConfig.config.inputinfo.columns,function(value,key){
                 if (timeCol===value.column_name) {
                    cleancompConfig.config.inputinfo.columns[key].isTime=true 
                    cleancompConfig.config.inputinfo.columns[key].dateFormat=value.dateFormat
                    $('#format').val(value.dateFormat);
                    cleancompConfig.config.storeinfo.esconfig.format=$('#format').val()

                 }else{
                    cleancompConfig.config.inputinfo.columns[key].isTime=false
                 };
             })
             angular.forEach(cleancompConfig.config.config.filterDetail,function(value,key){
                 angular.forEach(value.resultArr,function(v,k){
                    if (timeCol===v.resultName) {
                        cleancompConfig.config.config.filterDetail[key].resultArr[k].isTime=true
                        cleancompConfig.config.config.filterDetail[key].resultArr[k].dateFormat=v.dateFormat
                        $('#format').val(v.dateFormat); 
                        cleancompConfig.config.storeinfo.esconfig.format=$('#format').val()
                    }else{
                        cleancompConfig.config.config.filterDetail[key].resultArr[k].isTime=false
                    };
                 })
                 
             })

      }



       $scope.openAdvancedSet=function(){
         if($("#advancedSet").is(":hidden")){
            $("#advancedSet").show();
            $("#sliceOperation").attr("data-rule","required;integer[+]")
            $("#sliceOperation").removeAttr("novalidate","novalidate");
            cleancompConfig.config.storeinfo.esconfig.isOpenAdvanSet=true
         }else{
            $("#advancedSet").hide();
            $(".msg-wrap").remove();
            $("#sliceOperation").attr("novalidate","novalidate"); 
            cleancompConfig.config.storeinfo.esconfig.isOpenAdvanSet=false

         }
         
       }
        
        


        $scope.showTime=function(){

            $("#getTime").removeAttr("checked");
            $("#getColume").attr("checked","checked");
            $("#timeFormat").removeAttr("style");
            $("#format").attr("data-rule","required")
            $("#format").removeAttr("novalidate","novalidate");
            $scope.timeColumns=[]
             angular.forEach(cleancompConfig.config.storeinfo.escolumns,function(value,key){
                 if (value.type_name=='datetime') {
                    $scope.timeColumns.push(value)
                 };     
             })
            if ($scope.timeColumns.length==0) {
              $("#notimedata").show();
              $("#timeFormat").hide();
              $(".msg-wrap").remove();
              $("#format").attr("novalidate","novalidate"); 
            }else{
              $("#notimedata").hide();
              $("#timeFormat").show();
              $("#format").attr("data-rule","required")
              $("#format").removeAttr("novalidate","novalidate");
            };
        }
      
        $scope.hideTime=function(){
             $("#getColume").removeAttr("checked");
             $("#getTime").attr("checked","checked");
             $(".msg-wrap").remove();
             $("#format").attr("novalidate","novalidate"); 
             $("#timeFormat").attr("style","display:none");
             $("#notimedata").hide();
             angular.forEach(cleancompConfig.config.inputinfo.columns,function(value,key){
                 if (value.isTime===true) {
                    value.isTime=false 
                 }
             }); 

             
             angular.forEach(cleancompConfig.config.config.filterDetail,function(value,key){
                angular.forEach(value.resultArr,function(v,k){
                   if (v.isTime===true) {
                      v.isTime=false  
                   }
                })
             }); 

        }

        $scope.getNow=function(){
             $("#getColume").removeAttr("checked");
             $("#getNow").attr("checked","checked");
             $(".msg-wrap").remove();
             $("#format").attr("novalidate","novalidate"); 
             $("#timeFormat").attr("style","display:none");
             $("#notimedata").hide();
             angular.forEach(cleancompConfig.config.inputinfo.columns,function(value,key){
                 if (value.isTime===true) {
                    value.isTime=false 
                 }
             }); 
                          
             angular.forEach(cleancompConfig.config.config.filterDetail,function(value,key){
                angular.forEach(value.resultArr,function(v,k){
                   if (v.isTime===true) {
                      v.isTime=false  
                   }
                })
                
             }); 

        }

        //给输出配置中的下拉框设置datetime类型的值
        $scope.focus=function(){
             $scope.timeColumns=[]
             angular.forEach(cleancompConfig.config.storeinfo.escolumns,function(value,key){
                 if (value.type_name=='datetime') {
                    $scope.timeColumns.push(value)
                 };     
             })

            if ($scope.timeColumns.length==0) {
              $("#notimedata").show();
              $("#timeFormat").hide();
              $(".msg-wrap").remove();
              $("#format").attr("novalidate","novalidate"); 
            }else{
              $("#notimedata").hide();
              $("#timeFormat").show();
              $("#format").attr("data-rule","required")
              $("#format").removeAttr("novalidate","novalidate");
            };
            
        }

        

        $("#changeTime").change(function(){
             var timeCol=$("#changeTime option:selected").val();
             //设置时间字段
             cleancompConfig.config.storeinfo.esconfig.timeColumn=timeCol

             angular.forEach(cleancompConfig.config.inputinfo.columns,function(value,key){
                 if (timeCol===value.column_name) {
                    cleancompConfig.config.inputinfo.columns[key].isTime=true 
                    cleancompConfig.config.inputinfo.columns[key].dateFormat=value.dateFormat
                    cleancompConfig.config.storeinfo.esconfig.format=value.dateFormat
                 }else{
                    cleancompConfig.config.inputinfo.columns[key].isTime=false
                 };
             })
             angular.forEach(cleancompConfig.config.config.filterDetail,function(value,key){
                 angular.forEach(value.resultArr,function(v,k){
                    if (timeCol===v.resultName) {
                        cleancompConfig.config.config.filterDetail[key].resultArr[k].isTime=true
                        cleancompConfig.config.config.filterDetail[key].resultArr[k].dateFormat=v.dateFormat
                        cleancompConfig.config.storeinfo.esconfig.format=v.dateFormat
                    }else{
                        cleancompConfig.config.config.filterDetail[key].resultArr[k].isTime=false
                    };
                 })    
             })
         })
         
  

        }
    };
});
