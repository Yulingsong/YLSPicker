# YLSPicker
Select data from popup view which make by the picker

#### 效果图：（在网页上看gif好像有限闪眼睛，所以如果使用的话大家可以阅读Readme.md）
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

#### 用法
用起来说方便也挺方便，说不方便的话，也着实有些不是很方便  

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
 - (void)viewDidLoad {
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
 


[image-1]:	http://upload-images.jianshu.io/upload_images/1062695-edd9a35a6a382b55.gif?imageMogr2/auto-orient/strip