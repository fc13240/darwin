/**
* @author fushiguang
* @this DarwinMLine
* @constructor
* @param domid 为展示图表的dom的id，不需要以#开头
* @param data 为数据对象，格式：
* {"xvalues":['x1'，'x2'，'x3',...], "yvalues":{"y1name":[y11,y12,y13,...],"y2name":[y21,y22,y23,y24,...]} }
*/
var DarwinMLine = function(domid, data) {
	this.domid = domid;
	this.data = data;
	this.finalOptions = {};
	this.bestWidthHeight = 1000/300;//宽高比,从demo获得
	this.padding = [0,0,0,0];
	/**
	 * options 为图表的参数。
	 * header.title.text 为图表标题，一般是必要的
	 * graph.legend.show 0不显示，1显示
	 * graph.linestyle.smooth 0直线，1平滑
	 * graph.linestyle.showarea 0不显示区域，1显示区域
	 */
	DarwinMLine.prototype.draw = function(width, height, options) {
		
		var _self = this;
		
		if (width == "" && height == "") {
			console.error("DarwinMLine for div["+this.domid+"], both width and height are empty. must at least one has value");
			return false;
		}
		if (width == "") {
			width = Math.floor(height * this.bestWidthHeight);
		}
		if (height == "") {
			height = Math.floor(width / this.bestWidthHeight);
		}
		
		if (typeof options == "undefined") {
			options = {};
		}
		
		var _padding = _self.padding;
		
		var _title = "";
		if (typeof options['header.title.text']!="undefined") {
			_padding[0] = 40;
			_title = options['header.title.text'];
		}
		
		var _legend = {"show":false, x:0, y:0, anchor:'middle'};
		if (typeof options['graph.legend.show']!="undefined" && parseInt(options['graph.legend.show'])>0) {
			_legend = {"show":true, x:Math.floor(width/2), y:height-10, anchor:'middle'};
			_padding[2] = 30;
		}
		
		var _smooth = false;
		if (typeof options['graph.linestyle.smooth']!="undefined" && parseInt(options['graph.linestyle.smooth'])>0) {
			_smooth = true;
		}
		
		var _showarea = false;
		if (typeof options['graph.linestyle.showarea']!="undefined" && parseInt(options['graph.linestyle.showarea'])>0) {
			_showarea = true;
		}
		
		 
		var graphOpt = {
				name: '',
				yValues: [],
				showDots: true,
				showLine: true,
				showArea: _showarea,
				smooth: _smooth,
				lineAttr: {stroke: 'auto', "stroke-width": 3, "stroke-linejoin": "round"},									// Атрибуты линии графика
				dotAttr: {fill: "#fff", stroke: 'auto', "stroke-width": 2},													// Атрибуты точек графика
				dotRadius: 4,																								// Радиус точек графика
				areaAttr: {stroke: 'none', opacity: .3, fill: 'auto'},														// Атрибуты подсвечиваемой области под графиком
				tooltip: {																									// Настройки всплывающих подсказок
					show: true,																								// Показывать подсказки
					activator: 'dot',																						// Когда показывать: area - при прохождение указателя мыши вдоль соответствующей области; dot - при прохождение указателя мыши рядом с соответствующей точкой
					dotActivatorRadius: 25,																					// Размер области активации подсказки для случая dot
					tooltipAttr: {fill: "#000", stroke: "#666", "stroke-width": 2, "fill-opacity": .7},						// Атрибуты контейнера с подсказкой
					labels: function(r, xValue, yValue, n){																	// Элементы отображающиеся на подсказке
						return r.text(10, 10, yValue).attr({font: '13px "Trebuchet MS"', fill: 'white', color: 'white', 'text-anchor': 'middle'});
					}
				}
		};
		
		var _graphs = [];
		for (var yname in this.data['yvalues']) {
			var oneg = {};//graphOpt;
			this._clone(graphOpt, oneg);
			oneg.name = yname;
			oneg.yValues = this.data['yvalues'][yname];
			_graphs.push(
				oneg
			);
		}
		
		var linechart2 = new lineChart(this.domid, 0,0,width,height, this.data.xvalues, {
			padding: _padding,
			legend: _legend,
			graph: _graphs,
			xAxis: {																										// Настройки оси X
				showLabels: true,																							// Показывать метки на оси
				showGridLines: true,																						// Показывать вертикальные линии сетки
				gridLinesAttr: {stroke: "#c0c0c0", 'stroke-width': 1, fill: 'none'},										// Атрибуты линии сетки
				gridStep: 1,																								// Шаг линий сетки
				gridShift: 0,																								// Смещение линий сетки
				labelsStep: 1,																								// Шаг меток оси
				labelsShift: 0,																								// Смещение меток оси
				labelsMT: 4,																								// Отступ меток сверху от оси в пикселах
				vAlign: 'bottom',																							// Выравнивание меток по верикали. Возможные значения bottom, top
				labelsTickSize: 3,																							// Размер засечек меток на оси
				labelsAttr: {font: '12px "Trebuchet MS"', fill: '#4c4c4c', color: '#4c4c4c', 'text-anchor': 'middle'},		// Атрибуты меток
				labelsAngle: -45,																							// Поворот меток в градусах
				labelFormatter: function(value, n){																			// Функция дополнительного действия над метками перед выводом
					return value;																							 
				}
			},
			
			yAxis: {																										// Настройки оси Y
				showLabels: true,																							// Показывать метки на оси
				showGridLines: true,																						// Показывать горизонтальные линии сетки
				gridLinesAttr: {stroke: "#c0c0c0", 'stroke-width': 1, fill: 'none'},										// Атрибуты линии сетки
				gridStep: 1,																								// Шаг линий сетки
				gridShift: 0,																								// Смещение линий сетки
				labelsStep: 1,																								// Шаг меток оси
				labelsShift: 0,																								// Смещение меток оси
				labelsTickSize: 3,																							// Размер засечек меток на оси
				isInteger: false,																							// Только целые числа на оси OY
				pLabelsNN: 5,																								// Предпочитаемое кол-во горизонтальных линий сетки
				labelsMR: 5,																								// Отступ меток справа от оси в пикселах
				labelsAttr: {font: '12px "Trebuchet MS"', fill: '#4c4c4c', color: '#4c4c4c', 'text-anchor': 'start'},		// Атрибуты меток
				labelFormatter: function(value){																			// Функция дополнительного действия над метками перед выводом 
					return value;
				}
			}
		});
		linechart2.addText(Math.floor(width/2), 20, _title, {font: '18px "Lucida Grande", Calibri, Helvetica, Arial, sans-serif', color: '#222222', fill: '#222222'});
		linechart2.draw();
		
		DarwinVis['viscontainer'][this.domid] = linechart2;
	};
	
	//递归设置属性值
	DarwinMLine.prototype._clone = function(fromobject, toobject) {
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
