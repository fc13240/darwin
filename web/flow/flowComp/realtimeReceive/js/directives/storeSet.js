'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('storeSet', function() {
    return {
    	restrict: 'EA',
    	scope: {    
          esIndex: '@',
          compId:'@'
        },
    	templateUrl: 'realtimeReceive/partials/store-set.html',
        replace: true,
        controller: function($scope,$element,cleancompConfig) {
            
            

	    	$scope.storeinfos = cleancompConfig.config.storeinfo;
	        $scope.cleancompConfig=cleancompConfig.config
      			$scope.popup_store = function(index) {
      				$element.find('#hdfs_store_modal').modal('show');
                     $scope.escolumns()
                     /*$scope.columns()*/
                    
      			  };
            
            $scope.columns=function(){
             $scope.timeColumns1=[]
             angular.forEach(cleancompConfig.config.storeinfo.escolumns,function(value,key){
                 if (value.type_name=='datetime') {
                    $scope.timeColumns1.push(value)
                 };     
             })
            }
			
            $scope.escolumns=function() {
              
           /*   $scope.inputLength=cleancompConfig.config.inputinfo.columns.length
              $scope.filterLength=cleancompConfig.config.config.filterDetail.length*/
              cleancompConfig.config.storeinfo.escolumns = [];
              angular.forEach(cleancompConfig.config.inputinfo.columns,function(value,key){
                 cleancompConfig.config.storeinfo.escolumns.push(value);
                 $scope.len=cleancompConfig.config.storeinfo.escolumns.length
              })
              angular.forEach(cleancompConfig.config.config.filterDetail,function(value,key){
                 angular.forEach(value.resultArr,function(v,k){
                   var filterJson={}
                   filterJson["column_name"]=v.resultName
                   filterJson["dateFormat"]=v.dateFormat
                   filterJson["id"]=$scope.len
                   filterJson["isTime"]=v.isTime
                   filterJson["type_name"]=v.type
                   cleancompConfig.config.storeinfo.escolumns.push(filterJson);
                   $scope.len=cleancompConfig.config.storeinfo.escolumns.length
                })
      
              })

            }
			
            $scope.selectOneStore=function(){
                 $("#selectOneStore").attr("style","border:2px solid #ccc;width:100px;height:25px;position:absolute;margin-left:240px;z-index:9999; background:#F5F8F8; border-radius:6px;");
            }

            $scope.addOneStore = function(storeType) {
                $("#selectOneStore").attr("style","display:none")
                var dataLength = $scope.storeinfos.length;
                if (dataLength>0) {
                    angular.forEach($scope.storeinfos,function(v,i){
                        var dataindex = parseInt(v.esconfig.dataName.replace('data',''));
                        if (dataindex>dataLength) {
                            dataLength = dataindex;
                        }
                    });
                }
                var storeinfoDefault;
                if (storeType==='全文索引') {
                        storeinfoDefault = {
                            "elasticSearch":{
                            dataName:"data1",
                            es_index:'',
                            es_table:'',
                        }
                       
                    };
                };
                
                $scope.storeinfos.push(storeinfoDefault);
            };

    		$scope.showStoreCols = [];
        }
    };
});
