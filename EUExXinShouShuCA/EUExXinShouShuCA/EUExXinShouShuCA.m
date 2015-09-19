//
//  EUExXinShouShuCA.m
//  EUExXinShouShuCA
//
//  Created by liguofu on 15/9/17.
//  Copyright (c) 2015年 liguofu. All rights reserved.
//

#import "EUExXinShouShuCA.h"

@implementation EUExXinShouShuCA

- (id)initWithBrwView:(EBrowserView *)eInBrwView {
    
    if (self = [super initWithBrwView:eInBrwView]) {
        
        NSLog(@"appcan-->uexXinShouShuCA-->initWithBrwView-->version_3.0.0");
        
    }
    
    return self;
    
}

/**
 *
 * 信手书 签名
 *
 * 参数:
 **/

- (void)sign:(NSMutableArray *)inArguments {
    
    if (_xinShouShuSign) {
        
        
    } else {
        
        _xinShouShuSign = [[UexXinShouShuSign alloc] initWithUexObj:self];

    }
    
    [_xinShouShuSign openSignView:inArguments];
    

}

/**
 *
 * 信手书 批注签名
 *
 * 参数:
 **/

- (void)multiSign:(NSMutableArray *)inArguments {
    
    if (_xinShouShuSign) {
        
        
    } else {
        
        _xinShouShuSign = [[UexXinShouShuSign alloc] initWithUexObj:self];
        
    }
    
    [_xinShouShuSign openMassSignView:inArguments];
    
}

- (void)getUploadDataGram:(NSMutableArray *)inArguments {
    
    if (_xinShouShuSign) {
        
        
    } else {
        
        _xinShouShuSign = [[UexXinShouShuSign alloc] initWithUexObj:self];
        
    }
    
    [_xinShouShuSign getDataGramFromSign];
    
}

/**
 *
 * 信手书 关闭
 *
 * 参数:
 **/

- (void)cleanSignImage:(NSMutableArray *)inArguments {
    
    NSString *path = @"";
    
    if (inArguments.count > 0) {
        
        path = [NSString stringWithFormat:@"%@",[inArguments objectAtIndex:0]];
        
    } else {
        
        [self jsSuccessWithName:@"uexXinShouShuCA.cbCleanSignImage" opId:0 dataType:UEX_CALLBACK_DATATYPE_TEXT strData:@"参数错误"];
        
    }
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath:path]) {
        
        BOOL isSuc = [fileMgr removeItemAtPath:path error:nil];
        
        if (isSuc) {
            
            [self jsSuccessWithName:@"uexXinShouShuCA.cbCleanSignImage" opId:0 dataType:UEX_CALLBACK_DATATYPE_INT intData:0];
            
        } else {
            
            [self jsSuccessWithName:@"uexXinShouShuCA.cbCleanSignImage" opId:0 dataType:UEX_CALLBACK_DATATYPE_INT intData:1];
            
        }
        
    } else {
        
        [self jsSuccessWithName:@"uexXinShouShuCA.cbCleanSignImage" opId:0 dataType:UEX_CALLBACK_DATATYPE_TEXT strData:@"路径不存在"];
        
    }
    
}

- (void)dealloc {
    
    if (_xinShouShuSign) {
        
        [_xinShouShuSign release];
        _xinShouShuSign = nil;
    }
    
    [super dealloc];
}
- (void)clean {
    
}

@end
