//
//  NotificationActionCenter.m
//  NotificationActionCenter
//
//  Created by YLCHUN on 16/4/7.
//  Copyright © 2016年 YLCHUN. All rights reserved.
//

#import "NotificationActionCenter.h"
#import <objc/runtime.h>

static NSString* NOTIFICATION_ACTION_NAME = @"NOTIFICATION_ACTION_NAME";
static NSString* kNotificationAction_Name_Any = @"NotificationAnyAction";
static NSString* kNotificationAction_KeyId_Any = @"kNotificationAction_KeyId_Any";
static NSString* kNotificationAction_Name_Remove = @"kNotificationAction_Name_Remove";
static dispatch_queue_t NotificationActionQueue;

#pragma mark- NotificationActionObject

@interface NotificationActionObject : NSObject
@property(nonatomic,assign)BOOL targetNow;
@property(nonatomic,copy)Class targetClass;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,retain)id object;
@property(nonatomic,copy)NSDictionary*userInfo;
@property(nonatomic,assign)NSString*regKeyId;

-(NotificationActionObject*)copyObj;
-(void)copyObj:(NotificationActionObject*)notificationActionObject;
@end

@implementation NotificationActionObject
-(NotificationActionObject*)copyObj{
    NotificationActionObject *notificationActionObject=[[NotificationActionObject alloc]init];
    notificationActionObject.object=[self.object copy];
    notificationActionObject.name=[self.name copy];
    notificationActionObject.targetClass=self.targetClass;
    notificationActionObject.targetNow=self.targetNow;
    notificationActionObject.userInfo=[self.userInfo copy];
    notificationActionObject.regKeyId=self.regKeyId;
    return notificationActionObject;
}
-(void)copyObj:(NotificationActionObject*)notificationActionObject{
    self.name=notificationActionObject.name;
    self.object=notificationActionObject.object;
    self.targetClass=notificationActionObject.targetClass;
    self.targetNow=notificationActionObject.targetNow;
    self.userInfo=notificationActionObject.userInfo;
    self.regKeyId=notificationActionObject.regKeyId;
}
@end

#pragma mark- NotificationActionCenter

@implementation NotificationActionCenter

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls{
    [self pushNotificationActionWithName:name targetNow:targetNow toVCClass:vcCls object:nil userInfo:nil];
}

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls object:(id)object{
    [self pushNotificationActionWithName:name targetNow:targetNow toVCClass:vcCls object:object userInfo:nil];
}

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls userInfo:(NSDictionary*)userInfo{
    [self pushNotificationActionWithName:name targetNow:targetNow toVCClass:vcCls object:nil userInfo:userInfo];
}

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls object:(id)object userInfo:(NSDictionary*)userInfo{
    [self pushNotificationActionWithName:name targetNow:targetNow toVCClass:vcCls keyId:nil object:object userInfo:userInfo];
}

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls keyId:(NSString*)keyId {
    [self pushNotificationActionWithName:name targetNow:targetNow toVCClass:vcCls keyId:keyId object:nil userInfo:nil];
}

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls keyId:(NSString*)keyId  object:(id)object{
    [self pushNotificationActionWithName:name targetNow:targetNow toVCClass:vcCls keyId:keyId object:object userInfo:nil];
}

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls keyId:(NSString*)keyId  userInfo:(NSDictionary*)userInfo{
    [self pushNotificationActionWithName:name targetNow:targetNow toVCClass:vcCls keyId:keyId object:nil userInfo:userInfo];
}

+(void)pushNotificationActionWithName:(NSString*)name targetNow:(BOOL)targetNow toVCClass:(Class)vcCls keyId:(NSString*)keyId object:(id)object userInfo:(NSDictionary*)userInfo{
    NSString*actionName;
    if ([name isKindOfClass:[NSString class]]) {
        actionName=name;
    }
    NSString*regKeyId;
    if ([keyId isKindOfClass:[NSString class]]) {
        regKeyId=keyId;
    }
    NotificationActionObject *notificationActionObject=[[NotificationActionObject alloc]init];
    notificationActionObject.object=object;
    notificationActionObject.name=actionName;
    notificationActionObject.targetClass=vcCls;
    notificationActionObject.targetNow=targetNow;
    notificationActionObject.userInfo=userInfo;
    notificationActionObject.regKeyId=regKeyId;
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_ACTION_NAME object:notificationActionObject userInfo:nil];
}

