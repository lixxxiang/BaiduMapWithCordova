//
//  CordovaViewController.h
//  testIOS2
//
//  Created by yyfwptz on 2017/5/10.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import <Cordova/CDVViewController.h>
#import <Cordova/CDVCommandDelegateImpl.h>
#import <Cordova/CDVCommandQueue.h>

@interface CordovaViewController : CDVViewController

@end

@interface CordovaCommandDelegate : CDVCommandDelegateImpl
@end

@interface CordovaCommandQueue : CDVCommandQueue
@end
