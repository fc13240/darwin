/*! kibana - v3.1.2 - 2015-12-28
 * Copyright (c) 2015 Rashid Khan; Licensed Apache License */

function jsonPath(obj,expr,arg){var P={resultType:arg&&arg.resultType||"VALUE",result:[],normalize:function(a){var b=[];return a.replace(/[\['](\??\(.*?\))[\]']/g,function(a,c){return"[#"+(b.push(c)-1)+"]"}).replace(/'?\.'?|\['?/g,";").replace(/;;;|;;/g,";..;").replace(/;$|'?\]|'$/g,"").replace(/#([0-9]+)/g,function(a,c){return b[c]})},asPath:function(a){for(var b=a.split(";"),c="$",d=1,e=b.length;e>d;d++)c+=/^[0-9*]+$/.test(b[d])?"["+b[d]+"]":"['"+b[d]+"']";return c},store:function(a,b){return a&&(P.result[P.result.length]="PATH"==P.resultType?P.asPath(a):b),!!a},trace:function(a,b,c){if(a){var d=a.split(";"),e=d.shift();if(d=d.join(";"),b&&b.hasOwnProperty(e))P.trace(d,b[e],c+";"+e);else if("*"===e)P.walk(e,d,b,c,function(a,b,c,d,e){P.trace(a+";"+c,d,e)});else if(".."===e)P.trace(d,b,c),P.walk(e,d,b,c,function(a,b,c,d,e){"object"==typeof d[a]&&P.trace("..;"+c,d[a],e+";"+a)});else if(/,/.test(e))for(var f=e.split(/'?,'?/),g=0,h=f.length;h>g;g++)P.trace(f[g]+";"+d,b,c);else/^\(.*?\)$/.test(e)?P.trace(P.eval(e,b,c.substr(c.lastIndexOf(";")+1))+";"+d,b,c):/^\?\(.*?\)$/.test(e)?P.walk(e,d,b,c,function(a,b,c,d,e){P.eval(b.replace(/^\?\((.*?)\)$/,"$1"),d[a],a)&&P.trace(a+";"+c,d,e)}):/^(-?[0-9]*):(-?[0-9]*):?([0-9]*)$/.test(e)&&P.slice(e,d,b,c)}else P.store(c,b)},walk:function(a,b,c,d,e){if(c instanceof Array)for(var f=0,g=c.length;g>f;f++)f in c&&e(f,a,b,c,d);else if("object"==typeof c)for(var h in c)c.hasOwnProperty(h)&&e(h,a,b,c,d)},slice:function(a,b,c,d){if(c instanceof Array){var e=c.length,f=0,g=e,h=1;a.replace(/^(-?[0-9]*):(-?[0-9]*):?(-?[0-9]*)$/g,function(a,b,c,d){f=parseInt(b||f),g=parseInt(c||g),h=parseInt(d||h)}),f=0>f?Math.max(0,f+e):Math.min(e,f),g=0>g?Math.max(0,g+e):Math.min(e,g);for(var i=f;g>i;i+=h)P.trace(i+";"+b,c,d)}},eval:function(x,_v,_vname){try{return $&&_v&&eval(x.replace(/@/g,"_v"))}catch(e){throw new SyntaxError("jsonPath: "+e.message+": "+x.replace(/@/g,"_v").replace(/\^/g,"_a"))}}},$=obj;return expr&&obj&&("VALUE"==P.resultType||"PATH"==P.resultType)?(P.trace(P.normalize(expr).replace(/^\$;/,""),obj,"$"),P.result.length?P.result:!1):void 0}define("jsonpath",function(a){return function(){var b;return b||a.jsonPath}}(this)),function(a){"use strict";if(a.URL=a.URL||a.webkitURL,a.Blob&&a.URL)try{return void new Blob}catch(b){}var c=a.BlobBuilder||a.WebKitBlobBuilder||a.MozBlobBuilder||function(a){var b=function(a){return Object.prototype.toString.call(a).match(/^\[object\s(.*)\]$/)[1]},c=function(){this.data=[]},d=function(a,b,c){this.data=a,this.size=a.length,this.type=b,this.encoding=c},e=c.prototype,f=d.prototype,g=a.FileReaderSync,h=function(a){this.code=this[this.name=a]},i="NOT_FOUND_ERR SECURITY_ERR ABORT_ERR NOT_READABLE_ERR ENCODING_ERR NO_MODIFICATION_ALLOWED_ERR INVALID_STATE_ERR SYNTAX_ERR".split(" "),j=i.length,k=a.URL||a.webkitURL||a,l=k.createObjectURL,m=k.revokeObjectURL,n=k,o=a.btoa,p=a.atob,q=a.ArrayBuffer,r=a.Uint8Array,s=/^[\w-]+:\/*\[?[\w\.:-]+\]?(?::[0-9]+)?/;for(d.fake=f.fake=!0;j--;)h.prototype[i[j]]=j+1;return k.createObjectURL||(n=a.URL=function(a){var b,c=document.createElementNS("http://www.w3.org/1999/xhtml","a");return c.href=a,"origin"in c||("data:"===c.protocol.toLowerCase()?c.origin=null:(b=a.match(s),c.origin=b&&b[1])),c}),n.createObjectURL=function(a){var b,c=a.type;return null===c&&(c="application/octet-stream"),a instanceof d?(b="data:"+c,"base64"===a.encoding?b+";base64,"+a.data:"URI"===a.encoding?b+","+decodeURIComponent(a.data):o?b+";base64,"+o(a.data):b+","+encodeURIComponent(a.data)):l?l.call(k,a):void 0},n.revokeObjectURL=function(a){"data:"!==a.substring(0,5)&&m&&m.call(k,a)},e.append=function(a){var c=this.data;if(r&&(a instanceof q||a instanceof r)){for(var e="",f=new r(a),i=0,j=f.length;j>i;i++)e+=String.fromCharCode(f[i]);c.push(e)}else if("Blob"===b(a)||"File"===b(a)){if(!g)throw new h("NOT_READABLE_ERR");var k=new g;c.push(k.readAsBinaryString(a))}else a instanceof d?"base64"===a.encoding&&p?c.push(p(a.data)):"URI"===a.encoding?c.push(decodeURIComponent(a.data)):"raw"===a.encoding&&c.push(a.data):("string"!=typeof a&&(a+=""),c.push(unescape(encodeURIComponent(a))))},e.getBlob=function(a){return arguments.length||(a=null),new d(this.data.join(""),a,"raw")},e.toString=function(){return"[object BlobBuilder]"},f.slice=function(a,b,c){var e=arguments.length;return 3>e&&(c=null),new d(this.data.slice(a,e>1?b:this.data.length),c,this.encoding)},f.toString=function(){return"[object Blob]"},f.close=function(){this.size=0,delete this.data},c}(a);a.Blob=function(a,b){var d=b?b.type||"":"",e=new c;if(a)for(var f=0,g=a.length;g>f;f++)e.append(a[f]);return e.getBlob(d)}}("undefined"!=typeof self&&self||"undefined"!=typeof window&&window||this.content||this),define("panels/table/lib/Blob",function(){});var saveAs=saveAs||"undefined"!=typeof navigator&&navigator.msSaveOrOpenBlob&&navigator.msSaveOrOpenBlob.bind(navigator)||function(a){"use strict";if("undefined"==typeof navigator||!/MSIE [1-9]\./.test(navigator.userAgent)){var b=a.document,c=function(){return a.URL||a.webkitURL||a},d=b.createElementNS("http://www.w3.org/1999/xhtml","a"),e="download"in d,f=function(c){var d=b.createEvent("MouseEvents");d.initMouseEvent("click",!0,!1,a,0,0,0,0,0,!1,!1,!1,!1,0,null),c.dispatchEvent(d)},g=a.webkitRequestFileSystem,h=a.requestFileSystem||g||a.mozRequestFileSystem,i=function(b){(a.setImmediate||a.setTimeout)(function(){throw b},0)},j="application/octet-stream",k=0,l=10,m=function(b){var d=function(){"string"==typeof b?c().revokeObjectURL(b):b.remove()};a.chrome?d():setTimeout(d,l)},n=function(a,b,c){b=[].concat(b);for(var d=b.length;d--;){var e=a["on"+b[d]];if("function"==typeof e)try{e.call(a,c||a)}catch(f){i(f)}}},o=function(b,i){var l,o,p,q=this,r=b.type,s=!1,t=function(){n(q,"writestart progress write writeend".split(" "))},u=function(){if((s||!l)&&(l=c().createObjectURL(b)),o)o.location.href=l;else{var d=a.open(l,"_blank");void 0==d&&"undefined"!=typeof safari&&(a.location.href=l)}q.readyState=q.DONE,t(),m(l)},v=function(a){return function(){return q.readyState!==q.DONE?a.apply(this,arguments):void 0}},w={create:!0,exclusive:!1};return q.readyState=q.INIT,i||(i="download"),e?(l=c().createObjectURL(b),d.href=l,d.download=i,f(d),q.readyState=q.DONE,t(),void m(l)):(a.chrome&&r&&r!==j&&(p=b.slice||b.webkitSlice,b=p.call(b,0,b.size,j),s=!0),g&&"download"!==i&&(i+=".download"),(r===j||g)&&(o=a),h?(k+=b.size,void h(a.TEMPORARY,k,v(function(a){a.root.getDirectory("saved",w,v(function(a){var c=function(){a.getFile(i,w,v(function(a){a.createWriter(v(function(c){c.onwriteend=function(b){o.location.href=a.toURL(),q.readyState=q.DONE,n(q,"writeend",b),m(a)},c.onerror=function(){var a=c.error;a.code!==a.ABORT_ERR&&u()},"writestart progress write abort".split(" ").forEach(function(a){c["on"+a]=q["on"+a]}),c.write(b),q.abort=function(){c.abort(),q.readyState=q.DONE},q.readyState=q.WRITING}),u)}),u)};a.getFile(i,{create:!1},v(function(a){a.remove(),c()}),v(function(a){a.code===a.NOT_FOUND_ERR?c():u()}))}),u)}),u)):void u())},p=o.prototype,q=function(a,b){return new o(a,b)};return p.abort=function(){var a=this;a.readyState=a.DONE,n(a,"abort")},p.readyState=p.INIT=0,p.WRITING=1,p.DONE=2,p.error=p.onwritestart=p.onprogress=p.onwrite=p.onabort=p.onerror=p.onwriteend=null,q}}("undefined"!=typeof self&&self||"undefined"!=typeof window&&window||this.content);"undefined"!=typeof module&&null!==module?module.exports=saveAs:"undefined"!=typeof define&&null!==define&&null!=define.amd&&define("panels/table/lib/FileSaver",[],function(){return saveAs}),function(a){"use strict";var b=(String.fromCharCode,function(){try{document.createElement("$")}catch(a){return a}}(),function(a){var b=a.textContent||a.innerText;return null==b?"":b.replace(/^\s*(.*?)\s+$/,"$1")});a.tableExport=function(c,d,e){e=e.toLowerCase()||"";var f=a.document,g=f.getElementById(c),h=f.characterSet,i={json:"application/json;charset="+h,txt:"csv/txt;charset="+h,csv:"csv/txt;charset="+h,doc:"application/vnd.ms-doc",excel:"application/vnd.ms-excel"},j=function(a,b){return a.replace(/{(\w+)}/g,function(a,c){return b[c]})},k=function(){return a.Blob},l=function(a){var b=a,c=-1!==a.indexOf(",")||-1!==a.indexOf("\r")||-1!==a.indexOf("\n"),d=-1!==a.indexOf('"');return d&&(b=b.replace(/"/g,'""')),(c||d)&&(b='"'+b+'"'),b},m=function(a){var b=k();saveAs(new b([a],{type:i[e]}),d+"."+e)},n=function(){for(var a,c="\ufeff",d=0;a=g.rows[d];d++){for(var e,f=0;e=a.cells[f];f++)c=c+(f?",":"")+l(b(e));c+="\r\n"}m(c)},o=function(){var a=[];if(g.tHead)for(var c,d=0;c=g.tHead.rows[0].cells[d];d++)a.push(b(c));var e=[];if(g.tBodies)for(var f,h=0;f=g.tBodies[h];h++)for(var i,j=0;i=f.rows[j];j++){var k=e.length;e[k]=[];for(var l,n=0;l=i.cells[n];n++)e[k].push(b(l))}var o={header:a,data:e};m(JSON.stringify(o))},p=function(){var a="excel";switch(e){case"xls":a="excel";break;default:a="excel"}var c='<html xmlns:x="urn:schemas-microsoft-com:office:'+a+'">';c+='<head><meta charset="'+h+'" /><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>',c+="{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->",c+="</head><body><table>{table}</table></body></html>";for(var d,f="",i=[["<thead><tr>","</tr></thead>"],["<tbody><tr>","</tr></tbody>"],["<tr>","</tr>"]],k=[["<th>","</th>"],["<td>","</td>"]],l=+!g.tHead,n=1-l,o=0;d=g.rows[o];o++){if(l=o>n?2:l,f+=i[l][0],"none"!==d.style.display)for(var p,q=0;p=d.cells[q];q++)if("none"!==p.style.display){var r=p.children,s="";if(0!==r.length)for(var t,u=0;t=r[u];u++)"none"!==t.style.display&&(s+=b(t));else s=b(p);f+=k[+!!l][0]+s+k[+!!l][1]}f+=i[l][1],l++}m(j(c,{worksheet:"Worksheet",table:f}))},q={json:o,txt:n,csv:n,doc:p,docx:p,xls:p,xlsx:p};q[e]()}}(window),define("panels/table/lib/tableExport",function(){}),define("panels/table/module",["angular","app","lodash","kbn","moment","jsonpath","./lib/Blob","./lib/FileSaver","./lib/tableExport"],function(a,b,c,d,e){"use strict";var f=a.module("kibana.panels.table",[]);b.useModule(f),f.controller("table",["$rootScope","$scope","$modal","$q","$compile","$timeout","fields","querySrv","dashboard","filterSrv","$filter","backendSrv","$http",function(b,f,g,h,i,j,k,l,m,n,o,p,q){f.dictionaryInfo=m.current.filed_dic.dictionaryInfo,f.panelMeta={modals:[{description:"检查",icon:"icon-info-sign",partial:"app/partials/inspector.html",show:f.panel.spyable}],editorTabs:[{title:"分页控制设置",src:"app/panels/table/pagination.html"}]};var r={isFilter:!1,localFilter:"",size:100,pages:5,offset:0,sort:["_score","desc"],overflow:"min-height",fields:[],highlight:["*"],sortable:!0,header:!0,paging:!0,field_list:!0,all_fields:!1,range:"center",rangeUnit:"minute",timeRange:"10",trimFactor:300,localTime:!1,timeField:"@timestamp",spyable:!0,exportable:!0,queries:{mode:"all",ids:[]},style:{"font-size":"9pt"},normTimes:!0};c.defaults(f.panel,r),f.init=function(){f.columns={},c.each(f.panel.fields,function(a){f.columns[a]=!0}),f.Math=Math,f.identity=a.identity,f.$on("refresh",function(){f.get_data()}),f.fields=k,f.get_data()},f.percent=d.to_percent,f.closeFacet=function(){f.modalField&&delete f.modalField},f.termsModal=function(b,c){f.closeFacet(),j(function(){f.modalField=b.key,f.adhocOpts={height:"200px",chart:c,field:b.key,span:f.panel.span,type:"terms",title:"Top 10 terms in field "+b.value},s(a.toJson(f.adhocOpts),"terms")},0)},f.statsModal=function(b){f.closeFacet(),j(function(){f.modalField=b.key,f.adhocOpts={height:"200px",field:b.key,mode:"mean",span:f.panel.span,type:"stats",title:"Statistics for "+b.value},s(a.toJson(f.adhocOpts),"stats")},0)};var s=function(a,b){f.facetPanel=a,f.facetType=b};f.toggle_micropanel=function(b,e){var g=c.map(f.data,function(a){return a.kibana._source}),h=d.top_field_values(g,b,10,e);a.forEach(h.counts,function(a,b){("string"==typeof a[0]||"object"==typeof a[0])&&("object"==typeof a[0]&&(a[0]=JSON.stringify(a[0])),a[0].indexOf("@start-highlight@")>=0&&(a[0]=a[0].replace("@start-highlight@","").replace("@end-highlight@",""),a[0].indexOf('["')>=0&&(a[0]=a[0].replace('["',"").replace('"]',""))))}),f.micropanel={field:b,grouped:e,values:h.counts,hasArrays:h.hasArrays,related:d.get_related_fields(g,b),limit:10,count:c.countBy(g,function(a){return c.contains(c.keys(a),b)})["true"]};var i=f.ejs.client.get("/"+m.indices+"/_mapping/field/"+b,void 0,void 0,function(a,b){return!1});return i.then(function(a){var b=c.uniq(jsonPath(a,"*.*.*.*.mapping.*.type"));c.isArray(b)&&(f.micropanel.type=b.join(", ")),c.intersection(b,["long","float","integer","double"]).length>0&&(f.micropanel.hasStats=!0)})},f.toggle_setTime=function(a,b,c){f.setTime={fieldKey:a,field:b,grouped:c}},f.micropanelColor=function(a){var b=["bar-success","bar-warning","bar-danger","bar-info","bar-primary"];return a>b.length?"":b[a]},f.set_sort=function(a){f.panel.sort[0]===a?f.panel.sort[1]="asc"===f.panel.sort[1]?"desc":"asc":f.panel.sort[0]=a,f.get_data()},f.toggle_field=function(b){var d=[];c.each(f.panel.fields,function(b){a.isUndefined(b.key)||d.push(b.key)}),c.indexOf(d,b)>-1?(f.panel.fields=o("textformatforarray")(c.without(d,b),f.dscolumns),delete f.columns[b]):(f.panel.fields.push(o("textformattomap")(b,f.dscolumns)),f.columns[b]=!0)},f.toggle_highlight=function(a){c.indexOf(f.panel.highlight,a)>-1?f.panel.highlight=c.without(f.panel.highlight,a):f.panel.highlight.push(a)},f.toggle_details=function(a){a.kibana.details=a.kibana.details?!1:!0,a.kibana.view=a.kibana.view||"table"},f.page=function(a){f.panel.offset=a*f.panel.size,f.get_data()},f.build_search=function(b,d,g,h){if(("string"==typeof d||"object"==typeof d)&&("object"==typeof d&&(d=JSON.stringify(d)),d.indexOf("@start-highlight@")>=0&&(d=d.replace("@start-highlight@","").replace("@end-highlight@",""),d.indexOf('["')>=0&&(d=d.replace('["',"").replace('"]',"")))),"range"==h){var i=0;if("number"==typeof Number(f.panel.timeRange)||NaN!=typeof Number(f.panel.timeRange))if(Number(f.panel.timeRange)>0){if("second"==f.panel.rangeUnit?i=1e3*f.panel.timeRange:"minute"==f.panel.rangeUnit?i=1e3*f.panel.timeRange*60:"hour"==f.panel.rangeUnit?i=1e3*f.panel.timeRange*60*60:"day"==f.panel.rangeUnit&&(i=1e3*f.panel.timeRange*60*60*24),"before"==f.panel.range)var j=Date.parse(d)-i,k=Date.parse(d);else if("after"==f.panel.range)var j=Date.parse(d),k=Date.parse(d)+i;else if("center"==f.panel.range)var j=Date.parse(d)-i,k=Date.parse(d)+i;n.set({type:"time",from:e.utc(j).toDate(),to:e.utc(k).toDate(),field:b})}else alert("请输入正整数");else alert("请输入数字")}else{var l;c.isArray(d)?l="("+c.map(d,function(b){return a.toJson(b)}).join(" AND ")+")":c.isUndefined(d)?(l="*",g=!g):l=a.toJson(d),f.panel.offset=0,n.set({type:"field",field:b,query:l,mandate:g?"mustNot":"must"})}},f.fieldExists=function(a,b){n.set({type:"exists",field:a,mandate:b})},f.keyvalues=m.current.filed_dic.keyvalues,f.dscolumns=m.current.filed_dic.dscolumns;var t;f.get_data=function(b,e){var g,h,i,j,k;if(f.panel.error=!1,0!==m.indices.length&&(1!==m.indices.length||"INDEX_MISSING"!==m.indices[0])){k=[f.ejs.Sort(f.panel.sort[0]).order(f.panel.sort[1]).ignoreUnmapped(!0)],f.panel.localTime&&k.push(f.ejs.Sort(f.panel.timeField).order(f.panel.sort[1]).ignoreUnmapped(!0)),f.panelMeta.loading=!0;var p=f.panelMeta;g=c.isUndefined(b)?0:b,f.segment=g,h=f.ejs.Request().indices(m.indices[g]),f.panel.queries.ids=l.idsByMode(f.panel.queries),t=j,j=l.getQueryObjs(f.panel.queries.ids),i=f.ejs.BoolQuery(),f.querieinfos=[],c.each(j,function(a){var b="",c=a.query;1==f.panel.isFilter&&""!=f.panel.localFilter&&(b=a.query+" AND "+f.panel.localFilter,a.query=b),f.querieinfos.push(a.query),i=i.should(l.toEjsObj(a)),a.query=c}),h=h.query(f.ejs.FilteredQuery(i,n.getBoolFilter(n.ids()))).highlight(f.ejs.Highlight(f.panel.highlight).fragmentSize(2147483647).preTags("@start-highlight@").postTags("@end-highlight@").noMatchSize(100)).size(f.panel.size*f.panel.pages).sort(k),f.populate_modal(h),h.doSearch().then(function(b){return 0==b.hits.hits.length?f.isShowData=!0:f.isShowData=!1,a.forEach(b.hits.hits,function(d,e){c.isUndefined(d.highlight)||(a.forEach(d.highlight,function(a,b){a.toString().indexOf("@start-highlight@")>=0&&(d._source[b]=a)}),delete b.hits.hits[e].highlight),f.panel.highlight.length>0&&a.forEach(f.querieinfos,function(b,c){"*"!=b&&a.forEach(d._source,function(a,c){$.inArray("*",f.panel.highlight)>=0?b==a&&(d._source[c]=a.toString().replaceAll(a,"@start-highlight@"+a+"@end-highlight@")):$.inArray(c,f.panel.highlight)>=0&&(console.log("部分设定字典高亮显示"),b==a&&(d._source[c]=a.toString().replaceAll(a,"@start-highlight@"+a+"@end-highlight@")))})})}),null===f.panelMeta&&(f.panelMeta=p),f.panelMeta.loading=!1,void 0===f.panel?!1:(0===g&&(f.panel.offset=0,f.hits=0,f.data=[],f.current_fields=[],e=f.query_id=(new Date).getTime()),c.isUndefined(b.error)?void(f.query_id===e&&(f.keyvalues=[],f.data=f.data.concat(c.map(b.hits.hits,function(b){var e=c.clone(b),g=c.omit(b,"_source","sort","_score");return c.isUndefined(f.dictionaryInfo)||0===f.dictionaryInfo.length?e.kibana={_source:c.extend(d.flatten_json(o("filedValueFormat")(b._source,m.dictionaryInfo)),g),highlight:d.flatten_json(b.highlight||{})}:(a.forEach(f.dictionaryInfo,function(a,b){var c={};c.k=a.key,c.v=a.value,f.keyvalues[a.key]=c}),e.kibana={_source:c.extend(d.flatten_json(o("filedValueFormat1")(b._source,f.keyvalues)),g),highlight:d.flatten_json(b.highlight||{})}),f.current_fields=f.current_fields.concat(c.keys(e.kibana._source)),e})),f.current_fields=c.uniq(f.current_fields),a.forEach(f.keyvalues,function(b,c){a.forEach(f.current_fields,function(a,b){c==a&&delete f.current_fields[b]})}),f.current_fields=o("textformatforarray")(f.current_fields,f.dscolumns),f.hits+=b.hits.total,f.data=c.sortBy(f.data,function(a,b){return c.isUndefined(a.sort)?a._score:a.sort[0]}),"desc"===f.panel.sort[1]&&f.data.reverse(),f.data=f.data.slice(0,f.panel.size*f.panel.pages),o("filedValueFormat")(f.data,f.keyvalues),(f.data.length<f.panel.size*f.panel.pages||!c.contains(n.timeField(),f.panel.sort[0])||"desc"!==f.panel.sort[1])&&g+1<m.indices.length&&f.get_data(g+1,f.query_id))):void(f.panel.error=f.parse_error(b.error)))})}},f.populate_modal=function(b){f.inspector=a.toJson(JSON.parse(b.toString()),!0)},f.without_kibana=function(a){var b=c.clone(a);return delete b.kibana,b},f.set_refresh=function(a){f.refresh=a},f.close_edit=function(){f.refresh&&f.get_data(),f.columns=[],c.each(f.panel.fields,function(a){f.columns[a]=!0}),f.refresh=!0},f.locate=function(a,b){b=b.split(".");for(var c=/(.+)\[(\d+)\]/,d=0;d<b.length;d++){var e=c.exec(b[d]);a=e?a[e[1]][parseInt(e[2],10)]:a[b[d]]}return a},f.export_panel=function(a){var b="root-table";tableExport(b,"report","xls")}}]),f.filter("tableHighlight",function(){return function(a){return!c.isUndefined(a)&&!c.isNull(a)&&a.toString().length>0?a.toString().replaceAll("@start-highlight@",'<code class="highlight">').replaceAll("@end-highlight@","</code>"):""}});f.filter("colHighlight",function(){return function(a){if(!c.isUndefined(a)&&!c.isNull(a)&&a.toString().length>0){var b="221.202.100.81";return a.toString().replaceAll(b,'<code class="highlight">'+b+"</code>")}return""}}),String.prototype.replaceAll=function(a,b){return this.replace(new RegExp(a,"gm"),b)},f.directive("stringHtml",function(){return function(a,b,c){c.stringHtml&&a.$watch(c.stringHtml,function(a){b.html(a||"")})}}),f.filter("tableTruncate",function(){return function(a,b,d){return!c.isUndefined(a)&&!c.isNull(a)&&a.toString().length>0?a.length>b/d?a.substr(0,b/d)+"...":a:""}}),f.filter("tableJson",function(){var b;return function(d,e){return!c.isUndefined(d)&&!c.isNull(d)&&d.toString().length>0?(b=a.toJson(d,e>0?!0:!1),b=b.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;"),e>1&&(b=b.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g,function(a){var b="number";return/^"/.test(a)?b=/:$/.test(a)?"key strong":"":/true|false/.test(a)?b="boolean":/null/.test(a)&&(b="null"),'<span class="'+b+'">'+a+"</span>"})),b):""}}),f.filter("tableLocalTime",function(){return function(a,b){return e(b.sort[1]).format("YYYY-MM-DDTHH:mm:ss.SSSZ")}})});