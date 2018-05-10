# DVSlider
swift仿网易新闻顶部滑动导航栏

适配了各种机型的导航栏情况。

在DVSliderTool中可以设置更改title的高度，颜色，每页最多显示title的个数，以及下划线的长度等，后续会持续更新完善

使用如下:

在ViewController中，传入视图控制器，标题数组。
DVSliderManager.sharedInstance.creatSlideView(vc:self,title:["商品1","商品2","商品3","商品4","商品5","商品6"])

在ViewController 将移除的时候，销毁
DVSliderManager.sharedInstance.dismiss()


