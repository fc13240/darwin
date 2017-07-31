define.amd.jQuery = true;
require.config({
    baseUrl: 'workFlow/app',
    paths:{
        config:                   '../config',
        settings:                 './components/settings',
        css:                      '../vendor/require/css',
        text:                     '../vendor/require/text',
        'angular':                '../vendor/angular/angular',
        'angular-cookies':        '../vendor/angular/angular-cookies',
        
        'jquery':                 '../vendor/jquery/jquery-1.9.1',
        'jquery-ui':              '../vendor/jquery/jquery-ui',
        'popupSmallMenu':         '../vendor/popupsmallmenu/jquery.popupSmallMenu',
        
        lodash:                   'components/lodash.extended',
        'lodash-src':             '../vendor/lodash',
        
        'sco.message':            '../vendor/sco/sco.message',
        
        'raphael':                '../vendor/raphael/raphael',
        'raphael-json':           '../vendor/raphael/raphael.json',
        'raphael-connection':     '../vendor/raphael/raphael.connection',
    },
    shim:{
        'angular':{
            exports:'angular'
        },
        
        'angular-cookies':         ['angular'],
        
        'raphael-json':            ['raphael'],
        'raphael-connection':      ['raphael'],
        
        'sco.message':             ['jquery']
    },
    waitSeconds: 200,
    urlArgs: "version=v1.0.0.3"
});
require(['app'], function () {})