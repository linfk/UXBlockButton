//
//  UXBlockButton.h
//  UXBlockButton
//
//  Created by frank.lin on 16/8/4.
//  Copyright © 2016年 frank.lin. All rights reserved.
//

#ifndef UXBlockButton_h
#define UXBlockButton_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


// 按钮类型,只有图片、只有文字、左图片右文字、左文字右图片、上面图片下面文字、上面文字下面图片
typedef enum : NSUInteger {
    UXBtnTypeOnlyImage,
    UXBtnTypeOnlyText,
    UXBtnTypeLImageRText,
    UXBtnTypeLTextRImage,
    UXBtnTypeTImageBText,
    UXBtnTypeTTextBImage,
} UXBlockButtonType;

// 当点击按钮时响应事件的block
typedef void (^ux_blockBtnClicked)(id sender);


@interface UXBlockButton : UIButton


// 图片和按钮之间的横向间隙
@property (nonatomic, assign) CGFloat   hSpaceBetweenImageAndText;
// 图片和按钮之间的纵向间隙
@property (nonatomic, assign) CGFloat   vSpaceBetweenImageAndText;


- (id)initWithType:(UXBlockButtonType)btnType
       normalImage:(UIImage*)normalImage
  highlightedImage:(UIImage*)highlightedImage
     disabledImage:(UIImage*)disabledImage
             title:(NSString*)btnTitle
         titleFont:(UIFont*)font
      onClickBlock:(ux_blockBtnClicked)block;



@end



#endif /* UXBlockButton_h */
