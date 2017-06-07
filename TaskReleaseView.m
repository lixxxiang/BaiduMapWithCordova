//
//  TaskReleaseView.m
//  testIOS2
//
//  Created by yyfwptz on 2017/6/5.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import "TaskReleaseView.h"
#import "AppDelegate.h"
#import "ViewController.h"

@implementation TaskReleaseView
@synthesize missionDelegate;
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
    [super awakeFromNib];
    self.taskReleaseView = [[[NSBundle mainBundle]loadNibNamed:@"TaskReleaseView" owner:self options:nil]lastObject];
    self.taskReleaseView.frame = self.bounds;
    //    [_btn1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.taskReleaseView];
    _infos = [NSArray arrayWithObjects:@"描述一下想拍摄的内容", @"直播地点", @"直播时间", @"感谢费",nil];
    _missionReleaseTableView.dataSource = self;
    _missionReleaseTableView.scrollEnabled = NO;

    /**
     * important ADD DELEGATE
     */
    _missionReleaseTableView.delegate = self;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.pictrueNameValue=[self.filelist objectAtIndex:indexPath.row];
//    
//    OVWPictureShowViewController *pictureShowViewController;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        pictureShowViewController = [[OVWPictureShowViewController alloc] initWithNibName:@"PictureShowView_iphone" bundle:Nil];
//    } else {
//        pictureShowViewController = [[OVWPictureShowViewController alloc] initWithNibName:@"PictureShowView_ipad" bundle:Nil];
//    }
//    self.delegate=pictureShowViewController;
//    [self.delegate passValue:self.pictrueNameValue];
//    [self presentModalViewController:pictureShowViewController animated:YES];
//    NSLog(@"%ld", (long)indexPath.row);
//    [delegate tableViewClicked:(NSInteger)indexPath.row];
    switch (indexPath.row) {
        case 0:{
            NSLog(@"%ld", (long)indexPath.row);
            ViewController *viewController = [[ViewController alloc]init];
            missionDelegate = viewController;
            [missionDelegate describeInfo];
            break;
        }
        case 1:
            [missionDelegate showLocation];
            
            break;
        case 2:
            [missionDelegate showTime];
            break;
        case 3:
            [missionDelegate fee];
            break;
        default:
            break;
    }
}


@end
