//
//  UexXinShouShuCAUtility.m
//  EUExXinShouShuCA
//
//  Created by liguofu on 15/9/18.
//  Copyright (c) 2015年 liguofu. All rights reserved.
//

#define configFile @"uexXinShouShuCA/uexXinShouShuCA"
#define configPostfix @"plist"
#define DBNAME @"uexXinShouShuCA.txt"
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define   defaultx 0
#define   defaulty 0
#import "UexXinShouShuCAUtility.h"

@implementation UexXinShouShuCAUtility

+ (signinfo)SetSignData:(int)index info:(signinfo *)infodata {
    
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
        
        if ([strFace isEqualToString:@"true"]) {
            
            info.cameraInfo.checkface=TRUE;
            
        } else {
            
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

+ (signMutiInfo)SetMutiSignData:(int)index info:(signMutiInfo *)infodata {
    
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

+ (NSString *) getTestSignItemValue:(NSString *)item index:(int)ArrayIndex {
    
    NSString *path=[self getpath];
    
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:@"signs"];
    NSDictionary *signDic= SignArray[ArrayIndex];
    NSString * tmp=[[signDic objectForKey:item] retain];
    
    [dict release];
    
    return tmp;
    
}

+ (NSString *)getpath {
    
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *filePath2=[bundle pathForResource:configFile ofType:configPostfix];
    
    return filePath2;
    
}



+ (BOOL)setDataArray:(BjcaInterfaceView *)interfaceView {
    
    NSString *type = @"";
    NSString *StrtypeTid = @"";
    NSData * orgdata = nil;
    
    if ([self getTestTempItemValue:@"type"] && [self getTestTempItemValue:@"type"].length > 0) {
        
        type = [self getTestTempItemValue:@"type"];
        
    }
    
    if ([self getTestTempItemValue:@"styleTid"] && [self getTestTempItemValue:@"styleTid"]) {
        
        StrtypeTid = [self getTestTempItemValue:@"styleTid"];
        
    }
    
    bool res = TRUE;
    
    if([type isEqualToString:@"12"]) {
        
        orgdata=[NSData dataWithBytes:" " length:1];
        
    } else {
        
        NSString *name= [self getTestTempItemValue:@"data"];
        NSArray *array = [name componentsSeparatedByString:@"."];
        NSString *fileName = [array objectAtIndex:0];
        NSString *fileType = [array objectAtIndex:1];
        NSString *filePath = [NSString stringWithFormat:@"uexXinShouShuCA/%@",fileName];
        NSString *htmlStr = [[NSBundle mainBundle]pathForResource:filePath ofType:fileType];
        
        orgdata=[NSData dataWithContentsOfFile:htmlStr];
        
    }
    
    PdfRule ruleData;
    
    ruleData.DocStyleTid = StrtypeTid;
    ruleData.DocCrdTid = @"0";
    
    
    res=[interfaceView setTemplate:type mydata:orgdata PdfRule:ruleData];
    
    return res;
    
}

+ (formInfo)setFormInfoData:(formInfo *)infodata {
    
    NSString *Channel = [self getTestformInfoItemValue:@"Channel"];
    NSString *FlowId = [self getTestformInfoItemValue:@"FlowId"];
    NSString *IsSync = [self getTestformInfoItemValue:@"IsSync"];
    NSString *IsUnit = [self getTestformInfoItemValue:@"IsUnit"];
    NSString *WONo = [self getTestformInfoItemValue:@"WONo"];
    NSString *serverEncType = [self getTestformInfoItemValue:@"serverEncType"];
    
    formInfo info = *infodata;
    
    info.Channel = Channel;
    info.FlowId = FlowId;
    info.IsSync = IsSync;
    info.IsUnit = IsUnit;
    info.WONo = WONo;
    
    if([serverEncType isEqualToString:@"SM2"]) {
        
        info.serverEncType = EncType_SM2;
        
    } else {
        
        info.serverEncType = EncType_RSA;
        
    }
    
    return info;
    
}

+ (NSString *)writeDataGramToFile:(NSData *)dataGram {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
     NSString *homeDirectory = NSHomeDirectory();
    
    NSString *signCATxt = [homeDirectory stringByAppendingPathComponent:@"Documents/apps/uexXinShouShuCATxt"];
    
    
    if (![fileManager fileExistsAtPath:signCATxt]) {
        
        [fileManager createDirectoryAtPath:signCATxt withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    
    NSString *signCATxtPath = [signCATxt stringByAppendingPathComponent:DBNAME];
    
    if ([fileManager fileExistsAtPath:signCATxtPath]) {
        
        [fileManager removeItemAtPath:signCATxtPath error:nil];
        
    }
    
    BOOL isYes = [dataGram writeToFile:signCATxtPath atomically:YES];
    
    if (isYes) {
        
        return signCATxtPath;
        
    } else {
        
        return  @"";
    }
    
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color {
    
    return [self colorWithHexString:color alpha:1.0f];
    
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    
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

+ (NSDictionary *)getTestSignCamera :(NSString *) item index:(int)ArrayIndex {
    
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
+ (NSString *)getValue :(NSString *) item index:(int)ArrayIndex arr:(NSDictionary *)dict {
    
    NSString *tmp=[[dict objectForKey:item] retain];
    return tmp;
    
}

+ (NSString *)getTestPlistItemValue :(NSString *) item keyName:(NSString *)key index:(int)ArrayIndex{
    
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:item];
    NSDictionary *signDic= SignArray[ArrayIndex];
    NSString * tmp=[[signDic objectForKey:key] retain];
    [dict release];
    
    return tmp;
    
}

+ (NSString *)getTestTempItemValue :(NSString *) item {
    
    NSString *path=[self getpath];
    
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSDictionary *SignDic=[dict objectForKey:@"Template"];
    NSString * tmp=[[SignDic objectForKey:item] retain];
    
    [dict release];
    return tmp;
}

+ (NSString *)getTestformInfoItemValue :(NSString *) item {
    
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSDictionary *SignDic=[dict objectForKey:@"forminfo"];
    NSString * tmp=[[SignDic objectForKey:item] retain];
    
    [dict release];
    return tmp;
}

+ (NSString *)getTestCachetItemValue :(NSString *) item {
    
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

+ (NSString * )getMutiSignItemValue :(NSString *) item index:(int)ArrayIndex {
    NSString *path=[self getpath];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *SignArray=[dict objectForKey:@"mutiSigns"];
    NSDictionary *signDic= SignArray[ArrayIndex];
    NSString * tmp=[[signDic objectForKey:item] retain];
    [dict release];
    return tmp;
}
@end
