"use strict";
var jpeg          = require('jpeg-js')

exports.decodeImpl = function(left) {
    return function(right) {
	return function(ab) {
	    try {
		var d = jpeg.decode(ab, true);
		d.data = d.data.buffer;
		return right(d);
	    } catch (e) {
		return left(e);
	    };
	};
    };
};
