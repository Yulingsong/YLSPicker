//
//  ViewController.m
//  YLSPicker
//
//  Created by yulingsong on 16/9/1.
//  Copyright © 2016年 yulingsong. All rights reserved.
//
#define YLSRect(x, y, w, h)  CGRectMake([UIScreen mainScreen].bounds.size.width * x, [UIScreen mainScreen].bounds.size.height * y, [UIScreen mainScreen].bounds.size.width * w,  [UIScreen mainScreen].bounds.size.height * h)
#define YLSColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define YLSMainBackColor [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1]

#import "ViewController.h"
#import "YLSOPickerView.h"
#import "YLSOTPickerView.h"
#import "YLSThPickerView.h"

@interface ViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

/** text1 */
@property (nonatomic,strong) UITextField *text1;
/** text2 */
@property (nonatomic,strong) UITextField *text2;
/** text3 */
@property (nonatomic,strong) UITextField *text3;
/** text4 */
@property (nonatomic,strong) UITextField *text4;
/** text5 */
@property (nonatomic,strong) UITextField *text5;

/** bgview */
@property (nonatomic,strong) UIView *bgView;

/** view */
@property (nonatomic,strong) UIView *topView;
/** button */
@property (nonatomic,strong) UIButton *doneBtn;
/** button */
@property (nonatomic,strong) UIButton *ranBtn;
/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;
/** view */
@property (nonatomic,strong) UIView *popView;
/** string */
@property (nonatomic,strong) NSString *string;


/** array */
@property (nonatomic,strong) NSArray *arrayData;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Picker";
    self.arrayData = @[@"iPhone4",@"iPhone4S",@"iPhone5",@"iPhone5S",@"iPhone5C",@"iPhone6",@"iPhone6Plus",@"iPhone6S",@"iPhone6SPlus"];
    
    NSArray *placeholderArr = @[@"Picker OneVlaue",@"Picker TwoVlaue",@"Picker ThreeVlaue",@"test"];
    for (int i = 0; i < 4; i ++)
    {
        UITextField *text = [[UITextField alloc]initWithFrame:YLSRect(80/375, (140 + i * 60)/667, 215/375, 30/667)];
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.backgroundColor = [UIColor lightGrayColor];
        text.tag = i + 1000;
        text.placeholder = placeholderArr[i];
        text.delegate = self;
        [self.view addSubview:text];
        if(text.tag == 1000)
        {
            self.text1 = text;
        }else if(text.tag == 1001)
        {
            self.text2 = text;
        }else if(text.tag == 1002)
        {
            self.text3 = text;
        }else if(text.tag == 1003)
        {
            self.text4 = text;
//            self.text4.text = self.string;
        }
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:@"value" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTwoValue:) name:@"TwoValues" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getThreeValue:) name:@"ThreeValues" object:nil];
    
    self.bgView = [[UIView alloc]init];
    self.bgView.frame = YLSRect(0, 1, 1, 1);
    self.bgView.backgroundColor = YLSColorAlpha(0, 0, 0, 0.0);
    [self.view addSubview:self.bgView];
    
    self.popView = [[UIView alloc]init];
    self.popView.frame = YLSRect(0, (667 - 250)/667, 1, 250/667);
    self.popView.backgroundColor = [UIColor orangeColor];
    
    self.topView = [[UIView alloc]initWithFrame:YLSRect(0, 0, 1, 250/667)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.popView addSubview:self.topView];
    
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
    
    
    UILabel *titlelb = [[UILabel alloc]initWithFrame:YLSRect(100/375, 0, 175/375, 50/667)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.text = @"popView";;
    titlelb.font = [UIFont systemFontOfSize:20];
    [self.topView addSubview:titlelb];
    
    self.pickerView = [[UIPickerView alloc]init];
    [self.pickerView setFrame:YLSRect(0, 50/667, 1, 200/667)];
    [self.pickerView setBackgroundColor:YLSMainBackColor];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
    [self.topView addSubview:self.pickerView];

    [self.bgView addSubview:self.popView];

}

