# SDCycleView
图片轮播

------------------- 使用方法 --------------------
 SDCycleView *cycleView = [[SDCycleView alloc] initWithFrame: self.view.frame];
    cycleView.imagesDataSource = [self loadImages];
    cycleView.delegate = self;
    [self.view addSubview:cycleView];
    
    ------------- 代理监听 ---------------------
    -(void)cycleViewSelectIndex:(SDCycleView *)cycleView index:(NSInteger)index{
    
    NSLog(@"%zd",index);
}