+(void)removeNotificationActionWithTargetNow:(BOOL)targetNow toVCClass:(Class)vcCls keyId:(NSString*)keyId{
    [self pushNotificationActionWithName:kNotificationAction_Name_Remove targetNow:targetNow toVCClass:vcCls keyId:keyId object:nil userInfo:nil];
}
@end

//@interface UIView ()
//@property(nonatomic,copy)void(^dNot_showBlock)(void);
//@end
//@implementation UIView (NotificationActionCenter)
//
//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        
//        SEL originalSelector = @selector(didMoveToWindow);
//        SEL swizzledSelector = @selector(dNot_didMoveToWindow);
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        if (success) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}
//
//-(void)dNot_didMoveToWindow{
//    if (self.dNot_showBlock) {
//        self.dNot_showBlock();
//    }
//    [self dNot_didMoveToWindow];
//}
//
//-(void (^)(void))dNot_showBlock{
//    return objc_getAssociatedObject(self, _cmd);
//}
//
//-(void)setDNot_showBlock:(void (^)(void))block{
//    objc_setAssociatedObject(self, @selector(dNot_showBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//@end

#pragma mark- UIViewController (NotificationActionCenter)

@interface UIViewController (Reailze)<NotificationActionCenterProtocol>
@end
@implementation UIViewController (Reailze)
-(void)notificationActionWithName:(NSString*)name object:(id) object userInfo:(NSDictionary*)userInfo{}
@end

@interface UIViewController (NotificationActionCenter)
@property(nonatomic,assign)NSNumber* dNot_notTag;//默认 -1； -1可以注册通知，0空闲，1正在刷新（1用于显示刷新）
@property(nonatomic,assign)NSNumber* dNot_didShow;
@property(nonatomic,copy)void(^dNot_showBlock)(void);
@property(nonatomic,copy)NSString* dNot_regKeyId;//默认 kNotificationAction_KeyId_Any
//@property(nonatomic)NSMutableArray<NotificationActionObject*>* dNot_notObjs;
@property(nonatomic)NSMutableArray<NSString*>* dNot_notObjsNotNames;
@property(nonatomic)NSMutableDictionary<NSString*,NotificationActionObject*>* dNot_notObjsDict;
@end
@implementation UIViewController (NotificationActionCenter)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NotificationActionQueue = dispatch_queue_create("NotificationActionQueue", DISPATCH_QUEUE_SERIAL);
        Class class = [self class];
        SEL originalSelector;
        SEL swizzledSelector;
        Method originalMethod;
        Method swizzledMethod;
        BOOL success;
        
        originalSelector = @selector(viewDidLoad);
        swizzledSelector = @selector(dNot_viewDidLoad);
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        originalSelector = @selector(viewWillAppear:);
        swizzledSelector = @selector(dNot_viewWillAppear:);
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        originalSelector = @selector(viewDidDisappear:);
        swizzledSelector = @selector(dNot_viewDidDisappear:);
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


