# DVSlider
swift仿今日头条顶部滑动导航栏
在ViewController中给DVSliderManager传入数组，可以看到滑动导航条。设置delegateController，就可以在本页就可以接收到TableviewDelegate。

DVSliderManager.sharedInstance.titles = ["商品1","商品2","商品3","商品4"]

DVSliderManager.sharedInstance.delegateController=self

self.view .addSubview(DVSliderManager.sharedInstance.views)

//持续完善更新ing。

