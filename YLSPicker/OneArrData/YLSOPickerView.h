//
//  YLSOPickerView.h
//  YLSPicker
//
//  Created by yulingsong on 16/9/1.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLSOPickerView : UIView
/** array */
@property (nonatomic,strong) NSArray *array;
/** title */
@property (nonatomic,strong) NSString *title;
//快速创建
+(instancetype)pickerView;

//弹出
-(void)show;

@end
