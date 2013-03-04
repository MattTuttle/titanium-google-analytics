/**
 * Copyright (c) 2012 by Matt Tuttle
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"

#import "GAI.h"

@interface AnalyticsGoogleModule : TiModule {
    BOOL optOut;
    BOOL debug;
    NSTimeInterval dispatchInterval;
}

@end
