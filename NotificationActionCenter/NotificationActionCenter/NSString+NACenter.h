//
//  NSString+NACenter.h
//  NotificationActionCenter
//
//  Created by YLCHUN on 16/9/1.
//  Copyright © 2016年 YLCHUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NotNameIs(name)  notName.is(name)
@interface NSString (NACenter)
@property(nonatomic,copy,readonly)BOOL(^is)(NSString*string);
@property(nonatomic,copy,readonly)BOOL(^isIn)(NSArray<NSString*>*);
@end
