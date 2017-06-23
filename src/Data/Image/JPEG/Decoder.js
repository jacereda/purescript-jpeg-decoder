"use strict";
var jpeg          = require('jpeg-js')

exports.decodeImpl = function(left) {
    return function(right) {
	return function(ab) {
	    try {
		return right(jpeg.decode(ab, true));
	    } catch (e) {
		return left(e);
	    };
	};
    };
};
