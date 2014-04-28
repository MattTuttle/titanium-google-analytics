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


var button = Ti.UI.createButton({ title: "HOME", width: 200, height: 100, color: "#000" });
button.add(win);


button.addEventListener("click", function() {
	tracker.trackScreen("Home");
	console.log("--------------- @@@")
});
