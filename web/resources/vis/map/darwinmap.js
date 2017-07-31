var DarwinMap = function(domid, data) {
	this.domid = domid;
	this.data = data;
	this.areas = null;
	this.finalOptions = {};
	this.padding = [0,0,0,0];
	this.colorstart = {r:255, g:255, b:102};
	this.originW = 518;
	this.originH = 300;
	this.width = 518;
	this.height = 386;
	this.v_max = 0;
	this.v_min = 0;
	DarwinMap.prototype.preDraw = function(width, height, options) {
		var _self = this;
		width = parseFloat(width);
		height = parseFloat(height);
		if (width/height > this.originW/this.originH) {
			//以高为主
			width = this.originW*height/this.originH;
		} else {
			//以宽为主
			height = this.originH*width/this.originW;
		}
		this.width = width;
		this.height = height;
		this.ratio = this.width/this.originW;
		if (!this.areas) {
		    var datacount = _self.data.length, item;
		    for (i = 0; i < datacount; ++i) {
		        item = _self.data[i];
		        if (item['value'] > _self.v_max) {
		        	_self.v_max = item['value'];
		        }
		        if (item['value'] < _self.v_min) {
		        	_self.v_min = item['value'];
		        }
		    }
		    
			this.areas = {};
			$.each(_self.data, function(i, v) {
				areacolor = _self.getColor(v.value);
				_self.areas[v.label] = {attrs : {fill:_self.getColor(v.value)},value:v.value, tooltip:{content : "<span style=\"font-weight:bold;\">"+v.label+"</span><br />访问量 : "+v.value}};
			});
		}
	};
	DarwinMap.prototype.draw = function(width, height, options) {
		var _self = this;
		if (width == "" && height == "") {
			console.error("DarwinMap for div["+this.domid+"], both width and height are empty. must at least one has value");
			return false;
		}
		if (typeof options == "undefined") {
			options = {};
		}
		this.preDraw(width, height, options);
		var _padding = _self.padding;
		var _title = "";
		if (typeof options['header.title.text']!="undefined") {
			_padding[0] = 40;
			_title = options['header.title.text'];
		}
		console.log(_self.areas);
		$("#"+_self.domid).mapael({
			map : {
				name : "china_states",
				width : _self.width,
				height : _self.height,
				ratio : _self.ratio
			},
			areas : _self.areas
		});
		
		//DarwinVis['viscontainer'][this.domid] = map;
	};
	DarwinMap.prototype.getColor = function(value) {
		var color = "red", self = this, colorB = self.colorstart.b, newB = colorB, maxB = 204;
		//根据取值区间，获取新的RGB值
		if (this.v_max > this.v_min) {
			newB = parseInt(maxB - (maxB-colorB)*value/(self.v_max-self.v_min));
			color = "rgb("+self.colorstart.r+","+self.colorstart.g+","+newB+")";
		}
		return color;
	};
	//递归设置属性值
	DarwinMap.prototype._clone = function(fromobject, toobject) {
		for(var fk in fromobject) {
			if(typeof fromobject[fk]=="object") {
				toobject[fk] = {};
				this._clone(fromobject[fk], toobject[fk]);
			} else {
				toobject[fk] = fromobject[fk];
			}
		}
	};
	
};
