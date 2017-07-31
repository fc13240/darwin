'use strict';


// Declare app level module which depends on filters, and services
angular.module('comp.directives', []);
angular.module('comp.services', []);
angular.module('comp.filters', []);
angular.module('comp.controllers', []);
angular.module('comp', [
  'comp.filters',
  'comp.services',
  'comp.directives',
  'comp.controllers',
  'ui.bootstrap'
]);