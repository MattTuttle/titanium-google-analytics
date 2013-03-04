var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
win.open();

var GA = require('analytics.google');
//GA.optOut = true;
GA.debug = true;
GA.trackUncaughtExceptions = true;

var tracker = GA.getTracker("UA-5069201-8");
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
tracker.trackScreen("Home");

var transaction = GA.getTransaction({
	id: "hi"
});
transaction.tax = 0.6;
transaction.shipping = 0;
transaction.revenue = 24.99 * 0.7;
transaction.addItem({
	sku: "",
	name: "",
	category: "",
	price: 24.99,
	quantity: 1
});
tracker.trackTransaction(transaction);
