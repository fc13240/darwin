var pie = new d3pie("pieChart", {
	"header": {
		"title": {
			"text": "Lots of Programming Languages",
			"fontSize": 24,
			"font": "open sans"
		},
		"subtitle": {
			"text": "A full pie chart to show off label collision detection and resolution.",
			"color": "#999999",
			"fontSize": 12,
			"font": "open sans"
		},
		"titleSubtitlePadding": 9
	},
	"footer": {
		"color": "#999999",
		"fontSize": 10,
		"font": "open sans",
		"location": "bottom-left"
	},
	"size": {
		"canvasWidth": 590
	},
	"data": {
		"sortOrder": "value-desc",
		"content": [
			{
				"label": "JavaScript",
				"value": 264131,
				"color": "#546e91"
			},
			{
				"label": "Ruby",
				"value": 218812,
				"color": "#6ada6a"
			},
			{
				"label": "Java",
				"value": 157618,
				"color": "#7c9058"
			},
			{
				"label": "PHP",
				"value": 114384,
				"color": "#44b9ae"
			},
			{
				"label": "Python",
				"value": 95002,
				"color": "#bca349"
			},
			{
				"label": "C+",
				"value": 78327,
				"color": "#d0743c"
			},
			{
				"label": "C",
				"value": 67706,
				"color": "#64a61f"
			},
			{
				"label": "Objective-C",
				"value": 36344,
				"color": "#273c71"
			},
			{
				"label": "Shell",
				"value": 28561,
				"color": "#69a5f9"
			},
			{
				"label": "Cobol",
				"value": 24131,
				"color": "#2081c1"
			},
			{
				"label": "C#",
				"value": 100,
				"color": "#d8d138"
			},
			{
				"label": "Coldfusion",
				"value": 68,
				"color": "#a05c56"
			},
			{
				"label": "Fortran",
				"value": 218812,
				"color": "#98bf6e"
			},
			{
				"label": "Coffeescript",
				"value": 157618,
				"color": "#961818"
			},
			{
				"label": "Node",
				"value": 114384,
				"color": "#8bde90"
			},
			{
				"label": "Basic",
				"value": 95002,
				"color": "#7b6688"
			},
			{
				"label": "Cola",
				"value": 36344,
				"color": "#98a9c5"
			},
			{
				"label": "Perl",
				"value": 32170,
				"color": "#cc0d0d"
			},
			{
				"label": "Dart",
				"value": 28561,
				"color": "#8cc0e9"
			},
			{
				"label": "Go",
				"value": 264131,
				"color": "#634a22"
			},
			{
				"label": "Groovy",
				"value": 218812,
				"color": "#e4a049"
			},
			{
				"label": "Processing",
				"value": 157618,
				"color": "#53368f"
			},
			{
				"label": "Smalltalk",
				"value": 114384,
				"color": "#e98125"
			},
			{
				"label": "Scala",
				"value": 95002,
				"color": "#4baa49"
			},
			{
				"label": "Visual Basic",
				"value": 78327,
				"color": "#207f32"
			},
			{
				"label": "Scheme",
				"value": 67706,
				"color": "#d2ab58"
			},
			{
				"label": "Rust",
				"value": 36344,
				"color": "#0a6097"
			},
			{
				"label": "FoxPro",
				"value": 32170,
				"color": "#a3acb2"
			}
		]
	},
	"labels": {
		"outer": {
			"hideWhenLessThanPercentage": 1,
			"pieDistance": 32
		},
		"inner": {
			"hideWhenLessThanPercentage": 3
		},
		"mainLabel": {
			"fontSize": 11
		},
		"percentage": {
			"color": "#ffffff",
			"decimalPlaces": 0
		},
		"value": {
			"color": "#adadad",
			"fontSize": 11
		},
		"lines": {
			"enabled": true,
			"style": "straight"
		}
	},
	"effects": {
		"pullOutSegmentOnClick": {
			"effect": "linear",
			"speed": 400,
			"size": 8
		}
	},
	"misc": {
		"gradient": {
			"enabled": true,
			"percentage": 100
		}
	}
});