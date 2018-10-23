//
//  FTWebViewController.h
//  FTWebView
//
//  Created by wolffy on 2018/10/10.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface FTWebViewController : UIViewController

@property (nonatomic,copy) NSString * url;

/**
 开始加载网页

 @param url 网页地址
 */
- (void)startWithUrl:(NSString *)url title:(NSString *)title;

@end
