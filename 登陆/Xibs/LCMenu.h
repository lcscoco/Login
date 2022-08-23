//
//  LCMenu.h
//  登陆
//
//  Created by MAC on 2022/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol LCMenuDelegate <NSObject>

- (void)checkClick:(UIButton *)button;

@end


@interface LCMenu : UIView
@property (weak, nonatomic) IBOutlet UIButton *jishu;
@property (weak, nonatomic) IBOutlet UIButton *yunying;
@property (weak, nonatomic) IBOutlet UIButton *tuiguang;
- (IBAction)btnClick:(id)sender;

+ (instancetype)menuWithView;


@property (nonatomic, weak) id<LCMenuDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
