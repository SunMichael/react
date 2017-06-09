//
//  StorePickerView.h
//  ApManager
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvinceModel.h"
#import "CityModel.h"
#import "StreetModel.h"

typedef void(^PickerViewBlock)(ProvinceModel *area, CityModel *city ,StreetModel *street);

typedef NS_ENUM(NSInteger, PickerType) {
    PickerTypeProvince,         //省市区
    PickerTypeStreet,           //街道
    PickerTypeStoreType,         //店铺类型
    PickerTypeTime,              //时间
    PickerTypeSingleDay          //续约天数
};

@interface AreaPickerView : UIView<UIPickerViewDataSource , UIPickerViewDelegate>

@property(nonatomic,assign) NSInteger pIndex;
@property(nonatomic,assign) NSInteger cIndex;       //选中的市
@property(nonatomic,assign) NSInteger aIndex;       //选中的区

@property(nonatomic,assign) NSInteger typeIndex;      //主类型
@property(nonatomic,assign) NSInteger subTypeIndex;     //子类型

@property(nonatomic,assign) NSInteger sIndex;       //选中的街道

@property(nonatomic,assign) NSInteger timeIndex;      //主类型
@property(nonatomic,assign) NSInteger subTimeIndex;     //子类型

@property(nonatomic,assign) NSInteger dayIndex; 

@property(nonatomic,copy) void(^chooseTimeBlock)(NSString *hour,NSString *min);
@property(nonatomic,copy) void(^chooseDayBlock)(NSInteger day);
/**
*  更新选择器数据
*
*  @param array 数据
*  @param number 数量
*/
- (void)updatePickerViewWithSource:(NSArray *)array andComponents:(NSInteger)number andType:(PickerType)type andCompletedBlock:(PickerViewBlock)block;

- (void)showPickerView;

@end
