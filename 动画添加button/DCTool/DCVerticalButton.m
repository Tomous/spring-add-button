//
//  DCVerticalButton.m
//  动画添加button
//
//  Created by wenhua on 2017/11/22.
//  Copyright © 2017年 wenhua. All rights reserved.
//

#import "DCVerticalButton.h"
#import "UIView+Extension.h"
@implementation DCVerticalButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.centerX = self.width * 0.5;
    self.imageView.centerY = self.height * 0.3;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + _margin;
    self.titleLabel.width = self.width;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
