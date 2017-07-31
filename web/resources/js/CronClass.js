/**
 * trigger|task都需要用到的脚本，cron调度的js脚本
 * @returns
 */
function CronClass(){
	var crontabGroupInputHtml;
	var crontabGroupInputLable,weekDiv,monthDiv,dayDiv,hourDiv,minuteDiv;
	this.init = function(){
		$("#periodType").on("change",function(){
			$("#cronValue").val("");
			$("#cronHtml").html("");
			var selVal = $(this).val();
			createHtml(selVal);
			
			if($(this).val()==''){
				$("#cronValue").val("");
				$("#crontabGroupInput").html('');
			}
		});
		
		crontabGroupInputHtml = $("#crontabGroupInput").html();
		crontabGroupInputLable = $("#crontabGroupInputLable").html();
		weekDiv = $("#weekDiv").html();
		monthDiv = $("#monthDiv").html();
		dayDiv = $("#dayDiv").html();
		hourDiv = $("#hourDiv").html();
		minuteDiv = $("#minuteDiv").html();
		$("#crontabGroupInput").html("");
//		console.log("crontabGroupInputHtml="+crontabGroupInputHtml);
		
		//回填cron的数据到页面
		
		
		var _periodType = $("#_periodType").val();
		console.log(_periodType);
		if(_periodType && _periodType!=''){
			$("#periodType").val(_periodType);
		}
		$("#_periodType").remove();
		
//		if(true){return;}
		
		var _cronValue = $("#cronValue").val();
		console.log(_cronValue);
		if(_cronValue!=''){
			
//			var arr = _cronValue.split(" ");
//			if(arr[4]!="*"){
//				$("#periodType").val("week");
//			}else if(arr[3]!="*"){
//				$("#periodType").val("month");
//			}else if(arr[2]!="*"){
//				$("#periodType").val("day");
//			}else if(arr[1]!="*"){
//				$("#periodType").val("hour");
//			}else if(arr[0]!="*"){
//				$("#periodType").val("minute");
//			}
			
			//根据cron动态创建html
			createHtml($("#periodType").val());
			
			/*将cron值赋给控件#week,#month,#day,#hour,#minute*/
			var cronValue = $("#cronValue").val();
//			console.log("cronValue="+cronValue);
			if(cronValue!=''){
				var arr = cronValue.split(" ");
				console.log("arr="+arr.length);
				console.log(arr);
				for(var i=0;i<arr.length;i++){
//					if(arr[i]=="*"){continue;}
					if(i==0){
						$("#minute").val(arr[i]);
					}else if(i==1){
						$("#hour").val(arr[i]);
					}else if(i==2){
						$("#day").val(arr[i]);
					}else if(i==3){
						$("#month").val(arr[i]);
					}else if(i==4){
						$("#week").val(arr[i]);
					}
				}
			}
		}
	};
	
	//根据cron动态创建html
	function createHtml(selVal){
		if($.trim(selVal)==''){return;}
//		console.log("createHtml.selVal="+selVal);
		var w = "周<input size=4 id='week' data-rule='required;integer;range[1~7];'/>&nbsp;&nbsp;<br>";
		var MM = "月<input size=2 id='month' data-rule='required;integer;range[1~12];'/>&nbsp;&nbsp;<br>";
		var dd = "日<input size=2 id='day' data-rule='required;integer;range[1~31];'/>&nbsp;&nbsp;<br>";
		var HH = "时<input size=2 id='hour' data-rule='required;integer;range[0~24];'/>&nbsp;&nbsp;<br>";
		var mm = "分<input size=2 id='minute' data-rule='required;integer;range[0~60];'/>&nbsp;&nbsp;<br>";
		
		//weekDiv,monthDiv,dayDiv,hourDiv,minuteDiv;
		if(selVal=='week'){
//			$("#cronHtml").html(w+MM+dd+HH+mm);
			$("#crontabGroupInput").html(crontabGroupInputLable+minuteDiv+hourDiv+dayDiv+monthDiv+weekDiv);
		}else if(selVal=='year'){
//			$("#cronHtml").html(MM+dd+HH+mm);
			$("#crontabGroupInput").html(crontabGroupInputLable+minuteDiv+hourDiv+dayDiv+monthDiv);
		}else if(selVal=='month'){
//			$("#cronHtml").html(MM+dd+HH+mm);
			$("#crontabGroupInput").html(crontabGroupInputLable+minuteDiv+hourDiv+dayDiv+monthDiv);
		}else if(selVal=='day'){
//			$("#cronHtml").html(dd+HH+mm);
			$("#crontabGroupInput").html(crontabGroupInputLable+minuteDiv+hourDiv+dayDiv);
		}else if(selVal=='hour'){
//			$("#cronHtml").html(HH+mm);
			$("#crontabGroupInput").html(crontabGroupInputLable+minuteDiv+hourDiv);
		}else if(selVal=='minute'){
//			$("#cronHtml").html(mm);
			$("#crontabGroupInput").html(crontabGroupInputLable+minuteDiv);
		}else if(selVal=='second'){
			$("#crontabGroupInput").html(crontabGroupInputLable);
		}else{
			$("#crontabGroupInput").html(crontabGroupInputLable);
		}
		
//		if(selVal=='second'){
//			$("#crontabGroupInput").html("");
//		}else{
//			$("#crontabGroupInput").html(crontabGroupInputHtml);
//		}
		
		$("#week,#month,#day,#hour,#minute").on('blur',function(){
			var _id = $(this).attr("id");
			var selVal = $(this).val();
			if(selVal==''){selVal = "*";}
			htian(_id,selVal);
		});
	}
	
	//#week,#month,#day,#hour,#minute失去焦点事件，则回填cron的值到控件
	function htian(_id,selVal){
		console.log("createHtml.htian="+_id+",selVal="+selVal);
		var cronValue = $("#cronValue").val();
		var arr;
		if(cronValue==''){
			arr = [];
//			console.log(arr.length);
			for(var i=0;i<5;i++){
				arr[i] = "*";
			}
		}else{
			arr = cronValue.split(" ");
		}
		
		if(_id=='week'){
			arr[4] = selVal;
			$("#cronValue").val(convert22(arr));
		}else if(_id=='month'){
			arr[3] = selVal;
			$("#cronValue").val(convert22(arr));
		}else if(_id=='day'){
			arr[2] = selVal;
			$("#cronValue").val(convert22(arr));
		}else if(_id=='hour'){
			arr[1] = selVal;
			$("#cronValue").val(convert22(arr));
		}else if(_id=='minute'){
			arr[0] = selVal;
			$("#cronValue").val(convert22(arr));
		}
		
		console.log($("#cronValue").val());
	}

	// Array convert String
	function convert22(arr){
		if(!arr){
			return arr;
		}
		
		var buf = "";
		for(var i=0;i<arr.length;i++){
			buf += arr[i] + " ";
		}
		return buf;
	}
}