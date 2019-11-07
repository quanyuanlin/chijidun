//
//  CGClient.h
//  chijidun
//
//  Created by iMac on 16/8/28.
//
//

#import <Foundation/Foundation.h>
#import "CGRequest.h"
#import "CGResponse.h"

#import "UserLoginNewRequest.h"
#import "UserLoginNewResponse.h"
#import "UserRegisterRequest.h"
#import "UserRegisterResponse.h"
#import "UserResetPasswordRequest.h"
#import "UserResetPasswordResponse.h"
#import "UserLoginOutRequest.h"
#import "UserLoginOutResponse.h"
#import "StartUpIndexRequest.h"
#import "StartUpIndextResponse.h"
#import "StartUpVersionRequest.h"
#import "StartUpVersionResponse.h"
#import "CompanyPushSwitchRequest.h"
#import "CompanyPushSwitchResponse.h"
#import "GetCompanyPushSwitchRequest.h"
#import "GetCompanyPushSwitchResponse.h"
#import "HasCompanyMealRequest.h"
#import "HasCompanyResponse.h"
#import "TeamOrderIndexRequest.h"
#import "TeamOrderIndexResponse.h"
#import "OrderGetTimeIntervalRequest.h"
#import "OrderGetTimeIntervalResponse.h"
#import "GetMemberAndOrderRequest.h"
#import "GetMembersAndOrderResponse.h"
#import "OrderGetMenuRequest.h"
#import "OrderGetMenuResponse.h"
#import "ConfirmOrderResquest.h"
#import "ConfirmOrderResponse.h"
#import "SaveOrderRequest.h"
#import "SaveOrderResponse.h"
#import "IsPlaceOrderRequest.h"
#import "IsPlaceOrderResponse.h"
#import "GetOrderInfoRequest.h"
#import "GetOrderInfoResponse.h"
#import "DeleteOrderRequest.h"
#import "DeleteOrderResponse.h"
#import "TeamOrderPayRequest.h"
#import "TeamOrderPayResponse.h"
#import "SaveCompanyMealApplyRequest.h"
#import "SaveCompanyMealByInviteRequest.h"
#import "CharacterAppPayRequest.h"
#import "AccountOrderRequest.h"
#import "AccountOrderResponse.h"
#import "GetCompanyNameRequest.h"
#import "GlobalSettingRequest.h"
#import "GlobalSettingResponse.h"
#import "CartSetByMemberRequest.h"
#import "CartGetByMemberRequest.h"
#import "CartGetByMemberResponse.h"
#import "OrderAddRequest.h"
#import "OrderAddResponse.h"
#import "OrderConfirmOrderRequest.h"
#import "OrderConfirmOrderResponse.h"
#import "UserAddressListsRequest.h"
#import "UserAddressListsResponse.h"
#import "UserAddressAddRequest.h"
#import "UserAddressAddResponse.h"
#import "UserAddressDeleteRequest.h"
#import "UserAddressDeleteResponse.h"
#import "UserAddressUpdateRequest.h"
#import "UserAddressUpdateResponse.h"
#import "UserAddressAutoRequest.h"
#import "UserAddressAutoResponse.h"
#import "OrderPayListRequest.h"
#import "OrderPayListResponse.h"
#import "ServiceOpenAreaListRequest.h"
#import "ServiceOpenAreaListResponse.h"
#import "SiteLogRequest.h"
#import "MemberFavListsRequest.h"
#import "MemberFavListsResponse.h"
#import "SearchHistoryRequest.h"
#import "SearchHistoryResponse.h"
#import "MemberSearchRequest.h"
#import "MemberSearchResponse.h"
#import "ItemGetDetailRequest.h"
#import "ItemGetDetailResponse.h"

