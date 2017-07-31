'use strict';

/* Directives */


var module = angular.module('userInfo.directives');
  
module.directive('wfStateStat', function() {
    return {
        restrict: 'EA',
        scope: { 
    		wfstatestat: '=',
            url: '@'
    	},
        templateUrl: 'userInfo/partials/wf-state-stat.html',
        replace: true,
        controller: function($scope,$element) {
            $scope.option = {
                title : {
                    text: '共'+$scope.wfstatestat.total+'个处理流程',
                    x:'center'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient : 'vertical',
                    x : 'left',
                    data:['已部署','未部署']
                },
                calculable : false,
                backgroundColor: 'white',
                series : [
                    {
                        name:'流程',
                        type:'pie',
                        radius : '50%',
                        center: ['50%', '70%'],
                        data:[
                            {value:$scope.wfstatestat.wfstatestat.deployed, name:'已部署'},
                            {value:$scope.wfstatestat.wfstatestat.notdeployed, name:'未部署'}
                        ]
                    }
                ]
            };
            require([
                'echarts',
                'echarts/chart/pie'
                ],
                function (ec) {
                    var myChart = ec.init($element.find('.content').get(0));
                    myChart.setOption($scope.option);
                }
            );
    	}
    };
});