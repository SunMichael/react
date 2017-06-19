//
//  EditToolController.m
//  ZATools
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "EditToolController.h"
#import "ToolView.h"
@interface EditToolController ()
{
    UIScrollView *scroll;
    UIView *useingView;
    UIView *unuseingView;
    float w;
    float offx;
    float space;
    CGPoint _startP;
    CGPoint _buttonP;
    
    NSMutableArray *_useingViews;
    NSMutableArray *_unuseingViews;
}
@end

@implementation EditToolController

- (void)viewDidLoad {
    [super viewDidLoad];

    w = 140 * (kScreenWidth/750.f) ;
    w = w > 90.f ? w : 90.f;
    offx = 10;
    space = (kScreenWidth - 3*w - offx*2)/2;
    [self.view addSubview:[self backScrollView]];
    
    [self initUseingView];
    [self initUnuseingView];

}
- (UIScrollView *)backScrollView{
    if (!scroll) {
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, navigationBarHeight, kScreenWidth, kScreenHeight - navigationBarHeight)];
        scroll.showsVerticalScrollIndicator = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.backgroundColor = kBackViewColor;
        scroll.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [scroll setContentSize:CGSizeMake(kScreenWidth, scroll.height + 1.0f)];
        [self.view addSubview:scroll];
    }
    return scroll;
}

/**
 初始化正在使用的工具内容
 */
- (void)initUseingView{
    useingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    useingView.backgroundColor = kBackViewColor;
    [scroll addSubview:useingView];
    
    IvyLabel *tipLab = [[IvyLabel alloc] initWithFrame:CGRectMake(offx, 20, kScreenWidth, 16) text:@"已启用的工具（拖拽可以排序）" font:GetFont(16) textColor:kGrayColor textAlignment:NSTextAlignmentLeft numberLines:1];
    [useingView addSubview:tipLab];
    
    IvyButton *button = [[IvyButton alloc] initWithFrame:CGRectMake(kScreenWidth - 70.0f, tipLab.y - ( 30/2 - tipLab.height/2 ), 60.0f, 30.f) titleStr:@"" titleColor:kRedColor font:GetFont(14) logoImg:nil backgroundImg:[UIImage createImageWithColor:kBackViewColor]];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"完成" forState:UIControlStateSelected];
    button.layer.cornerRadius = 3.f;
    button.layer.borderColor = kRedColor.CGColor;
    button.layer.borderWidth = 1.f;
    [button addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [useingView addSubview:button];
    

    NSMutableArray *ary = [NSMutableArray arrayWithArray:@[GetImage(@"ice"),GetImage(@"chanjian"),GetImage(@"blood"),GetImage(@"yuchanqi"),GetImage(@"add")]];
    NSMutableArray *titleAry = [NSMutableArray arrayWithArray:@[@"能不能吃",@"产检时间",@"宝宝血型",@"预产期计算",@"添加工具"]];
    [self loadUseingTools:ary titles:titleAry];
}


/**
 加载视图

 @param iconAry xxx
 @param titleAry xxx
 */
- (void)loadUseingTools:(NSMutableArray *)iconAry titles:(NSMutableArray *)titleAry{
    float offy = 60.f;

    _useingViews = [NSMutableArray array];
    NSInteger row = (iconAry.count % 3 == 0) ? (iconAry.count/3) : (iconAry.count/3 + 1);
    for (NSInteger i = 0; i < row; i++) {
        for (NSInteger j = 0; j < 3; j++) {
            if (3 * i + j >= iconAry.count) {
                break;
            }
            ToolView *view = [[ToolView alloc] initWithFrame:CGRectMake(offx + w * j + space * j, w * i + 10*i + offy, w, w) withEditStatus:YES
                              ];
            view.iconView.image = iconAry[i * 3 + j];
            view.titleLab.text = titleAry[i * 3 + j];
            [view.button setImage:view.iconView.image forState:UIControlStateNormal];
            view.button.userInteractionEnabled = NO;
            __weak ToolView *copyView = view;
            view.editBlock = ^(BOOL add, NSInteger index){
                __strong ToolView *sView = copyView;
                [self sortUseingViews:sView index:index ];
            };
            view.tag = 3 * i + j;
            [useingView addSubview:view];
            [_useingViews addObject:view];
            
            UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
            [view addGestureRecognizer:gesture];
        }
    }
    
    CGRect frame = useingView.frame;
    frame.size.height = row *(w + 10.f) + offy;
    useingView.frame = frame;
}


/**
 点击移除处理

 @param copyView copyView description
 @param index index description
 */
