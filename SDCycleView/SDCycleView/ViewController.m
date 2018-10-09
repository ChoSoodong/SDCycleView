//
//  ViewController.m
//  SDCycleView
//
//  Created by ZHAO on 2018/10/9.
//  Copyright © 2018年 HaramElectronic. All rights reserved.
//

#import "ViewController.h"
#import "SDCycleView.h"

@interface ViewController ()<SDCycleViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SDCycleView *cycleView = [[SDCycleView alloc] initWithFrame: self.view.frame];
    cycleView.imagesDataSource = [self loadImages];
    cycleView.delegate = self;
    [self.view addSubview:cycleView];
}

-(void)cycleViewSelectIndex:(SDCycleView *)cycleView index:(NSInteger)index{
    
    NSLog(@"%zd",index);
}


-(NSArray *)loadImages{
    
    NSArray *array = @[
                       
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539060095646&di=2a52582fdc767d5caa2e431ce9fc9cc7&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201407%2F11%2F20140711181328_nTvLk.jpeg",
                       
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539060111168&di=006a3e6448fcf388a1d75c4cfe1df494&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201404%2F06%2F20140406005247_LEKmJ.jpeg",
                       
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1539050048&di=637fab49d287ec7aa02c7e6e621641fc&src=http://cdnq.duitang.com/uploads/item/201407/14/20140714135400_3MYaS.jpeg"
                       
                       ];
    
    return array;
}


@end
