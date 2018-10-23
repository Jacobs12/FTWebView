//
//  BJNewsScreenConfig.m
//  ipaperiphone
//
//  Created by wolffy on 2017/10/10.
//  Copyright © 2017年 灰太狼. All rights reserved.
//

#import "BJNewsScreenConfig.h"

#define BJNEWS_SCREEN_SCALE ([UIScreen mainScreen].bounds.size.width/320.0)

@implementation BJNewsScreenConfig

+ (BJNewsScreenConfig *)defaultManager{
    BJNewsScreenConfig * manager = [[BJNewsScreenConfig alloc] init];
    return manager;
}

+ (BOOL)isiPhoneX{
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
}

/**
 iphone x Navigation Bar增加高度
 
 @param y 原始高度
 @return 增加后的高度
 */
+ (float)heightForNavigationBar:(float)y{
    if(IS_IPHONE_X){
        return y + 24;
    }else{
        return y;
    }
}

/**
 返回屏幕安全区域高度
 */
+ (float)heightForScreen{
    float height = [UIScreen mainScreen].bounds.size.height;
    if(IS_IPHONE_X){
        height = height - 34;
    }
    return height;
}

/**
 版面宽度
 
 @return 版面宽度
 */
+ (float)widthForImage{
    return [UIScreen mainScreen].bounds.size.width;
}

/**
 版面高度
 
 @return 版面高度
 */
+ (float)heightForImage{
    if(IS_IPHONE_X){
        return 568 * BJNEWS_SCREEN_SCALE - 64 - 50 * BJNEWS_SCREEN_SCALE;
    }else{
        return  [UIScreen mainScreen].bounds.size.height - 64 - 50 * BJNEWS_SCREEN_SCALE;
    }
}

@end