-(void)dNot_viewDidLoad{
    if ([self conformsToProtocol:@protocol(NotificationActionCenterProtocol)]) {
        self.dNot_notTag=@-1;
        self.dNot_didShow=@0;
        __weak UIViewController* dNot_weekSelf=self;
        dispatch_sync(NotificationActionQueue, ^{
            if (!dNot_weekSelf.dNot_showBlock) {//显示响应
                dNot_weekSelf.dNot_showBlock=^(){
                    BOOL needRemoveNotRef=false;
                    dNot_weekSelf.dNot_notTag=@1;
                    
                    for (NSInteger i=0; i<dNot_weekSelf.dNot_notObjsNotNames.count; i++) {
                        NSString *actionName=dNot_weekSelf.dNot_notObjsNotNames[i];
                        NotificationActionObject*notObj=dNot_weekSelf.dNot_notObjsDict[actionName];
                        if ([actionName isEqualToString:kNotificationAction_Name_Remove]) {
                            needRemoveNotRef=true;
                        }else{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [dNot_weekSelf notificationActionWithName:actionName object:notObj.object userInfo:notObj.userInfo];
                            });
                            [dNot_weekSelf.dNot_notObjsDict removeObjectForKey:actionName];
                            [dNot_weekSelf.dNot_notObjsNotNames removeObject:actionName];
                            i-=1;
                        }
                    }
                    
                    
    //                for (NSInteger i=0; i<dNot_weekSelf.dNot_notObjs.count; i++) {
    //                    @try {
    //                        NotificationActionObject*notObj=dNot_weekSelf.dNot_notObjs[i];
    //                        NSString*notName=notObj.notName.length>0?notObj.notName:kNotificationAction_Name_Any;
    //                        if ([notName isEqualToString:kNotificationAction_Name_Remove]) {
    //                            needRemoveNotRef=true;
    //                        }else{
    //                            dispatch_async(dispatch_get_main_queue(), ^{
    //                                [dNot_weekSelf refnotificationActionWithName:notName object:notObj.object userInfo:notObj.userInfo];
    //                            });
    //                            [dNot_weekSelf.dNot_notObjs removeObject:notObj];
    //                            i-=1;
    //                        }
    //                    } @catch (NSException *exception) {
    //                        
    //                    } @finally {
    //                        
    //                    }
    //                }
                    
                    dNot_weekSelf.dNot_notTag=@0;
                    if (needRemoveNotRef) {
                        for (UIViewController*subVC in dNot_weekSelf.childViewControllers) {
                            [subVC remomeNotificationAction];
                        }
                        [dNot_weekSelf remomeNotificationAction];
                    }
                };
            }
        });
    }
    [self dNot_viewDidLoad];
}

- (void)dNot_viewWillAppear:(BOOL)animated{
    if ([self conformsToProtocol:@protocol(NotificationActionCenterProtocol)]) {
        self.dNot_didShow=@1;
        if(self.dNot_showBlock){
            self.dNot_showBlock();
        }
    }
    [self dNot_viewWillAppear:animated];
}

-(void)dNot_viewDidDisappear:(BOOL)animated{
    if ([self conformsToProtocol:@protocol(NotificationActionCenterProtocol)]) {
        self.dNot_didShow=@0;
    }
    [self dNot_viewDidDisappear:animated];
}

-(void)dNot_regNot{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dNot_notAction:) name:NOTIFICATION_ACTION_NAME object:nil];
    self.dNot_notTag=@0;
}

-(void)dNot_notAction:(NSNotification*)notification{
    __weak UIViewController* dNot_weekSelf=self;
    dispatch_async(NotificationActionQueue, ^{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        BOOL targetToSelf=false;
        NotificationActionObject *notObj=(NotificationActionObject*)notification.object;
        if ((!notObj.targetClass || notObj.targetClass==dNot_weekSelf.class)&&(notObj.regKeyId.length==0 || [dNot_weekSelf.dNot_regKeyId isEqualToString:notObj.regKeyId])) {
            targetToSelf=true;
        }
        if (targetToSelf) {
            notObj=[notObj copyObj];
            if (notObj.targetNow||(dNot_weekSelf.dNot_didShow.intValue==1&&dNot_weekSelf.dNot_notTag.intValue==0)) {//立刻响应
                NSString*actionName=notObj.name.length>0?notObj.name:kNotificationAction_Name_Any;
                if ([actionName isEqualToString:kNotificationAction_Name_Remove]) {
                    for (UIViewController*subVC in dNot_weekSelf.childViewControllers) {
                        [subVC remomeNotificationAction];
                    }
                    [dNot_weekSelf remomeNotificationAction];
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [dNot_weekSelf notificationActionWithName:actionName object:notObj.object userInfo:notObj.userInfo];
                    });
                }
            }else{
                //缓存更新通知
                [dNot_weekSelf tsNotObj:notObj];
            }
        }
    });
}


