var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
win.open();

var GA = require('analytics.google');
// GA.setDryRun(true);
GA.localDispatchPeriod = 10;


var tracker = GA.getTracker("UA-50445546-1");

tracker.trackEvent({
	category: "category",
	action: "test",
	label: "label",
	value: 1
});

tracker.trackEvent({
	category: "category",
	action: "test",
	label: "label"
});

tracker.trackSocial({
	network: "facebook",
	action: "action",
	target: "target"
});

tracker.trackTiming({
	category: "",
	time: 10,
	name: "",
	label: ""
});

tracker.trackScreen({ path: "Home", customDimension: { 1: "free" }});



