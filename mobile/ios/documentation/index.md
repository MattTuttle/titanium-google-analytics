# Google Analytics Module

## Description

Connects to Google Analytics for app event tracking.

## Accessing the Analytics Module

To access this module from JavaScript, you would do the following:

	var GA = require("analytics.google");

The GA variable is a reference to the Module object.

## Reference

### getTracker(id)

Retrieve an analytics tracker object. Must pass the "UA-XXXXXXX-X" id string that you get from Google Analytics.

### Tracker.trackEvent(params)

Tracks an event taking the following parameters:

* category : String
* action : String
* label : String
* value : Integer

### Tracker.trackScreen(name)

Tracks a screen change taking a single string parameter, the screen's name.

### Tracker.trackSocial(params)

Tracks social interactions taking the following parameters:

* network : String (e.g. facebook, pinterest, twitter)
* action : String
* target : String

### Tracker.trackTiming(params)

Tracks a timing taking the following parameters:

* category : String
* time : Integer (in milliseconds)
* name : String
* label : String

## Usage

```javascript
var GA = require('analytics.google');
var tracker = GA.getTracker("UA-XXXXXXX-X");
tracker.trackEvent({
	category: "my event category",
	action: "clicked",
	label: "how many (c)licks?",
	value: 3
});
```

## Author

Matt Tuttle - heardtheword@gmail.com

## License

Copyright (c) 2013 Matt Tuttle

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
