//
//  LeftViewController.m
//  testIOS2
//
//  Created by yyfwptz on 2017/6/1.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *image = [UIImage imageNamed:@"avatar"];
    _avatar.image = image;
    _avatar.contentMode = UIViewContentModeScaleAspectFit;

    _funtions = [NSArray arrayWithObjects:@"求助", @"支援", @"偷看", @"常去", @"钱包", @"设置", nil];
    //_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"cellId";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    NSUInteger index = indexPath.row;
    cell.imageView.image = [UIImage imageNamed:@"avatar"];
    cell.textLabel.text = [_funtions objectAtIndex:index];
    cell.detailTextLabel.text = [_funtions objectAtIndex:index];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _funtions.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
