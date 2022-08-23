//
//  User.m
//  登陆
//
//  Created by MAC on 2022/8/17.
//

#import "User.h"

@implementation User

+ (instancetype)sharedUser{
    static id instance = nil;
    if(instance == nil){
        instance = [[self alloc] init];
    }
    return instance;
}

@end
