'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('sourceSet', function() {
    return {
        require: '^modal',
    	restrict: 'EA',
    	templateUrl: 'esExport/partials/source-set.html',
        replace: true,
        controller: function($scope,$element,$compile,esExportConfig) {

            
            //console.log(esExportConfig.config.inputinfo[0])
            $scope.inputinfo=esExportConfig.config.inputinfo[0]
            $scope.selectValidator=function(){
                if ($scope.inputinfo.index_type==2) {
                    $scope.timeColume=$scope.inputinfo.index_name.substring($scope.inputinfo.index_name.indexOf('@{')+2,$scope.inputinfo.index_name.indexOf('}'))
                    console.log($scope.timeColume.indexOf('HH'))
                    if ($scope.timeColume.indexOf('HH')<0) {
                        console.log("进了判断d的")
                        $('form').validator( "destroy" );
                        $("#begintime").attr("data-rule","required;timed")
                        $("#endtime").attr("data-rule","required;timed")
                    }else{
                        console.log("进了判断H的")
                        $('form').validator( "destroy" );
                        $("#begintime").attr("data-rule","required;timeH")
                        $("#endtime").attr("data-rule","required;timeH")
                    };
                   
                };   
            }
            
            if($scope.inputinfo.index_type==1){
                $scope.showInfo='索引名称'
                $("#timeIndexShow").hide();
                $(".msg-wrap").remove();
                $("#begintime").attr("novalidate","novalidate"); 
                $("#endtime").attr("novalidate","novalidate"); 
                //$("#selectindex").attr("data-rule","required;esSingleFormat;length[1~25]")
                
            }else{
                $scope.showInfo='索引名称@{yyyyMMdd}'
                $("#timeIndexShow").show();
                $("#begintime").attr("data-rule","required;time")
                $("#begintime").removeAttr("novalidate","novalidate");
                $("#endtime").attr("data-rule","required;time")
                $("#endtime").removeAttr("novalidate","novalidate");
                //$("#selectindex").attr("data-rule","required;estimeFormat")
                
            }

    		$scope.getsingleIndex=function(){
                $scope.showInfo='索引名称'
                $('form').validator( "destroy" );
    			$("#timeIndexShow").hide();
                $(".msg-wrap").remove();
                $("#begintime").attr("novalidate","novalidate"); 
                $("#endtime").attr("novalidate","novalidate"); 
               
                //$("#selectindex").attr("data-rule","required;esSingleForma;length[1~25]")

    		}

    		$scope.getTimeIndex=function(){
                $scope.showInfo='索引名称@{yyyyMMdd}'
                $('form').validator( "destroy" );
    			$("#timeIndexShow").show();
                $("#begintime").attr("data-rule","required;time")
                $("#begintime").removeAttr("novalidate","novalidate");
                $("#endtime").attr("data-rule","required;time")
                $("#endtime").removeAttr("novalidate","novalidate");
                //$("#selectindex").attr("data-rule","required;estimeFormat")
                
    		}

            $scope.validateTime=function(){
        
                $scope.startTime=$scope.inputinfo.start_time.replace('d','').replace("H",'')
                $scope.endTime=$scope.inputinfo.end_time.replace('d','').replace("H",'')
        
                if(eval($scope.startTime)>eval($scope.endTime)){
                    if (confirm("起始时间必须小于结束时间")) {
                        return true;
                    }return false;
                }
            }
        }
    };
});