-(void)getValue:(NSNotification *)notification
{
    self.text1.text = notification.object;
}
-(void)getTwoValue:(NSNotification *)notification
{
    self.text2.text = notification.object;
}
-(void)getThreeValue:(NSNotification *)notification
{
    self.text3.text = notification.object;
}


-(void)quit
{
    [UIView animateWithDuration:0.5 animations:^{
        if ([self.text4.text isEqualToString:@""])
        {
            self.text4.text = self.arrayData[0];
        }

        CGPoint point = self.bgView.center;
        point.y += 667;
        self.bgView.center = point;
//        CGPoint point = self.popView.center;
//        point.y += 250;
//        self.popView.center = point;
    } completion:^(BOOL finished) {
        
    }];
}




#pragma mark - UITextFieldDelegate
//点击文本框时触发的事件，唤起跳出视图
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 1000)
    {
        YLSOPickerView *picker = [[YLSOPickerView alloc]init];
        picker.array = @[@"iPhone4",@"iPhone4S",@"iPhone5",@"iPhone5S",@"iPhone5C",@"iPhone6",@"iPhone6Plus",@"iPhone6S",@"iPhone6SPlus"];
        picker.title = @"pick number";
        [picker show];
    }else if(textField.tag == 1001)
    {
        YLSOTPickerView *picker = [[YLSOTPickerView alloc]init];
        picker.title = @"Select Cars";
        //也可以用这种数据形式
//        picker.array = @[
//                         @{
//                             @"cityName":@"German",
//                             @"cars":@[@"BMW",@"Audi",@"Volkswagen",@"Volvo",@"Mercedes"]
//                            }
//                         ,@{
//                             @"cityName":@"American",
//                            @"cars":@[@"Ford",@"Dodge",@"Chrysler",@"Cadililac"]
//                             }
//                         ,@{
//                             @"cityName":@"Japenese",
//                            @"cars":@[@"Toyota",@"Nissian",@"Mazda",@"Lexus",@"Honda"]
//                             }
//                         ];
        NSDictionary *dict = @{@"German":@[@"BMW",@"Audi",@"Volkswagen",@"Volvo",@"Mercedes"],
                               @"American":@[@"Ford",@"Dodge",@"Chrysler",@"Cadililac"],
                               @"Japanese":@[@"Toyota",@"Nissian",@"Mazda",@"Lexus",@"Honda"]};
        picker.dict = dict;
        [picker show];
    }else if(textField.tag == 1002)
    {
        NSArray *array = @[@[@"Mr",@"Mrs",@"Ms",@"Miss"],@[@"Funny",@"Cool",@"Hot",@"Wonderful",@"Raining",@"Happy",@"Super",@"Lazy",@"Amazing",@"Bat",@"Iron",@"Bat",@"Rocket",@"Pretty",@"Lex"],@[@"Man",@"Luthor",@"Boy",@"Girl",@"Person",@"Cutie",@"Babe",@"Raccoon"]];
        YLSThPickerView *picker = [[YLSThPickerView alloc]init];
        picker.array = array;
        picker.title = @"Describe Yourself";
        [picker show];
    }else if(textField.tag == 1003)
    {
        // 浮现
        [UIView animateWithDuration:0.5 animations:^{
            self.bgView.backgroundColor = YLSColorAlpha(0, 0, 0, 0.4);

            CGPoint point = self.bgView.center;
            point.y -= 667;
            self.bgView.center = point;
//            CGPoint point = self.popView.center;
//            point.y -= 250;
//            self.popView.center = point;
        } completion:^(BOOL finished) {
            
        }];
    }
    return NO;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.arrayData count];
}

#pragma mark - 代理
// 返回第component列第row行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.arrayData[row];
}

// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.text4.text = self.arrayData[row];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
