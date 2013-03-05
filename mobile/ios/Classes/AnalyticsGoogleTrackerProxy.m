/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "AnalyticsGoogleTrackerProxy.h"
#import "AnalyticsGoogleTransactionProxy.h"


@implementation AnalyticsGoogleTrackerProxy

-(id)initWithDefault
{
    if (self = [super init])
    {
        if (![NSThread isMainThread])
        {
            TiThreadPerformOnMainThread(^{
                tracker = [[GAI sharedInstance] defaultTracker];
                trackingId = [tracker trackingId];
            }, NO);
        }
    }
    return self;
}

-(id)initWithTrackingId:(NSString*)value
{
    if (self = [super init])
    {
        trackingId = [[NSString alloc] initWithString:value];
        if (![NSThread isMainThread])
        {
            TiThreadPerformOnMainThread(^{
                tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
            }, NO);
        }
    }
    return self;
}

-(void)dealloc
{
    RELEASE_TO_NIL(tracker);
    RELEASE_TO_NIL(trackingId);
    [super dealloc];
}

#pragma mark Public APIs

-(void)trackEvent:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *category;
    NSString *action;
    NSString *label;
    NSNumber *value;

    ENSURE_ARG_OR_NIL_FOR_KEY(category, args, @"category", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(action, args, @"action", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(label, args, @"label", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(value, args, @"value", NSNumber);

    [tracker sendEventWithCategory:category
                         withAction:action
                          withLabel:label
                          withValue:value];
}

-(void)trackSocial:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *network;
    NSString *action;
    NSString *target;

    ENSURE_ARG_FOR_KEY(network, args, @"network", NSString);
    ENSURE_ARG_FOR_KEY(action, args, @"action", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(target, args, @"target", NSString);

    [tracker sendSocial:network
              withAction:action
              withTarget:target];
}

-(void)trackTiming:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *category;
    NSNumber *time;
    NSString *name;
    NSString *label;

    ENSURE_ARG_FOR_KEY(category, args, @"category", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(name, args, @"name", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(label, args, @"label", NSString);
    ENSURE_ARG_FOR_KEY(time, args, @"time", NSNumber);

    [tracker sendTimingWithCategory:category
                           withValue:[time doubleValue]
                            withName:name
                           withLabel:label];
}

-(void)trackScreen:(id)value
{
    ENSURE_UI_THREAD_1_ARG(value);
    ENSURE_SINGLE_ARG(value, NSString);

    [tracker sendView:value];
}

-(void)trackTransaction:(id)value
{
    ENSURE_UI_THREAD_1_ARG(value);
    ENSURE_SINGLE_ARG(value, AnalyticsGoogleTransactionProxy);

    AnalyticsGoogleTransactionProxy *proxy = (AnalyticsGoogleTransactionProxy*)value;
    [tracker sendTransaction: [proxy transaction]];
}

-(void)send:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *trackType;
    NSDictionary *parameters;

    ENSURE_ARG_FOR_KEY(trackType, args, @"trackType", NSString);
    ENSURE_ARG_FOR_KEY(parameters, args, @"parameters", NSDictionary);

    [tracker send:trackType params:parameters];
}

-(void)close
{
    ENSURE_UI_THREAD_0_ARGS;
    [tracker close];
}

-(id)trackingId
{
    return trackingId;
}

-(void)setAnonymize:(id)value
{
    ENSURE_UI_THREAD_1_ARG(value);
    ENSURE_SINGLE_ARG(value, NSNumber);

    tracker.anonymize = [value boolValue];
}

-(void)setUseHttps:(id)value
{
    ENSURE_UI_THREAD_1_ARG(value);
    ENSURE_SINGLE_ARG(value, NSNumber);

    tracker.useHttps = [value boolValue];
}

-(void)setSampleRate:(id)value
{
    ENSURE_UI_THREAD_1_ARG(value);
    ENSURE_SINGLE_ARG(value, NSNumber);

    tracker.sampleRate = [value doubleValue];
}

-(id<GAITracker>)tracker
{
    return tracker;
}

@end
