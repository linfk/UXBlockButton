//
//  ViewController.m
//  UXBlockButton
//
//  Created by frank.lin on 16/8/4.
//  Copyright © 2016年 frank.lin. All rights reserved.
//

#import "ViewController.h"
#import "UXBlockButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGPoint viewCenter = self.view.center;
    UIImage *normalImg = [UIImage imageNamed:@"play_btn_normal"];
    UIImage *highlightedImg = [UIImage imageNamed:@"play_btn_select"];
    // Image Only
    UXBlockButton *playButton = [[UXBlockButton alloc] initWithType:UXBtnTypeOnlyImage
                                                         normalImage:normalImg
                                                    highlightedImage:highlightedImg
                                                       disabledImage:nil
                                                               title:nil
                                                           titleFont:nil
                                                        onClickBlock:^(id sender) {
                                                            UXBlockButton *btn = (UXBlockButton*)sender;
                                                            NSLog(@"Only图片按钮按下 %@", btn);
                                                        }];
    playButton.center = CGPointMake(viewCenter.x*0.5, viewCenter.y*0.3);
    [self.view addSubview:playButton];
    
    // Text Only
    playButton = [[UXBlockButton alloc] initWithType:UXBtnTypeOnlyText
                                         normalImage:nil
                                    highlightedImage:nil
                                       disabledImage:nil
                                               title:@"只有文字的按钮"
                                           titleFont:[UIFont systemFontOfSize:20]
                                        onClickBlock:^(id sender) {
                                            UXBlockButton *btn = (UXBlockButton*)sender;
                                            NSLog(@"Only文字按钮按下 %@", btn);
                                        }];
    playButton.center = CGPointMake(viewCenter.x*1.5, viewCenter.y*0.3);
    [self.view addSubview:playButton];
    
    // Left Image Rigth Text
    playButton = [[UXBlockButton alloc] initWithType:UXBtnTypeLImageRText
                                         normalImage:normalImg
                                    highlightedImage:highlightedImg
                                       disabledImage:nil
                                               title:@"左边图片右边文字"
                                           titleFont:[UIFont systemFontOfSize:20]
                                        onClickBlock:^(id sender) {
                                            UXBlockButton *btn = (UXBlockButton*)sender;
                                            NSLog(@"LImgRText文字按钮按下 %@", btn);
                                        }];
    playButton.center = CGPointMake(viewCenter.x, viewCenter.y*0.6);
    [self.view addSubview:playButton];
    
    // Left Text Rigth Image
    playButton = [[UXBlockButton alloc] initWithType:UXBtnTypeLTextRImage
                                         normalImage:normalImg
                                    highlightedImage:highlightedImg
                                       disabledImage:nil
                                               title:@"左边文字右边图片"
                                           titleFont:[UIFont systemFontOfSize:20]
                                        onClickBlock:^(id sender) {
                                            UXBlockButton *btn = (UXBlockButton*)sender;
                                            NSLog(@"LTextRImg文字按钮按下 %@", btn);
                                        }];
    playButton.center = CGPointMake(viewCenter.x, viewCenter.y*0.9);
    [self.view addSubview:playButton];
    
    // Top Image Bottom Text
    playButton = [[UXBlockButton alloc] initWithType:UXBtnTypeTImageBText
                                         normalImage:normalImg
                                    highlightedImage:highlightedImg
                                       disabledImage:nil
                                               title:@"键盘"
                                           titleFont:[UIFont systemFontOfSize:12]
                                        onClickBlock:^(id sender) {
                                            UXBlockButton *btn = (UXBlockButton*)sender;
                                            NSLog(@"TImageBText文字按钮按下 %@", btn);
                                        }];
    playButton.center = CGPointMake(viewCenter.x, viewCenter.y*1.4);
    playButton.vSpaceBetweenImageAndText = 9;
    [self.view addSubview:playButton];
    
    // Top Text Bottom Image
    playButton = [[UXBlockButton alloc] initWithType:UXBtnTypeTTextBImage
                                         normalImage:normalImg
                                    highlightedImage:highlightedImg
                                       disabledImage:nil
                                               title:@"上"
                                           titleFont:[UIFont systemFontOfSize:20]
                                        onClickBlock:^(id sender) {
                                            UXBlockButton *btn = (UXBlockButton*)sender;
                                            NSLog(@"TTextBImage文字按钮按下 %@", btn);
                                        }];
    playButton.center = CGPointMake(viewCenter.x, viewCenter.y*1.8);
    [self.view addSubview:playButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
