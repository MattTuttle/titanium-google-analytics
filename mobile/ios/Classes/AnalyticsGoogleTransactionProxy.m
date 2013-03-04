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
    RELEASE_TO_NIL(transaction);
    [super dealloc];
}

-(void)InitTransaction:(id)args
{
    NSString *transactionId;
    NSString *affiliation;
    
    ENSURE_ARG_FOR_KEY(transactionId, args, @"id", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(affiliation, args, @"affiliation", NSString);
    
    transaction = [GAITransaction transactionWithId:transactionId
                                    withAffiliation:affiliation];
}

-(id)initWithArgs:(NSDictionary*)args
{
    if (self = [super init])
    {
        ENSURE_UI_THREAD(InitTransaction, args);
    }
    return self;
}

#pragma mark Public APIs

-(void)setTax:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    
    transaction.taxMicros = [value doubleValue] * 1000000;
}

-(void)setShipping:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    
    transaction.shippingMicros = [value doubleValue] * 1000000;
}

-(void)setRevenue:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    
    transaction.revenueMicros = [value doubleValue] * 1000000;
}

-(void)addItem:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *productCode;
    NSString *productName;
    NSString *productCategory;
    NSNumber *priceMicros;
    NSNumber *quantity;
    
    ENSURE_ARG_FOR_KEY(productCode, args, @"sku", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(productName, args, @"name", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(productCategory, args, @"category", NSString);
    ENSURE_ARG_FOR_KEY(priceMicros, args, @"price", NSNumber);
    ENSURE_ARG_FOR_KEY(quantity, args, @"quantity", NSNumber);
    
    [transaction addItemWithCode:productCode
                            name:productName
                        category:productCategory
                     priceMicros:[priceMicros doubleValue] * 1000000
                        quantity:[quantity integerValue]];
}

-(GAITransaction*)transaction
{
    return transaction;
}

@end
