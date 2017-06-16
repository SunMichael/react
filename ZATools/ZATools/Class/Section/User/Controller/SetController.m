//
//  SetController.m
//  yizhenjia
//
//  Created by 汪宁 on 16/8/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SetController.h"
#import "FeedBackController.h"
#import "AboutController.h"

#import "AFNetworking.h"
#import "Account.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "YzjTabbarController.h"
#import "YzjNavigationController.h"
#import "LogoutView.h"
#import "NetworkServiceConfig.h"
#import "UMessage.h"

#define CellVeiticalSpace    15.0f
@interface SetController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic, strong)UITableView *setTableView;


@end
@implementation SetController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.94f green:0.94f blue:0.95f alpha:1.00f];
 
    [self createTableView];

}
- (NSString *)title{
    return @"设置";
}
- (NSString *)backTitle{
    return @"返回";
}

-(void)createTableView
{
    
    _setTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,navigationBarHeight , kScreenWidth, kScreenHeight-navigationBarHeight) style:UITableViewStyleGrouped];
    // _setTableView.backgroundColor=[UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    _setTableView.dataSource=self;
    _setTableView.delegate=self;
    _setTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    _setTableView.tableFooterView=view;
    [self.view addSubview:_setTableView];
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CellVeiticalSpace;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        return 1;
    }else if (section==1)
    {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UserCellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    
    [self createCell:indexPath cell:cell];
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                //
                NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@""];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
                break;
                
            default:
                break;
        }
        
    }else if (indexPath.section==1)
    {
        switch (indexPath.row) {

            case 1:
            {
                AboutController *vc=[[AboutController alloc]init];
                [RootNavController pushViewController:vc animated:YES];
            }
                break;
            default:
            {
                //
                [self checkTheVersion];
            }
                break;
        }
        
    }else
    {
        //退出登录
        LogoutView *logOutView=[[LogoutView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        logOutView.logOut=^(){
            
            //删除推送绑定
            NSString *string = [[IvyUserDefaults shareUserDefaults] getUserId];
            NSString *online = @"test";
            if ([[NetworkServiceConfig shareInstance] isOnline]) {
                online = @"online";
            }
            NSString *alia = [NSString stringWithFormat:@"%@_%@",online,string];
            [UMessage removeAlias:alia type:@"alias_uid" response:^(id responseObject, NSError *error) {
                
            }];
            
            [[IvyUserDefaults shareUserDefaults]setUserInfor:nil];
            [[IvyUserDefaults shareUserDefaults]setToken:nil];
            [[IvyUserDefaults shareUserDefaults]setUserId:nil];
            [[IvyUserDefaults shareUserDefaults]setPhoto:nil];
            [[IvyUserDefaults shareUserDefaults]setBabyInfor:nil];
            [[IvyUserDefaults shareUserDefaults]setFeedDay:0];
            [[IvyUserDefaults shareUserDefaults]setSleepDay:0];
            LoginController *vc=[[LoginController alloc]init];
            vc.isOut=YES;
            AppDelegate *delegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate replaceRootViewController:vc animationOptions:UIViewAnimationOptionTransitionNone];
            
        };
        [[UIApplication sharedApplication].keyWindow addSubview:logOutView];
        [logOutView showLogoutView];
        
    }
    
    
    
}


-(void)checkTheVersion{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",@""]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.f];
    [request setHTTPMethod:@"POST"];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"%@ %@", response, responseObject);
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            NSDictionary* responseDic = responseObject;
            NSString* appStoreVersion = nil;
            NSArray *configData = [responseDic valueForKey:@"results"];
            if (responseDic) {
                for(id config in configData)
                {
                    appStoreVersion = [config valueForKey:@"version"];
                }
            }
            if (appStoreVersion) {
                
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"NewVersion"];
                
                NSString* currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                if ([currentVersion compare:appStoreVersion options:NSNumericSearch]==NSOrderedAscending) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"前往更新到最新版本"  delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消", nil];
                    [alertView show];
                }else
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"NewVersion"];
                    
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"当前版本是最新版本"  delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alertView show];
                    
                    
                }
            }
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:1];
            [_setTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            
            
        }
    }];
    [dataTask resume];
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@""]]];
    }
    
}


-(void)createCell:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15.f, 0, 100, UserCellHeight)];
    label.textColor = kBlackColor;
    label.font=[UIFont systemFontOfSize:15];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 110.f, 0, 100, UserCellHeight)];
    tipLabel.textAlignment = NSTextAlignmentRight;
    tipLabel.font = label.font;
    tipLabel.textColor = kBlackColor;
    
    
    UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, UserCellHeight-0.5, kScreenWidth-20, 0.5)];
    lineImageView.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.94f alpha:1.00f];
    
    UIImageView *rightImageView=[[UIImageView alloc] init];
    rightImageView.image=[UIImage imageNamed:@"ic_arrow"];
    rightImageView.frame = CGRectMake(kScreenWidth -10.0f- rightImageView.image.size.width, UserCellHeight/2 - rightImageView.image.size.height/2, rightImageView.image.size.width, rightImageView.image.size.height);
    [cell.contentView addSubview:rightImageView];
    
    
    NSString *str;
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                str=@"清除图片缓存";
                [cell.contentView addSubview:lineImageView];
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section==1)
    {
        switch (indexPath.row) {
            case 0:
            {
                str=@"当前版本";
                [cell.contentView addSubview:lineImageView];
                NSString* currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                tipLabel.text = [NSString stringWithFormat:@"V%@",currentVersion];
                [cell.contentView addSubview:tipLabel];
            }
                break;
            case 1:
            {
                str=@"关于我们";
                [cell.contentView addSubview:lineImageView];
                [cell.contentView addSubview:rightImageView];
            }
                break;
            default:
                break;
        }
        
    }else
    {
        
        label.frame=CGRectMake(0, 0, kScreenWidth, UserCellHeight);
        label.textAlignment=NSTextAlignmentCenter;
        [rightImageView removeFromSuperview];
        str=@"退出登录";
        
    }
    
    label.text=str;
    [cell.contentView addSubview:label];
    
    
    
    
    
    
}


@end
