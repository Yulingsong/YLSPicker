//
//  YLSThPickerView.m
//  YLSPicker
//
//  Created by yulingsong on 16/9/1.
//  Copyright © 2016年 yulingsong. All rights reserved.
//
#define YLSRect(x, y, w, h)  CGRectMake([UIScreen mainScreen].bounds.size.width * x, [UIScreen mainScreen].bounds.size.height * y, [UIScreen mainScreen].bounds.size.width * w,  [UIScreen mainScreen].bounds.size.height * h)
#define YLSFont(f) [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width * f]
#define YLSColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define YLSMainBackColor [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1]
#define BlueColor [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1]
#define ClearColor [UIColor clearColor]

#import "YLSThPickerView.h"

@interface YLSThPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
/** view */
@property (nonatomic,strong) UIView *topView;
/** button */
@property (nonatomic,strong) UIButton *doneBtn;
/** button */
@property (nonatomic,strong) UIButton *ranBtn;
/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;
/** string */
@property (nonatomic,strong) NSString *result;
/** string */
@property (nonatomic,strong) NSString *result1;
/** string */
@property (nonatomic,strong) NSString *result2;

@end

@implementation YLSThPickerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:YLSRect(0, 0, 1, 917/667)];
    
    if (self)
    {
        self.backgroundColor = YLSColorAlpha(0, 0, 0, 0.4);
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topView = [[UIView alloc]initWithFrame:YLSRect(0, 667/667, 1, 250/667)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    //为view上面的两个角做成圆角。不喜欢的可以注掉
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.topView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.topView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.topView.layer.mask = maskLayer;
    
    self.doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.doneBtn setFrame:YLSRect(320/375, 5/667, 50/375, 40/667)];
    [self.doneBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.doneBtn];
    
    self.ranBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.ranBtn setTitle:@"Random" forState:UIControlStateNormal];
    [self.ranBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.ranBtn setFrame:YLSRect(5/375, 5/667, 100/375, 40/667)];
    [self.ranBtn addTarget:self action:@selector(random:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.ranBtn];
    
    UILabel *titlelb = [[UILabel alloc]initWithFrame:YLSRect(100/375, 0, 175/375, 50/667)];
    titlelb.backgroundColor = ClearColor;
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.text = self.title;
    titlelb.font = YLSFont(20/375);
    [self.topView addSubview:titlelb];
    
    self.pickerView = [[UIPickerView alloc]init];
    [self.pickerView setFrame:YLSRect(0, 50/667, 1, 200/667)];
    [self.pickerView setBackgroundColor:YLSMainBackColor];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
    [self.topView addSubview:self.pickerView];
    
}

//快速创建
+(instancetype)pickerView
{
    return [[self alloc]init];
}

//弹出
- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

//添加弹出移除的动画效果
- (void)showInView:(UIView *)view
{
    // 浮现
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint point = self.center;
        point.y -= 250;
        self.center = point;
    } completion:^(BOOL finished) {
        
    }];
    [view addSubview:self];
}

-(void)quit
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += 250;
        self.center = point;
    } completion:^(BOOL finished) {
        if (!self.result)
        {
            self.result = self.array[0][0];
        }
        if (!self.result1)
        {
            self.result1 = self.array[1][0];
        }
        if (!self.result2)
        {
            self.result2 = self.array[2][0];
        }
        NSString *result = [NSString stringWithFormat:@"%@ %@ %@",self.result,self.result1,self.result2];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ThreeValues" object:result];
        [self removeFromSuperview];
    }];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
//    NSLog(@"%ld",self.array.count);
    return self.array.count;
}

// returns the # of rows in each component.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.array[component] count];
}

#pragma mark - 代理
// 返回第component列第row行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.array[component][row];
}

// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        self.result = self.array[component][row];
    }else if(component == 1)
    {
        self.result1 = self.array[component][row];
    }else
    {
        self.result2 = self.array[component][row];
    }
}
-(void)random:(UIPickerView *)picker
{
    for (int i = 0; i < 3; i++)
    {
        // 假设让第0列随机选中一行
        // 取出第0列的行数
        NSInteger count = [self.array[i] count];
        int random = arc4random_uniform((u_int32_t)count);
        //不会触发代理的选中方法
        [self.pickerView selectRow:random inComponent:i animated:YES];
        //label数据刷新
        [self pickerView:picker didSelectRow:random inComponent:i];
    }
}


@end
