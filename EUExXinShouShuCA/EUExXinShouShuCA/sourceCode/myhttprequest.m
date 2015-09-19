//
//  myhttprequest.m
//  xxs_demo
//
//  Created by miaofan on 13-5-13.
//  Copyright (c) 2013年 bjca. All rights reserved.
//

#import "myhttprequest.h"
#import <UIKit/UIKit.h>

@implementation myhttprequest
- (id )mySignRequestWithServer:(NSString *)data{
    
    NSLog(@"myRequestWithServer");
   	NSString *file=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"ip.txt"];
    bool resfile=[[NSFileManager defaultManager] fileExistsAtPath:file];
    NSString*ip=nil;
    if(resfile==FALSE)
    {
        NSBundle *bundle=[NSBundle mainBundle];
        NSString *path=[bundle pathForResource:@"BjcaConfig" ofType:@"plist"];
        NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
        NSString *tmp=[dict objectForKey:@"IPAddress"];
        ip=[[NSString alloc] initWithFormat:@"%@",tmp];
        NSLog(@"ip-1:%@",ip);
    }
    else
    {
        ip=[[NSString alloc]initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"ip-2:%@",ip);
    }
    
    NSURL *url = [NSURL URLWithString:ip];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSMutableDictionary* headers = [[NSMutableDictionary alloc] init];
    [headers setValue:@"application/x-www-form-urlencoded; charset=utf-8" forKey:@"Content-Type"];
    NSString*urlData=[self EncodeUTF8Str:data];
    NSString *addData=[NSString stringWithFormat:@"padjson=%@",urlData];
    NSData *xmlData=[addData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:xmlData];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    receiveData=[[NSMutableData alloc]init];
    [ip release];
    [conn release];
    return self;
}

#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"ldidReceiveResponse1");
    
    [receiveData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    NSLog(@"didReceiveData2");
    [receiveData appendData:data];
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FAILURE" object:nil userInfo:nil];
    NSLog(@"error====%@",error);
    if(receiveData!=nil)
        {
        receiveData=nil;
        }
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *tmp = [[NSString alloc] initWithData: receiveData encoding:NSUTF8StringEncoding];

    NSLog(@"connectionDidFinishLoading:%@",tmp);
    bool res=TRUE;
    if([tmp isEqualToString:@"0"])
        {
        res=TRUE;
        }
    else
        {
        res=FALSE;
        }
    
    if(res==TRUE){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SUCCESS" object:nil userInfo:nil];
        
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FAILURE" object:nil userInfo:nil];
    }
    NSLog(@"data:%@",receiveData);
    if(receiveData!=nil)
        {
        [receiveData release];
        receiveData=nil;
        }
    
    
    NSLog(@"finish loading release...");
}
#pragma mark -
#pragma mark Encode Chinese to ISO8859-1 in URL
-(NSString *)EncodeUTF8Str:(NSString *)encodeStr{
    CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    NSString *preprocessedString = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)encodeStr, CFSTR(""), kCFStringEncodingUTF8);
    NSString *newStr = [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingUTF8) autorelease];
    [preprocessedString release];
    return newStr;
}
@end