- (void)sortUseingViews:(ToolView *)copyView index:(NSInteger)index {
    CGPoint p = copyView.center;
    
    for (NSInteger i = index; i < _useingViews.count - 1; i++) {
        
        NSInteger num ;
        if (index == 0) {
            num = i;
        }else{
            num = i + 1;
        }
        
        UIView * nextBtn = _useingViews[i + 1];
        CGPoint tempP = nextBtn.center;
        [UIView animateWithDuration:0.5 animations:^{
            nextBtn.center = p;
        }];
        p = tempP;
        nextBtn.tag = i;
    }
    [copyView removeFromSuperview];
    [_useingViews removeObject:copyView];
    [self sortArray:_useingViews];
    
    
    copyView.editBtn.selected = YES;
    copyView.tag = _unuseingViews.count;
    copyView.userInteractionEnabled = YES;
    __weak ToolView *weakView = copyView;
    copyView.editBlock = ^(BOOL add, NSInteger index){
        __strong ToolView *sView = weakView;
        [self sortUnuseingViews:sView index:sView.tag ];
    };
    [_unuseingViews addObject:copyView];
    [unuseingView addSubview:copyView];
    
    CGRect frame2 = useingView.frame;
    NSInteger num = (_useingViews.count % 3 == 0) ? (_useingViews.count/3) : (_useingViews.count/3 + 1);
    frame2.size.height = num *(w + 10.f) + 60.0f;
    useingView.frame = frame2;
    
    CGFloat maxyY = [self sortAddArray:_unuseingViews offy:40.f];
    CGRect frame = unuseingView.frame;
    frame.size.height = maxyY ;
    frame.origin.y = CGRectGetMaxY(useingView.frame) + 10.f;
    unuseingView.frame = frame;
    
    [self sortArray:_useingViews];
}


/**
 加载视图

 @param iconAry iconAry description
 @param titleAry titleAry description
 */
- (void)loadUnuseingTools:(NSArray *)iconAry titles:(NSArray *)titleAry{
    float offy = 40.f;
    _unuseingViews = [NSMutableArray array];
    NSInteger row = (iconAry.count % 3 == 0) ? (iconAry.count/3) : (iconAry.count/3 + 1);
    for (NSInteger i = 0; i < row; i++) {
        for (NSInteger j = 0; j < 3; j++) {
            if (3 * i + j >= iconAry.count) {
                break;
            }
            ToolView *view = [[ToolView alloc] initWithFrame:CGRectMake(offx + w * j + space * j, w * i + 10.f*i + offy, w, w) withEditStatus:NO
                              ];
            view.iconView.image = iconAry[i * 3 + j];
            view.titleLab.text = titleAry[i * 3 + j];
            [view.button setImage:view.iconView.image forState:UIControlStateNormal];
            view.editBtn.selected = YES;
            view.button.userInteractionEnabled = NO;
            view.tag = i*3 + j;
            __weak ToolView *copyView = view;
            view.editBlock = ^(BOOL add , NSInteger index){
                __strong ToolView *sView = copyView;
                [self sortUnuseingViews:sView index:index ];
            };
            [unuseingView addSubview:view];
            [_unuseingViews addObject:view];
            
            UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
            [view addGestureRecognizer:gesture];
        }
    }
    CGRect frame = unuseingView.frame;
    frame.size.height = row *(w + 10.f) + offy;
    unuseingView.frame = frame;
    
    if (CGRectGetMaxY(unuseingView.frame) > scroll.height) {
        [scroll setContentSize:CGSizeMake(kScreenWidth, CGRectGetMaxY(unuseingView.frame) + 20.f)];
    }
}

/**
 点击添加处理

 @param copyView copyView description
 @param index index description
 */
- (void)sortUnuseingViews:(ToolView *)copyView index:(NSInteger)index{
    CGPoint p = copyView.center;
    
    for (NSInteger i = index; i < _unuseingViews.count - 1; i++) {
        
        UIView * nextBtn = _unuseingViews[i + 1];
        CGPoint tempP = nextBtn.center;
        [UIView animateWithDuration:0.5 animations:^{
            nextBtn.center = p;
        }];
        p = tempP;
        nextBtn.tag = i;
    }
    [copyView removeFromSuperview];
    [_unuseingViews removeObject:copyView];
    [self sortArray:_unuseingViews];
    
    copyView.tag = _useingViews.count ;
    copyView.editBtn.selected = NO;
    copyView.userInteractionEnabled = YES;
    __weak ToolView *weakView = copyView;
    copyView.editBlock = ^(BOOL add, NSInteger index){
        __strong ToolView *sView = weakView;
        [self sortUseingViews:sView index:sView.tag ];
    };
    [_useingViews addObject:copyView];
    [useingView addSubview:copyView];
    
    CGFloat maxyY = [self sortAddArray:_useingViews offy:60.f];
    CGRect frame = useingView.frame;
    frame.size.height = maxyY ;
    useingView.frame = frame;
    
    CGRect frame2 = unuseingView.frame;
    NSInteger num = (_unuseingViews.count % 3 == 0) ? (_unuseingViews.count/3) : (_unuseingViews.count/3 + 1);
    frame2.size.height = num *(w + 10.f) + 40.f;
    frame2.origin.y = CGRectGetMaxY(useingView.frame) + 10.;
    unuseingView.frame = frame2;
    
    [self sortArray: _unuseingViews];
}

/**
 初始化未添加的工具视图
 */
