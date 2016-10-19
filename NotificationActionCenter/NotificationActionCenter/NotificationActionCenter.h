//
//  NotificationActionCenter.h
//  NotificationActionCenter
//
//  Created by YLCHUN on 16/4/7.
//  Copyright © 2016年 YLCHUN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NotificationActionCenter;
typedef NotificationActionCenter NACenter;

@protocol NotificationActionCenterProtocol <NSObject>
/**
 *  行为执行
 *
 *  @param name     行为名
 *  @param object   id参数
 *  @param userInfo 字典参数
 */
-(void)notificationActionWithName:(NSString*)name  object:(id) object userInfo:(NSDictionary*)userInfo;

@optional
/**
 *  绑定行为，不可重写
 *
 *  @param keyId kid
 */
-(void)bindingNotificationActionWithKeyId:(NSString*)keyId;
/**
 *  移除行为(UIViewControll销毁时候系统默认会进行关绑定移除销毁)
 */
-(void)remomeNotificationAction;

@end



@interface NotificationActionCenter : NSObject
/**
 *  发送行为
 *
 *  @param name      行为名，（默认为 NotificationAnyAction）
 *  @param targetNow 是否立刻发送，false 控制器显示时候执行（若当前控制器正在显示则立刻执行）
 *  @param vcCls     目标类
 *  @param keyId     目标类实例对象对象标识（变量）
 *  @param object    跟id参数
 *  @param userInfo  跟字典参数
 */
+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls;

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls object:(id)object;

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls userInfo:(NSDictionary*)userInfo;

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls object:(id)object userInfo:(NSDictionary*)userInfo;

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls keyId:(NSString*)keyId;

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls keyId:(NSString*)keyId object:(id)object;

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls keyId:(NSString*)keyId userInfo:(NSDictionary*)userInfo;

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls keyId:(NSString*)keyId object:(id)object userInfo:(NSDictionary*)userInfo;


/**
 *  移除行为
 *
 *  @param targetNow 是否立刻发送，false 控制器显示时候执行（若当前控制器正在显示则立刻执行）
 *  @param vcCls     目标类
 *  @param keyId     目标类实例对象对象标识（变量）
 */
+(void)removeNotificationActionWithTargetNow:(BOOL)targetNow toVCClass:(Class)vcCls keyId:(NSString*)keyId;

@end










