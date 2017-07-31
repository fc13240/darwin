'use strict';


// Declare app level module which depends on filters, and services
angular.module('userInfo.directives', []);
angular.module('userInfo.services', []);
angular.module('userInfo.filters', []);
angular.module('userInfo.controllers', []);
angular.module('userInfo', [
  'userInfo.filters',
  'userInfo.services',
  'userInfo.directives',
  'userInfo.controllers'
]);