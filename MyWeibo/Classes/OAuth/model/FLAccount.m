//
//  FLAccount.m
//  MyWeibo
//
//  Created by asddfg on 16/2/26.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLAccount.h"

#define FLAccessTokenKey  @"token"
#define FLExpiresKey  @"expires"
#define FLUidKey  @"uid"
#define FLExpiresDateKey  @"expires_date"
#define FLUserNameKey  @"name"

#import <MJExtension/MJExtension.h>

@implementation FLAccount
// 底层便利当前的类的所有属性，一个一个归档和接档
MJExtensionCodingImplementation

+ (instancetype)acoountWithDict:(NSDictionary *)dict
{
    FLAccount *account = [[self alloc] init];
    //KVC
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

/*
//归档的时候调用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:FLAccessTokenKey];
    [aCoder encodeObject:_uid forKey:FLUidKey];
    [aCoder encodeObject:_expires_in forKey:FLExpiresKey];
    [aCoder encodeObject:_expires_date forKey:FLExpiresDateKey];
    [aCoder encodeObject:_name forKey:FLUserNameKey];
}

//解档的时候调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        //一定要赋值
        _access_token = [aDecoder decodeObjectForKey:FLAccessTokenKey];
        _uid = [aDecoder decodeObjectForKey:FLUidKey];
        _expires_in = [aDecoder decodeObjectForKey:FLExpiresKey];
        _expires_date = [aDecoder decodeObjectForKey:FLExpiresDateKey];
        _name = [aDecoder decodeObjectForKey:FLUserNameKey];
    
    }
    return self;
}
*/

@end
