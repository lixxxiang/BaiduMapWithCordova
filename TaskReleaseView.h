//
//  TaskReleaseView.h
//  testIOS2
//
//  Created by yyfwptz on 2017/6/5.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol missionDelegate<NSObject>

-(void)describeInfo;
-(void)showLocation;
-(void)showTime;
-(void)fee;

@end

@interface TaskReleaseView : UIView<UITableViewDelegate, UITableViewDataSource>
{
    id<missionDelegate> missionDelegate;
}

@property (strong, nonatomic) IBOutlet UITableView *missionReleaseTableView;
@property (strong, nonatomic) IBOutlet UIView *taskReleaseView;
@property (strong, nonatomic) NSArray *infos;
@property (strong, nonatomic) id <missionDelegate> missionDelegate;
@end
