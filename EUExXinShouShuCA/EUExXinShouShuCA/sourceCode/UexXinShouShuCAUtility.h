//
//  UexXinShouShuCAUtility.h
//  EUExXinShouShuCA
//
//  Created by liguofu on 15/9/18.
//  Copyright (c) 2015年 liguofu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BjcaInterfaceView.h"

@interface UexXinShouShuCAUtility : NSObject

+ (signinfo)SetSignData:(int)index info:(signinfo *)infodata;

+ (NSString * )getTestSignItemValue :(NSString *) item index:(int)ArrayIndex;

+ (NSString *)getTestPlistItemValue :(NSString *) item keyName:(NSString *)key index:(int)ArrayIndex;

+ (signMutiInfo)SetMutiSignData:(int)index info:(signMutiInfo *)infodata;

+ (BOOL)setDataArray:(BjcaInterfaceView *)interfaceView;

+ (formInfo)setFormInfoData:(formInfo *)infodata;

+ (NSString *)writeDataGramToFile:(NSData *)dataGram;

@end
