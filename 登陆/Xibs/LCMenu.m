//
//  LCMenu.m
//  登陆
//
//  Created by MAC on 2022/8/22.
//

#import "LCMenu.h"

@implementation LCMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)menuWithView{
    LCMenu *menu = [[[NSBundle mainBundle] loadNibNamed:@"LCMenu" owner:nil options:nil] firstObject];
    menu.layer.cornerRadius = 5;
    return menu;
}


- (IBAction)btnClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    if([self.delegate respondsToSelector:@selector(checkClick:)]){
        [self.delegate checkClick:button];
    }
}
@end