- (void)initUnuseingView{
    unuseingView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(useingView.frame) + 10.f, kScreenWidth, 0)];
    unuseingView.backgroundColor = kBackViewColor;
    [scroll addSubview:unuseingView];
    
    IvyLabel *tipLab = [[IvyLabel alloc] initWithFrame:CGRectMake(offx, offx, kScreenWidth, 16) text:@"工具推荐" font:GetFont(16) textColor:kGrayColor textAlignment:NSTextAlignmentLeft numberLines:1];
    [unuseingView addSubview:tipLab];
    
    NSMutableArray *unuseAry = [NSMutableArray arrayWithArray:@[GetImage(@"ice"),GetImage(@"chanjian"),GetImage(@"blood"),GetImage(@"yuchanqi"),GetImage(@"add")]];
    NSMutableArray *unuserTitleAry = [NSMutableArray arrayWithArray:@[@"能不能吃",@"产检时间",@"宝宝血型",@"预产期计算",@"添加工具"]];
    [self loadUnuseingTools:unuseAry titles:unuserTitleAry];
}

- (void)finish:(IvyButton *)button{
    
    for (ToolView *view in _useingViews) {
        view.editBtn.hidden = button.selected;
    }
    for (ToolView *view in _unuseingViews) {
        view.editBtn.hidden = button.selected;
    }
    button.selected = !button.selected;
}


/**
 更新被点击的视图坐标

 @param ary ary description
 @param offy offy description
 @return return value description
 */
- (CGFloat)sortAddArray:(NSMutableArray *)ary offy:(float)offy{
    if (ary.count == 0) {
        return offy;
    }
    NSInteger i = (ary.count % 3 == 0) ? (ary.count/3 -1) : (ary.count/3 );
    NSInteger j = ary.count - 1 - 3*i;
    CGRect frame = CGRectMake(offx + w * j + space * j, w * i + 10.f*i + offy, w, w);
    ToolView *view = (ToolView *)[ary lastObject];
    view.frame = frame;
    return CGRectGetMaxY(view.frame);
}


- (void)gesture:(UILongPressGestureRecognizer *)longGes{
 
    UIView * currentBtn = (UIView *)longGes.view;
    
    if (UIGestureRecognizerStateBegan == longGes.state) {
        [UIView animateWithDuration:0.2 animations:^{
            currentBtn.transform = CGAffineTransformScale(currentBtn.transform, 1.2, 1.2);
            currentBtn.alpha = 0.7f;
            _startP = [longGes locationInView:currentBtn];
            _buttonP = currentBtn.center;
        }];
    }
    
    if (UIGestureRecognizerStateChanged == longGes.state) {
        CGPoint newP = [longGes locationInView:currentBtn];
        CGFloat movedX = newP.x - _startP.x;
        CGFloat movedY = newP.y - _startP.y;
        currentBtn.center = CGPointMake(currentBtn.center.x + movedX, currentBtn.center.y + movedY);
        
        // 获取当前按钮的索引
        NSInteger fromIndex = currentBtn.tag;
        // 获取目标移动索引
        NSInteger toIndex = [self getMovedIndexByCurrentButton:currentBtn];
        
        if (toIndex < 0) {
            return;
        } else {
            
            currentBtn.tag = toIndex;
            // 按钮向后移动
            if (fromIndex < toIndex) {
                
                for (NSInteger i = fromIndex; i < toIndex; i++) {
                    // 拿到下一个按钮
                    UIView * nextBtn = _useingViews[i + 1];
                    CGPoint tempP = nextBtn.center;
                    [UIView animateWithDuration:0.5 animations:^{
                        nextBtn.center = _buttonP;
                    }];
                    _buttonP = tempP;
                    nextBtn.tag = i;
                }
                [self sortArray:_useingViews];
            } else if(fromIndex > toIndex) { // 按钮向前移动
                
                for (NSInteger i = fromIndex; i > toIndex; i--) {
                    UIView * previousBtn = _useingViews[i - 1];
                    CGPoint tempP = previousBtn.center;
                    [UIView animateWithDuration:0.5 animations:^{
                        previousBtn.center = _buttonP;
                    }];
                    _buttonP = tempP;
                    previousBtn.tag = i;
                }
                [self sortArray:_useingViews];
            }
        }
    }
    
    // 手指松开之后 进行的处理
    if (UIGestureRecognizerStateEnded == longGes.state) {
        [UIView animateWithDuration:0.2 animations:^{
            currentBtn.transform = CGAffineTransformIdentity;
            currentBtn.alpha = 1.0f;
            currentBtn.center = _buttonP;
        }];
    }
}
- (NSInteger)getMovedIndexByCurrentButton:(UIView *)currentButton
{
    for (NSInteger i = 0; i< _useingViews.count ; i++) {
        UIView * button = _useingViews[i];
        if (!currentButton || button != currentButton) {
            if (CGRectContainsPoint(button.frame, currentButton.center)) {
                return i;
            }
        }
    }
    return -1;
}

- (void)sortArray:(NSMutableArray *)array
{
    // 对已改变按钮的数组进行排序
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        UIView *temp1 = (UIView *)obj1;
        UIView *temp2 = (UIView *)obj2;
        return temp1.tag > temp2.tag;    //将tag值大的按钮向后移
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title{
    return @"添加工具";
}



@end
