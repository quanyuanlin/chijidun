/*
不要手动修改
*/
#import "ApiClient.h"

@interface ApiClient ()
@property(strong, nonatomic) AFHTTPRequestOperationManager *manager;
@property(strong, nonatomic) NSString *requestURL;
@property(strong, nonatomic) beforeRequestBlock beforeRequestCallback;
@property(strong, nonatomic) afterRequestBlock afterRequestCallback;
@property(strong, nonatomic) getTokenBlock getTokenBlock;
@property BOOL isHideProgress;
@property BOOL isDisableAfterRequest;
@end

@implementation ApiClient {
}

- (instancetype)init:(beforeRequestBlock)beforeRequest
        afterRequest:(afterRequestBlock)afterRequest
            getToken:(getTokenBlock)getToken
           getApiUrl:(getApiUrlBlock)getApiUrl {

    _beforeRequestCallback = beforeRequest;
    _afterRequestCallback = afterRequest;
    _requestURL = getApiUrl();
    _getTokenBlock = getToken;

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

- (void)post:(NSString *)url parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure {
    [parameters setObject:[NSString stringWithFormat:@"%@", _getTokenBlock()] forKey:@"token"];
    [parameters setObject:Current_Version forKey:@"version"];
    [parameters setObject:@"ios" forKey:@"source"];
    NSString *deviceToken = [App shared].deviceToken;;
    [parameters setValue:deviceToken forKey:@"device"];
#ifdef DEBUG
    NSDictionary *params = (NSDictionary *) parameters;
    id _token = params[@"token"];
    if ([params[@"token"] isEqual:@"(null)"]) {
        _token = @"";
    }
    printf("curl %s -d 'token=%s&source=%s&device=%s&version=%s&data=%s'\n", [url UTF8String], [_token UTF8String], [params[@"source"] UTF8String],[params[@"device"] UTF8String],[params[@"version"] UTF8String],[params[@"data"] UTF8String]);
#endif

    _beforeRequestCallback(parameters, url, _isHideProgress);

    [_manager
            POST:url
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation,
                 id responseObject) {

             if (responseObject == nil) {
                 responseObject = [[NSMutableDictionary alloc] init];
                 responseObject[@"result"] = @"服务器返回格式错误!";
                 responseObject[@"status"] = @"0";
             }
             _isHideProgress = NO;
             if (_isDisableAfterRequest) {
                 _isDisableAfterRequest = NO;
             } else {
                 _afterRequestCallback(responseObject, url);
             }

             if ([[NSString stringWithFormat:@"%@", responseObject[@"status"]] isEqual:@"1"]) {
                 if (success != nil) {
                     success(responseObject, url);
                 }
             } else {
                 if (failure != nil) {
                     failure(responseObject, url);
                 }
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSMutableDictionary *response = [NSMutableDictionary new];
             response[@"status"] = @"0";
             response[@"result"] = error.userInfo[@"NSLocalizedDescription"];
             self.afterRequestCallback(response, nil);
             if (failure != nil) {
                 failure(response, url);
             }
         }];
}

-(void)doCartAdd:(CartAddRequest *)request success:(successBlock)success{
    [self doCartAdd:request success:success failure:nil];
}
-(void)doCartAdd:(CartAddRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@cart/add",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doCartDelete:(CartDeleteRequest *)request success:(successBlock)success{
    [self doCartDelete:request success:success failure:nil];
}
-(void)doCartDelete:(CartDeleteRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@cart/delete",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doCartLists:(CartListsRequest *)request success:(successBlock)success{
    [self doCartLists:request success:success failure:nil];
}
-(void)doCartLists:(CartListsRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@cart/lists",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doCartUpdate:(CartUpdateRequest *)request success:(successBlock)success{
    [self doCartUpdate:request success:success failure:nil];
}
-(void)doCartUpdate:(CartUpdateRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@cart/update",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doCustom_itemAd_list:(Custom_itemAd_listRequest *)request success:(successBlock)success{
    [self doCustom_itemAd_list:request success:success failure:nil];
}
-(void)doCustom_itemAd_list:(Custom_itemAd_listRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@custom_item/ad_list",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doCustom_itemGet:(Custom_itemGetRequest *)request success:(successBlock)success{
    [self doCustom_itemGet:request success:success failure:nil];
}
-(void)doCustom_itemGet:(Custom_itemGetRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@custom_item/get",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doCustom_itemIndex:(Custom_itemIndexRequest *)request success:(successBlock)success{
    [self doCustom_itemIndex:request success:success failure:nil];
}
-(void)doCustom_itemIndex:(Custom_itemIndexRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@custom_item/index",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doCustom_itemLists:(Custom_itemListsRequest *)request success:(successBlock)success{
    [self doCustom_itemLists:request success:success failure:nil];
}
-(void)doCustom_itemLists:(Custom_itemListsRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@custom_item/lists",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doCustom_orderAdd:(Custom_orderAddRequest *)request success:(successBlock)success{
    [self doCustom_orderAdd:request success:success failure:nil];
}
-(void)doCustom_orderAdd:(Custom_orderAddRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@custom_order/add",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doCustom_orderLists:(Custom_orderListsRequest *)request success:(successBlock)success{
    [self doCustom_orderLists:request success:success failure:nil];
}
-(void)doCustom_orderLists:(Custom_orderListsRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@custom_order/lists",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doCustom_orderPay:(Custom_orderPayRequest *)request success:(successBlock)success{
    [self doCustom_orderPay:request success:success failure:nil];
}
-(void)doCustom_orderPay:(Custom_orderPayRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@custom_order/pay",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doIndexGet:(IndexGetRequest *)request success:(successBlock)success{
    [self doIndexGet:request success:success failure:nil];
}
-(void)doIndexGet:(IndexGetRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@index/bannerList",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doItemFollow:(ItemFollowRequest *)request success:(successBlock)success{
    [self doItemFollow:request success:success failure:nil];
}
-(void)doItemFollow:(ItemFollowRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@item/follow",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doItemGet:(ItemGetRequest *)request success:(successBlock)success{
    [self doItemGet:request success:success failure:nil];
}
-(void)doItemGet:(ItemGetRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@item/getDetail",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doItemUnfollow:(ItemUnfollowRequest *)request success:(successBlock)success{
    [self doItemUnfollow:request success:success failure:nil];
}
-(void)doItemUnfollow:(ItemUnfollowRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@item/unfollow",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doMemberGet:(MemberGetRequest *)request success:(successBlock)success{
    [self doMemberGet:request success:success failure:nil];
}
-(void)doMemberGet:(MemberGetRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@member/get",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doMemberLists:(MemberListsRequest *)request success:(successBlock)success{
    [self doMemberLists:request success:success failure:nil];
}
-(void)doMemberLists:(MemberListsRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@member/index",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doMember_commentAdd:(Member_commentAddRequest *)request success:(successBlock)success{
    [self doMember_commentAdd:request success:success failure:nil];
}
-(void)doMember_commentAdd:(Member_commentAddRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@member_comment/add",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doMember_commentLists:(Member_commentListsRequest *)request success:(successBlock)success{
    [self doMember_commentLists:request success:success failure:nil];
}
-(void)doMember_commentLists:(Member_commentListsRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@member_comment/lists",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doMember_favsAdd:(Member_favsAddRequest *)request success:(successBlock)success{
    [self doMember_favsAdd:request success:success failure:nil];
}
-(void)doMember_favsAdd:(Member_favsAddRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@member_favs/add",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doMember_favsDelete:(Member_favsDeleteRequest *)request success:(successBlock)success{
    [self doMember_favsDelete:request success:success failure:nil];
}
-(void)doMember_favsDelete:(Member_favsDeleteRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@member_favs/delete",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doMessageAdd:(MessageAddRequest *)request success:(successBlock)success{
    [self doMessageAdd:request success:success failure:nil];
}
-(void)doMessageAdd:(MessageAddRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@message/add",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doMessageDelete:(MessageDeleteRequest *)request success:(successBlock)success{
    [self doMessageDelete:request success:success failure:nil];
}
-(void)doMessageDelete:(MessageDeleteRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@message/delete",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doMessageLists:(MessageListsRequest *)request success:(successBlock)success{
    [self doMessageLists:request success:success failure:nil];
}
-(void)doMessageLists:(MessageListsRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@message/lists",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doOrderAdd_order_refund:(OrderAdd_order_refundRequest *)request success:(successBlock)success{
    [self doOrderAdd_order_refund:request success:success failure:nil];
}
-(void)doOrderAdd_order_refund:(OrderAdd_order_refundRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@order/add_order_refund",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doOrderDelete:(OrderDeleteRequest *)request success:(successBlock)success{
    [self doOrderDelete:request success:success failure:nil];
}
-(void)doOrderDelete:(OrderDeleteRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@order/delete",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doOrderGet:(OrderGetRequest *)request success:(successBlock)success{
    [self doOrderGet:request success:success failure:nil];
}
-(void)doOrderGet:(OrderGetRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@order/get",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doOrderNeedCommentCount:(OrderNeedCommentCountRequest *)request success:(successBlock)success{
    [self doOrderNeedCommentCount:request success:success failure:nil];
}
-(void)doOrderNeedCommentCount:(OrderNeedCommentCountRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@order/needCommentCount",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doOrderOrderConfirm:(OrderOrderConfirmRequest *)request success:(successBlock)success{
    [self doOrderOrderConfirm:request success:success failure:nil];
}
-(void)doOrderOrderConfirm:(OrderOrderConfirmRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@order/orderConfirm",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doOrderPay:(OrderPayRequest *)request success:(successBlock)success{
    [self doOrderPay:request success:success failure:nil];
}
-(void)doOrderPay:(OrderPayRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@order/pay",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doOrderRefund:(OrderRefundRequest *)request success:(successBlock)success{
    [self doOrderRefund:request success:success failure:nil];
}
-(void)doOrderRefund:(OrderRefundRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@order/refund",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doQuanExchange_quan:(QuanExchange_quanRequest *)request success:(successBlock)success{
    [self doQuanExchange_quan:request success:success failure:nil];
}
-(void)doQuanExchange_quan:(QuanExchange_quanRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@quan/exchange_quan",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doQuanGet:(QuanGetRequest *)request success:(successBlock)success{
    [self doQuanGet:request success:success failure:nil];
}
-(void)doQuanGet:(QuanGetRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@quan/get",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doQuanLists:(QuanListsRequest *)request success:(successBlock)success{
    [self doQuanLists:request success:success failure:nil];
}
-(void)doQuanLists:(QuanListsRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@quan/lists",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doSmsSend_verify_code:(SmsSend_verify_codeRequest *)request success:(successBlock)success{
    [self doSmsSend_verify_code:request success:success failure:nil];
}
-(void)doSmsSend_verify_code:(SmsSend_verify_codeRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@sms/send_verify_code",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doTeamAdd:(TeamAddRequest *)request success:(successBlock)success{
    [self doTeamAdd:request success:success failure:nil];
}
-(void)doTeamAdd:(TeamAddRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@team/add",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doTestIndex:(TestIndexRequest *)request success:(successBlock)success{
    [self doTestIndex:request success:success failure:nil];
}
-(void)doTestIndex:(TestIndexRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@test/index",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doUserExist:(UserExistRequest *)request success:(successBlock)success{
    [self doUserExist:request success:success failure:nil];
}
-(void)doUserExist:(UserExistRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@user/exist",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doUserCheckRegCode:(UserCheckRegCodeRequest *)request success:(successBlock)success{
    [self doUserCheckRegCode:request success:success failure:nil];
}
-(void)doUserCheckRegCode:(UserCheckRegCodeRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@user/checkRegCode",_requestURL]
    parameters:parameters
       success:success
       failure:failure];
}

