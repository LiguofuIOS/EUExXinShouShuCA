//
//  UexcaSignViewController.m
//  EUExXinShouShuCA
//
//  Created by liguofu on 15/9/17.
//  Copyright (c) 2015年 liguofu. All rights reserved.
//

#import "UexcaSignViewController.h"
#import "myhttprequest.h"

#define configFile @"testinfo"
#define configPostfix @"plist"
#define DBNAME @"test.txt"
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define   defaultx 0
#define   defaulty 0

@interface UexcaSignViewController ()

@end

@implementation UexcaSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    orientationpre=[[UIApplication sharedApplication] statusBarOrientation];
    [self initSubView];
}

- (void)initSubView {
    signIndex=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 60, 30)];
    signIndex.text=@"0";
    signIndex.backgroundColor = [UIColor grayColor];
    signIndex.textColor = [UIColor whiteColor];
    signIndex.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:signIndex];
    
    UIButton *addSign = [[UIButton alloc]initWithFrame:CGRectMake(10 + 80, 70, 60, 30)];
    [addSign setTitle:@"+" forState:UIControlStateNormal];
    [addSign setBackgroundColor:[UIColor grayColor]];
    [addSign addTarget:self action:@selector(addSignWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addSign];
    
    UIButton *reduceSign = [[UIButton alloc]initWithFrame:CGRectMake(10 + 160, 70, 60, 30)];
    [reduceSign setTitle:@"-" forState:UIControlStateNormal];
    [reduceSign setBackgroundColor:[UIColor grayColor]];
    [reduceSign addTarget:self action:@selector(reduceSignWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reduceSign];
    
    UIButton *interface = [[UIButton alloc]initWithFrame:CGRectMake(10 + 240, 70, 60, 30)];
    [interface setTitle:@"签名" forState:UIControlStateNormal];
    [interface setBackgroundColor:[UIColor grayColor]];
    [interface addTarget:self action:@selector(startinterface) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:interface];
    
    cameraIndex=[[UILabel alloc]initWithFrame:CGRectMake(10, 120, 60, 30)];
    cameraIndex.text=@"0";
    cameraIndex.backgroundColor = [UIColor grayColor];
    cameraIndex.textColor = [UIColor whiteColor];
    cameraIndex.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cameraIndex];
    
    UIButton *addcamera = [[UIButton alloc]initWithFrame:CGRectMake(10 + 80, 120, 60, 30)];
    [addcamera setTitle:@"+" forState:UIControlStateNormal];
    [addcamera setBackgroundColor:[UIColor grayColor]];
    [addcamera addTarget:self action:@selector(addCameraWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addcamera];
    
    UIButton *reducecamera = [[UIButton alloc]initWithFrame:CGRectMake(10 + 160, 120, 60, 30)];
    [reducecamera setTitle:@"-" forState:UIControlStateNormal];
    [reducecamera setBackgroundColor:[UIColor grayColor]];
    [reducecamera addTarget:self action:@selector(reduceCameraWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reducecamera];
    
    UIButton *camera = [[UIButton alloc]initWithFrame:CGRectMake(10 + 240, 120, 60, 30)];
    [camera setTitle:@"拍照" forState:UIControlStateNormal];
    [camera setBackgroundColor:[UIColor grayColor]];
    [camera addTarget:self action:@selector(cameraWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:camera];
    
    
    recordIndex=[[UILabel alloc]initWithFrame:CGRectMake(10, 170, 60, 30)];
    recordIndex.text=@"0";
    recordIndex.backgroundColor = [UIColor grayColor];
    recordIndex.textColor = [UIColor whiteColor];
    recordIndex.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:recordIndex];
    
    UIButton *addRecord = [[UIButton alloc]initWithFrame:CGRectMake(10 + 80, 170, 60, 30)];
    [addRecord setTitle:@"+" forState:UIControlStateNormal];
    [addRecord setBackgroundColor:[UIColor grayColor]];
    [addRecord addTarget:self action:@selector(addRecordWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addRecord];
    
    UIButton *reduceRecord = [[UIButton alloc]initWithFrame:CGRectMake(10 + 160, 170, 60, 30)];
    [reduceRecord setTitle:@"-" forState:UIControlStateNormal];
    [reduceRecord setBackgroundColor:[UIColor grayColor]];
    [reduceRecord addTarget:self action:@selector(reduceRecordWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reduceRecord];
    
    UIButton *record = [[UIButton alloc]initWithFrame:CGRectMake(10 + 240, 170, 60, 30)];
    [record setTitle:@"录音" forState:UIControlStateNormal];
    [record setBackgroundColor:[UIColor grayColor]];
    [record addTarget:self action:@selector(record) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:record];
    
    massIndex=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, 60, 30)];
    massIndex.text=@"0";
    massIndex.backgroundColor = [UIColor grayColor];
    massIndex.textColor = [UIColor whiteColor];
    massIndex.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:massIndex];
    
    UIButton *addMass = [[UIButton alloc]initWithFrame:CGRectMake(10 + 80, 220, 60, 30)];
    [addMass setTitle:@"+" forState:UIControlStateNormal];
    [addMass setBackgroundColor:[UIColor grayColor]];
    [addMass addTarget:self action:@selector(addMassWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addMass];
    
    UIButton *reduceMass = [[UIButton alloc]initWithFrame:CGRectMake(10 + 160, 220,60, 30)];
    [reduceMass setTitle:@"-" forState:UIControlStateNormal];
    [reduceMass setBackgroundColor:[UIColor grayColor]];
    [reduceMass addTarget:self action:@selector(reduceMassWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reduceMass];
    
    UIButton *massButton = [[UIButton alloc]initWithFrame:CGRectMake(10 + 240, 220, 60, 30)];
    [massButton setTitle:@"批注" forState:UIControlStateNormal];
    [massButton setBackgroundColor:[UIColor grayColor]];
    [massButton addTarget:self action:@selector(massShowWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:massButton];
    
    UIButton *encode = [[UIButton alloc]initWithFrame:CGRectMake(10 + 80, 270, 60, 30)];
    [encode setTitle:@"打包" forState:UIControlStateNormal];
    [encode setBackgroundColor:[UIColor grayColor]];
    [encode addTarget:self action:@selector(encodeWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:encode];
    
    UIButton *reset = [[UIButton alloc]initWithFrame:CGRectMake(10 + 160, 270, 60, 30)];
    [reset setTitle:@"清除" forState:UIControlStateNormal];
    [reset setBackgroundColor:[UIColor grayColor]];
    [reset addTarget:self action:@selector(resetMyconfigWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reset];
    
    UIButton *addcachet = [[UIButton alloc]initWithFrame:CGRectMake(10 + 240, 270, 60, 30)];
    [addcachet setTitle:@"签章" forState:UIControlStateNormal];
    [addcachet setBackgroundColor:[UIColor grayColor]];
    [addcachet addTarget:self action:@selector(addCachetWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addcachet];
    
    UIButton *addAttach = [[UIButton alloc]initWithFrame:CGRectMake(10, 270, 60, 30)];
    [addAttach setTitle:@"证据" forState:UIControlStateNormal];
    [addAttach setBackgroundColor:[UIColor grayColor]];
    [addAttach addTarget:self action:@selector(setHash) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAttach];
    
    mypackage1 = [[BjcaInterfaceView alloc]init];
    mypackage1.delegate=self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRecord:) name:@"record" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCameraImage:) name:@"cameraPicture" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelCamera:) name:@"cancelPicture" object:nil];
    
}
- (void)getOrigianSignImg {
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(220, 380, 100, 100)];
    UIImage *imgSign = [mypackage1 getOrignalSignature];
    UIImage *smallImage=[self scaleImage:imgSign toSize:CGSizeMake(100, 100)];
    imgView.frame = CGRectMake(220, 380, smallImage.size.width, smallImage.size.height);
    [imgView setImage:imgSign];
    [self.view addSubview:imgView];
}
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    float sdefaultx=size.width;
    float sdefaulty=size.height;
    float adp=(image.size.width/sdefaultx)/(image.size.height/sdefaulty);
    float scax;
    float scay;
    if(adp>=1)
    {
        scax=size.width;
        scay=(image.size.height)*(size.width)/(image.size.width);
    }
    else {
        scax=(image.size.width)*(size.height)/(image.size.height);
        scay=size.height;
    }
    CGSize mysize;
    mysize.width=scax;
    mysize.height=scay;
    UIGraphicsBeginImageContext(mysize);
    [image drawInRect:CGRectMake(0, 0, scax, scay)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)addSignWay {
    NSString *strIndex=signIndex.text;
    int index=[strIndex intValue];
    int max=[self getTestIndexCount:@"signs"];
    if(index<max-1)
    {
        index=index+1;
        NSString *setNum=[NSString stringWithFormat:@"%d",index];
        signIndex.text=setNum;
    }
}

- (void)reduceSignWay {
    NSString *strIndex=signIndex.text;
    int index=[strIndex intValue];
    if(index>=1)
    {
        index=index-1;
        NSString *setNum=[NSString stringWithFormat:@"%d",index];
        signIndex.text=setNum;
    }
}

- (void)addCameraWay {
    NSString *strIndex=cameraIndex.text;
    int index=[strIndex intValue];
    int max=[self getTestIndexCount:@"cameras"];
    if(index<max-1)
    {
        index=index+1;
        NSString *setNum=[NSString stringWithFormat:@"%d",index];
        cameraIndex.text=setNum;
    }
}

- (void)reduceCameraWay {
    NSString *strIndex=cameraIndex.text;
    int index=[strIndex intValue];
    if(index>=1)
    {
        index=index-1;
        NSString *setNum=[NSString stringWithFormat:@"%d",index];
        cameraIndex.text=setNum;
    }
}

- (void)addRecordWay {
    NSString *strIndex=recordIndex.text;
    int index=[strIndex intValue];
    int max=[self getTestIndexCount:@"records"];
    if(index<max-1)
    {
        index=index+1;
        NSString *setNum=[NSString stringWithFormat:@"%d",index];
        recordIndex.text=setNum;
    }
}

- (void)reduceRecordWay {
    NSString *strIndex=recordIndex.text;
    int index=[strIndex intValue];
    if(index>=1)
    {
        index=index-1;
        NSString *setNum=[NSString stringWithFormat:@"%d",index];
        recordIndex.text=setNum;
    }
}

- (void)addMassWay {
    NSString *strIndex=massIndex.text;
    int index=[strIndex intValue];
    int max=[self getTestIndexCount:@"mutiSigns"];;
    if(index<max-1)
    {
        index=index+1;
        NSString *setNum=[NSString stringWithFormat:@"%d",index];
        massIndex.text=setNum;
    }
}

- (void)reduceMassWay {
    NSString *strIndex=massIndex.text;
    int index=[strIndex intValue];
    if(index>=1)
    {
        index=index-1;
        NSString *setNum=[NSString stringWithFormat:@"%d",index];
        massIndex.text=setNum;
    }
}

- (void)startinterface {
    NSString *strIndex=signIndex.text;
    int index=[strIndex intValue];
    signinfo info;
    memset(&info, 0, sizeof(signinfo));
    info= [self SetSignData:index info:&info];
    NSString *strContextid=[self getTestSignItemValue:@"cid" index:index];
    int CLS;
    @try
    {
        CLS=[strContextid intValue];
    }
    @catch (NSException *exception) {
        return;
    }
    bool res;
    res = [mypackage1 showInputDialog:CLS callBack:@"myPicture" signerInfo:info];
    if (res==TRUE) {
        signView = [mypackage1 getDoodleView];
        [self.view addSubview:signView];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"签名参数配置错误" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
}

- (void)cameraWay {
    NSString *strIndex=cameraIndex.text;
    int index=[strIndex intValue];
    cameraInfo info;
    info= [self SetCameraData:index info:&info];
    info.FrameRect=CGRectMake(0, 0, 0,0 );
    NSString *strContextid=[self getTestCameraItemValue:@"cid" index:index];
    int CLS;
    @try
    {
        CLS=[strContextid intValue]+[signIndex.text intValue];
    }
    @catch (NSException *exception) {
        return  ;
    }
    int max=[self getTestCameraIndexCount];
    bool res= FALSE;
    if(max==0)
    {
        res=[mypackage1 showtakePicture:CLS callBack:@"myPicture" cameraInfo:info];
    }
    else
    {
        cameraInfoEvidence info1;
        info1= [self SetCameraDataEvident:index info:&info1];
        info1.geo=TRUE;
        res=[mypackage1 showtakePictureEvidence:CLS callBack:@"myPicture" cameraInfo:info evidence:info1];
    }
    
    if(res==TRUE)
    {
        UIView *cameraView;
        cameraView = [mypackage1 getPictureView];
        cameraView.layer.borderColor = [UIColor redColor].CGColor;
        cameraView.layer.borderWidth = 5;
        [self.view addSubview:cameraView];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"照相机参数配置错误" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
}

- (void)record {
    NSString *strIndex=recordIndex.text;
    int index=[strIndex intValue];
    NSString *strContextid=[self getTestPlistItemValue:@"records" keyName:@"cid" index:index];
    int CLS;
    @try
    {
        CLS=[strContextid intValue]+[signIndex.text intValue];
    }
    @catch (NSException *exception) {
        return  ;
    }
    recordInfo info;
    info= [self SetRecordData:index info:&info];
    info.FrameRect=CGRectMake(0, 0, 0,0);
    int max=[self getTestRecordIndexCount];
    bool res= true;
    if(max==0)
    {
        [mypackage1 startMediaRecording:CLS callBack:@"myPicture" recordInfo:info];
    }
    else
    {
        recordInfoEvidence info1;
        info1= [self SetRecordDataEvident:index info:&info1];
        res=[mypackage1 startMediaRecordingEvidence:CLS callBack:@"myPicture" recordInfo:info evidence:info1];
    }
    if(res==FALSE)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"record参数配置错误" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    else
    {
        UIView *recordView;
        recordView = [mypackage1 getRecordView];
        if (info.showUi) {
            [self.view addSubview:recordView];
        }else {
            UIAlertView * laert = [[UIAlertView alloc]initWithTitle:@"是否关闭录音" message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消",nil];
            laert.tag = 401;
            [laert show];
            [laert release];
        }
    }
}

- (void)massShowWay {
    NSString *strIndex=massIndex.text;
    int index=[strIndex intValue];
    NSString *strContextid=[self getTestPlistItemValue:@"mutiSigns" keyName:@"cid" index:index];
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
    info = [self SetMutiSignData:index info:&info];
    UIView *massView;
    [mypackage1 showMassInputDialog:CLS callBack:@"myPicture" muti:info];
    massView = [mypackage1 getMassSignView];
    [self.view addSubview:massView];
}

- (void)encodeWay {
    BOOL res= [self setDataArray];
    if(res==false)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置模版失败" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    formInfo info;
    info= [self setFormInfoData:(&info)];
    res= [mypackage1 setFormInfo:info];
    if(res==false)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置模版失败" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    NSString *str;
    str=[mypackage1 getUploadDataGram];
    if(str==nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"打包失败" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"打包成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    myhttprequest *mywebreq=[[myhttprequest alloc]init];
    [mywebreq mySignRequestWithServer:str];
    [mywebreq release];
    
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = NSHomeDirectory();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    NSString *filePath4 = [documentDirectory stringByAppendingPathComponent:DBNAME];
    if ( ![fileManager fileExistsAtPath:path]) {
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    [data writeToFile:filePath4 atomically:YES];
}

- (void)addCachetWay {
    CachetObj info;
    info= [self SetCachetData:(&info)];
    bool res;
    res=[mypackage1 addChachetObj:info];
    if (res==FALSE) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置模版失败" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

- (formInfo)setFormInfoData:(formInfo *)infodata {
    NSString *Channel= [self getTestformInfoItemValue:@"Channel"];
    NSString *FlowId= [self getTestformInfoItemValue:@"FlowId"];
    NSString *IsSync= [self getTestformInfoItemValue:@"IsSync"];
    NSString *IsUnit= [self getTestformInfoItemValue:@"IsUnit"];
    NSString *WONo= [self getTestformInfoItemValue:@"WONo"];
    NSString *serverEncType= [self getTestformInfoItemValue:@"serverEncType"];
    formInfo info=*infodata;
    info.Channel=Channel;
    info.FlowId=FlowId;
    info.IsSync=IsSync;
    info.IsUnit=IsUnit;
    info.WONo=WONo;
    if([serverEncType isEqualToString:@"SM2"])
    {
        info.serverEncType=EncType_SM2;
    }
    else
    {
        info.serverEncType=EncType_RSA;
    }
    return info;
}

- (BOOL)setDataArray {
    NSString *type= [self getTestTempItemValue:@"type"];
    NSString *StrtypeTid= [self getTestTempItemValue:@"styleTid"];
    bool res=TRUE;
    NSData * orgdata = nil;
    if([type isEqualToString:@"12"])
    {
        orgdata=[NSData dataWithBytes:" " length:1];
    }else{
        NSString *name= [self getTestTempItemValue:@"data"];
        NSArray *array = [name componentsSeparatedByString:@"."];
        NSString *fileName = [array objectAtIndex:0];
        NSString *fileType = [array objectAtIndex:1];
        NSString *htmlStr= [[NSBundle mainBundle]pathForResource:fileName ofType:fileType];
        orgdata=[NSData dataWithContentsOfFile:htmlStr];
    }
    PdfRule ruleData;
    ruleData.DocStyleTid=StrtypeTid;
    ruleData.DocCrdTid=@"0";
    res=[mypackage1 setTemplate:type mydata:orgdata PdfRule:ruleData];
    return res;
}

- (void)getimage:(NSNotification *)noti {
    if(myimage!=nil)
    {
        [myimage removeFromSuperview];
        [myimage release];
        myimage =nil;
    }
   	NSDictionary *info = [noti userInfo];
    UIImage *SignPicture = [info objectForKey:@"myimage"];
    //     NSData *data = UIImageJPEGRepresentation(SignPicture, 1.0);
    if(myimage==nil)
    {
        myimage =  [[UIImageView alloc] initWithImage:SignPicture];
    }
    [myimage setFrame:CGRectMake(0, 420, SignPicture.size.width, SignPicture.size.height)];
    [self.view addSubview:myimage];
}

- (void)getRecord:(NSNotification *)noti {
    //    NSDictionary *info = [noti userInfo];
    //    NSString * url = [info objectForKey:@"myrecord"] ;
}

- (void)getCameraImage:(NSNotification *)noti {
    if(myCameraImage!=nil)
    {
        [myCameraImage removeFromSuperview];
        [myCameraImage release];
        myCameraImage =nil;
    }
    NSDictionary *info = [noti userInfo];
    UIImage *image = [info objectForKey:@"myCameraImage"];
    {
        if(myCameraImage==nil)
        {
            myCameraImage =  [[UIImageView alloc] initWithImage:image];
        }
        [myCameraImage setFrame:CGRectMake(200, 300, image.size.width, image.size.height)];
        [self.view addSubview:myCameraImage];
    }
}

- (void)cancelCamera:(NSNotification *)noti {
    //     NSDictionary *info = [noti userInfo];
    NSLog(@"返回");
}

- (signinfo )SetSignData:(int)index info:(signinfo *)infodata {
    signinfo info=*infodata;
    info.name=[self getTestSignItemValue:@"name" index:index];
    info.IdNumber=[self getTestSignItemValue:@"IdNumber" index:index];
    info.RuleType=[self getTestSignItemValue:@"RuleType" index:index];
    info.Tid=[self getTestSignItemValue:@"Tid" index:index];
    NSString *geoStr=[self getTestSignItemValue:@"geo" index:index];
    NSString *TssStr=[self getTestSignItemValue:@"isTss" index:index];
    if( [geoStr isEqualToString:@"true"])
    {
        info.geo=TRUE;
    }
    else
    {
        info.geo=FALSE;
    }
    if( [TssStr isEqualToString:@"true"])
    {
        info.isTss=TRUE;
    }
    else
    {
        info.isTss=FALSE;
    }
    info.kw=[self getTestSignItemValue:@"kw" index:index];
    info.kwPos=[self getTestSignItemValue:@"kwPost" index:index];
    info.kwOffset=[self getTestSignItemValue:@"kwOffset" index:index];
    info.kwIndex =[self getTestSignItemValue:@"kwIndex" index:index];
    info.xOffset = [self getTestSignItemValue:@"xOffset" index:index];
    info.yOffset = [self getTestSignItemValue:@"yOffset" index:index];
    info.Left=[self getTestSignItemValue:@"Left" index:index];
    info.Top=[self getTestSignItemValue:@"Top" index:index];
    info.Right=[self getTestSignItemValue:@"Right" index:index];
    info.Bottom=[self getTestSignItemValue:@"Bottom" index:index];
    info.Pageno=[self getTestSignItemValue:@"Pageno" index:index];
    info.imgeInfo.SignImageSize.height=[[self getTestSignItemValue:@"SignImageSizeHeight" index:index] floatValue];
    info.imgeInfo.SignImageSize.width=[[self getTestSignItemValue:@"SignImageSizeWidth" index:index] floatValue];
    info.scale = [[self getTestSignItemValue:@"Scale" index:index] floatValue];
    info.strokeWidth = [[self getTestSignItemValue:@"StrokeWidth" index:index] floatValue];
    info.strokeColor =[self colorWithHexString:[self getTestSignItemValue:@"StrokeColor" index:index]];
    NSString *strMyself = [self getTestSignItemValue:@"isViewMyself" index:index];
    if ([strMyself isEqualToString:@"false"]) {
        info.isViewMyself=FALSE;
    }else{
        info.isViewMyself=TRUE;
    }
    //    info.timePos=[self getTestSignItemValue:@"timePos" index:index];
    //    info.timeFormat=[self getTestSignItemValue:@"timeFormat" index:index];
    
    NSDictionary *arrary=[self getTestSignCamera:@"camera" index:index];
    NSString *strshowPreviewUI = [self getValue:@"showPreviewUI" index:index arr:arrary];
    if ([strshowPreviewUI isEqualToString:@"true"]) {
        info.cameraInfo.quality = [[self getValue:@"quality" index:index arr:arrary]floatValue];
        info.cameraInfo.cameraImageSize.width = [[self getValue:@"width" index:index arr:arrary]floatValue];
        info.cameraInfo.cameraImageSize.height = [[self getValue:@"height" index:index arr:arrary]floatValue];
        
        NSString *strEvidence=[self getValue:@"evidence" index:index arr:arrary];
        NSString *strAttach=[self getValue:@"attach" index:index arr:arrary];
        NSString *strtakePicOnComfirmSig = [self getValue:@"takePicOnComfirmSig" index:index arr:arrary];
        NSString *strshowPreviewUI = [self getValue:@"showPreviewUI" index:index arr:arrary];
        NSString *strSaveAllData = [self getValue:@"bSaveAllData" index:index arr:arrary];
        NSString * strFace=[self getValue:@"face" index:index arr:arrary];
        if ([strFace isEqualToString:@"true"])
        {
            info.cameraInfo.checkface=TRUE;
        }
        else
        {
            info.cameraInfo.checkface=FALSE;
        }
        info.cameraInfo.faceMessage=[self getValue:@"faceMessage" index:index arr:arrary];
        
        if( [strEvidence isEqualToString:@"true"]){
            info.cameraInfo.evidence=TRUE;
        }else{
            info.cameraInfo.evidence=FALSE;
        }
        if( [strAttach isEqualToString:@"true"]){
            info.cameraInfo.attach=TRUE;
        }else{
            info.cameraInfo.attach=FALSE;
        }
        if( [strtakePicOnComfirmSig isEqualToString:@"true"]){
            info.cameraInfo.takePicOnComfirmSig=TRUE;
        }else{
            info.cameraInfo.takePicOnComfirmSig=FALSE;
        }
        if( [strshowPreviewUI isEqualToString:@"true"]){
            info.cameraInfo.showPreviewUI=TRUE;
        }else{
            info.cameraInfo.showPreviewUI=FALSE;
        }
        if ([strSaveAllData isEqualToString:@"true"]) {
            info.cameraInfo.savePicData=TRUE;
        }else{
            info.cameraInfo.savePicData=FALSE;
        }
        
        info.cameraInfo.callbackKey = [self getValue:@"callbackKey" index:index arr:arrary];
    }
    return info;
}

- (CachetObj)SetCachetData:(CachetObj *)infodata {
    CachetObj info=*infodata;
    info.Tid=[self getTestCachetItemValue:@"Tid"];
    info.IsTSS=[self getTestCachetItemValue:@"IsTSS"];
    info.RuleType=[self getTestCachetItemValue:@"RuleType"];
    info.kw=[self getTestCachetItemValue:@"kw"];
    info.kwPos=[self getTestCachetItemValue:@"kwPost"];
    info.kwOffset=[self getTestCachetItemValue:@"kwOffset"];
    info.Left=[self getTestCachetItemValue:@"Left"];
    info.Top=[self getTestCachetItemValue:@"Top"];
    info.Right=[self getTestCachetItemValue:@"Right"];
    info.Bottom=[self getTestCachetItemValue:@"Bottom"];
    info.Pageno=[self getTestCachetItemValue:@"Pageno"];
    info.AppName=[self getTestCachetItemValue:@"AppName"];
    return info;
}

- (cameraInfo)SetCameraData:(int)index info:(cameraInfo *)infodata {
    cameraInfo info=*infodata;
    info.property=@"shenfenzheng";
    NSString * strFace=[self getTestCameraItemValue:@"face" index:index];
    if ([strFace isEqualToString:@"true"])
    {
        info.checkface=TRUE;
    }
    else
    {
        info.checkface=false;
    }
    info.faceMessage=[self getTestCameraItemValue:@"faceMessage" index:index];
    info.quality=[[self getTestCameraItemValue:@"quality" index:index] floatValue];
    info.imageSize.cameraImageSize.width=[[self getTestCameraItemValue:@"width" index:index] floatValue];
    info.imageSize.cameraImageSize.height=[[self getTestCameraItemValue:@"height" index:index] floatValue];
    return info;
}

- (cameraInfoEvidence)SetCameraDataEvident:(int)index info:(cameraInfoEvidence *)infodata {
    cameraInfoEvidence info=*infodata;
    NSDictionary *arrary=[self getTestCameraEvidence:@"evidence" index:index];
    NSString *strIndex=cameraIndex.text;
    int index111=[strIndex intValue];
    NSString *attachStr=[self getValue:@"attach" index:index111 arr:arrary];
    if([attachStr isEqualToString:@"true"])
    {
        info.attach=TRUE;
    }
    else
    {
        info.attach=FALSE;
    }
    NSString *geoStr=[self getValue:@"geo" index:index111 arr:arrary];
    if([geoStr isEqualToString:@"true"])
    {
        info.geo=TRUE;
    }
    else
    {
        info.geo=FALSE;
    }
    info.type=(BioType)[[self getValue:@"BioType" index:index111 arr:arrary] intValue];
    info.index=[[self getValue:@"index" index:index111 arr:arrary] intValue];
    info.evidenceId=[[self getValue:@"eniId" index:index111 arr:arrary] intValue]+[signIndex.text intValue];
    return info;
}

- (recordInfoEvidence)SetRecordDataEvident:(int)index info:(recordInfoEvidence *)infodata {
    cameraInfoEvidence info=*infodata;
    NSDictionary *arrary=[self getTestRecordEvidence:@"evidence" index:index];
    NSString *strIndex=cameraIndex.text;
    int index111=[strIndex intValue];
    NSString *attachStr=[self getValue:@"attach" index:index111 arr:arrary];
    if([attachStr isEqualToString:@"true"])
    {
        info.attach=TRUE;
    }
    else
    {
        info.attach=FALSE;
    }
    info.type=(BioType)[[self getValue:@"BioType" index:index111 arr:arrary] intValue];
    info.index=[[self getValue:@"index" index:index111 arr:arrary] intValue];
    info.evidenceId=[[self getValue:@"eniId" index:index111 arr:arrary] intValue]+[signIndex.text intValue];
    return info;
}

- (recordInfo )SetRecordData:(int)index info:(recordInfo *)infodata {
    recordInfo info=*infodata;
    NSString *ui=[self getTestPlistItemValue:@"records" keyName:@"showUi" index:index];
    if ([ui isEqualToString:@"TRUE"]||[ui isEqualToString:@"true"]) {
        info.showUi=TRUE;
    }
    else
    {
        info.showUi=FALSE;
    }
    info.DurTime=[[self getTestPlistItemValue:@"records" keyName:@"DurTime" index:index] floatValue];
    return info;
}

- (signMutiInfo)SetMutiSignData:(int)index info:(signMutiInfo *)infodata {
    signMutiInfo info=*infodata;
    info.name=[self getMutiSignItemValue:@"name" index:index];
    info.IdNumber=[self getMutiSignItemValue:@"IdNumber" index:index];
    info.RuleType=[self getMutiSignItemValue:@"RuleType" index:index];
    info.Tid=[self getMutiSignItemValue:@"Tid" index:index];
    info.kw=[self getMutiSignItemValue:@"kw" index:index];
    info.kwPos=[self getMutiSignItemValue:@"kwPost" index:index];
    info.kwOffset=[self getMutiSignItemValue:@"kwOffset" index:index];
    info.kwIndex =[self getTestSignItemValue:@"kwIndex" index:index];
    info.xOffset = [self getMutiSignItemValue:@"xOffset" index:index];
    info.yOffset = [self getMutiSignItemValue:@"yOffset" index:index];
    info.Left=[self getMutiSignItemValue:@"Left" index:index];
    info.Top=[self getMutiSignItemValue:@"Top" index:index];
    info.Right=[self getMutiSignItemValue:@"Right" index:index];
    info.Bottom=[self getMutiSignItemValue:@"Bottom" index:index];
    info.Pageno=[self getMutiSignItemValue:@"Pageno" index:index];
    
    info.SignImageSize.width=[[self getMutiSignItemValue:@"SignImageSizeWidth" index:index] intValue];
    info.SignImageSize.height=[[self getMutiSignItemValue:@"SignImageSizeHeight" index:index] intValue];
    info.commitment = [self getMutiSignItemValue:@"commitment" index:index];
    info.timePos = [self getMutiSignItemValue:@"timePos" index:index];;
    info.timeFormat = [self getMutiSignItemValue:@"timeFormat" index:index];;
    info.strokeWidth = [[self getMutiSignItemValue:@"StrokeWidth" index:index] floatValue];
    info.strokeColor = [self colorWithHexString:[self getMutiSignItemValue:@"StrokeColor" index:index]];
    info.scale = [[self getMutiSignItemValue:@"Scale" index:index] floatValue];
    info.lineMax = [[self getMutiSignItemValue:@"LineMax" index:index] intValue];
    NSString *strEcho = [self getMutiSignItemValue:@"Scale" index:index];
    if ([strEcho isEqualToString:@"true"]) {
        info.isEcho=TRUE;
    }else{
        info.isEcho=FALSE;
    }
    return info;
}

- (NSString * )getTestSignItemValue :(NSString *) item index:(int)ArrayIndex {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:@"signs"];
    NSDictionary *signDic= SignArray[ArrayIndex];
    NSString * tmp=[[signDic objectForKey:item] retain];
    [dict release];
    return tmp;
}

- (NSString * )getMutiSignItemValue :(NSString *) item index:(int)ArrayIndex {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:@"mutiSigns"];
    NSDictionary *signDic= SignArray[ArrayIndex];
    NSString * tmp=[[signDic objectForKey:item] retain];
    [dict release];
    return tmp;
}

- (NSDictionary *)getTestSignCamera :(NSString *) item index:(int)ArrayIndex {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:@"signs"];
    NSDictionary *signDic= SignArray[ArrayIndex];
    NSEnumerator *nse = [signDic keyEnumerator];
    id thing;
    while (thing=[nse nextObject]) {
        NSString *tmp=(NSString *)thing;
        BOOL res= [item isEqualToString:tmp];
        if(res==TRUE)
        {
            NSDictionary * tmp=[[signDic objectForKey:item] retain];
            [dict release];
            return tmp;
        }
    }
    return nil;
}

- (int)getTestIndexCount:(NSString *)type {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:type];
    int count=(int)[SignArray count];
    [dict release];
    return count;
}

- (int)getTestCameraIndexCount {
    NSString *strIndex=cameraIndex.text;
    int index111=[strIndex intValue];
    NSDictionary *dic=[self getTestCameraEvidence:@"evidence" index:index111] ;
    if(dic==nil)
    {
        return 0;
    }
    return 1;
}

- (int)getTestRecordIndexCount {
    NSString *strIndex=recordIndex.text;
    int index111=[strIndex intValue];
    NSDictionary *dic=[self getTestRecordEvidence:@"evidence" index:index111] ;
    if(dic==nil)
    {
        return 0;
    }
    return 1;
}

- (NSString * )getTestCameraItemValue :(NSString *) item index:(int)ArrayIndex {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:@"cameras"];
    NSDictionary *signDic= SignArray[ArrayIndex];
    NSString * tmp=[[signDic objectForKey:item] retain];
    [dict release];
    return tmp;
}

- (NSDictionary * )getTestCameraEvidence :(NSString *) item index:(int)ArrayIndex {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:@"cameras"];
    NSDictionary *signDic= SignArray[ArrayIndex];
    NSEnumerator *nse = [signDic keyEnumerator];
    id thing;
    while (thing=[nse nextObject]) {
        NSString *tmp=(NSString *)thing;
        BOOL res= [item isEqualToString:tmp];
        if(res==TRUE)
        {
            NSDictionary * tmp=[[signDic objectForKey:item] retain];
            [dict release];
            return tmp;
        }
    }
    return nil;
}

- (NSDictionary * )getTestRecordEvidence :(NSString *) item index:(int)ArrayIndex {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:@"records"];
    NSDictionary *signDic= SignArray[ArrayIndex];
    NSEnumerator *nse = [signDic keyEnumerator];
    id thing;
    while (thing=[nse nextObject]) {
        NSString *tmp=(NSString *)thing;
        BOOL res= [item isEqualToString:tmp];
        if(res==TRUE)
        {
            NSDictionary * tmp=[[signDic objectForKey:item] retain];
            [dict release];
            return tmp;
        }
    }
    return nil;
}

- (NSString *)getValue :(NSString *) item index:(int)ArrayIndex arr:(NSDictionary *)dict {
    NSString *tmp=[[dict objectForKey:item] retain];
    return tmp;
}

- (NSString *)getTestPlistItemValue :(NSString *) item keyName:(NSString *)key index:(int)ArrayIndex{
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:item];
    NSDictionary *signDic= SignArray[ArrayIndex];
    NSString * tmp=[[signDic objectForKey:key] retain];
    [dict release];
    return tmp;
}

