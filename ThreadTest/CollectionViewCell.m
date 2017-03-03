//
//  CollectionViewCell.m
//  ThreadTest
//
//  Created by Lee on 2017/3/3.
//  Copyright © 2017年 李家乐. All rights reserved.
//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#import "CollectionViewCell.h"
#import "UIView+Frame.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setSelected:(BOOL)selected {
    
    if (selected) {
        self.backgroundColor = [UIColor blackColor];
        self.labelDay.textColor = [UIColor whiteColor];
    }else {
        self.backgroundColor = [UIColor clearColor];
        self.labelDay.textColor = [UIColor blackColor];
        
    }
}
@end