-(void)doUserGet:(UserGetRequest *)request success:(successBlock)success{
    [self doUserGet:request success:success failure:nil];
}
-(void)doUserGet:(UserGetRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@user/get",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doUserLogin:(UserLoginRequest *)request success:(successBlock)success{
    [self doUserLogin:request success:success failure:nil];
}
-(void)doUserLogin:(UserLoginRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@user/login",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doUserMemberReplyUncheckCount:(UserMemberReplyUncheckCountRequest *)request success:(successBlock)success{
    [self doUserMemberReplyUncheckCount:request success:success failure:nil];
}
-(void)doUserMemberReplyUncheckCount:(UserMemberReplyUncheckCountRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@user/memberReplyUncheckCount",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doUserScore_list:(UserScore_listRequest *)request success:(successBlock)success{
    [self doUserScore_list:request success:success failure:nil];
}
-(void)doUserScore_list:(UserScore_listRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@user/score_list",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doUser_bindCallback:(User_bindCallbackRequest *)request success:(successBlock)success{
    [self doUser_bindCallback:request success:success failure:nil];
}
-(void)doUser_bindCallback:(User_bindCallbackRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@user_bind/callback",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doUser_likeAdd:(User_likeAddRequest *)request success:(successBlock)success{
    [self doUser_likeAdd:request success:success failure:nil];
}
-(void)doUser_likeAdd:(User_likeAddRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@user_like/add",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
-(void)doUser_likeDelete:(User_likeDeleteRequest *)request success:(successBlock)success{
    [self doUser_likeDelete:request success:success failure:nil];
}
-(void)doUser_likeDelete:(User_likeDeleteRequest *)request success:(successBlock)success failure:(failureBlock)failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"data"] = [request toJSON];
    [self post:[NSString stringWithFormat:@"%@user_like/delete",_requestURL]
          parameters:parameters
          success:success
          failure:failure];
}
@end
