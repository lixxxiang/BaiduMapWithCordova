//
//  TaskReleaseView.m
//  testIOS2
//
//  Created by yyfwptz on 2017/6/5.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import "TaskReleaseView.h"

@implementation TaskReleaseView
//@synthesize delegate;
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
    self.taskReleaseView = [[[NSBundle mainBundle]loadNibNamed:@"TaskReleaseView" owner:self options:nil]lastObject];
    self.taskReleaseView.frame = self.bounds;
    //    [_btn1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.taskReleaseView];
    _infos = [NSArray arrayWithObjects:@"描述一下想拍摄的内容", @"直播地点", @"直播时间", @"感谢费",nil];
    _missionReleaseTableView.dataSource = self;
    [self addSubview:_missionReleaseTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"cellId";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    NSUInteger index = indexPath.row;
    cell.imageView.image = [UIImage imageNamed:@"avatar"];
    cell.textLabel.text = [_infos objectAtIndex:index];
    cell.detailTextLabel.text = [_infos objectAtIndex:index];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infos.count;
}

@end
