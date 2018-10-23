//
//  BJNewsScreenConfig.h
//  ipaperiphone
//
//  Created by wolffy on 2017/10/10.
//  Copyright © 2017年 灰太狼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJNewsScreenConfig : NSObject

+ (BJNewsScreenConfig *)defaultManager;

#define IS_IPHONE_X [BJNewsScreenConfig isiPhoneX]

+ (BOOL)isiPhoneX;

/*iPhone X 适配*/

/**
 iphone x Navigation Bar增加高度

 @param y 原始高度
 @return 增加后的高度
 */
#define BJNEWS_SCREEN_NAVHEIGHT(y) [BJNewsScreenConfig heightForNavigationBar:y]

/**
 返回屏幕安全区域高度
 */
#define BJNEWS_SCREEN_HEIGHT [BJNewsScreenConfig heightForScreen]

/**
 iphone x Navigation Bar增加高度

 @param y 原始高度
 @return 增加后的高度
 */
+ (float)heightForNavigationBar:(float)y;

/**
 返回屏幕安全区域高度
 */
+ (float)heightForScreen;

/**
 版面宽度

 @return 版面宽度
 */
+ (float)widthForImage;

/**
 版面高度

 @return 版面高度
 */
+ (float)heightForImage;

@end
