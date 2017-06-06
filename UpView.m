//
//  UpView.m
//  testIOS2
//
//  Created by yyfwptz on 2017/5/10.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import "UpView.h"
#import "CordovaViewController.h"
#import "AppDelegate.h"

@implementation UpView
@synthesize delegate;



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib

{
    
    UIImage *image = [UIImage imageNamed:@"imageView"];
//    [_imageView setImage:image];
    _imageView.image = image;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.UpView = [[[NSBundle mainBundle]loadNibNamed:@"UpView" owner:self options:nil]lastObject];
    self.UpView.frame = self.bounds;
    [_btn2 addTarget:self action:@selector(simulate:) forControlEvents:UIControlEventTouchUpInside];
    [_btn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.UpView];
    [_btn2 setTitleColor:[UIColor colorWithRed:(234/255.0) green:(153/255.0) blue:(71/255.0) alpha:(1)] forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor colorWithRed:(234/255.0) green:(153/255.0) blue:(71/255.0) alpha:(1)] forState:UIControlStateNormal];
    [self addSubview:_btn2];
    [self addSubview:_btn];
    [self addSubview:_imageView];
    
}

-(void)show:(UIButton *)sender
{
    NSLog(@"ee");
//    [delegate showCordova];
    [delegate showTask];
}

-(void)simulate:(UIButton *)sender
{
    NSLog(@"gg");
    [delegate showCordova];
}


@end
