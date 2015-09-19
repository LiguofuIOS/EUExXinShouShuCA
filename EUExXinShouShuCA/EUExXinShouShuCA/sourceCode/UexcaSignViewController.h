//
//  UexcaSignViewController.h
//  EUExXinShouShuCA
//
//  Created by liguofu on 15/9/17.
//  Copyright (c) 2015年 liguofu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BjcaInterfaceView.h"

@interface UexcaSignViewController : UIViewController <OnSignListenerDelegate> {
    
    BjcaInterfaceView *mypackage1;
    UILabel *signIndex;
    UILabel *cameraIndex;
    UILabel *recordIndex;
    UILabel *massIndex;
    
    UIImageView *myimage;
    UIImageView *myCameraImage;
    UIImageView *myOrignalImage;
    UIView *signView;
    
    int orientationpre;
}

@end
