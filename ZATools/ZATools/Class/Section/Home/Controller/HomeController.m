//
//  ViewController.m
//  ZATools
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeController.h"
#import <React/RCTRootView.h>
#import "ToolView.h"
#import "EditToolController.h"
#import "ToolController.h"


@interface HomeController () 
{
    UIScrollView *scroll;
    NSArray *titleAry;
}
@end

@implementation HomeController


-(NSString *)title{
    return @"首页";
}
- (BOOL)needBack{
    return NO;
}

- (void)viewDidLoad {
    
    //    [self addReactView];
    
    [super viewDidLoad];
    IvyHeaderBar *header = [[IvyHeaderBar alloc] initWithTitle:@"我的母婴护理师" leftBtnTitle:nil leftBtnImg:[UIImage imageNamed:@"Icon_back"] leftBtnHighlightedImg:nil rightBtnTitle:nil rightBtnImg:nil rightBtnHighlightedImg:nil backgroundColor:[UIColor whiteColor]];
    [header.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //    [self.view addSubview:header];
    
    [self.view addSubview:[self backScrollView]];
    [self loadToolsViews];
    
}

- (UIScrollView *)backScrollView{
    if (!scroll) {
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, navigationBarHeight, kScreenWidth, kScreenHeight - navigationBarHeight -kFooterTabbarHeight)];
        scroll.showsVerticalScrollIndicator = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.backgroundColor = [UIColor whiteColor];
        scroll.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        [scroll setContentSize:CGSizeMake(kScreenWidth, scroll.height + 1.0f)];
        [self.view addSubview:scroll];
    }
    return scroll;
}

- (void)loadToolsViews{
    NSArray *ary = @[GetImage(@"ice"),GetImage(@"chanjian"),GetImage(@"blood"),GetImage(@"yuchanqi"),GetImage(@"add")];
    titleAry = @[@"能不能吃",@"产检时间",@"宝宝血型",@"预产期计算",@"添加工具"];
    NSInteger row = (ary.count % 3 == 0) ? (ary.count/3) : (ary.count/3 + 1);
    float w = kScreenWidth/3;
    for (NSInteger i = 0; i < row; i++) {
        for (NSInteger j = 0; j < 3; j++) {
            if (3 * i + j >= ary.count) {
                break;
            }
            ToolView *view = [[ToolView alloc] initWithFrame:CGRectMake(w * j, w * i, w, w)];
            view.iconView.image = ary[i * 3 + j];
            view.titleLab.text = titleAry[i * 3 + j];
            [view.button setImage:view.iconView.image forState:UIControlStateNormal];
            [view.button addTarget:self action:@selector(clickedTool:) forControlEvents:UIControlEventTouchUpInside];
            view.button.tag = 3*i + j;
            [scroll addSubview:view];
        }
        
    }
}

- (void)clickedTool:(IvyButton *)sender{
    
    if(sender.tag == titleAry.count - 1){
        EditToolController *edit = [[EditToolController alloc] init];
        [RootNavController pushViewController:edit animated:YES];
    }else{
        ToolController *tool = [[ToolController alloc] init];
        tool.headerTitle = @"能不能吃";
        [RootNavController pushViewController:tool animated:YES];
    }
}


- (void)addReactView{
    NSURL *jsCodeLocation;
#ifdef DEBUG
    jsCodeLocation = [NSURL
                      URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    //    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"ios" withExtension:@"jsbundle"];
#else
    //发布前要对js文件进行打包 更改路径
    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"ios" withExtension:@"jsbundle"];
#endif
    
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                         moduleName        : @"ZATools"
                         initialProperties :
     @{
       @"scores" : @[
               @{
                   @"name" : @"Alex",
                   @"value": @"42"
                   },
               @{
                   @"name" : @"Joel",
                   @"value": @"10"
                   }
               ]
       }
                          launchOptions    : nil];
    self.view = rootView;
}

@end
