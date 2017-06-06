//
//  UpView.h
//  testIOS2
//
//  Created by yyfwptz on 2017/5/10.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol viewDelegate<NSObject>

-(void)showCordova;
-(void)showTask;
@end

@interface UpView : UIView{

    id<viewDelegate> delegate;
}
@property (strong, nonatomic) IBOutlet UIView *UpView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) id <viewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@end
