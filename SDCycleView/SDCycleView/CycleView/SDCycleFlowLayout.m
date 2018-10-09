//
//  SDCycleFlowLayout.m
//
//
//  Created by ZHAO on 2018/10/8.
//  
//

#import "SDCycleFlowLayout.h"

@implementation SDCycleFlowLayout

// 准备布局
- (void)prepareLayout {
    [super prepareLayout];
    
    // 让cell和collectionView一样大
    self.itemSize = self.collectionView.bounds.size;
    
    // 设置最小行列间距
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    // 设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}


@end
