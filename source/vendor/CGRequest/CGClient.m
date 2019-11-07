//
//  CGClient.m
//  chijidun
//
//  Created by iMac on 16/8/28.
//
//

#import "CGClient.h"

@interface CGClient ()
@property(strong, nonatomic) AFHTTPRequestOperationManager *manager;
@property(strong, nonatomic) NSString *requestURL;
@property(strong, nonatomic) NSString *teamURL;
@property(strong, nonatomic) beforeRequestBlocks beforeRequestCallback;
@property(strong, nonatomic) afterRequestBlocks afterRequestCallback;
@property(strong, nonatomic) getTokenBlock getTokenBlock;
@property BOOL isHideProgress;
@property BOOL isDisableAfterRequest;
@end

@implementation CGClient
- (instancetype)init:(beforeRequestBlocks)beforeRequest
        afterRequest:(afterRequestBlocks)afterRequest
            getToken:(getTokenBlock)getToken
           getApiUrl:(getApiUrlBlock)getApiUrl {
    
    _beforeRequestCallback = beforeRequest;
    _afterRequestCallback = afterRequest;
    _requestURL = getApiUrl();
    _getTokenBlock = getToken;
    _teamURL=kTeamUrl;
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.requestSerializer.timeoutInterval = 10;
    _manager.requestSerializer.HTTPShouldHandleCookies = YES;
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"accept"];
    _isHideProgress = _isDisableAfterRequest = NO;
    return self;
}

- (instancetype)hideProgress {
    _isHideProgress = YES;
    return self;
}

- (instancetype)disableAfterRequest {
    _isDisableAfterRequest = YES;
    return self;
}

