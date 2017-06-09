//
//  StorePickerView.m
//  ApManager
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "AreaPickerView.h"
#import "ProvinceModel.h"
#import "CityModel.h"
#import "StreetModel.h"

@implementation AreaPickerView
{
    UIView *toolBar;
    UIPickerView *pickView;
    UIView *backView;
    NSArray *copyAry ;
    NSInteger copyNumber;
    PickerType copyType;
    PickerViewBlock copyBlock;
    
    NSArray *selectedCitys;
    NSArray *selectedAreas;
    NSArray *selectedTypes;
    NSArray *selectedTime;
    
    NSInteger pIndex;       //选中的省
    NSInteger cIndex;       //选中的市
    NSInteger aIndex;       //选中的区
    
    NSInteger typeIndex;      //主类型
    NSInteger subTypeIndex;     //子类型
    
    NSInteger sIndex;       //选中的街道

    NSInteger timeIndex;      //主类型
    NSInteger subTimeIndex;     //子类型

    
}
@synthesize pIndex = pIndex;
@synthesize cIndex = cIndex;
@synthesize aIndex = aIndex;
@synthesize typeIndex = typeIndex;
@synthesize subTypeIndex = subTypeIndex;
@synthesize sIndex = sIndex;
@synthesize timeIndex = timeIndex;
@synthesize subTimeIndex = subTimeIndex;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        selectedCitys = [NSArray array];
        selectedAreas = [NSArray array];
        selectedTypes = [NSArray array];
        pIndex = 0;
        cIndex = 0;
        aIndex = 0;
        sIndex = 0;
        timeIndex = 0;
        subTimeIndex = 0;
        _dayIndex = 0;
        [self loadPickerView];
        [self loadPickerHeaderView];
    }
    return self;
}
- (void)loadPickerView{
    pickView=[[UIPickerView alloc]initWithFrame:CGRectMake(0.0f, kScreenHeight + 44.0f, kScreenWidth, 200.0f)];
    pickView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    pickView.delegate=self;
    pickView.dataSource=self;
    pickView.showsSelectionIndicator=YES;
//    [pickView setBackgroundColor:[UIColor colorWithRed:0.81f green:0.84f blue:0.86f alpha:1.00f]];
    [pickView setBackgroundColor:[UIColor whiteColor]];
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    backView.backgroundColor = kGrayColor;
    backView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPickerView)];
    [backView addGestureRecognizer:tap];
    
    [self addSubview:backView];
    [self addSubview:pickView];
}

-(void)showPickerView{
    [UIView animateWithDuration:0.3 animations:^{
        float offy = pickView.origin.y == (kScreenHeight - pickView.height) ? kScreenHeight + toolBar.height : (kScreenHeight - pickView.height);
        pickView.frame = CGRectMake(0, offy, kScreenWidth, pickView.height);
        float offy2 = pickView.origin.y == (kScreenHeight - pickView.height) ? pickView.frame.origin.y- toolBar.height : kScreenHeight;
        toolBar.frame = CGRectMake(0, offy2, kScreenWidth, toolBar.height);
        backView.alpha = 0.5 - backView.alpha;
    }completion:^(BOOL finished) {
        if (finished) {
            if (pickView.y > kScreenHeight) {
                self.hidden = YES;
            }else{
                self.hidden = NO;
            }
        }
    }];
}
/**
 *  加载选择器顶部
 */
