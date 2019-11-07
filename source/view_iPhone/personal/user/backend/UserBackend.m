#import "UserBackend.h"
#import "App.h"

@implementation UserBackend
- (id)init {
    self = [super init];
    if (self) {
        self.repository = [UserRepository shared];
        self.assembler = [UserAssembler new];
    }
    return self;
}

+ (instancetype)shared {
    static UserBackend *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

#pragma userSetting 其他设置

- (RACSignal *)requestUpdateUserSetting:(NSInteger)type withValue:(NSString *)value {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSString stringWithFormat:@"{\"type\":\"%ld\",\"info\":\"%@\"}", type, value]
                   forKey:@"data"];
    @weakify(self)
    return
            [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                @strongify(self)
                [self
                        POST:[NSString stringWithFormat:@"%@/user/other_set",
                                                        self.config.backendURL]
                  parameters:parameters
                     success:^(AFHTTPRequestOperation *operation,
                             id responseObject) {
                         NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
                         if (status) {
                             if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                                 [subscriber sendNext:[self.assembler user:[responseObject objectForKey:@"data"]]];
                             }
                             else {
                                 [subscriber sendNext:[self.assembler responseResult:responseObject]];
                             }


                         }
                         else {
                             [subscriber sendNext:[self.assembler user:nil]];
                         }

                     } failure:^(AFHTTPRequestOperation *operation,
                                NSError *error) {
                            [subscriber sendError:error];
                        }];

                return [RACDisposable disposableWithBlock:^{

                }];
            }];
}

- (RACSignal *)requestAuthenticateUserBind:(USER *)user {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [NSString stringWithFormat:@"{\"type\":\"%@\",\"keyid\":\"%@\"}", user.usertype, user.keyid];
    // TODO: 格式化
    @weakify(self)
    return
            [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                @strongify(self)
                [self
                        POST:[NSString stringWithFormat:@"%@/user_bind/callback",
                                                        self.config.backendURL]
                  parameters:parameters
                     success:^(AFHTTPRequestOperation *operation,
                             id responseObject) {
                         //[subscriber sendNext:[self.assembler responseResult:responseObject]];

                         NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
                         if (status) {
                             //DDLogVerbose(@"authenticate success.%@",responseObject);
                             [subscriber sendNext:[self.assembler user:[responseObject objectForKey:@"data"]]];
                         }
                         else {
                             [subscriber sendNext:[self.assembler user:nil]];
                             //                 DDLogVerbose(@"authenticate failer.%@",responseObject);
                             //                 NSError *error;
                             //                 NSDictionary *errorDescription;
                             //                 errorDescription = @{ NSLocalizedDescriptionKey: [responseObject objectForKey:@"result"] };
                             //                 error = [NSError errorWithDomain:@"UserAuthentication"
                             //                                             code:0
                             //                                         userInfo:errorDescription];
                             //                 [subscriber sendError:error];
                         }

                         //[responseObject objectForKey:@"status"]

                     } failure:^(AFHTTPRequestOperation *operation,
                                NSError *error) {
                            [subscriber sendError:error];
                        }];

                return [RACDisposable disposableWithBlock:^{

                }];
            }];

}

- (RACSignal *)requestAuthenticateUserBindAdd:(USER *)user {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [NSString stringWithFormat:@"{\"type\":\"%@\",\"keyid\":\"%@\"}", user.usertype, user.keyid];
    // TODO: 格式化
    @weakify(self)
    return
            [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                @strongify(self)
                [self
                        POST:[NSString stringWithFormat:@"%@/user_bind/add",
                                                        self.config.backendURL]
                  parameters:parameters
                     success:^(AFHTTPRequestOperation *operation,
                             id responseObject) {
                         [subscriber sendNext:[self.assembler responseResult:responseObject]];

                     } failure:^(AFHTTPRequestOperation *operation,
                                NSError *error) {
                            [subscriber sendError:error];
                        }];

                return [RACDisposable disposableWithBlock:^{

                }];
            }];

}

