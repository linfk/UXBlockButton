//
//  UXBlockButton.m
//  UXBlockButton
//
//  Created by frank.lin on 16/8/4.
//  Copyright © 2016年 frank.lin. All rights reserved.
//


#import "UXBlockButton.h"

@interface UXBlockButton()
{
    UXBlockButtonType   _btnType;
    ux_blockBtnClicked  _btnClickedBlock;
}

@end


@implementation UXBlockButton



- (id)initWithType:(UXBlockButtonType)btnType
        normalImage:(UIImage *)normalImage
   highlightedImage:(UIImage *)highlightedImage
      disabledImage:(UIImage *)disabledImage
              title:(NSString *)btnTitle
          titleFont:(UIFont*)font
       onClickBlock:(ux_blockBtnClicked)block
{
    self = [super init];
    if (self){
        self.frame = CGRectZero;
        self.backgroundColor = [UIColor clearColor];
        if (normalImage && [normalImage isKindOfClass:[UIImage class]]){
            [self setImage:normalImage forState:UIControlStateNormal];
        }
        if (highlightedImage && [highlightedImage isKindOfClass:[UIImage class]]){
            [self setImage:highlightedImage forState:UIControlStateHighlighted];
            [self setImage:highlightedImage forState:UIControlStateSelected];
        }
        if (disabledImage && [disabledImage isKindOfClass:[UIImage class]]){
            [self setImage:disabledImage forState:UIControlStateDisabled];
        }
        if (btnTitle && [btnTitle isKindOfClass:[NSString class]]){
            [self setTitle:btnTitle forState:UIControlStateNormal];
        }
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        if (font && [font isKindOfClass:[UIFont class]]){
            self.titleLabel.font = font;
        }
        
        _btnType = btnType;
        // 默认左右间距5
        self.hSpaceBetweenImageAndText = 5;
        // 默认上下间距2
        self.vSpaceBetweenImageAndText = 2;
        
        // 设置点击事件的回调block
        if (block){
            _btnClickedBlock = block;
            [self addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            _btnClickedBlock = nil;
        }
#if 0
        // debug
        self.backgroundColor = [UIColor greenColor];
        self.titleLabel.backgroundColor = [UIColor redColor];
        self.imageView.backgroundColor = [UIColor blueColor];
#endif
    }
    return self;
}

- (void)setBtnFrameByType:(UXBlockButtonType)inType
{
    CGPoint center = self.center;
    UIImage *normalImg = [self imageForState:UIControlStateNormal];
    CGSize imageSize = normalImg.size;
    CGSize  titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    titleSize.height = ceil(titleSize.height);
    titleSize.width = ceil(titleSize.width);
    switch (inType) {
        case UXBtnTypeOnlyImage:
        {
            self.frame = CGRectMake(0, 0, imageSize.width, imageSize.width);
        }
            break;
        case UXBtnTypeOnlyText:
        {
            self.frame = CGRectMake(0, 0, titleSize.width+_hSpaceBetweenImageAndText*2, titleSize.height+_vSpaceBetweenImageAndText*2);
        }
            break;
        case UXBtnTypeLImageRText:
        {
            CGFloat btnWidth = imageSize.width + titleSize.width + _hSpaceBetweenImageAndText*2;
            CGFloat btnHeight = imageSize.height > titleSize.height ? imageSize.height:titleSize.height;
            self.frame = CGRectMake(0, 0, btnWidth, btnHeight);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -_hSpaceBetweenImageAndText, 0, _hSpaceBetweenImageAndText);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, _hSpaceBetweenImageAndText, 0, _hSpaceBetweenImageAndText);
        }
            break;
        case UXBtnTypeLTextRImage:
        {
            // top left bottom right
            CGFloat btnWidth = imageSize.width + titleSize.width + _hSpaceBetweenImageAndText*2;
            CGFloat btnHeight = imageSize.height > titleSize.height ? imageSize.height:titleSize.height;
            self.frame = CGRectMake(0, 0, btnWidth, btnHeight);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width+_hSpaceBetweenImageAndText*2, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width+_hSpaceBetweenImageAndText, 0, imageSize.width+_hSpaceBetweenImageAndText);
        }
            break;
        case UXBtnTypeTImageBText:
        {
            CGFloat btnWidth = imageSize.width > titleSize.width ? imageSize.width:titleSize.width;
            CGFloat btnHeight = imageSize.height + titleSize.height + _vSpaceBetweenImageAndText;
            self.frame = CGRectMake(0, 0, btnWidth, btnHeight);
            if (imageSize.width < titleSize.width){
                // 文字比图片宽
                CGFloat imgEdgeOffset = 0;
                imgEdgeOffset = (btnWidth-imageSize.width)/2;
                self.imageEdgeInsets = UIEdgeInsetsMake(0, imgEdgeOffset, _vSpaceBetweenImageAndText + titleSize.height, -imgEdgeOffset-imageSize.width);
                self.titleEdgeInsets = UIEdgeInsetsMake(_vSpaceBetweenImageAndText + imageSize.height, -imageSize.width, 0, 0);
            }
            else {
                // 图片比文字宽
                CGFloat textEdgeOffset = (btnWidth-titleSize.width)/2;
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, _vSpaceBetweenImageAndText + titleSize.height, 0);
                self.titleEdgeInsets = UIEdgeInsetsMake(_vSpaceBetweenImageAndText + imageSize.height, -titleSize.width-textEdgeOffset, 0, textEdgeOffset);
            }
        }
            break;
        case UXBtnTypeTTextBImage:
        {
            CGFloat btnWidth = imageSize.width > titleSize.width ? imageSize.width:titleSize.width;
            CGFloat btnHeight = imageSize.height + titleSize.height + _vSpaceBetweenImageAndText;
            self.frame = CGRectMake(0, 0, btnWidth, btnHeight);
            if (imageSize.width < titleSize.width){
                // 文字比图片宽
                CGFloat imgEdgeOffset = 0;
                imgEdgeOffset = (btnWidth-imageSize.width)/2;
                self.imageEdgeInsets = UIEdgeInsetsMake(_vSpaceBetweenImageAndText + titleSize.height, imgEdgeOffset, 0, -imgEdgeOffset-imageSize.width);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, _vSpaceBetweenImageAndText + imageSize.height, 0);
            }
            else {
                // 图片比文字宽
                CGFloat textEdgeOffset = (btnWidth-titleSize.width)/2;
                self.imageEdgeInsets = UIEdgeInsetsMake(_vSpaceBetweenImageAndText + titleSize.height, 0, 0, 0);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -titleSize.width-textEdgeOffset, _vSpaceBetweenImageAndText + imageSize.height, textEdgeOffset);
            }
        }
            break;
        default:
            // 默认是上面图片下面文字
        {
            CGFloat btnWidth = imageSize.width > titleSize.width ? imageSize.width:titleSize.width;
            CGFloat btnHeight = imageSize.height + titleSize.height + _vSpaceBetweenImageAndText;
            self.frame = CGRectMake(0, 0, btnWidth, btnHeight);
            if (imageSize.width < titleSize.width){
                // 文字比图片宽
                CGFloat imgEdgeOffset = 0;
                imgEdgeOffset = (btnWidth-imageSize.width)/2;
                self.imageEdgeInsets = UIEdgeInsetsMake(0, imgEdgeOffset, _vSpaceBetweenImageAndText + titleSize.height, -imgEdgeOffset-imageSize.width);
                self.titleEdgeInsets = UIEdgeInsetsMake(_vSpaceBetweenImageAndText + imageSize.height, -imageSize.width, 0, 0);
            }
            else {
                // 图片比文字宽
                CGFloat textEdgeOffset = (btnWidth-titleSize.width)/2;
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, _vSpaceBetweenImageAndText + titleSize.height, 0);
                self.titleEdgeInsets = UIEdgeInsetsMake(_vSpaceBetweenImageAndText + imageSize.height, -titleSize.width-textEdgeOffset, 0, textEdgeOffset);
            }
        }
            break;
    }
    self.center = center;
}


- (void)onButtonClicked:(id)sender
{
    if (_btnClickedBlock){
        _btnClickedBlock(sender);
    }
}


#pragma mark -
#pragma mark Getter And Setter
- (void)setHSpaceBetweenImageAndText:(CGFloat)inSpace
{
    _hSpaceBetweenImageAndText = inSpace;
    [self setBtnFrameByType:_btnType];
}

- (void)setVSpaceBetweenImageAndText:(CGFloat)inSpace{
    _vSpaceBetweenImageAndText = inSpace;
    [self setBtnFrameByType:_btnType];
}




@end

