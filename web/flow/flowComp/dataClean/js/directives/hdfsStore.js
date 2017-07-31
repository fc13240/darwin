'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('hdfsStore', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'dataClean/partials/hdfs-store.html',
        replace: true,
        controller: function($scope, $element, $compile, cleancompConfig) {
    		var self = this;
      		$scope.datatypeitems = [
      		                        {type:'text', name:'文本'}
      		                       // {type:'gzip', name:'gzip文件'},
      		                       //{type:'binary', name:'二进制'}
      		                        ];
      		$scope.outrowfilters = [
      		                        {value:'yes', text:'条件输出'},
      		                        {value:'no', text:'全部输出'}
      		                        ];
      		//>/</=/>=/<=/d>/d</d=/d>=/d<=/isnull/notnull/contain/notcontain/
      		$scope.outrowops = [
      		                     {value:'>',text:'大于'},
      		                     {value:'<',text:'小于'},
      		                     {value:'=',text:'等于'},
      		                     {value:'<>',text:'不等于'},
      		                     {value:'>=',text:'大于且等于'},
      		                     {value:'<=',text:'小于且等于'},
//      		                     {value:'d>',text:'数值大于'},
//      		                  	 {value:'d<',text:'数值小于'},
//      		                  	 {value:'d=',text:'数值等于'},
//      		                  	 {value:'d>=',text:'数值大于等于'},
//      		                  	 {value:'d<=',text:'数值小于等于'},
      		                  	 {value:'isnull',text:'为空'},
      		                  	 {value:'notnull',text:'不为空'},
      		                  	 {value:'contain',text:'包含'},
      		                  	 {value:'notcontain',text:'不包含'},
      		                  	 {value:'startWith',text:'以值开头'},
      		                  	 {value:'notStartWith',text:'不以值开头'},
      		                  	 {value:'endWith',text:'以值结尾'},
      		                  	 {value:'notEndWith',text:'不以值结尾'}
      		                    ];


      		
      		//上移
      		$scope.upOneStore=function(getindex){
            var index=$($element).find("#storeinfo-outcols-selected"+getindex).get(0).selectedIndex
            if (index > 0) {
            var beforeRow = cleancompConfig.config.storeinfo[getindex].outCols[index-1];
            var currentRow = cleancompConfig.config.storeinfo[getindex].outCols[index];
            cleancompConfig.config.storeinfo[getindex].outCols.splice(index-1,2,currentRow,beforeRow);
            } 

      		}

          //下移
          $scope.downOneStore=function(getindex){
            var index=$($element).find("#storeinfo-outcols-selected"+getindex).get(0).selectedIndex
            if (index < $scope.storeinfo.outCols.length-1) {
              var behindRow = cleancompConfig.config.storeinfo[getindex].outCols[index+1];
              var currentRow = cleancompConfig.config.storeinfo[getindex].outCols[index];
              cleancompConfig.config.storeinfo[getindex].outCols.splice(index,2,behindRow,currentRow);
            }
            
          }


          //验证输出配置里面条件输出
          //需要验证的值
          $scope.validatekey=[
               'startWith',
               'notStartWith',
               'endWith',
               'notEndWith'
          ]
          //验证
          $scope.validateValue=function(index){
                var value=$("#storeinfo-filter-op"+index).val();
                if ($.inArray(value, $scope.validatekey)>=0) {
                      $("#storeinfo-filter-value"+index).attr("data-rule","required");
                      $("#storeinfo-filter-value"+index).removeAttr("novalidate","novalidate");
                }else{
                      $(".msg-wrap").remove();
                      $("#storeinfo-filter-value"+index).attr("novalidate","novalidate");    
                };
          }
      		
      		

      		$scope.getAllCols = function() {
      			var cols = [];
      			angular.forEach(cleancompConfig.config.inputinfo, function(v,i){
      				angular.forEach(v.colDetail, function(col,j){
      					cols.push(v.dataName+"."+col.name);
      				});
      			});
      			angular.forEach(cleancompConfig.config.config.vcol, function(v,i){
      				cols.push(v.data+'.'+v.colName);
      			});
      			return cols;
      		};
      		$scope.addStoreFilter = function(index) {
            var value=$("#storeinfo-filter-op"+index).val();
            if ($.inArray(value, $scope.validatekey)<0) {
                var filter = {colname:'',cond:'',val:''};
                filter.colname = $('#storeinfo-filter-left'+index).val();
                filter.cond = $('#storeinfo-filter-op'+index).val();
                filter.val = $('#storeinfo-filter-value'+index).val();
                $scope.storeinfos[index].rowfilterDetail.push(filter);
            }else{
              $('#storeinfo-filter-value'+index).isValid(function(v){
                  if(v){
                    var filter = {colname:'',cond:'',val:''};
                    filter.colname = $('#storeinfo-filter-left'+index).val();
                    filter.cond = $('#storeinfo-filter-op'+index).val();
                    filter.val = $('#storeinfo-filter-value'+index).val();
                    $scope.storeinfos[index].rowfilterDetail.push(filter);
                  }else {
                    return;
                  }
                  
              });
            };
      			
      		};
      		$scope.removeStoreFilter = function(index) {
      			$.each($('#storeinfo-filter-selected'+index).find('option:selected'), function(i,v){
					$scope.storeinfos[index].rowfilterDetail.splice($(v).val(),1);
				});
      		};
      		$scope.addOutCols = function(index) {
      			if ($.inArray($('#storeinfo-outcols-'+index).val(),$scope.storeinfos[index].outCols) ==-1) {
            		$scope.storeinfos[index].outCols.push($('#storeinfo-outcols-'+index).val());
            	}
      		};
			//全部添加到输出
            $scope.addAllOutCols = function(index) {
				$.each($('#storeinfo-outcols-'+index+' option'),function(i,v){
					if ($.inArray($(v).val(),$scope.storeinfos[index].outCols) ==-1) {
						$scope.storeinfos[index].outCols.push($(v).val());
					}
				});
      		};
	        //移除所有的
            $scope.removeAllOutCols=function(index){
		  // $('#storeinfo-outcols-selected'+index+' option').empty();
              $.each($('#storeinfo-outcols-selected'+index+' option'), function(i,v){
                  $scope.storeinfos[index].outCols.splice($(v),1);
              });
		}

		$scope.removeOutCols = function(colIndex) {
			$.each($('#storeinfo-outcols-selected'+colIndex).find('option:selected'), function(i,v){
				$scope.storeinfos[colIndex].outCols.splice($(v).index(),1);
			});
		};
            $scope.addSortCols = function(index) {
                  if ($scope.storeinfos[index].sort=== undefined) {
                    $scope.storeinfos[index].sort = {'cols':[],'order':'desc'}
                  }
                  $scope.storeinfos[index].sort.cols.push($('#storeinfo-sortcols-'+index).val());

            		};
            		$scope.removeSortCols = function(colIndex) {
            			$.each($('#storeinfo-sortcols-selected'+colIndex).find('option:selected'), function(i,v){
            				$scope.storeinfos[colIndex].sort.cols.splice($(v).index(),1);
            			});
            		};
            $scope.allOrders = [{text:'升序',value:'asc'},{text:'降序',value:'desc'}];
      		$scope.storeinfoFilter = [];
        }
    };
});
