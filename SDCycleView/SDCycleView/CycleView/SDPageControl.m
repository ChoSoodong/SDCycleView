//
//  SDPageControl.m
//
//
//  Created by ZHAO on 2018/10/8.
//  
//

#import "SDPageControl.h"

@implementation SDPageControl


- (void) setCurrentPage:(NSInteger)page {
    
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        CGSize size;
        
        size.height = _height == 0 ? 10 : _height;
        
        size.width = _width == 0 ? 10 : _width;
        
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     
                                     size.width,size.height)];
        
        
        
    }
    
}



@end
