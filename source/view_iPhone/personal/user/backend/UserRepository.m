//
//  UserRepository.m
//  btc
//
//  Created by txj on 15/1/28.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "UserRepository.h"

@implementation UserRepository

-(void)clearAccessTokenStore
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
}
-(void)clearUserStore
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
}

- (AccessToken *)restoreAccessToken
{
    AccessToken *token;
    NSData *raw = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    if (nil != raw)
    {
        token = [NSKeyedUnarchiver unarchiveObjectWithData:raw];
        if(nil!=token){
            if (token.accessToken!=nil) {
            }
            else{
                [self clearAccessTokenStore];
                token=nil;
            }
            
        }
    }
    return token;
}

- (USER *)restore
{
    USER *user;
    NSData *raw = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        if (nil != raw)
    {
        user = [NSKeyedUnarchiver unarchiveObjectWithData:raw];
        if(nil!=user){
            if (user.token!=nil) {
            }
            else{
                [self clearUserStore];
                user=nil;
            }

            }
           }
    return user;
}
- (void)storageToken:(AccessToken *)accessToken
{
    NSData *raw = [NSKeyedArchiver archivedDataWithRootObject:accessToken];
    [[NSUserDefaults standardUserDefaults] setObject:raw forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)storage:(USER *)user
{
    NSData *raw = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:raw forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (instancetype)shared
{
    static UserRepository *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}
@end