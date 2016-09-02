//
//  ViewController.m
//  YLSPicker
//
//  Created by yulingsong on 16/9/1.
//  Copyright © 2016年 yulingsong. All rights reserved.
//
#define YLSRect(x, y, w, h)  CGRectMake([UIScreen mainScreen].bounds.size.width * x, [UIScreen mainScreen].bounds.size.height * y, [UIScreen mainScreen].bounds.size.width * w,  [UIScreen mainScreen].bounds.size.height * h)

#import "ViewController.h"
#import "YLSOPickerView.h"
#import "YLSOTPickerView.h"
#import "YLSThPickerView.h"

@interface ViewController ()<UITextFieldDelegate>

/** text1 */
@property (nonatomic,strong) UITextField *text1;
/** text2 */
@property (nonatomic,strong) UITextField *text2;
/** text3 */
@property (nonatomic,strong) UITextField *text3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Picker";
    NSArray *placeholderArr = @[@"Picker OneVlaue",@"Picker TwoVlaue",@"Picker ThreeVlaue"];
    for (int i = 0; i < 3; i ++)
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
        }else
        {
            self.text3 = text;
        }
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:@"value" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTwoValue:) name:@"TwoValues" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getThreeValue:) name:@"ThreeValues" object:nil];
    
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
    }else
    {
        NSArray *array = @[@[@"Mr",@"Mrs",@"Ms",@"Miss"],@[@"Funny",@"Cool",@"Hot",@"Wonderful",@"Raining",@"Happy",@"Super",@"Lazy",@"Amazing",@"Bat",@"Iron",@"Bat",@"Rocket",@"Pretty",@"Lex"],@[@"Man",@"Luthor",@"Boy",@"Girl",@"Person",@"Cutie",@"Babe",@"Raccoon"]];
        YLSThPickerView *picker = [[YLSThPickerView alloc]init];
        picker.array = array;
        picker.title = @"Describe Yourself";
        [picker show];
    }
    return NO;
}

@end