- (NSString *)getTestTempItemValue :(NSString *) item {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSDictionary *SignDic=[dict objectForKey:@"Template"];
    NSString * tmp=[[SignDic objectForKey:item] retain];
    [dict release];
    return tmp;
}

- (NSString *)getTestformInfoItemValue :(NSString *) item {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSDictionary *SignDic=[dict objectForKey:@"forminfo"];
    NSString * tmp=[[SignDic objectForKey:item] retain];
    [dict release];
    return tmp;
}

- (NSString *)getTestCachetItemValue :(NSString *) item {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSDictionary *SignDic=[dict objectForKey:@"Cachet"];
    if(SignDic==nil)
    {
        return nil;
    }
    NSString * tmp=[[SignDic objectForKey:item] retain];
    [dict release];
    return tmp;
}

- (NSString *)getpath {
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *filePath2=[bundle pathForResource:configFile ofType:configPostfix];
    return filePath2;
}

- (void)resetMyconfigWay {
    [mypackage1 reset];
}

- (void)save {
    if ([mypackage1 isDrawn]) {
        [mypackage1 confirm];
        [mypackage1 dismiss];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入签名信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    [self removeView];
}

- (void)cancel {
    [mypackage1 cancel];
    [mypackage1 dismiss];
    [self removeView];
}

- (void)clear {
    [mypackage1 clearDrawing];
}

- (void)dismiss {
    [mypackage1 dismiss];
    [self removeView];
}

- (void)onConfirm {
    NSLog(@"onConfirm");
}

- (void)onCancel {
    NSLog(@"onCancel");
}

- (void)onDismiss {
    NSLog(@"onDismiss");
}

- (void)removeView {
    [signView removeFromSuperview];
    signView = nil;
}

- (void)getImageInterface {
    if(myOrignalImage!=nil)
    {
        [myOrignalImage removeFromSuperview];
        [myOrignalImage release];
        myOrignalImage =nil;
    }
    UIImage *image;
    image = [mypackage1 getOrignalSignature];
    if(myOrignalImage==nil)
    {
        myOrignalImage =  [[UIImageView alloc] initWithImage:image];
    }
    [myOrignalImage setFrame:CGRectMake(200, 200, image.size.width, image.size.height)];
    [self.view addSubview:myOrignalImage];
}

- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}
//默认alpha值为1
- (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1.0f];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==401) {
        if (buttonIndex==0) {
            [mypackage1 stopRecord];
        }else{
        }
    }
}

