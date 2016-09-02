# YLSPicker
Select data from popup view which make by the picker

####效果图：（在网页上看gif好像有限闪眼睛，所以如果使用的话大家可以阅读Readme.md）
![pckerVIew](http://upload-images.jianshu.io/upload_images/1062695-edd9a35a6a382b55.gif?imageMogr2/auto-orient/strip)

----------------------------------------

####简介
- 这是我自己写的一个简单的选择器，有三种形式
  - 选择单组数据
  - 选择两组联动的数据
  - 选择三组不相关的数据，并且可以随机三组（喜欢买彩票的可以做成随机选择彩票，多方便！）
- 纯代码方式完成
- 样式什么的想要修改起来也很简单，使用也很简单。
- 由于技术不行，还没怎么去思考怎么将三个选择器封装成一个选择器。所以有时候使用起来就有点麻烦。

####用法
用起来很方便  

<h5>单组数据的使用</h5>
- 单组数据，引入``` OneArrData```文件夹   
- 引入头文件``` #import "YLSOPickerView.h" ```  
- 在点击事件或者需要弹出事件中写下下面的代码  
  
```
//你需要选择的数组数据
NSArray *array = @[@"Picker OneVlaue",@"Picker TwoVlaue",@"Picker ThreeVlaue"];
YLSOPickerView *picker = [[YLSOPickerView alloc]init];
        picker.array = array
        picker.title = @"pick number";
        [picker show];
```


