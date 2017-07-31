/*! kibana - v3.1.2 - 2015-07-29
 * Copyright (c) 2015 Rashid Khan; Licensed Apache License */

define("panels/fields/module",["angular","app","lodash"],function(a,b,c){"use strict";var d=a.module("kibana.panels.fields",[]);b.useModule(d),d.controller("fields",["$scope",function(a){a.panelMeta={};var b={style:{},arrange:"vertical",micropanel_position:"right"};c.defaults(a.panel,b),a.init=function(){}}])});