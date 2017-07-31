
define(['settings'],
function (Settings) {
  "use strict";

  return new Settings({
	  
	  base_url:'workFlow/',
	  refrash_time:60000,//单位毫秒
	  flow_comp_delete_url:'/flow?method=ajaxDelete&flowCompId=<%=data.compId%>',
	  check_comp_can_delete_url:'',
	  flow_save_url:'/flow?method=ajaxSave',
	  flow_state:'/flow?method=ajaxDeleteLine',
	  flow_save_data:function(data){
	  	var tmp = {};
	  	tmp['config'] = data;
	  	tmp['type'] = document.getElementById('type')!=null?document.getElementById('type').value:"";
	  	tmp['name'] = document.getElementById('flowName')!=null?document.getElementById('flowName').value:"";
	  	tmp['projectId'] = document.getElementById('projectId')!=null?document.getElementById('projectId').value:"";
	  	tmp['flowId'] = document.getElementById('flowId')!=null?document.getElementById('flowId').value:"";
	  	tmp['periodType'] = document.getElementById('periodType')!=null?document.getElementById('periodType').value:"";
	  	tmp['cronValue'] = document.getElementById('cronValue')!=null?document.getElementById('cronValue').value:"";
	  	return tmp;
  	  },
	  comp_data_from:'data',//组件数据来源 url, data
	  comp_load_url:'flow.json',
	  comp_load_data:function(){
	  	  var data = document.getElementById('config')!=null?document.getElementById('config').innerHTML:'';
	  	  
	  	  return data;
  		 
  	  },
	  comp_config_url:'/flow/flowComp/conf.jsp?type=<%=data.type%>&compId=<%=data.compId%>',
	  graph_template:function(activated){
  		var _template = '<div id="graph<%=data.comp%>" class="graph"'
			+'data-id="<%=data.comp%>" graph-type="<%=data.type%>" style="left:<%=data.x%>px; top:<%=data.y%>px">'
			+'<div class="title" style="float: left; width: 88px;"><img title="双击组件可进行关联" onerror="this.src=\'img/rose.png\'" style="width: 71px;height: 60px;" src="/resources/site/img/comp-<%=data.type%>.png"/></div>'
			+'<div class="content" title="<%=data.compName%>" style="float: left; word-break: break-all; width: 70px;height: 60px;overflow: hidden;">';
  			if (activated === true || activated === "true") {
  			  _template+='<input type="checkbox" class="css-checkbox" id="checkbox<%=data.comp%>" checked="checked"/>';
	          if (this.get_state()===true||this.get_state()==="true") {
	             _template += '<label for="checkbox<%=data.comp%>" name="checkbox1_lbl" class="css-label lite-disabled"></label>';
	          }else{
	             _template += '<label for="checkbox<%=data.comp%>" name="checkbox1_lbl" class="css-label lite-check"></label>';
	          };
  			}else {
  			  _template+='<input type="checkbox" class="css-checkbox" id="checkbox<%=data.comp%>"/>';
	          if (this.get_state()===true||this.get_state()==="true") {
	            _template += '<label for="checkbox<%=data.comp%>" name="checkbox1_lbl" class="css-label lite-disabled"></label>';
	          }else{
	            _template += '<label for="checkbox<%=data.comp%>" name="checkbox1_lbl" class="css-label lite-check"></label>';
	          };
  			}	
			_template+='<%=data.compName%></div>'
			
		return _template;
  	  },
  	  get_state:function() {
  		var disabled = document.getElementById('flow_disabled')!=null?document.getElementById('flow_disabled').value:false;
  		return disabled;
  	  },
  	  get_content_menu:function(){
        
  		  var state = this.get_state()==="true" || this.get_state()===true?true:false;
  		  var menu = [
  		      {
  		    	  name:'编辑',
  		    	  icon:'edit',
  		    	  show:state?false:true
  		      },
  		      {
  		    	  name:'查看配置',
  		    	  icon:'view',
  		    	  show:state?true:false
  		      },
  		      {
  		    	  name:'查看数据',
  		    	  icon:'viewdata',
  		    	  url:'/flow/flowComp/viewData.jsp?type=<%=data.type%>&compId=<%=data.compId%>',
  		    	  show:true
  		      },
  		      {
  		    	  name:'删除',
  		    	  icon:'delete',
  		    	  show:state?false:true
  		      },
  		      {
  		    	  name:'删除关联',
  		    	  icon:'deletelink',
  		    	  show:state?false:true
  		      }
  		  ];
  		  return menu;
  	  }
  });
});
