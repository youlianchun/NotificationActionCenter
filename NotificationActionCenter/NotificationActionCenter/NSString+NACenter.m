//
//  NSString+NACenter.m
//  NotificationActionCenter
//
//  Created by YLCHUN on 16/9/1.
//  Copyright © 2016年 YLCHUN. All rights reserved.
//

#import "NSString+NACenter.h"

@implementation NSString (NACenter)
-(BOOL (^)(NSString *))is{
    return ^(NSString *str){
        BOOL b=[self isEqualToString:str];
        return  b;
    };
}

-(BOOL (^)(NSArray<NSString*>*))isIn{
    return ^(NSArray<NSString*>*strs){
        BOOL b=[strs containsObject:self];
        return  b;
    };
}
@end