- (RACSignal *)requestUser {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *filter = [[NSMutableDictionary alloc] init];
    NSError *error;
    NSData *dumps = [NSJSONSerialization dataWithJSONObject:filter options:0
                                                      error:&error];
    NSString *requestJSON;
    requestJSON = [[NSString alloc] initWithData:dumps
                                        encoding:NSUTF8StringEncoding];
    parameters[@"data"] = requestJSON;
    @weakify(self)
    return
            [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                @strongify(self)
                [self
                        POST:[NSString stringWithFormat:@"%@/user/get",
                                                        self.config.backendURL]
                  parameters:parameters
                     success:^(AFHTTPRequestOperation *operation,
                             id responseObject) {
                         NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
                         if (status) {
                             [subscriber sendNext:[self.assembler user:[responseObject objectForKey:@"data"]]];
                         }
                         else {
                             [subscriber sendNext:[self.assembler user:nil]];
                         }
                     } failure:^(AFHTTPRequestOperation *operation,
                                NSError *error) {
                            [subscriber sendError:error];
                        }];

                return [RACDisposable disposableWithBlock:^{

                }];
            }];

}

- (RACSignal *)requestUpdateUserAvatar:(USER *)user {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *filter = [[NSMutableDictionary alloc] init];

    [filter setValue:[NSNumber numberWithInteger:[user.user_id intValue]] forKey:@"id"];
    [filter setValue:user.avatarimg forKey:@"file"];

    NSError *error;
    NSData *dumps = [NSJSONSerialization dataWithJSONObject:filter options:0
                                                      error:&error];
    NSString *requestJSON;
    requestJSON = [[NSString alloc] initWithData:dumps
                                        encoding:NSUTF8StringEncoding];
    [parameters setObject:requestJSON forKey:@"data"];
    @weakify(self)
    return
            [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                @strongify(self)
                [self
                        POST:[NSString stringWithFormat:@"%@/user/avatar",
                                                        self.config.backendURL]
                  parameters:parameters
                     success:^(AFHTTPRequestOperation *operation,
                             id responseObject) {
                         [subscriber sendNext:[self.assembler responseResult:responseObject]];
                     } failure:^(AFHTTPRequestOperation *operation,
                                NSError *error) {
                            [subscriber sendError:error];
                        }];

                return [RACDisposable disposableWithBlock:^{

                }];
            }];
}


- (RACSignal *)requestSaveUser:(USER *)user {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *filter = [[NSMutableDictionary alloc] init];

    [filter setValue:user.user_id forKey:@"id"];
    [filter setValue:user.name forKey:@"username"];
    [filter setValue:user.email forKey:@"email"];
    [filter setValue:user.sex forKey:@"sex"];
    [filter setValue:user.birthday forKey:@"birthday"];
    [filter setValue:user.intro forKey:@"intro"];
    [filter setValue:user.card_id forKey:@"idcard"];
    [filter setValue:user.provence forKey:@"province"];
    [filter setValue:user.city forKey:@"city"];
    [filter setValue:user.area forKey:@"area"];

    NSError *error;
    NSData *dumps = [NSJSONSerialization dataWithJSONObject:filter options:0
                                                      error:&error];
    NSString *requestJSON;
    requestJSON = [[NSString alloc] initWithData:dumps
                                        encoding:NSUTF8StringEncoding];
    [parameters setObject:requestJSON forKey:@"data"];
    @weakify(self)
    return
            [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                @strongify(self)
                [self
                        POST:[NSString stringWithFormat:@"%@/user/update",
                                                        self.config.backendURL]
                  parameters:parameters
                     success:^(AFHTTPRequestOperation *operation,
                             id responseObject) {
                         [subscriber sendNext:[self.assembler responseResult:responseObject]];
                     } failure:^(AFHTTPRequestOperation *operation,
                                NSError *error) {
                            [subscriber sendError:error];
                        }];

                return [RACDisposable disposableWithBlock:^{

                }];
            }];
}

- (void)clearStore {
    [self.repository clearUserStore];
}

- (USER *)restore {
    USER *user = [self.repository restore];
    if (user) {
        [[App shared] setCurrentUser:user];
    }

    return user;
}


@end
