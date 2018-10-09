//
//  SDCycleView.h
//
//
//  Created by ZHAO on 2018/10/8.
//  
//

#import <UIKit/UIKit.h>

@class SDCycleView;

@protocol SDCycleViewDelegate<NSObject>

-(void)cycleViewSelectIndex:(SDCycleView *)cycleView index:(NSInteger)index;

@end


@interface SDCycleView : UIView

/** 图片url 或 图片名称 的 数组 */
@property (nonatomic, strong) NSArray *imagesDataSource;

/*********** 自定义属性 ***********/
/** 当前选中的指示器图片名称 */
@property (nonatomic, copy) NSString *currentPageIndicatorImageName;
/** 未选中的指示器图片名称 */
@property (nonatomic, copy) NSString *pageIndicatorImageName;
/** 分页指示器的宽度 */
@property (nonatomic, assign) CGFloat pageIndicatorWidth;
/** 分页指示器的高度 */
@property (nonatomic, assign) CGFloat pageIndicatorHeight;


/** 代理属性 */
@property (nonatomic, weak) id<SDCycleViewDelegate> delegate;

@end
