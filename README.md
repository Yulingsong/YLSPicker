# YLSPicker
Select data from popup view which make by the picker

#### 效果图：（在网页上看gif好像（不是好像，应该就是）亮闪眼睛，所以如果使用的话大家可以阅读Readme.md）
<h5>2.0</h5>

![9月-03-2016 17-49-51.gif](http://upload-images.jianshu.io/upload_images/1062695-5051762d50ff7123.gif?imageMogr2/auto-orient/strip)

<h5>1.0</h5>
![pckerVIew][image-1]

---- 

#### 简介
- 这是我自己写的一个简单的选择器，有三种形式
  - 选择单组数据
  - 选择两组联动的数据
  - 选择三组不相关的数据，并且可以随机三组（喜欢买彩票的可以做成随机选择彩票，多方便！）
- 纯代码方式完成
- 样式什么的想要修改起来也很简单，使用也很简单。
- 由于技术不行，还没怎么去思考怎么将三个选择器封装成一个选择器。所以有时候使用起来就有点麻烦。
- 之前想着封装起来用block传值什么的，但是问题是我对block并不是很了解，就用了通知传值，等接下来会花时间去学习，之后再更新这个项目。
- 这里添加了第四个，第四个是直接在主页面加一个view，然后进行相应的设置。

#### 用法
因为封装的不是特别好，所以用起来需要写的东西不算少。而且分下来写的三个picker其实道理都是一样的，所以要是有大神会封装啥的，可以自己研究研究封装，然后教下我。
用法几乎一样，差别就是传的值不一样。其实只需要看看代码，基本上就都明白了  
######  **（有个问题我很好奇啊，就是我用Mou编辑的Readme.md,代码块为啥就是没有颜色，哪怕我在三个点之后添加了Objective-c也不管用啊）要是有大神知道的话赶紧指导下我**

<h5>单组数据的使用</h5>
- 单组数据，引入`OneArrData`文件夹
- 引入头文件`#import "YLSOPickerView.h"`
- 在点击事件或者需要弹出事件中写下下面的代码  

```
//你需要选择的数组数据
NSArray *array = @[@"Picker OneVlaue",@"Picker TwoVlaue",@"Picker ThreeVlaue"];
YLSOPickerView *picker = [[YLSOPickerView alloc]init];
        picker.array = array
        picker.title = @"pick number";
        [picker show];
 ```  
 - 最后在viewDidload里面接收下通知，然后在方法中写你需要把获取的值放在哪

 ```
 - (void)viewDidLoad 
 {
    [super viewDidLoad];
    //接受通知
 	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:@"value" object:nil];
 }
 
 //实现通知方法
 -(void)getValue:(NSNotification *)notification
{
    self.textFeild.text = notification.object;
}
 
 ```  
 
 
 
<h5>两组联动数据的使用</h5>
- 单组数据，引入`TwoArrData`文件夹
- 引入头文件`#import "YLSOTPickerView.h"`
- 在点击事件或者需要弹出事件中写下下面的代码    

```
//你需要选择的数组数据
        YLSOTPickerView *picker = [[YLSOTPickerView alloc]init];
        picker.title = @"Select Cars";
 //这里我传得值是字典形式，大家也可以传数组形式，那样的话在YLSOTPickerView.m文件里大家需要修改一下部分内容
        NSDictionary *dict = @{@"German":@[@"BMW",@"Audi",@"Volkswagen",@"Volvo",@"Mercedes"],
                               @"American":@[@"Ford",@"Dodge",@"Chrysler",@"Cadililac"],
                               @"Japanese":@[@"Toyota",@"Nissian",@"Mazda",@"Lexus",@"Honda"]};
        picker.dict = dict;
        [picker show];

 ```  
 也可以是下面这种形式的数据  
 
 ```
       picker.array = @[
                         @{
                             @"cityName":@"German",
                             @"cars":@[@"BMW",@"Audi",@"Volkswagen",@"Volvo",@"Mercedes"]
                            }
                         ,@{
                             @"cityName":@"American",
                            @"cars":@[@"Ford",@"Dodge",@"Chrysler",@"Cadililac"]
                             }
                         ,@{
                             @"cityName":@"Japenese",
                            @"cars":@[@"Toyota",@"Nissian",@"Mazda",@"Lexus",@"Honda"]
                             }
                         ];

 ```
 
 - 最后在viewDidload里面接收下通知，然后在方法中写你需要把获取的值放在哪

 ```
 - (void)viewDidLoad 
 {
    [super viewDidLoad];
    //接受通知
 	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTwoValue:) name:@"TwoValues" object:nil];
 }
 
 //实现通知方法
 -(void)getTwoValue:(NSNotification *)notification
{
    self.textFeild.text = notification.object;
}
 
 ```


<h5>三组不相关的数据使用</h5>
- 单组数据，引入`ThreeArrData`文件夹
- 引入头文件`#import "YLSThPickerView.h"`
- 在点击事件或者需要弹出事件中写下下面的代码    

```
//你需要选择的数组数据
 NSArray *array = @[@[@"Mr",@"Mrs",@"Ms",@"Miss"],@[@"Funny",@"Cool",@"Hot",@"Wonderful",@"Raining",@"Happy",@"Super",@"Lazy",@"Amazing",@"Bat",@"Iron",@"Bat",@"Rocket",@"Pretty",@"Lex"],@[@"Man",@"Luthor",@"Boy",@"Girl",@"Person",@"Cutie",@"Babe",@"Raccoon"]];
        YLSThPickerView *picker = [[YLSThPickerView alloc]init];
        picker.array = array;
        picker.title = @"Describe Yourself";
        [picker show];

 ```   
 - 最后在viewDidload里面接收下通知，然后在方法中写你需要把获取的值放在哪

 ```
 - (void)viewDidLoad 
 {
    [super viewDidLoad];
    //接受通知
 	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getThreeValue:) name:@"ThreeValues" object:nil];
 }
 
 //实现通知方法
 -(void)getThreeValue:(NSNotification *)notification
{
    self.textFeild.text = notification.object;
}
 
 ``` 

<h5>第四个文本框，就是用来测试用的</h5>
就是在本页面添加一个view，来显示picker。




[image-1]:	http://upload-images.jianshu.io/upload_images/1062695-edd9a35a6a382b55.gif?imageMogr2/auto-orient/strip