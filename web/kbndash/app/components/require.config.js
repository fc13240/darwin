/*! kibana - v3.1.2 - 2015-07-28
 * Copyright (c) 2015 Rashid Khan; Licensed Apache License */

require.config({baseUrl:"app",urlArgs:"version=2",paths:{config:"../config",settings:"components/settings",kbn:"components/kbn",vendor:"../vendor",css:"../vendor/require/css",text:"../vendor/require/text",moment:"../vendor/moment",blob:"../vendor/blob",filesaver:"../vendor/filesaver",chromath:"../vendor/chromath",angular:"../vendor/angular/angular","angular-cookies":"../vendor/angular/angular-cookies","angular-dragdrop":"../vendor/angular/angular-dragdrop","angular-strap":"../vendor/angular/angular-strap","angular-sanitize":"../vendor/angular/angular-sanitize",timepicker:"../vendor/angular/timepicker",datepicker:"../vendor/angular/datepicker",bindonce:"../vendor/angular/bindonce","checklist-model":"../vendor/angular/checklist-model","angular-ui-grid":"../vendor/angular/ui-grid/ng-grid.min",lodash:"components/lodash.extended","lodash-src":"../vendor/lodash",bootstrap:"../vendor/bootstrap/bootstrap",jquery:"../vendor/jquery/jquery-1.8.0","jquery-ui":"../vendor/jquery/jquery-ui-1.10.3","extend-jquery":"components/extend-jquery","jquery.flot":"../vendor/jquery/jquery.flot","jquery.flot.pie":"../vendor/jquery/jquery.flot.pie","jquery.flot.events":"../vendor/jquery/jquery.flot.events","jquery.flot.selection":"../vendor/jquery/jquery.flot.selection","jquery.flot.stack":"../vendor/jquery/jquery.flot.stack","jquery.flot.stackpercent":"../vendor/jquery/jquery.flot.stackpercent","jquery.flot.time":"../vendor/jquery/jquery.flot.time","jquery.flot.byte":"../vendor/jquery/jquery.flot.byte",modernizr:"../vendor/modernizr-2.6.1",numeral:"../vendor/numeral",jsonpath:"../vendor/jsonpath",elasticjs:"../vendor/elasticjs/elastic-angular-client",elasticsearch:"../vendor/elasticjs/elasticsearch.angular.min",echarts:"../vendor/echart/echarts-all"},shim:{angular:{deps:["jquery","config"],exports:"angular"},bootstrap:{deps:["jquery"]},modernizr:{exports:"Modernizr"},jsonpath:{exports:"jsonPath"},jquery:{exports:"jQuery"},"jquery-ui":["jquery"],"jquery.flot":["jquery"],"jquery.flot.byte":["jquery","jquery.flot"],"jquery.flot.pie":["jquery","jquery.flot"],"jquery.flot.events":["jquery","jquery.flot"],"jquery.flot.selection":["jquery","jquery.flot"],"jquery.flot.stack":["jquery","jquery.flot"],"jquery.flot.stackpercent":["jquery","jquery.flot"],"jquery.flot.time":["jquery","jquery.flot"],"angular-sanitize":["angular"],"angular-cookies":["angular"],"angular-dragdrop":["jquery","jquery-ui","angular"],"angular-loader":["angular"],"angular-mocks":["angular"],"angular-resource":["angular"],"angular-route":["angular"],"angular-touch":["angular"],bindonce:["angular"],"checklist-model":["angular"],"angular-strap":["angular","bootstrap","timepicker","datepicker"],"angular-ui-grid":["jquery","angular"],timepicker:["jquery","bootstrap"],datepicker:["jquery","bootstrap"],elasticjs:["angular","../vendor/elasticjs/elastic"],elasticsearch:["angular"]},waitSeconds:60});