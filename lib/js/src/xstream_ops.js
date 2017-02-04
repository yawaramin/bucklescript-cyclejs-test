'use strict';

var xs = require("xstream").default;

exports.combine = function(ss) { return xs.combine.apply(null, ss); }
exports.combine2 = function(s1, s2) { return xs.combine(s1, s2); }
exports.combine3 = function(s1, s2, s3) { return xs.combine(s1, s2, s3); }
exports.combine4 = function(s1, s2, s3, s4) { return xs.combine(s1, s2, s3, s4); }
exports.combine5 = function(s1, s2, s3, s4, s5) { return xs.combine(s1, s2, s3, s4, s5); }
exports.combine6 = function(s1, s2, s3, s4, s5, s6) { return xs.combine(s1, s2, s3, s4, s5, s6); }
exports.combine7 = function(s1, s2, s3, s4, s5, s6, s7) { return xs.combine(s1, s2, s3, s4, s5, s6, s7); }
exports.combine8 = function(s1, s2, s3, s4, s5, s6, s7, s8) { return xs.combine(s1, s2, s3, s4, s5, s6, s7, s8); }

exports.merge = function(ss) { return xs.merge.apply(null, ss); }
exports.merge2 = function(s1, s2) { return xs.merge(s1, s2); }
exports.merge3 = function(s1, s2, s3) { return xs.merge(s1, s2, s3); }
exports.merge4 = function(s1, s2, s3, s4) { return xs.merge(s1, s2, s3, s4); }
exports.merge5 = function(s1, s2, s3, s4, s5) { return xs.merge(s1, s2, s3, s4, s5); }
exports.merge6 = function(s1, s2, s3, s4, s5, s6) { return xs.merge(s1, s2, s3, s4, s5, s6); }
exports.merge7 = function(s1, s2, s3, s4, s5, s6, s7) { return xs.merge(s1, s2, s3, s4, s5, s6, s7); }
exports.merge8 = function(s1, s2, s3, s4, s5, s6, s7, s8) { return xs.merge(s1, s2, s3, s4, s5, s6, s7, s8); }

