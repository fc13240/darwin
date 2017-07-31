define(['angular'],
function (_) {
  "use strict";

  return function Settings (options) {
    var defaults = {
        base_url:'',
        refrash_time:60000,
        flow_comp_delete_url:'',
        check_comp_can_delete_url:'',
		flow_save_url:'',
		flow_save_data:function(data){return {}},
        comp_data_from:'url',//组件数据来源 url, data
        comp_load_url:'flow.json',
        comp_load_data:function(){return '';},
        comp_config_url:'',
        graph_template:function(){
      		var _template = '<div id="graph<%=data.comp%>" class="graph"'
    			+'data-id="<%=data.comp%>" graph-type="<%=data.type%>" style="left:<%=data.x%>px; top:<%=data.y%>px">'
    			+'<div class="title"><img onerror="this.src=\'img/rose.png\'" src="/resources/site/img/comp-<%=data.type%>.png"/></div>'
    			+'<div class="content"><%=data.compName%></div>'
    			+'</div>';
    		return _template;
      	},
      	get_state:function() {
      		return false;
      	 },
    	get_content_menu:function(){
    		var menu = [
    		  {
		    	  name:'编辑',
		    	  icon:'edit'
		      },
		      {
		    	  name:'删除',
		    	  icon:'delete'
		      },
		      {
		    	  name:'删除关联',
		    	  icon:'deletelink'
		      }
		  ];
		  return menu;
	  }
    };

    var settings = {};
    angular.forEach(defaults, function(value, key) {
      settings[key] = typeof options[key] !== 'undefined' ? options[key]  : defaults[key];
    });

    return settings;
  };
});