- (void)post:(NSString *)url parameters:(id)parameters success:(successBlocks)success failure:(failureBlocks)failure {
    
    _beforeRequestCallback(parameters, url, _isHideProgress);
    NSDictionary *dic=[self dictionaryWithJsonString:parameters];
    NSString *token=_getTokenBlock();
    if (token==nil) {
        token = @"";
    }
    [dic setValue:token forKey:@"token"];
    [dic setValue:@"ios" forKey:@"source"];
    [dic setValue:Current_Version forKey:@"version"];
    
    [[App shared] readDeviceToken];
    NSString *deviceToken = [App shared].deviceToken;
    [dic setValue:deviceToken forKey:@"device"];
    
#ifdef DEBUG
    printf("curl %s -d 'token=%s&source=%s&device=%s&version=%s&data=%s'\n", [url UTF8String], [token UTF8String],[dic[@"source"] UTF8String],[dic[@"device"] UTF8String],[dic[@"version"] UTF8String], [parameters UTF8String]);
#endif
    
    [_manager
     POST:url
     parameters:dic
     success:^(AFHTTPRequestOperation *operation,
               id responseObject) {
         CGResponse *response = [[CGResponse alloc]init];
         if (responseObject == nil) {
             response.result=@"服务器返回格式错误!";
             response.status=@"0";
         }else{
             response=[CGResponse mj_objectWithKeyValues:responseObject];
         }
         _isHideProgress = NO;
         if (_isDisableAfterRequest) {
             if ([responseObject[@"status"] intValue]==1) {
                 if (success != nil) {
                     success(response, url);
                 }
             } 
         } else {
             _afterRequestCallback(response, url);
             if ([responseObject[@"status"] intValue]==1) {
                 if (success != nil) {
                     success(response, url);
                 }
             } else {
                 if (failure != nil) {
                     failure(response, url);
                 }
             }
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         CGResponse *response=[[CGResponse alloc]init];
         response.status=@"0";
         response.result=error.userInfo[@"NSLocalizedDescription"];
         self.afterRequestCallback(response, nil);
         if (failure != nil) {
             failure(response, url);
         }
     }];
}
// no token
- (void)postNoToken:(NSString *)url parameters:(id)parameters success:(successBlocks)success failure:(failureBlocks)failure {
    
    _beforeRequestCallback(parameters, url, _isHideProgress);
    
    NSMutableDictionary *dic=[self dictionaryWithString:parameters];
    [dic setValue:@"ios" forKey:@"source"];
    
#ifdef DEBUG
    printf("curl %s -d 'source=%s&version=%s'\n", [url UTF8String],[dic[@"source"] UTF8String],[dic[@"version"] UTF8String]);
#endif
    
    [_manager
     POST:url
     parameters:dic
     success:^(AFHTTPRequestOperation *operation,
               id responseObject) {
         CGResponse *response = [[CGResponse alloc]init];
         if (responseObject == nil) {
             response.result=@"服务器返回格式错误!";
             response.status=@"0";
         }else{
             response=[CGResponse mj_objectWithKeyValues:responseObject];
         }
         _isHideProgress = NO;
         if (_isDisableAfterRequest) {
             _isDisableAfterRequest = NO;
         } else {
             _afterRequestCallback(response, url);
         }
         if ([[NSString stringWithFormat:@"%@", responseObject[@"status"]] isEqual:@"1"]) {
             if (success != nil) {
                 success(response, url);
             }
         } else {
             if (failure != nil) {
                 failure(response, url);
             }
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         CGResponse *response=[[CGResponse alloc]init];
         response.status=@"0";
         response.result=error.userInfo[@"NSLocalizedDescription"];
         self.afterRequestCallback(response, nil);
         if (failure != nil) {
             failure(response, url);
         }
     }];
}
//no data
- (void)postNoData:(NSString *)url parameters:(id)parameters success:(successBlocks)success failure:(failureBlocks)failure {
    
    _beforeRequestCallback(parameters, url, _isHideProgress);
    NSDictionary *dic=[self dictionaryWithString:parameters];
    NSString *token=_getTokenBlock();
    if (token==nil) {
        token = @"";
    }
    [dic setValue:token forKey:@"token"];
    [dic setValue:@"ios" forKey:@"source"];
    
    [[App shared] readDeviceToken];
    NSString *deviceToken = [App shared].deviceToken;
    [dic setValue:deviceToken forKey:@"device"];
    
#ifdef DEBUG
    printf("curl %s -d 'token=%s&source=%s&device=%s&%s'\n", [url UTF8String], [token UTF8String],[dic[@"source"] UTF8String],[dic[@"device"] UTF8String], [parameters UTF8String]);
#endif
    
    [_manager
     POST:url
     parameters:dic
     success:^(AFHTTPRequestOperation *operation,
               id responseObject) {
         CGResponse *response = [[CGResponse alloc]init];
         if (responseObject == nil) {
             response.result=@"服务器返回格式错误!";
             response.status=@"0";
         }else{
             response=[CGResponse mj_objectWithKeyValues:responseObject];
         }
         _isHideProgress = NO;
         if (_isDisableAfterRequest) {
             _isDisableAfterRequest = NO;
         } else {
             _afterRequestCallback(response, url);
         }
         if ([[NSString stringWithFormat:@"%@", responseObject[@"status"]] isEqual:@"1"]) {
             if (success != nil) {
                 success(response, url);
             }
         } else {
             if (failure != nil) {
                 failure(response, url);
             }
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         CGResponse *response=[[CGResponse alloc]init];
         response.status=@"0";
         response.result=error.userInfo[@"NSLocalizedDescription"];
         self.afterRequestCallback(response, nil);
         if (failure != nil) {
             failure(response, url);
         }
     }];
}
//get
- (void)GetNoData:(NSString *)url parameters:(id)parameters success:(successBlocks)success failure:(failureBlocks)failure {
    
    _beforeRequestCallback(parameters, url, _isHideProgress);
    NSDictionary *dic=[self dictionaryWithString:parameters];
    NSString *token=_getTokenBlock();
    if (token==nil) {
        token = @"";
    }
    [dic setValue:token forKey:@"token"];
    [dic setValue:@"ios" forKey:@"source"];
    
    [[App shared] readDeviceToken];
    NSString *deviceToken = [App shared].deviceToken;
    [dic setValue:deviceToken forKey:@"device"];
    
#ifdef DEBUG
    printf("curl %s -d 'token=%s&source=%s&device=%s&%s'\n", [url UTF8String], [token UTF8String],[dic[@"source"] UTF8String],[dic[@"device"] UTF8String], [parameters UTF8String]);
#endif
    [_manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation,id responseObject) {
        CGResponse *response = [[CGResponse alloc]init];
        if (responseObject == nil) {
            response.result=@"服务器返回格式错误!";
            response.status=@"0";
        }else{
            response=[CGResponse mj_objectWithKeyValues:responseObject];
        }
        _isHideProgress = NO;
        if (_isDisableAfterRequest) {
            _isDisableAfterRequest = NO;
        } else {
            _afterRequestCallback(response, url);
        }
        if ([[NSString stringWithFormat:@"%@", responseObject[@"status"]] isEqual:@"1"]) {
            if (success != nil) {
                success(response, url);
            }
        } else {
            if (failure != nil) {
                failure(response, url);
            }
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CGResponse *response=[[CGResponse alloc]init];
        response.status=@"0";
        response.result=error.userInfo[@"NSLocalizedDescription"];
        self.afterRequestCallback(response, nil);
        if (failure != nil) {
            failure(response, url);
        }
    }];
    
}

-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[@"data"] = jsonString;    
    return dic;
}
-(NSMutableDictionary *)dictionaryWithString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *JSONData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:dicData];
    return dict;
}
-(void)doStartUpIndex:(StartUpIndexRequest *)request success:(successBlocks)success
{
    [self doStartUpIndex:request success:success failure:nil];
}
-(void)doStartUpIndex:(StartUpIndexRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoToken:[NSString stringWithFormat:@"%@startup/index",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doStartUpVersion:(StartUpVersionRequest *)request success:(successBlocks)success
{
    [self doStartUpVersion:request success:success failure:nil];
}
-(void)doStartUpVersion:(StartUpVersionRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoToken:[NSString stringWithFormat:@"%@startup/version",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doUserLoginNew:(UserLoginNewRequest *)request success:(successBlocks)success
{
    [self doUserLoginNew:request success:success failure:nil];
}
-(void)doUserLoginNew:(UserLoginNewRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user/login",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doUserLoginOut:(UserLoginOutRequest *)request success:(successBlocks)success
{
    [self doUserLoginOut:request success:success failure:nil];
}
-(void)doUserLoginOut:(UserLoginOutRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user/logout",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doUserRegister:(UserRegisterRequest *)request success:(successBlocks)success
{
    [self doUserRegister:request success:success failure:nil];
}
-(void)doUserRegister:(UserRegisterRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user/register",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doUserResetPassword:(UserResetPasswordRequest *)request success:(successBlocks)success
{
    [self doUserResetPassword:request success:success failure:nil];
}
-(void)doUserResetPassword:(UserResetPasswordRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user/resetPassword",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doCompanyPushSwitch:(CompanyPushSwitchRequest *)request success:(successBlocks)success
{
    [self doCompanyPushSwitch:request success:success failure:nil];
}
-(void)doCompanyPushSwitch:(CompanyPushSwitchRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user/setCompanyMealPushSwitch",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doGetCompanyPushSwitch:(GetCompanyPushSwitchRequest *)request success:(successBlocks)success
{
    [self doGetCompanyPushSwitch:request success:success failure:nil];
}
-(void)doGetCompanyPushSwitch:(GetCompanyPushSwitchRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user/getCompanyMealPushSwitch",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doHasCompanyMeal:(HasCompanyMealRequest *)request success:(successBlocks)success
{
    [self doHasCompanyMeal:request success:success failure:nil];
}
-(void)doHasCompanyMeal:(HasCompanyMealRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/site/hasCompanyMeal",_teamURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doTeamOrderIndex:(TeamOrderIndexRequest *)request success:(successBlocks)success
{
    [self doTeamOrderIndex:request success:success failure:nil];
}
-(void)doTeamOrderIndex:(TeamOrderIndexRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/order/index",_teamURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doOrderGetTimeInterval:(OrderGetTimeIntervalRequest *)request success:(successBlocks)success
{
    [self doOrderGetTimeInterval:request success:success failure:nil];
}
-(void)doOrderGetTimeInterval:(OrderGetTimeIntervalRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/order/getTimeInterval",_teamURL]
    parameters:paramStr
       success:success
       failure:failure];
}
-(void)doGetMemberAndOrder:(GetMemberAndOrderRequest *)request success:(successBlocks)success
{
    [self doGetMemberAndOrder:request success:success failure:nil];
}
-(void)doGetMemberAndOrder:(GetMemberAndOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/order/getMembersAndOrder",_teamURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doOrderGetMenu:(OrderGetMenuRequest *)request success:(successBlocks)success
{
    [self doOrderGetMenu:request success:success failure:nil];
}
-(void)doOrderGetMenu:(OrderGetMenuRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/order/getMenu",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doItemGetDetail:(ItemGetDetailRequest *)request success:(successBlocks)success
{
    [self doItemGetDetail:request success:success failure:nil];
}
-(void)doItemGetDetail:(ItemGetDetailRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/site/getItemDetail",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doConfirmOrder:(ConfirmOrderResquest *)request success:(successBlocks)success
{
    [self doConfirmOrder:request success:success failure:nil];
}
-(void)doConfirmOrder:(ConfirmOrderResquest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/order/confirmOrder",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doSaveOrder:(SaveOrderRequest *)request success:(successBlocks)success
{
    [self doSaveOrder:request success:success failure:nil];
}
-(void)doSaveOrder:(SaveOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/order/saveOrder",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doIsPlaceOrder:(IsPlaceOrderRequest *)request success:(successBlocks)success
{
   [self doIsPlaceOrder:request success:success failure:nil];
}
-(void)doIsPlaceOrder:(IsPlaceOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/order/IsPlaceOrder",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doGetOrderInfo:(GetOrderInfoRequest *)request success:(successBlocks)success
{
   [self doGetOrderInfo:request success:success failure:nil];
}
-(void)doGetOrderInfo:(GetOrderInfoRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/order/getOrderInfo",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doDeleteOrder:(DeleteOrderRequest *)request success:(successBlocks)success
{
    [self doDeleteOrder:request success:success failure:nil];
}
-(void)doDeleteOrder:(DeleteOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/order/deleteOrder",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doTeamOrderPay:(TeamOrderPayRequest *)request success:(successBlocks)success
{
   [self doTeamOrderPay:request success:success failure:nil];
}
-(void)doTeamOrderPay:(TeamOrderPayRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/order/pay",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doGetCompanyName:(GetCompanyNameRequest *)request success:(successBlocks)success
{
    [self doGetCompanyName:request success:success failure:nil];
}
-(void)doGetCompanyName:(GetCompanyNameRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/site/getCompanyName",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doSaveCompanyMealApply:(SaveCompanyMealApplyRequest *)request success:(successBlocks)success
{
    [self doSaveCompanyMealApply:request success:success failure:nil];
}
-(void)doSaveCompanyMealApply:(SaveCompanyMealApplyRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/site/saveCompanyMealApply",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doSaveCompanyMealByInvite:(SaveCompanyMealByInviteRequest *)request success:(successBlocks)success
{
    [self doSaveCompanyMealByInvite:request success:success failure:nil];
}
-(void)doSaveCompanyMealByInvite:(SaveCompanyMealByInviteRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/site/saveCompanyMealByInvite",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doCharacterAppPay:(CharacterAppPayRequest *)request success:(successBlocks)success
{
    [self doCharacterAppPay:request success:success failure:nil];

}
-(void)doCharacterAppPay:(CharacterAppPayRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self GetNoData:[NSString stringWithFormat:@"%@/order/characterAppPay",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doAccountOrder:(AccountOrderRequest *)request success:(successBlocks)success
{
    [self doAccountOrder:request success:success failure:nil];
}
-(void)doAccountOrder:(AccountOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/account/order",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doGlobalSetting:(GlobalSettingRequest *)request success:(successBlocks)success
{
    [self doGlobalSetting:request success:success failure:nil];
}
-(void)doGlobalSetting:(GlobalSettingRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@startup/globalSetting",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doCartSetByMember:(CartSetByMemberRequest *)request success:(successBlocks)success
{
    [self doCartSetByMember:request success:success failure:nil];
}
-(void)doCartSetByMember:(CartSetByMemberRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@cart/setByMember",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doCartGetByMember:(CartGetByMemberRequest *)request success:(successBlocks)success
{
    [self doCartGetByMember:request success:success failure:nil];
}
-(void)doCartGetByMember:(CartGetByMemberRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@cart/getByMember",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doOrderAdd:(OrderAddRequest *)request success:(successBlocks)success
{
    [self doOrderAdd:request success:success failure:nil];
}
-(void)doOrderAdd:(OrderAddRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@order/add",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doOrderConfirmOrder:(OrderConfirmOrderRequest *)request success:(successBlocks)success
{
    [self doOrderConfirmOrder:request success:success failure:nil];
}
-(void)doOrderConfirmOrder:(OrderConfirmOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@order/confirmOrder",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doMemberFavLists:(MemberFavListsRequest *)request success:(successBlocks)success
{
    [self doMemberFavLists:request success:success failure:nil];
}
-(void)doMemberFavLists:(MemberFavListsRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@member_favs/lists",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doUserAddressLists:(UserAddressListsRequest *)request success:(successBlocks)success
{
    [self doUserAddressLists:request success:success failure:nil];
}
-(void)doUserAddressLists:(UserAddressListsRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user_address/listsFor237",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];

}

-(void)doUserAddressAdd:(UserAddressAddRequest *)request success:(successBlocks)success
{
    [self doUserAddressAdd:request success:success failure:nil];
}
-(void)doUserAddressAdd:(UserAddressAddRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user_address/add",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];

}

-(void)doUserAddressDelete:(UserAddressDeleteRequest *)request success:(successBlocks)success
{
    [self doUserAddressDelete:request success:success failure:nil];
}
-(void)doUserAddressDelete:(UserAddressDeleteRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user_address/delete",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];

}

-(void)doUserAddressUpdate:(UserAddressUpdateRequest *)request success:(successBlocks)success
{
    [self doUserAddressUpdate:request success:success failure:nil];
}
-(void)doUserAddressUpdate:(UserAddressUpdateRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user_address/updateAddress",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}

-(void)doUserAddressAuto:(UserAddressAutoRequest *)request success:(successBlocks)success
{
    [self doUserAddressAuto:request success:success failure:nil];
}
-(void)doUserAddressAuto:(UserAddressAutoRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@user_address/autoSelectAddr",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];

}

-(void)doOrderPayList:(OrderPayListRequest *)request success:(successBlocks)success
{
    [self doOrderPayList:request success:success failure:nil];
}
-(void)doOrderPayList:(OrderPayListRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@order/payList",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}
-(void)doServiceOpenAreaList:(ServiceOpenAreaListRequest *)request success:(successBlocks)success
{
    [self doServiceOpenAreaList:request success:success failure:nil];
}
-(void)doServiceOpenAreaList:(ServiceOpenAreaListRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@startup/serviceOpenAreaList",_requestURL]
    parameters:paramStr
       success:success
       failure:failure];
}


-(void)doSiteLog:(SiteLogRequest *)request success:(successBlocks)success
{
    [self doSiteLog:request success:success failure:nil];
}
-(void)doSiteLog:(SiteLogRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self postNoData:[NSString stringWithFormat:@"%@/site/requestLog",_teamURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doSearchHistory:(SearchHistoryRequest *)request success:(successBlocks)success
{
    [self doSearchHistory:request success:success failure:nil];
}
-(void)doSearchHistory:(SearchHistoryRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@member/searchHistory",_requestURL]
          parameters:paramStr
             success:success
             failure:failure];
}

-(void)doMemberSearch:(MemberSearchRequest *)request success:(successBlocks)success
{
    [self doMemberSearch:request success:success failure:nil];
}
-(void)doMemberSearch:(MemberSearchRequest *)request success:(successBlocks)success failure:(failureBlocks)failure
{
    CGRequest *param = [[CGRequest alloc]init];
    NSString *paramStr=[param paramStringWithParamObject:request];
    [self post:[NSString stringWithFormat:@"%@member/search",_requestURL]
          parameters:paramStr
             success:success
             failure:failure];
}
@end















