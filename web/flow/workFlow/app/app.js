/**
 * main app level module
 */
define([
  'angular',
  'jquery',
  'lodash',
  'angular-cookies'
],
function (angular, appLevelRequire) {

  "use strict";

  var app = angular.module('workflow', []),
    // we will keep a reference to each module defined before boot, so that we can
    // go back and allow it to define new features later. Once we boot, this will be false
    pre_boot_modules = [],
    // these are the functions that we need to call to register different
    // features if we define them after boot time
    register_fns = {};

  /**
   * Tells the application to watch the module, once bootstraping has completed
   * the modules controller, service, etc. functions will be overwritten to register directly
   * with this application.
   * @param  {[type]} module [description]
   * @return {[type]}        [description]
   */
  app.useModule = function (module) {
    if (pre_boot_modules) {
      pre_boot_modules.push(module);
    } else {
      _.extend(module, register_fns);
    }
    return module;
  };

  app.safeApply = function ($scope, fn) {
    switch($scope.$$phase) {
    case '$apply':
      // $digest hasn't started, we should be good
      $scope.$eval(fn);
      break;
    case '$digest':
      // waiting to $apply the changes
      setTimeout(function () { app.safeApply($scope, fn); }, 10);
      break;
    default:
      // clear to begin an $apply $$phase
      $scope.$apply(fn);
      break;
    }
  };

  var apps_deps = [
    'workflow',
    'ngCookies'
  ];

  angular.forEach('controllers directives services filters'.split(' '),
  function (type,key) {
    var module_name = 'workflow.'+type;
    // create the module
    app.useModule(angular.module(module_name, []));
    // push it into the apps dependencies
    apps_deps.push(module_name);
  });

  // load the core components
  require([
	'controllers/all',
	'directives/all',
	'services/all',
   ], function () {

    // bootstrap the app
    angular
      .element(document)
      .ready(function() {
        angular.bootstrap(document, apps_deps)
          .invoke(['$rootScope', function ($rootScope) {
            _.each(pre_boot_modules, function (module) {
              _.extend(module, register_fns);
            });
            pre_boot_modules = false;

            $rootScope.requireContext = appLevelRequire;
            $rootScope.require = function (deps, fn) {
              var $scope = this;
              $scope.requireContext(deps, function () {
                var deps = _.toArray(arguments);
                // Check that this is a valid scope.
                if($scope.$id) {
                  $scope.$apply(function () {
                    fn.apply($scope, deps);
                  });
                }
              });
            };
          }]);
      });
  });

  return app;
});
