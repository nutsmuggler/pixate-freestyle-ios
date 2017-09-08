//
//  PXArrayUnshiftMethod.m
//  pixate-expression-machine
//
//  Created by Kevin Lindsey on 3/25/14.
//  Copyright (c) 2014 Pixate, Inc. All rights reserved.
//

#import "PXArrayUnshiftMethod.h"
#import "PXArrayValue.h"

@implementation PXArrayUnshiftMethod

- (void)invokeWithEnvironment:(PXExpressionEnvironment *)env
             invocationObject:(id<PXExpressionValue>)invocationObject
                         args:(id<PXExpressionArray>)args
{
    if (invocationObject.valueType == PX_VALUE_TYPE_ARRAY)
    {
        PXArrayValue *array = (PXArrayValue *)invocationObject;

        [args.elements enumerateObjectsUsingBlock:^(id<PXExpressionValue> value, NSUInteger idx, BOOL *stop) {
            [array unshiftValue:value];
        }];
    }
    else
    {
        [env logMessage:@"The unshift method expects an array as the invocation object"];
    }
}

@end
