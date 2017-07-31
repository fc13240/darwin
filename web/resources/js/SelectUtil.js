function SelectUtil(idOrObj){
	if(typeof(idOrObj)=="string"){
		this.selectObj=document.getElementById(idOrObj);
	}
	else if (idOrObj!=null && typeof(idOrObj)=="object" && idOrObj.tagName=="SELECT"){
		this.selectObj=idOrObj;
	}
	else{
		alert("创建对象失败，参数不合法！");
	}
}
SelectUtil.prototype.isExist=function(itemValue){
	var isExist = false;
	for(var i=0; i<this.selectObj.options.length; i++){
		if(this.selectObj.options[i].value==itemValue){
			isExist=true;
			break;
		}
	}
	return isExist;
}
SelectUtil.prototype.addItem=function(itemText,itemValue){
	if(!itemText || !itemValue || typeof(itemText)!="string" ||typeof(itemValue)!="string" )return false;
	if(this.isExist(itemValue)){
		//alert("项目已存在！");
		return false;
	}
	var optionItem = new Option(itemText,itemValue);
	this.selectObj.options.add(optionItem);
	return true;
}
SelectUtil.prototype.delItem=function(itemValue){
	var bDel=false;
	for(var i=0; i<this.selectObj.options.length; i++){
		if(this.selectObj.options[i].value==itemValue){
			bDel=true;
			this.selectObj.options.remove(i);
			break;
		}
	}
	return bDel;
}
SelectUtil.prototype.delSelectedItem=function(){
	var length = this.selectObj.options.length-1;
	var num = 0;
	for(var i=length; i>=0; i--){
		if(this.selectObj.options[i].selected==true){
			this.selectObj.options[i] = null;
			num++;
		}
	}
	return num;
}
SelectUtil.prototype.cloneItem = function (itemValue){
	var result=null;
	for(var i=0; i<this.selectObj.options.length; i++){
		if(this.selectObj.options[i].value==itemValue){
			result=this.selectObj.options[i];
			break;
		}
	}
	if(result==null)return null;
	return new Option(result.text,result.value);
}
SelectUtil.prototype.getItem = function (itemValue){
	var result=null;
	for(var i=0; i<this.selectObj.options.length; i++){
		if(this.selectObj.options[i].value==itemValue){
			result=this.selectObj.options[i];
			break;
		}
	}
	return result;
}
SelectUtil.prototype.modItemText=function(itemText,itemValue){
	var opt=this.getItem(itemValue);
	if(opt==null){
		alert("没有找到指定的项目！");
		return false;
	}
	else{
		opt.text = itemText;
		return true;
	}
}
SelectUtil.prototype.selItemByValue=function(itemValue){
	var opt = this.getItem(itemValue);
	if(opt!=null){
		opt.selected=true;
		return true;
	}
	else{
		return false;
	}
}
SelectUtil.prototype.clear=function(){
	this.selectObj.options.length=0;
}
SelectUtil.prototype.selectedIndex=function(){
	return this.selectObj.selectedIndex;
}
SelectUtil.prototype.seletedText=function(){
	return this.selectObj.text;
}
SelectUtil.prototype.getSelectedItem=function(){
	var idx = this.selectObj.selectedIndex;
	if(idx==-1)return null;
	else{
		return this.selectObj.options[idx];
	}
}
SelectUtil.prototype.adjustItem=function(optionObj,direction){
	if(!optionObj){
		optionObj = this.getSelectedItem();
	}
	if(!optionObj)return false;
	var delta = (direction=="down")?1:-1;
	if(optionObj.index+delta<0 || optionObj.index+delta>=this.selectObj.options.length)return true;
	else{
		var opt,tmp;
		opt = this.selectObj.options[optionObj.index+delta];
		tmp = opt.value;
		opt.value=optionObj.value;
		optionObj.value = tmp;
		tmp = opt.text;
		opt.text=optionObj.text;
		optionObj.text = tmp;
		opt.selected=true;
		optionObj.selected=false;
		return true;
	}
}
SelectUtil.prototype.getAllItem=function(){
	return this.selectObj.options;
}
SelectUtil.prototype.getItemCount=function(){
	return this.selectObj.options.length;
}
SelectUtil.prototype.moveSelectedItemTo=function(anotherSelectObj){
	console.log(anotherSelectObj);
	if(!anotherSelectObj)return false;
	var length = this.selectObj.options.length-1;
	var num = 0,opt;
	for(var i=length; i>=0; i--){
		if(this.selectObj.options[i].selected==true){
			num++;
			opt = this.selectObj.options[i];
			//没有验证有无重复
			anotherSelectObj.options.add(new Option(opt.text,opt.value));
			this.selectObj.options[i] = null;
		}
	}
	return num;
}
SelectUtil.prototype.moveAllItemTo=function(anotherSelectObj,bCreate){
	if(!anotherSelectObj)return false;
	var length = this.selectObj.options.length-1;
	var num = 0,opt=null;
	for(var i=length; i>=0; i--){
		num++;
		opt = this.selectObj.options[i];
		//没有验证有无重复
		anotherSelectObj.options.add(new Option(opt.text,opt.value));
		this.selectObj.options[i] = null;
	}
	return num;
}
SelectUtil.prototype.getObject=function(){
	return this.selectObj;
}
SelectUtil.prototype.selectAll=function(){
	for(var i=0; i<this.selectObj.options.length; i++){
		this.selectObj.options[i].selected=true;
	}
}