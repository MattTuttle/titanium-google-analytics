/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "AnalyticsGoogleTransactionProxy.h"
#import "TiBase.h"

@implementation AnalyticsGoogleTransactionProxy

-(void)dealloc
{
    RELEASE_TO_NIL(_transaction);
    [super dealloc];
}

-(void)InitTransaction:(id)args
{
    NSString *transactionId;
    NSString *affiliation;
    NSNumber *tax;
    NSNumber *shipping;
    NSNumber *revenue;

    ENSURE_ARG_FOR_KEY(transactionId, args, @"id", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(affiliation, args, @"affiliation", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(tax, args, @"tax", NSNumber);
    ENSURE_ARG_OR_NIL_FOR_KEY(shipping, args, @"shipping", NSNumber);
    ENSURE_ARG_OR_NIL_FOR_KEY(revenue, args, @"revenue", NSNumber);

    _transaction = [[GAITransaction transactionWithId:transactionId
                                    withAffiliation:affiliation] retain];
    _transaction.taxMicros = [self toMicros:[tax doubleValue]];
    _transaction.shippingMicros = [self toMicros:[shipping doubleValue]];
    _transaction.revenueMicros = [self toMicros:[revenue doubleValue]];
}

-(id)initWithArgs:(NSDictionary*)args
{
    if (self = [super init])
    {
        _transaction = nil;
        ENSURE_UI_THREAD(InitTransaction, args);
    }
    return self;
}

-(int64_t)toMicros:(double)value
{
    return (int64_t) (value * 1000000);
}

#pragma mark Public APIs

-(void)addItem:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *productCode;
    NSString *productName;
    NSString *productCategory;
    NSNumber *price;
    NSNumber *quantity;

    ENSURE_ARG_FOR_KEY(productCode, args, @"sku", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(productName, args, @"name", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(productCategory, args, @"category", NSString);
    ENSURE_ARG_FOR_KEY(price, args, @"price", NSNumber);
    ENSURE_ARG_FOR_KEY(quantity, args, @"quantity", NSNumber);

    GAITransactionItem *item = [GAITransactionItem itemWithCode:productCode
                                                           name:productName
                                                       category:productCategory
                                                    priceMicros:[self toMicros:[price doubleValue]]
                                                       quantity:[quantity integerValue]];
    [_transaction addItem:item];
}

-(GAITransaction*)transaction
{
    return _transaction;
}

@end
