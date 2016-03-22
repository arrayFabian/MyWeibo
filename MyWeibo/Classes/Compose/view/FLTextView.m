//
//  FLTextView.m
//  MyWeibo
//
//  Created by Mac on 16/3/13.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLTextView.h"

@interface FLTextView ()

@property (nonatomic, weak) UILabel *placeholderLabel;

@end


@implementation FLTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
        self.showsVerticalScrollIndicator = NO;

    }
    return self;
}

- (UILabel *)placeholderLabel
{
    if (_placeholderLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.textColor = [UIColor grayColor];
        _placeholderLabel = label;
    }
    return _placeholderLabel;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self.placeholderLabel sizeToFit];
    
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
     [self.placeholderLabel sizeToFit];
}

- (void)setHideplaceholder:(BOOL)hideplaceholder
{
    _hideplaceholder = hideplaceholder;
    self.placeholderLabel.hidden = hideplaceholder;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 8;
}

@end
