//
//  TipsView.m
//  testIOS2
//
//  Created by yyfwptz on 2017/6/7.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import "TipsView.h"

@implementation TipsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    _price.backgroundColor = [UIColor colorWithRed:(234/255.0) green:(153/255.0) blue:(71/255.0) alpha:(1)];
    self.tipsView = [[[NSBundle mainBundle]loadNibNamed:@"TipsView" owner:self options:nil]lastObject];
    self.tipsView.frame = self.bounds;
    [self addSubview:self.tipsView];
    [self addSubview:_price];
}

@end
