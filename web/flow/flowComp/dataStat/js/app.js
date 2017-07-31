'use strict';

// Declare app level module which depends on filters, and services
angular.module('comp.directives', []);
angular.module('comp.services', []);
angular.module('comp.controllers', []);
angular.module('comp', [
  'comp.services',
  'comp.directives',
  'comp.controllers'
]);