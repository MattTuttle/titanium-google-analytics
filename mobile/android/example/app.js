var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
win.open();

var GA = require('analytics.google');
//GA.optOut = true;
GA.debug = true;
//GA.trackUncaughtExceptions = true;

var tracker = GA.getTracker("UA-5069201-9");
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

var transaction = GA.makeTransaction({
	id: "hi",
	tax: 0.6,
	shipping: 0,
	revenue: 24.99 * 0.7
});
transaction.addItem({
	sku: "ABC123",
	name: "My Alphabet",
	category: "product category",
	price: 24.99,
	quantity: 1
});
tracker.trackTransaction(transaction);
