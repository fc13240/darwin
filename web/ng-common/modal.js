'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('modal', function () {
    return {
      template: '<div class="modal fade bs-example-modal-lg" id="{{modalId}}" aria-hidden="true">'
			   +'<div class="modal-dialog modal-lg">'
			   +'	<div class="modal-content content">'
			   +'		<div class="modal-header header" >'
			   +'			<button type="button" class="close" data-dismiss="modal" aria-label="Close">'
			   +'<span aria-hidden="true">&times;</span></button>'
			   +'			<h4 class="modal-title">{{ title }}</h4>'
			   +'		</div>'
			   +'		<div class="modal-body" ng-transclude></div>'
			   +'		<div class="modal-footer">'
         +'   <div style="margin-right:80px" >'
			   +'			<button id="saveOne" type="button" class="btn btn-primary" data-dismiss="modal" ng-click="close();">保存</button>'
			   +'		</div>'
         +'   </div>'
			   +'	</div>'
			   +'</div>'
			   +'</div>',
      restrict: 'E',
      transclude: true,
      replace:true,
      scope:true,
      link: function postLink(scope, element, attrs) {
        scope.title = attrs.modaltitle;
        scope.modalId = attrs.modalid;
        $(element).modal({
            keyboard:true,
            backdrop: 'static',
            show: false
        });
      }
    };
  });