/**
 * Copyright (c) 2012 by Matt Tuttle
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "AnalyticsGoogleModule.h"
#import "AnalyticsGoogleTransactionProxy.h"
#import "AnalyticsGoogleTrackerProxy.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation AnalyticsGoogleModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"896dcd67-ac04-4df5-8a2a-923f6f1556ce";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"analytics.google";
}

#pragma mark Lifecycle

-(void)startup
{
	[super startup];

    // Dispatch any stored tracking events
    if (![NSThread isMainThread])
    {
        TiThreadPerformOnMainThread(^{
            optOut = [[GAI sharedInstance] optOut];
            debug = [[GAI sharedInstance] debug];
            dispatchInterval = [[GAI sharedInstance] dispatchInterval];
        }, NO);
    }
}

-(void)shutdown:(id)sender
{
	[super shutdown:sender];

    // Dispatch any stored tracking events
    if (![NSThread isMainThread])
    {
        TiThreadPerformOnMainThread(^{
            [[GAI sharedInstance] dispatch];
        }, NO);
    }
}

#pragma mark Cleanup

-(void)dealloc
{
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma Public APIs

-(id)getTracker:(id)args
{
    NSString *trackingId;
    ENSURE_ARG_AT_INDEX(trackingId, args, 0, NSString);

	return [[[AnalyticsGoogleTrackerProxy alloc] initWithTrackingId:trackingId] autorelease];
}

-(id)makeTransaction:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    return [[[AnalyticsGoogleTransactionProxy alloc] initWithArgs:args] autorelease];
}

-(id)optOut
{
    return [NSNumber numberWithBool:optOut];
}

-(void)setOptOut:(id)value
{
    ENSURE_UI_THREAD_1_ARG(value);
    ENSURE_TYPE(value, NSNumber);
    [GAI sharedInstance].optOut = optOut = [TiUtils boolValue:value];
}

-(id)defaultTracker
{
    return [[AnalyticsGoogleTrackerProxy alloc] initWithDefault];
}

-(id)debug
{
    return [NSNumber numberWithBool:debug];
}

-(void)setDebug:(id)value
{
    ENSURE_UI_THREAD_1_ARG(value);
    ENSURE_TYPE(value, NSNumber);
    [GAI sharedInstance].debug = debug = [TiUtils boolValue:value];
}

-(id)dispatchInterval
{
    return [NSNumber numberWithDouble:dispatchInterval];
}

-(void)setDispatchInterval:(id)value
{
    ENSURE_UI_THREAD_1_ARG(value);
    ENSURE_TYPE(value, NSNumber);
    [GAI sharedInstance].dispatchInterval = dispatchInterval = [value doubleValue];
}

-(void)setTrackUncaughtExceptions:(id)value
{
    ENSURE_UI_THREAD_1_ARG(value);
    ENSURE_TYPE(value, NSNumber);
    [GAI sharedInstance].trackUncaughtExceptions = [value boolValue];
}

@end
