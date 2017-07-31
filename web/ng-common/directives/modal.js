'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('modal', function () {
    return {
      template: '<div class="modal fade bs-example-modal-lg" id="{{modalId}}" aria-hidden="true">'
			   +'<div class="modal-dialog modal-lg">'
			   +'	<div class="modal-content">'
			   +'		<div class="modal-header">'
			   +'			<button type="button" class="close" data-dismiss="modal" aria-label="Close">'
			   +'<span aria-hidden="true">&times;</span></button>'
			   +'			<h4 class="modal-title">{{ title }}</h4>'
			   +'		</div>'
			   +'		<div class="modal-body" ng-transclude></div>'
			   +'		<div class="modal-footer">'
			   +'			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>'
			   +'		</div>'
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