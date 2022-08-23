//
//  LCMessageCell.h
//  登陆
//
//  Created by MAC on 2022/8/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCMessageCell : UITableViewCell


+ (instancetype)messageCellWithTableView:(UITableView *)tableView dict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
