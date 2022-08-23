//
//  LCMessageCell.m
//  登陆
//
//  Created by MAC on 2022/8/16.
//

#import "LCMessageCell.h"

@interface LCMessageCell()


@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *accountLable;
@property (weak, nonatomic) IBOutlet UILabel *identityLable;   //身份
@property (weak, nonatomic) IBOutlet UILabel *departmentLable; //部门




@end

@implementation LCMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)messageCellWithTableView:(UITableView *)tableView dict:(NSDictionary *)dict
{
    static NSString *ID = @"message";
    LCMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LCMessageCell" owner:nil options:nil] firstObject];
    }
    cell.nameLable.text = dict[@"regname"];
    cell.accountLable.text = dict[@"phone"];
    cell.identityLable.text = dict[@"department"];
    cell.departmentLable.text = dict[@"userStatus"];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