-(void)tsNotObj:(NotificationActionObject*)notObj{
//        if (!self.dNot_notObjs) {
//            self.dNot_notObjs=[NSMutableArray array];
//        }
//        NSString*notName=notObj.notName.length>0?notObj.notName:kNotificationAction_Name_Any;
//        NSString *preStr=[NSString stringWithFormat:@"notName == '%@'",notName];
//        NSPredicate *pre = [NSPredicate predicateWithFormat:preStr];
//        pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
//        pthread_mutex_lock(&mutex);
//        NSArray *arrayPre = [self.dNot_notObjs filteredArrayUsingPredicate: pre];
//        if (arrayPre.count>0) {
//            [self.dNot_notObjs removeObjectsInArray:arrayPre];
//        }
//        [self.dNot_notObjs addObject:notObj];
//        pthread_mutex_unlock(&mutex);
    
    if (!self.dNot_notObjsDict) {
        self.dNot_notObjsDict=[NSMutableDictionary<NSString *,NotificationActionObject *> dictionary];
    }
    if (!self.dNot_notObjsNotNames) {
        self.dNot_notObjsNotNames=[NSMutableArray<NSString*> array];
    }
    NSString*actionName=notObj.name.length>0?notObj.name:kNotificationAction_Name_Any;
    if (![self.dNot_notObjsNotNames containsObject:actionName]) {
        [self.dNot_notObjsNotNames addObject:actionName];
    }
    self.dNot_notObjsDict[actionName]=notObj;
}


//-(NSMutableArray<NotificationActionObject *> *)dNot_notObjs{
//    return objc_getAssociatedObject(self, _cmd);
//}
//
//-(void)setDNot_notObjs:(NSMutableArray<NotificationActionObject *> *)objs{
//    objc_setAssociatedObject(self, @selector(dNot_notObjs), objs, OBJC_ASSOCIATION_RETAIN);
//}

-(NSMutableArray<NSString *> *)dNot_notObjsNotNames{
     return objc_getAssociatedObject(self, _cmd);
}

-(void)setDNot_notObjsNotNames:(NSMutableArray<NSString *> *)dNot_notObjsNotNames{
    objc_setAssociatedObject(self, @selector(dNot_notObjsNotNames), dNot_notObjsNotNames, OBJC_ASSOCIATION_RETAIN);
}

-(NSMutableDictionary<NSString *,NotificationActionObject *> *)dNot_notObjsDict{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setDNot_notObjsDict:(NSMutableDictionary<NSString *,NotificationActionObject *> *)dNot_notObjsDict{
    objc_setAssociatedObject(self, @selector(dNot_notObjsDict), dNot_notObjsDict, OBJC_ASSOCIATION_RETAIN);
}

-(void (^)(void))dNot_showBlock{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setDNot_showBlock:(void (^)(void))block{
    objc_setAssociatedObject(self, @selector(dNot_showBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//-1可以注册通知，0空闲，1正在刷新
-(NSNumber*)dNot_notTag{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setDNot_notTag:(NSNumber*)notTag{
    objc_setAssociatedObject(self, @selector(dNot_notTag), notTag, OBJC_ASSOCIATION_ASSIGN);
}

-(NSNumber*)dNot_didShow{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setDNot_didShow:(NSNumber*)didShow{
    objc_setAssociatedObject(self, @selector(dNot_didShow), didShow, OBJC_ASSOCIATION_ASSIGN);
}

-(NSString *)dNot_regKeyId{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setDNot_regKeyId:(NSString *)regKeyId{
    objc_setAssociatedObject(self, @selector(dNot_regKeyId), regKeyId, OBJC_ASSOCIATION_ASSIGN);
}

-(void)bindingNotificationActionWithKeyId:(NSString*)keyId{
    self.dNot_regKeyId=keyId.length>0?keyId:kNotificationAction_KeyId_Any;
    if (self.dNot_notTag.intValue==-1) {
        [self dNot_regNot];
    }
}

-(void)remomeNotificationAction{
    if (self.dNot_notTag.intValue!=-1) {
//        [self.dNot_notObjs removeAllObjects];
//        self.dNot_notObjs=nil;
        [self.dNot_notObjsDict removeAllObjects];
        self.dNot_notObjsDict=nil;
        [self.dNot_notObjsNotNames removeAllObjects];
        self.dNot_notObjsNotNames=nil;
        self.dNot_regKeyId=nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_ACTION_NAME object:nil];
        self.dNot_notTag=@-1;
    }
}
@end


