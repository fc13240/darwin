/*! kibana - v3.1.2 - 2015-07-29
 * Copyright (c) 2015 Rashid Khan; Licensed Apache License */

define("panels/derivequeries/module",["angular","app","lodash"],function(a,b,c){"use strict";var d=a.module("kibana.panels.derivequeries",[]);b.useModule(d),d.controller("derivequeries",["$scope",function(a){a.panelMeta={};var b={loading:!1,label:"Search",query:"*",ids:[],field:"_type",fields:[],spyable:!0,rest:!1,size:5,mode:"terms only",exclude:[],history:[],remember:10};c.defaults(a.panel,b),a.init=function(){a.editing=!1}}])});