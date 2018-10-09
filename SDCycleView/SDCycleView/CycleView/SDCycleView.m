//
//  SDCycleView.m
//
//
//  Created by ZHAO on 2018/10/8.
//
//

#import "SDCycleView.h"
#import "SDCycleCell.h"
#import "SDCycleFlowLayout.h"
#import "SDPageControl.h"


#define KSectionCount 3         // 组数
#define KPageControlHeight 30   //分页指示器的高

@interface SDCycleView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) SDPageControl *pageControl;

@property (nonatomic, weak) NSTimer *timer;


@end
// 重用标识
static NSString * const cycleCellID = @"cycleCellID";
@implementation SDCycleView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    // 2.添加collectionView
    [self settingCollectionView];
    
    // 3.添加分页指示器
    [self settingPageControl];
    
    
    // 4.添加定时器
    // 如果用timer开头的方法 再加上把它添加到运行循环指定为Default时,下面两行相当于scheduled
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _timer = timer;
    
}


#pragma mark - 定时器每两秒让控制器调用一次此方法
- (void)nextPage {
    
    // 1.获取当前在第几页
    NSInteger page = _pageControl.currentPage;
    
    NSIndexPath *indexPath = nil;
    // 如果不是当前组的最后一个cell,就向下一页滚动
    if (page != (_imagesDataSource.count - 1)) {
        // 1-1
        // 1-2
        indexPath = [NSIndexPath indexPathForItem:page + 1 inSection:KSectionCount / 2];
    } else {
        // 如果已经到中间这一组的最后一个cell时,继续向下一组的第0个cell去滚动
        indexPath = [NSIndexPath indexPathForItem:0 inSection:KSectionCount / 2 + 1];
        // 2-0
        
    }
    
    // 必须要有动画
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - 添加分页指示器
- (void)settingPageControl {
    SDPageControl *pageControl = [[SDPageControl alloc] init];
    
    pageControl.currentPage = 0;
    
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    
    [self addSubview:pageControl];
    
    _pageControl = pageControl;
}

#pragma mark - 添加collectionView
- (void)settingCollectionView {
    // 0.创建布局对象
    SDCycleFlowLayout *flowLayout = [[SDCycleFlowLayout alloc] init];
    
    // 1.创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    // 2.设置背景颜色
    collectionView.backgroundColor = [UIColor whiteColor];
    
    // 3.添加到父控件上
    [self addSubview:collectionView];
    
    
    // 4.给collectionView添加约束

    
    // 5.设置数据源
    collectionView.dataSource = self;
    
    // 6.注册cell
    [collectionView registerClass:[SDCycleCell class] forCellWithReuseIdentifier:cycleCellID];
    
    // 开启分页
    collectionView.pagingEnabled = YES;
    // 关闭弹簧
    collectionView.bounces = NO;
    // 隐藏滚动条
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    
    // 7.给collectionView设置代理
    collectionView.delegate = self;
    _collectionView = collectionView;
    
}

/**
 布局子控件
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _collectionView.frame = self.bounds;
    _pageControl.frame = CGRectMake(0,self.frame.size.height - KPageControlHeight, self.frame.size.width, KPageControlHeight);
   
    
    
}


#pragma mark - set方法
-(void)setImagesDataSource:(NSArray *)imagesDataSource{
    _imagesDataSource = imagesDataSource;
    
    // 有数据之后再设置总页数
    _pageControl.numberOfPages = imagesDataSource.count;
}
-(void)setCurrentPageIndicatorImageName:(NSString *)currentPageIndicatorImageName{
    _currentPageIndicatorImageName = currentPageIndicatorImageName;
    
    [_pageControl setValue:[UIImage imageNamed:currentPageIndicatorImageName] forKeyPath:@"_currentPageImage"];
}
-(void)setPageIndicatorImageName:(NSString *)pageIndicatorImageName{
    _pageIndicatorImageName = pageIndicatorImageName;
    
     [_pageControl setValue:[UIImage imageNamed:pageIndicatorImageName] forKeyPath:@"_pageImage"];
}
-(void)setPageIndicatorWidth:(CGFloat)pageIndicatorWidth{
    _pageIndicatorWidth = pageIndicatorWidth;
    
    _pageControl.width = pageIndicatorWidth;
}

-(void)setPageIndicatorHeight:(CGFloat)pageIndicatorHeight{
    _pageIndicatorHeight = pageIndicatorHeight;
    
    _pageControl.height = pageIndicatorHeight;
}



// 绘图的方法,此方法在调用时,约束肯定已经正常计算完成
- (void)drawRect:(CGRect)rect {
    
    // 一启动默认就滚动到中间这一组的第0个cell  // 一启动默认就滚动到中间这一组的第0个cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:KSectionCount / 2];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return KSectionCount;
}
//items个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagesDataSource.count;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    SDCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cycleCellID forIndexPath:indexPath];
    // 2.设置数据
    cell.imageString = _imagesDataSource[indexPath.item];
    
    // 3.返回cell
    return cell;
}

/**
 轮播图片点击
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(cycleViewSelectIndex:index:)]) {
        [self.delegate cycleViewSelectIndex:self index:indexPath.item];
    }
}

// 手动拖得并且完全停下来会调用此方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 计算总共滚动到第几页了
    NSInteger previousCellCount = _collectionView.contentOffset.x / _collectionView.bounds.size.width;
    
    // 计算界面上当前显示cell的组的索引
    NSInteger section = previousCellCount / _imagesDataSource.count;
    // 计算界面上当前显示cell的item的索引
    NSInteger item = previousCellCount % _imagesDataSource.count;
    
    
    // 如果当前界面滚动的cell还是在中间这一组什么也不做,直接跳出此方法
    if (section == KSectionCount / 2) return;
    
    
    // 不在中间这一组就让它悄悄回到中间这一组,回中间组的第几个Item?
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForItem:item inSection:KSectionCount / 2];
    
    [_collectionView scrollToItemAtIndexPath:scrollIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    
}

// 代码方法滚动并且开始了动画,等滚动完一次,动画停下来时,会调用此方法一次
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

// 正在滚动中此方法都会
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.499;
    // 设置当页数
    _pageControl.currentPage = (page % _imagesDataSource.count);
}


// 将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // 让停时器在遥远的未来时间再去执行
    _timer.fireDate = [NSDate distantFuture];
}


// 用户停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 让定时器过两秒后重新断续执行
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
}


- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

// 当一个控件想要释放前,会先调用此方法,但它不一定能释放
- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    NSLog(@"%s", __FUNCTION__);
    [_timer invalidate]; // 让定时器释放
    
}
@end
