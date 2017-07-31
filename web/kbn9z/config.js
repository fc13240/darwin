/** @scratch /configuration/config.js/1
 *
 * == Configuration
 * config.js is where you will find the core Kibana configuration. This file contains parameter that
 * must be set before kibana is run for the first time.
 */
define(['settings'],
function (Settings) {
  "use strict";

  /** @scratch /configuration/config.js/2
   *
   * === Parameters
   */
  return new Settings({

    /** @scratch /configuration/config.js/5
     *
     * ==== elasticsearch
     *
     * The URL to your elasticsearch server. You almost certainly don't
     * want +http://localhost:9200+ here. Even if Kibana and Elasticsearch are on
     * the same host. By default this will attempt to reach ES at the same host you have
     * kibana installed on. You probably want to set it to the FQDN of your
     * elasticsearch host
     *
     * Note: this can also be an object if you want to pass options to the http client. For example:
     *
     *  +elasticsearch: {server: "http://localhost:9200", withCredentials: true}+
     *
     */
//    elasticsearch: "http://192.168.2.120:9200",
//	  elasticsearch: "http://192.168.2.50:8000/proxy/index.jsp?_tag=1",
    elasticsearch: "http://"+window.location.host+"/proxy/index.jsp?_tag=1",
    
    user_index        : '/es?method=esIndexSearchList',
    get_user_url	  : '/manage/user?method=getUid',

    /** @scratch /configuration/config.js/5
     *
     * ==== default_route
     *
     * This is the default landing page when you don't specify a dashboard to load. You can specify
     * files, scripts or saved dashboards here. For example, if you had saved a dashboard called
     * `WebLogs' to elasticsearch you might use:
     *
     * default_route: '/dashboard/elasticsearch/WebLogs',
     */
    default_route     : '/dashboard/file/blank.json',

    /** @scratch /configuration/config.js/5
     *
     * ==== kibana-int
     *
     * The default ES index to use for storing Kibana specific object
     * such as stored dashboards
     */
    kibana_index: "search-int",

    /** @scratch /configuration/config.js/5
     *
     * ==== panel_name
     *
     * An array of panel modules available. Panels will only be loaded when they are defined in the
     * dashboard, but this list is used in the "add panel" interface.
     */
    panel_names: {
      'histogram': '时间柱状图',
	  'linechart': '折线图',
      'map': '地图(中国/世界)',
//      'emap',
//      'marklinemap',
      'trend': '趋势图',
      'goal': '目标',
      'table': '列表',
      'filtering': 'filtering',
      'timepicker': 'timepicker',
      'text': '文字',
      'hits': '计数/多检索分组计数',
      'column': 'column',
      'trends': '环比分析图',
      'bettermap': 'bettermap',
      'query': 'query',
      'terms': '分组统计数据展示',
      'stats': 'stats',
      'sparklines': '微缩趋势图'
    },
    
    hidden_panels: [
      'bettermap',
      'column',
      'stats',
      'goal'
    ],
    
    panel_description: {
      'histogram': '时间序列显示事件发生的情况',
      'map': '地图',
      'trend': '趋势图',
      'goal': '用饼图显示目标完成情况',
      'table': '分页表格显示查询结果',
      'filtering': 'filtering',
      'timepicker': 'timepicker',
      'text': '文字面板',
      'hits': '对计数结果的显示',
      'column': 'column',
      'trends': '环比，相邻时间段的对比',
      'bettermap': 'bettermap',
      'query': 'query',
      'terms': '按分词的分组统计',
      'stats': 'stats',
      'sparklines': '迷你图'
    }
  });
});