- (CGRect)getXssScreen:(NSString *)name {
    CGRect rg = [ UIScreen mainScreen ].bounds;
    CGFloat width = rg.size.width;
    CGFloat height = rg.size.height;
    int x =[[UIApplication sharedApplication] statusBarOrientation];
    NSString *sysVersion = [[UIDevice  currentDevice]systemVersion];
    NSString *sysSubVersion = [sysVersion substringToIndex:1];
    int iSysSubVer = [sysSubVersion intValue];
    if (iSysSubVer>7) {
        rg=CGRectMake(defaultx,defaulty, width, height);
    }else{
        if(UIInterfaceOrientationPortrait==x||UIInterfaceOrientationPortraitUpsideDown==x){
            rg=CGRectMake(defaultx,defaulty, width, height);
        }
        else{
            rg=CGRectMake(defaultx,defaulty, height, width);
        }
    }
    return rg;
}


- (void)dealloc {
    [mypackage1 release];
    [signIndex release];
    [cameraIndex release];
    [recordIndex release];
    [massIndex release];
    [myimage release];
    [myCameraImage release];
    [myOrignalImage release];
    [signView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setHash{
    UIImage *img = [UIImage imageNamed:@"img.jpg"];
    NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
    BOOL CLS;
    CLS=[mypackage1 addEvidence:50 ownIndex:20 contentData:imgData bioType:PHOTO_SIGNER_IDENTITY_CARD_FRONT orAttach:NO];
}


@end