@class UserLoginNewRequest;
@class UserRegisterRequest;
@class UserResetPasswordRequest;
@class UserLoginOutRequest;
@class StartUpIndexRequest;
@class StartUpVersionRequest;
@class CompanyPushSwitchRequest;
@class GetCompanyPushSwitchRequest;
@class HasCompanyMealRequest;
@class TeamOrderIndexRequest;
@class OrderGetTimeIntervalRequest;
@class GetMemberAndOrderRequest;
@class OrderGetMenuRequest;
@class ItemGetDetailRequest;
@class ItemGetDetailResponse;
@class ConfirmOrderResquest;
@class SaveOrderRequest;
@class TeamOrderPayRequest;
@class SaveCompanyMealApplyRequest;
@class SaveCompanyMealByInviteRequest;
@class CharacterAppPayRequest;
@class AccountOrderRequest;
@class GetCompanyNameRequest;
@class GlobalSettingRequest;
@class CartSetByMemberRequest;
@class CartGetByMemberRequest;
@class CartGetByMemberResponse;
@class OrderAddRequest;
@class OrderAddResponse;
@class OrderConfirmOrderRequest;
@class OrderConfirmOrderResponse;
@class UserAddressListsRequest;
@class UserAddressListsResponse;
@class UserAddressAddRequest;
@class UserAddressAddResponse;
@class UserAddressDeleteRequest;
@class UserAddressDeleteResponse;
@class UserAddressUpdateRequest;
@class UserAddressUpdateResponse;
@class UserAddressAutoRequest;
@class UserAddressAutoResponse;
@class OrderPayListRequest;
@class OrderPayListResponse;
@class ServiceOpenAreaListRequest;
@class ServiceOpenAreaListResponse;
@class SiteLogRequest;
@class MemberFavListsRequest;
@class MemberFavListsResponse;
@class SearchHistoryRequest;
@class SearchHistoryResponse;
@class MemberSearchRequest;
@class MemberSearchResponse;

typedef void (^beforeRequestBlocks)(CGRequest *data,NSString *url,BOOL hideProgress);

typedef void (^afterRequestBlocks)(CGResponse *data,NSString *url);
typedef NSString* (^getTokenBlock)();

typedef NSString* (^getApiUrlBlock)();

typedef void (^successBlocks)(CGResponse *data,NSString *url);

typedef void (^failureBlocks)(CGResponse *data,NSString *url);

@interface CGClient : NSObject

- (instancetype)init:(beforeRequestBlocks)beforeRequest
        afterRequest:(afterRequestBlocks)afterRequest
            getToken:(getTokenBlock)getToken
           getApiUrl:(getApiUrlBlock)getApiUrl;

-(instancetype)hideProgress;

- (instancetype)disableAfterRequest;

