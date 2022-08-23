//
//  ViewController.h
//  登陆
//
//  Created by MAC on 2022/7/15.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSDictionary *dict;


@property (nonatomic, copy) void(^myBlock)(NSString *phone,NSString *password);


@end