- (void)loadPickerHeaderView{
    //创建确定，取消按钮
    NSMutableArray* items=[[NSMutableArray alloc]initWithCapacity:3];
    UIButton* confirmButton;
    UIButton *cannelButton;
    
    confirmButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmButton.backgroundColor =[UIColor clearColor];
    cannelButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    cannelButton.backgroundColor =[UIColor clearColor];
    
    confirmButton.frame =CGRectMake(kScreenWidth - 60.0f -5.0f, 5.0f, 60, 29);
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.titleLabel.font =[UIFont systemFontOfSize:17.0];
    [confirmButton addTarget:self action:@selector(confirmPickerView) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setTitleColor:[UIColor colorWithRed:0.01f green:0.59f blue:0.83f alpha:1.00f] forState:UIControlStateNormal];
    UIBarButtonItem* item1 =[[UIBarButtonItem alloc]initWithCustomView:confirmButton];
    
    cannelButton.frame=CGRectMake(5, 5, 60, 29);
    [cannelButton setTitle:@"取消" forState:UIControlStateNormal];
    cannelButton.titleLabel.font=[UIFont systemFontOfSize:17.0];
    [cannelButton addTarget:self action:@selector(pickerViewHide) forControlEvents:UIControlEventTouchUpInside];
    [cannelButton setTitleColor:[UIColor colorWithRed:0.01f green:0.59f blue:0.83f alpha:1.00f] forState:UIControlStateNormal];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithCustomView:cannelButton];
    
    
    UIBarButtonItem *spaceItem3=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:item2];
    [items addObject:spaceItem3];
    [items addObject:item1];
    if (!toolBar) {
        toolBar=[[UIView alloc]initWithFrame:CGRectMake(0, pickView.frame.origin.y-44, kScreenWidth, 44)];
        toolBar.hidden=NO;
        toolBar.backgroundColor = [UIColor whiteColor];
        [self addSubview:toolBar];
        
//        [toolBar addSubview:cannelButton];
        [toolBar addSubview:confirmButton];
        
//        CALayer *layer = [CALayer layer];
//        layer.backgroundColor = kGrayColor.CGColor;
//        layer.frame = CGRectMake(0.0f, 44.0f - 0.5f, kScreenWidth, 0.5f);
//        [toolBar.layer addSublayer:layer];
    }
    
    
    
}
-(void)confirmPickerView{
//    self.hidden = YES;
    [self showPickerView];
    
    switch (copyType) {
        case PickerTypeProvince:
        {
            pIndex = [pickView selectedRowInComponent: 0];
            cIndex = [pickView selectedRowInComponent: 1];
            aIndex = [pickView selectedRowInComponent: 2];
            
            ProvinceModel *province = [copyAry objectAtIndex: pIndex];
            CityModel *city = [selectedCitys objectAtIndex: cIndex];
            StreetModel *area = [selectedAreas objectAtIndex:aIndex];
            
            copyBlock(province, city ,area);
        }
            break;
        case PickerTypeStoreType:
        {
            typeIndex = [pickView selectedRowInComponent:0];
            subTypeIndex = [pickView selectedRowInComponent:1];
        }
            break;
        case PickerTypeStreet:{
            NSInteger index = [pickView selectedRowInComponent:0];
//            StreetModel *model = copyAry[index];
            sIndex = index;
           
        }
            break;
            
        case PickerTypeTime:{
            NSInteger index1 = [pickView selectedRowInComponent:0];
            timeIndex = index1;
            NSInteger index2 = [pickView selectedRowInComponent:1];
            subTimeIndex = index2;
            NSArray *array1 = [copyAry objectAtIndex:0];
            NSArray *array2 = [copyAry objectAtIndex:1];
            _chooseTimeBlock(array1[index1],array2[index2]);
        }
            break;
            
            case PickerTypeSingleDay:
        {
            _dayIndex = [pickView selectedRowInComponent:0];
            _chooseDayBlock([copyAry[_dayIndex] integerValue]);
        }
            break;
        default:
            break;
    }
    
}
-(void)pickerViewHide{
//    self.hidden = YES;
    [self showPickerView];
}

-(void)updatePickerViewWithSource:(NSArray *)array andComponents:(NSInteger)number andType:(PickerType)type andCompletedBlock:(PickerViewBlock)block{
    
    copyBlock = [block copy];
    copyAry = [NSArray arrayWithArray:array];
    copyNumber = number;
    copyType = type;
    [pickView reloadAllComponents];
    
    if (type == PickerTypeProvince ) {
        if (pIndex == 0 && cIndex == 0 && aIndex == 0) {
            [pickView selectRow:pIndex inComponent:0 animated:YES];
            [self pickerView:pickView didSelectRow:0 inComponent:0];
        }else{
            [pickView selectRow:pIndex inComponent:0 animated:YES];
            [self pickerView:pickView didSelectRow:pIndex inComponent:0];
            [pickView selectRow:cIndex inComponent:1 animated:YES];
            [self pickerView:pickView didSelectRow:cIndex inComponent:1];
            [pickView selectRow:aIndex inComponent:2 animated:YES];
        }
    }
    if (type == PickerTypeStoreType){
        if (typeIndex == 0  && subTypeIndex == 0) {
            [pickView selectRow:typeIndex inComponent:0 animated:YES];
            [self pickerView:pickView didSelectRow:0 inComponent:0];
        }else{

            [pickView selectRow:typeIndex inComponent:0 animated:YES];
            [self pickerView:pickView didSelectRow:typeIndex inComponent:0];
            [pickView selectRow:subTypeIndex inComponent:1 animated:YES];
            [self pickerView:pickView didSelectRow:subTypeIndex inComponent:1];
        }
        
    }
    if (type == PickerTypeStreet){
        
        [pickView selectRow:sIndex inComponent:0 animated:YES];
        
    }
    if (type == PickerTypeTime){
        if (timeIndex == 0  && subTimeIndex == 0) {
            [self pickerView:pickView didSelectRow:timeIndex inComponent:0];
           [pickView selectRow:timeIndex inComponent:0 animated:YES];

        }else{
            [self pickerView:pickView didSelectRow:timeIndex inComponent:0];
            [pickView selectRow:timeIndex inComponent:0 animated:YES];
            [self pickerView:pickView didSelectRow:subTimeIndex inComponent:0];
            [pickView selectRow:subTimeIndex inComponent:1 animated:YES];
        }
    }
    if (type == PickerTypeSingleDay) {
        
        [pickView selectRow:_dayIndex inComponent:0 animated:YES];
        
    }
}

