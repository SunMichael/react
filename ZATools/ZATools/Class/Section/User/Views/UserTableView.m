//
//  UserTableView.m
//  yizhenjia
//
//  Created by mac on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UserTableView.h"
#import "UserHeaderView.h"
#import "UserTableViewCell.h"
#import "SetController.h"
#import "ShareView.h"
#import "FeedBackController.h"
#import "ChooseStatusController.h"

@implementation UserTableView
{
    NSArray *allIconAry;
    NSArray *allTitleAry;
    UserHeaderView *headerView;
    NSInteger yuesaoStatus;

    BOOL cellEnable;
    NSString *tipText;
    BOOL canEdit;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        yuesaoStatus = 0;
        cellEnable = NO;
        canEdit = YES;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kBackViewColor;

        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        [self setLayoutMargins:UIEdgeInsetsZero];
//        [self setSeparatorInset:UIEdgeInsetsZero];
//        __weak UserTableView *weakSelf = self;
//        YZJGifHeader *header = [YZJGifHeader headerWithRefreshingBlock:^{
//           
//        }];
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.mj_header = header;
    
        allIconAry = @[[NSMutableArray arrayWithObjects:GetImage(@"heart"),nil],
                       @[GetImage(@"shareIcon"),GetImage(@"pingfen"),GetImage(@"feedback")],
                       @[GetImage(@"set")]
                       ];
        
        allTitleAry = @[[NSMutableArray arrayWithObjects:@"我的状态",nil],
                        @[@"分享给好友",@"给我们评分",@"意见反馈"],
                        @[@"设置"]];
        
        headerView = [[UserHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, 220.f)];
        self.tableHeaderView = headerView;
        tipText = @"未设置";
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestForTipNumber) name:RELOADORDERNUMBER object:nil];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return allTitleAry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *ary = allIconAry[section];
    return ary.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = @"cell";
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    NSArray *ary = allTitleAry[indexPath.section];
    NSArray *icons = allIconAry[indexPath.section];
    BOOL need = ary.count == 1 ? NO : YES;
    [cell updateCellWithImage:icons[indexPath.row] andTitle:ary[indexPath.row] needBottomLine:need];
    if (indexPath.row == 0 && indexPath.section == 0) {
        cell.tipLab.text = tipText;
        cell.tipLab.hidden = NO;
    }else{
        cell.tipLab.hidden = YES;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kUserCellH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section != (allTitleAry.count - 1) ? 10.0f : 0.001f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, 10.0f)];
    view.backgroundColor = kBackViewColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 10.0f : 0.001f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, 10.0f)];
    view.backgroundColor = kBackViewColor;
    return view;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        SetController *setVC = [SetController new];
        [RootNavController pushViewController:setVC animated:YES];
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                ShareView *shareView = [[ShareView alloc] initWithFrame:[UIScreen mainScreen].bounds shareType:shareFound];
                [shareView showShareView];
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                FeedBackController *vc=[[FeedBackController alloc]init];
                [RootNavController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
       
    }else if (indexPath.section == 0){
        if (indexPath.row == 0) {
            ChooseStatusController *status = [ChooseStatusController new];
            [RootNavController pushViewController:status animated:YES];
        }
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSString *tele= @"400-668-0707";
        tele=[tele stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://%@",tele];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
    
}

@end
