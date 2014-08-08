//
//  AL2Utils.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "AL2Utils.h"
#import <objc/runtime.h>

@implementation AL2Utils

+ (BOOL)swizzleMethod:(SEL)originalSelector in:(Class)klass with:(SEL)anotherSelector in:(Class)anotherKlass
{
    Method originalMethod = class_getInstanceMethod(klass, originalSelector);
    Method anotherMethod  = class_getInstanceMethod(anotherKlass, anotherSelector);
    if(!originalMethod || !anotherMethod) {
        return NO;
    }
    IMP originalMethodImplementation = class_getMethodImplementation(klass, originalSelector);
    IMP anotherMethodImplementation  = class_getMethodImplementation(anotherKlass, anotherSelector);
    if(class_addMethod(klass, originalSelector, originalMethodImplementation, method_getTypeEncoding(originalMethod))) {
        originalMethod = class_getInstanceMethod(klass, originalSelector);
    }
    if(class_addMethod(anotherKlass, anotherSelector,  anotherMethodImplementation,  method_getTypeEncoding(anotherMethod))) {
        anotherMethod = class_getInstanceMethod(anotherKlass, anotherSelector);
    }
    method_exchangeImplementations(originalMethod, anotherMethod);
    return YES;
}

@end