-(void)changePickviewType:(PickerType)type{
    if (type == PickerTypeProvince ) {
        if (pIndex == 0 && cIndex == 0 && aIndex == 0) {
            [self pickerView:pickView didSelectRow:0 inComponent:0];
        }else{
            [pickView selectRow:pIndex inComponent:0 animated:YES];
            [pickView selectRow:cIndex inComponent:1 animated:YES];
            [pickView selectRow:aIndex inComponent:2 animated:YES];
        }
    }else if (type == PickerTypeStoreType){
        if (typeIndex == 0  && subTypeIndex == 0) {
            [self pickerView:pickView didSelectRow:0 inComponent:0];
        }else{
            [pickView selectRow:typeIndex inComponent:0 animated:YES];
            [pickView selectRow:subTypeIndex inComponent:1 animated:YES];
        }
        
    }else if (type == PickerTypeStreet){
        
        [pickView selectRow:sIndex inComponent:0 animated:YES];
        
    }else if (type == PickerTypeTime){
        if (timeIndex == 0  && subTimeIndex == 0) {
            [self pickerView:pickView didSelectRow:0 inComponent:0];
        }else{
            [pickView selectRow:typeIndex inComponent:0 animated:YES];
            [pickView selectRow:subTypeIndex inComponent:1 animated:YES];
        }

    }
}

#pragma PickerView delegate && datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return copyNumber;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (copyType) {
        case PickerTypeProvince:
        {
            switch (component) {
                case 0:      //省
                {
                    return copyAry.count;
                }
                    break;
                case 1:
                {
                    return selectedCitys.count;
                }
                case 2:
                {
                    return selectedAreas.count;
                }
                default:
                    break;
            }
        }
            break;
        case PickerTypeStreet:
        {
            return copyAry.count;
        }
            break;
        case PickerTypeStoreType:
        {
            switch (component) {
                case 0:
                    return copyAry.count;
                    break;
                case 1:
                    return selectedTypes.count;
                    break;
                default:
                    break;
            }
        }
            break;
        case PickerTypeTime:
        {
            switch (component) {
                case 0:
                {
                    NSArray *arr = copyAry[0];
                    return arr.count;
                }
                    break;
                case 1:
                {
                    NSArray *ary = copyAry[1];
                    return ary.count;
                }
                default:
                    break;
            }
        }
            break;
            case PickerTypeSingleDay:
        {
            return copyAry.count;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (copyType) {
        case PickerTypeProvince:
        {
            switch (component) {
                case 0:      //省
                {
                    ProvinceModel *model = [copyAry objectAtIndex:row];
                    return model.name;
                }
                    break;
                case 1:
                {
                    CityModel *model = [selectedCitys objectAtIndex:row];
                    return model.name;
                }
                    break;
                case 2:
                {
                    StreetModel *model = [selectedAreas objectAtIndex:row];
                    return model.name;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case PickerTypeStreet:
        {
            StreetModel *model = [copyAry objectAtIndex:row];
            return model.name;
        }
            break;
        case PickerTypeStoreType:
        {
            switch (component) {
                case 0:
                {

                }
                    break;
                case 1:
                {


                }
                    break;
                default:
                    break;
            }
        }
            break;
        case PickerTypeTime:
        {
            switch (component) {
                case 0:
                {
                    NSArray *array = [copyAry objectAtIndex:0];
                    return array[row];
                }
                    break;
                case 1:
                {
                    NSArray *ary = copyAry[1];
                    return ary[row];
                }
                default:
                    break;
            }
        }
            break;
            case PickerTypeSingleDay:
        {
            return [NSString stringWithFormat:@"%@",copyAry[row]];
        }
            break;
        default:
            break;
    }
    return @"";
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (copyType) {
        case PickerTypeProvince:
        {
            switch (component) {
                case 0:      //省
                {
                    ProvinceModel *selectedPro = [copyAry objectAtIndex:row];
                    selectedCitys = [NSArray arrayWithArray:selectedPro.list];
                    CityModel *selectedCity = selectedCitys[0];
                    selectedAreas = selectedCity.list;
                    [pickerView selectRow: 0 inComponent: 1 animated: YES];
                    [pickerView selectRow: 0 inComponent: 2 animated: YES];
                    [pickerView reloadComponent: 1];
                    [pickerView reloadComponent: 2];
                }
                    break;
                case 1:
                {
                    CityModel *selectedCity = selectedCitys[row];
                    selectedAreas = [NSArray arrayWithArray:selectedCity.list];
                    [pickerView selectRow: 0 inComponent: 2 animated: YES];
                    [pickerView reloadComponent: 2];
                }
                case 2:
                {
                    
                }
                default:
                    break;
            }
        }
            break;
        case PickerTypeStreet:
        {
            
            
        }
            break;
        case PickerTypeTime:
        {
            switch (component) {
                case 0:
                {
                    selectedTime = copyAry[1];
                    [pickerView selectRow: 0 inComponent: 1 animated: YES];
                    [pickerView reloadComponent: 1];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case PickerTypeStoreType:
        {
            switch (component) {
                case 0:
                {
                   
                }
                    break;
                case 1:
                    
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
}

@end
