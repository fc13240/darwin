/* ==========================================================
 * sco.message.js
 * http://github.com/terebentina/sco.js
 * ==========================================================
 * Copyright 2013 Dan Caragea.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */

/*jshint laxcomma:true, sub:true, browser:true, jquery:true, eqeqeq: false */

;(function($jq, undefined) {
	"use strict";

	var pluginName = 'scojs_message';

	$jq[pluginName] = function(message, type) {
		clearTimeout($jq[pluginName].timeout);
		var $selector = $jq('#' + $jq[pluginName].options.id);
		if (!$selector.length) {
			$selector = $jq('<div/>', {id: $jq[pluginName].options.id}).appendTo($jq[pluginName].options.appendTo);
		}
		if ($jq[pluginName].options.animate) {
			$selector.addClass('page_mess_animate');
		} else {
			$selector.removeClass('page_mess_animate');
		}
		$selector.html(message);
		if (type === undefined || type == $jq[pluginName].TYPE_ERROR) {
			$selector.removeClass($jq[pluginName].options.okClass).addClass($jq[pluginName].options.errClass);
		} else if (type == $jq[pluginName].TYPE_OK) {
			$selector.removeClass($jq[pluginName].options.errClass).addClass($jq[pluginName].options.okClass);
		}
		$selector.slideDown('fast', function() {
			$jq[pluginName].timeout = setTimeout(function() { $selector.slideUp('fast'); }, $jq[pluginName].options.delay);
		});
	};


	$jq.extend($jq[pluginName], {
		options: {
			 id: 'page_message'
			,okClass: 'page_mess_ok'
			,errClass: 'page_mess_error'
			,animate: true
			,delay: 4000
			,appendTo: 'body'	// where should the modal be appended to (default to document.body). Added for unit tests, not really needed in real life.
		},

		TYPE_ERROR: 1,
		TYPE_OK: 2
	});
})($jq);
