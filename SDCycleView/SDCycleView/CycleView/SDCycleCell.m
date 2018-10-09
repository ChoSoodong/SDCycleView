//
//  SDCycleCell.m
//  
//
//  Created by ZHAO on 2018/10/8.
//
//

#import "SDCycleCell.h"
#import <UIImageView+WebCache.h>

@interface SDCycleCell()

/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SDCycleCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    
}


-(void)setImageString:(NSString *)imageString{
    _imageString = imageString;
    if ([imageString hasPrefix:@"http"]) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"default"]];
    }else{
        
        _imageView.image = [UIImage imageNamed:imageString];
    }
}


@end
