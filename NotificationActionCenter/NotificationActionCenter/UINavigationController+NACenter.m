//
//  UINavigationController+NACenter.m
//  NotificationActionCenter
//
//  Created by YLCHUN on 16/9/1.
//  Copyright © 2016年 YLCHUN. All rights reserved.
//

#import "UINavigationController+NACenter.h"
#import <objc/runtime.h>
#import "NotificationActionCenter.h"

@implementation UINavigationController (NACenter)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(popViewControllerAnimated:);
        SEL swizzledSelector = @selector(dNot_popViewControllerAnimated:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }

        originalSelector = @selector(popToViewController:animated:);
        swizzledSelector = @selector(dNot_popToViewController:animated:);
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }


        originalSelector = @selector(popToRootViewControllerAnimated:);
        swizzledSelector = @selector(dNot_popToRootViewControllerAnimated:);
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

-(UIViewController *)dNot_popViewControllerAnimated:(BOOL)animated{
    UIViewController*popedVC=[self dNot_popViewControllerAnimated:animated];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (UIViewController*subVC in popedVC.childViewControllers) {
            if ([subVC conformsToProtocol:@protocol(NotificationActionCenterProtocol)]) {
                [subVC performSelector:@selector(remomeNotificationAction)];
            }
        }
        if ([popedVC conformsToProtocol:@protocol(NotificationActionCenterProtocol)]) {
            [popedVC performSelector:@selector(remomeNotificationAction)];
        }
    });
    return popedVC;
}

-(NSArray<UIViewController *> *)dNot_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSArray<UIViewController *> *popedVCs=[self dNot_popToViewController:viewController animated:animated];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (UIViewController *popedVC in popedVCs) {
            for (UIViewController*subVC in popedVC.childViewControllers) {
                if ([subVC conformsToProtocol:@protocol(NotificationActionCenterProtocol)]) {
                    [subVC performSelector:@selector(remomeNotificationAction)];
                }
            }
            if ([popedVC conformsToProtocol:@protocol(NotificationActionCenterProtocol)]) {
                [popedVC performSelector:@selector(remomeNotificationAction)];
            }
        }
    });
    return popedVCs;
}
-(NSArray<UIViewController *> *)dNot_popToRootViewControllerAnimated:(BOOL)animated{
    NSArray<UIViewController *> *popedVCs=[self dNot_popToRootViewControllerAnimated:animated];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (UIViewController *popedVC in popedVCs) {
            for (UIViewController*subVC in popedVC.childViewControllers) {
                if ([subVC conformsToProtocol:@protocol(NotificationActionCenterProtocol)]) {
                    [subVC performSelector:@selector(remomeNotificationAction)];
                }
            }
            if ([popedVC conformsToProtocol:@protocol(NotificationActionCenterProtocol)]) {
                [popedVC performSelector:@selector(remomeNotificationAction)];
            }
        }
    });
    return popedVCs;
}
@end

