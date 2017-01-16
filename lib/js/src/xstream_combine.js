'use strict';

var combine = require("xstream").default.combine;

exports.combine2 = function(a, b) { return combine(a, b); }
exports.combine3 = function(a, b, c) { return combine(a, b, c); }
exports.combine4 = function(a, b, c, d) { return combine(a, b, c, d); }
exports.combine5 = function(a, b, c, d, e) { return combine(a, b, c, d, e); }
exports.combine6 = function(a, b, c, d, e, f) { return combine(a, b, c, d, e, f); }
exports.combine7 = function(a, b, c, d, e, f, g) { return combine(a, b, c, d, e, f, g); }
exports.combine8 = function(a, b, c, d, e, f, g, h) { return combine(a, b, c, d, e, f, g, h); }

