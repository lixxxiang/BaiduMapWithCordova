//
//  TaskReleaseView.h
//  testIOS2
//
//  Created by yyfwptz on 2017/6/5.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol viewDelegate<NSObject>
//
//-(void)test;
//
//@end
//
@interface TaskReleaseView : UIView<UITableViewDelegate, UITableViewDataSource>
//{
//    id<viewDelegate> delegate;
//}

@property (strong, nonatomic) IBOutlet UITableView *missionReleaseTableView;
@property (strong, nonatomic) IBOutlet UIView *taskReleaseView;
@property (strong, nonatomic) NSArray *infos;
//@property (strong, nonatomic) id <viewDelegate> delegate;
@end
