//
//  myhttprequest.h
//  xxs_demo
//
//  Created by miaofan on 13-5-13.
//  Copyright (c) 2013年 bjca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myhttprequest : NSObject{
    
    
    NSMutableData *receiveData;
    NSMutableData *receiveCert;
}
- (id)mySignRequestWithServer:(NSString *)data;
@end
