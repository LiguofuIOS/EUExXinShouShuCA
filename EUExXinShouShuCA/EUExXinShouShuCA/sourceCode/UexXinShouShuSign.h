//
//  UexXinShouShuSign.h
//  EUExXinShouShuCA
//
//  Created by liguofu on 15/9/18.
//  Copyright (c) 2015年 liguofu. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BjcaInterfaceView.h"
#import "UexXinShouShuCAUtility.h"
#import "EUtility.h"
#import "EUExBaseDefine.h"


@class EUExXinShouShuCA;

@interface UexXinShouShuSign : NSObject<OnSignListenerDelegate>

@property (nonatomic, assign) EUExXinShouShuCA *uexObj;

@property (nonatomic, retain) BjcaInterfaceView *interfaceView;

@property (nonatomic, retain) UIImageView *myCameraImage;

@property (nonatomic, retain) UIImageView *myOrignalImage;

@property (nonatomic, retain) UIView *signView;

- (id)initWithUexObj:(EUExXinShouShuCA *)uexObj;

//打开签名

- (void)openSignView:(NSMutableArray *)arr;

//打开批注签名

- (void)openMassSignView:(NSMutableArray *)arr;


//获取数据报

- (void)getDataGramFromSign;

@end
