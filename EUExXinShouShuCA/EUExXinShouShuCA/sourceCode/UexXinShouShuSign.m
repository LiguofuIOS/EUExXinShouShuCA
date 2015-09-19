//
//  UexXinShouShuSign.m
//  EUExXinShouShuCA
//
//  Created by liguofu on 15/9/18.
//  Copyright (c) 2015年 liguofu. All rights reserved.
//

#import "UexXinShouShuSign.h"
#import "EUExXinShouShuCA.h"

@implementation UexXinShouShuSign


- (id)initWithUexObj:(EUExXinShouShuCA *)uexObj {
    
    if (self = [super init]) {
        
        self.uexObj = uexObj;
        
        _interfaceView = [[BjcaInterfaceView alloc]init];
        _interfaceView.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRecord:) name:@"record" object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCameraImage:) name:@"cameraPicture" object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelCamera:) name:@"cancelPicture" object:nil];
        
    }
    
    return self;
    
}

- (void)openSignView:(NSMutableArray *)arr {
    
    NSString *strIndex = @"0";
    
    if (arr.count > 0) {
        
        strIndex = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
        
    }
    
    int index = [strIndex intValue];
    
    signinfo info;
    
    memset(&info, 0, sizeof(signinfo));
    
    info = [UexXinShouShuCAUtility SetSignData:index info:&info];
    
    NSString *strContextid=[UexXinShouShuCAUtility getTestSignItemValue:@"cid" index:index];
    
    int CLS;
    
    @try {
        
        CLS=[strContextid intValue];
        
    }
    
    @catch (NSException *exception) {
        
        return;
        
    }
    
    bool res;
    
    res = [_interfaceView showInputDialog:CLS callBack:@"myPicture" signerInfo:info];
    
    if (res==TRUE) {
        
        _signView = [_interfaceView getDoodleView];
        
        [EUtility brwView:_uexObj.meBrwView addSubview:_signView];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"签名参数配置错误" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
        
        return;
        
    }
    
}

- (void)openMassSignView:(NSMutableArray *)arr {
    
    NSString *strIndex = @"0";
    
    if (arr.count > 0) {
        
        strIndex = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
        
    }
    
    int index = [strIndex intValue];
    
    NSString *strContextid=[UexXinShouShuCAUtility getTestPlistItemValue:@"mutiSigns" keyName:@"cid" index:index];
    
    int CLS;
    @try
    {
        CLS=[strContextid intValue];
    }
    @catch (NSException *exception) {
        return  ;
    }
    signMutiInfo info;
    
    memset(&info, 0, sizeof(signMutiInfo));
    
    info = [UexXinShouShuCAUtility SetMutiSignData:index info:&info];
    
    [_interfaceView showMassInputDialog:CLS callBack:@"myPicture" muti:info];
    
    UIView *massView = [_interfaceView getMassSignView];
    
    [EUtility brwView:_uexObj.meBrwView addSubview:massView];
    
}

- (void)getDataGramFromSign {
    
    BOOL res = [UexXinShouShuCAUtility setDataArray:_interfaceView];
    
    if(res == false) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置模版失败" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
        
        return;
    }
    
    formInfo info;
    
    info = [UexXinShouShuCAUtility setFormInfoData:(&info)];
    
    res = [_interfaceView setFormInfo:info];
    
    if(res == false) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置模版失败" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
        
        return;
        
    }
    
    NSString *str = [_interfaceView getUploadDataGram];
    
    if(str == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"打包失败" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
        
        return;
        
    } else {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"打包成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
        
    }
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *signTxtPath = [UexXinShouShuCAUtility writeDataGramToFile:data];
    
    [_uexObj jsSuccessWithName:@"uexXinShouShuCA.cbGetUploadDataGram" opId:0 dataType:UEX_CALLBACK_DATATYPE_TEXT strData:signTxtPath];
    
}

#pragma mark -- OnSignListenerDelegate

- (void)onConfirm {
    
    NSLog(@"appcan-->uexXinShouShuCA-->UexXinShouShuSign.m-->onConfirm");
    
}

- (void)onCancel {
    
     NSLog(@"appcan-->uexXinShouShuCA-->UexXinShouShuSign.m-->onCancel");
    
}

- (void)onDismiss {
    
     NSLog(@"appcan-->uexXinShouShuCA-->UexXinShouShuSign.m-->onDismiss");
    
}

#pragma mark -- 签名,拍照,录音 通知

- (void)getimage:(NSNotification *)noti {
    
   	NSDictionary *info = [noti userInfo];
    UIImage *SignPicture = [info objectForKey:@"myimage"];
    
    NSData *imageData=UIImageJPEGRepresentation(SignPicture,1);
    
    NSFileManager *fmanager = [NSFileManager defaultManager];
    //获取程序的根目录
    NSString *homeDirectory = NSHomeDirectory();
    
    NSString *signCAImagePath = [homeDirectory stringByAppendingPathComponent:@"Documents/apps/uexXinShouShuCAImage"];
    
    if (![fmanager fileExistsAtPath:signCAImagePath]) {
        
        [fmanager createDirectoryAtPath:signCAImagePath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    //picture name
    NSString *timeStr = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSinceReferenceDate]];
    
    NSString *imgName = [NSString stringWithFormat:@"%@.jpg",[timeStr substringFromIndex:([timeStr length]-6)]];
    
    NSString *imgTmpPath = [signCAImagePath stringByAppendingPathComponent:imgName];
    
    if ([fmanager fileExistsAtPath:imgTmpPath]) {
        
        [fmanager removeItemAtPath:imgTmpPath error:nil];
        
    }
    
    BOOL succ = [imageData writeToFile:imgTmpPath atomically:YES];
    
    if (succ) {
        
        [_uexObj jsSuccessWithName:@"uexXinShouShuCA.cbSign" opId:0 dataType:UEX_CALLBACK_DATATYPE_TEXT strData:imgTmpPath];
        
    }
    
}

- (void)getRecord:(NSNotification *)noti {
    
    //    NSDictionary *info = [noti userInfo];
    //    NSString * url = [info objectForKey:@"myrecord"] ;
    
}

- (void)getCameraImage:(NSNotification *)noti {
    
    if(_myCameraImage != nil) {
        
        [_myCameraImage removeFromSuperview];
        [_myCameraImage release];
        _myCameraImage =nil;
        
    }
    
    NSDictionary *info = [noti userInfo];
    UIImage *image = [info objectForKey:@"myCameraImage"];
    
    if(_myCameraImage==nil) {
        
        _myCameraImage =  [[UIImageView alloc] initWithImage:image];
        
    }
    
    [_myCameraImage setFrame:CGRectMake(200, 300, image.size.width, image.size.height)];
    
}

- (void)cancelCamera:(NSNotification *)noti {
    
    //NSDictionary *info = [noti userInfo];
    NSLog(@"返回");
}

- (void)dealloc {
    
    if (_interfaceView) {
        
        _interfaceView.delegate = nil;
        [_interfaceView release];
        _interfaceView = nil;
    }
    
    [_myCameraImage release];
    [_myOrignalImage release];
    [_signView release];
    
    [super dealloc];
}

@end