-(void)doStartUpIndex:(StartUpIndexRequest *)request success:(successBlocks)success;
-(void)doStartUpIndex:(StartUpIndexRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doStartUpVersion:(StartUpVersionRequest *)request success:(successBlocks)success;
-(void)doStartUpVersion:(StartUpVersionRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doUserLoginNew:(UserLoginNewRequest *)request success:(successBlocks)success;
-(void)doUserLoginNew:(UserLoginNewRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doUserLoginOut:(UserLoginOutRequest *)request success:(successBlocks)success;
-(void)doUserLoginOut:(UserLoginOutRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doUserRegister:(UserRegisterRequest *)request success:(successBlocks)success;
-(void)doUserRegister:(UserRegisterRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doUserResetPassword:(UserResetPasswordRequest *)request success:(successBlocks)success;
-(void)doUserResetPassword:(UserResetPasswordRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doCompanyPushSwitch:(CompanyPushSwitchRequest *)request success:(successBlocks)success;
-(void)doCompanyPushSwitch:(CompanyPushSwitchRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doGetCompanyPushSwitch:(GetCompanyPushSwitchRequest *)request success:(successBlocks)success;
-(void)doGetCompanyPushSwitch:(GetCompanyPushSwitchRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doHasCompanyMeal:(HasCompanyMealRequest *)request success:(successBlocks)success;
-(void)doHasCompanyMeal:(HasCompanyMealRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doTeamOrderIndex:(TeamOrderIndexRequest *)request success:(successBlocks)success;
-(void)doTeamOrderIndex:(TeamOrderIndexRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doOrderGetTimeInterval:(OrderGetTimeIntervalRequest *)request success:(successBlocks)success;
-(void)doOrderGetTimeInterval:(OrderGetTimeIntervalRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doGetMemberAndOrder:(GetMemberAndOrderRequest *)request success:(successBlocks)success;
-(void)doGetMemberAndOrder:(GetMemberAndOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doItemGetDetail:(ItemGetDetailRequest *)request success:(successBlocks)success;
-(void)doItemGetDetail:(ItemGetDetailRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doOrderGetMenu:(OrderGetMenuRequest *)request success:(successBlocks)success;
-(void)doOrderGetMenu:(OrderGetMenuRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doConfirmOrder:(ConfirmOrderResquest *)request success:(successBlocks)success;
-(void)doConfirmOrder:(ConfirmOrderResquest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doSaveOrder:(SaveOrderRequest *)request success:(successBlocks)success;
-(void)doSaveOrder:(SaveOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doIsPlaceOrder:(IsPlaceOrderRequest *)request success:(successBlocks)success;
-(void)doIsPlaceOrder:(IsPlaceOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doGetOrderInfo:(GetOrderInfoRequest *)request success:(successBlocks)success;
-(void)doGetOrderInfo:(GetOrderInfoRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doDeleteOrder:(DeleteOrderRequest *)request success:(successBlocks)success;
-(void)doDeleteOrder:(DeleteOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doTeamOrderPay:(TeamOrderPayRequest *)request success:(successBlocks)success;
-(void)doTeamOrderPay:(TeamOrderPayRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;


-(void)doSaveCompanyMealApply:(SaveCompanyMealApplyRequest *)request success:(successBlocks)success;
-(void)doSaveCompanyMealApply:(SaveCompanyMealApplyRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doGetCompanyName:(GetCompanyNameRequest *)request success:(successBlocks)success;
-(void)doGetCompanyName:(GetCompanyNameRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doSaveCompanyMealByInvite:(SaveCompanyMealByInviteRequest *)request success:(successBlocks)success;
-(void)doSaveCompanyMealByInvite:(SaveCompanyMealByInviteRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doCharacterAppPay:(CharacterAppPayRequest *)request success:(successBlocks)success;
-(void)doCharacterAppPay:(CharacterAppPayRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doAccountOrder:(AccountOrderRequest *)request success:(successBlocks)success;
-(void)doAccountOrder:(AccountOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;


-(void)doGlobalSetting:(GlobalSettingRequest *)request success:(successBlocks)success;
-(void)doGlobalSetting:(GlobalSettingRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doCartSetByMember:(CartSetByMemberRequest *)request success:(successBlocks)success;
-(void)doCartSetByMember:(CartSetByMemberRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doCartGetByMember:(CartGetByMemberRequest *)request success:(successBlocks)success;
-(void)doCartGetByMember:(CartGetByMemberRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doOrderAdd:(OrderAddRequest *)request success:(successBlocks)success;
-(void)doOrderAdd:(OrderAddRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doOrderConfirmOrder:(OrderConfirmOrderRequest *)request success:(successBlocks)success;
-(void)doOrderConfirmOrder:(OrderConfirmOrderRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doMemberFavLists:(MemberFavListsRequest *)request success:(successBlocks)success;
-(void)doMemberFavLists:(MemberFavListsRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doUserAddressLists:(UserAddressListsRequest *)request success:(successBlocks)success;
-(void)doUserAddressLists:(UserAddressListsRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doUserAddressAdd:(UserAddressAddRequest *)request success:(successBlocks)success;
-(void)doUserAddressAdd:(UserAddressAddRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doUserAddressDelete:(UserAddressDeleteRequest *)request success:(successBlocks)success;
-(void)doUserAddressDelete:(UserAddressDeleteRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doUserAddressUpdate:(UserAddressUpdateRequest *)request success:(successBlocks)success;
-(void)doUserAddressUpdate:(UserAddressUpdateRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doUserAddressAuto:(UserAddressAutoRequest *)request success:(successBlocks)success;
-(void)doUserAddressAuto:(UserAddressAutoRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doOrderPayList:(OrderPayListRequest *)request success:(successBlocks)success;
-(void)doOrderPayList:(OrderPayListRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doServiceOpenAreaList:(ServiceOpenAreaListRequest *)request success:(successBlocks)success;
-(void)doServiceOpenAreaList:(ServiceOpenAreaListRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;


-(void)doSiteLog:(SiteLogRequest *)request success:(successBlocks)success;
-(void)doSiteLog:(SiteLogRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doSearchHistory:(SearchHistoryRequest *)request success:(successBlocks)success;
-(void)doSearchHistory:(SearchHistoryRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

-(void)doMemberSearch:(MemberSearchRequest *)request success:(successBlocks)success;
-(void)doMemberSearch:(MemberSearchRequest *)request success:(successBlocks)success failure:(failureBlocks)failure;

@end
















