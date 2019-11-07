/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "AFURLConnectionOperation.h"
#import "CartAddRequest.h"
#import "CartAddResponse.h"
#import "CartDeleteRequest.h"
#import "CartDeleteResponse.h"
#import "CartListsRequest.h"
#import "CartListsResponse.h"
#import "CartUpdateRequest.h"
#import "CartUpdateResponse.h"
#import "Custom_itemAd_listRequest.h"
#import "Custom_itemAd_listResponse.h"
#import "Custom_itemGetRequest.h"
#import "Custom_itemGetResponse.h"
#import "Custom_itemIndexRequest.h"
#import "Custom_itemIndexResponse.h"
#import "Custom_itemListsRequest.h"
#import "Custom_itemListsResponse.h"
#import "Custom_orderAddRequest.h"
#import "Custom_orderAddResponse.h"
#import "Custom_orderListsRequest.h"
#import "Custom_orderListsResponse.h"
#import "Custom_orderPayRequest.h"
#import "Custom_orderPayResponse.h"
#import "IndexGetRequest.h"
#import "IndexGetResponse.h"
#import "ItemFollowRequest.h"
#import "ItemFollowResponse.h"
#import "ItemGetRequest.h"
#import "ItemGetResponse.h"
#import "ItemUnfollowRequest.h"
#import "ItemUnfollowResponse.h"
#import "MemberGetRequest.h"
#import "MemberGetResponse.h"
#import "MemberListsRequest.h"
#import "MemberListsResponse.h"
#import "Member_commentAddRequest.h"
#import "Member_commentAddResponse.h"
#import "Member_commentListsRequest.h"
#import "Member_commentListsResponse.h"
#import "Member_favsAddRequest.h"
#import "Member_favsAddResponse.h"
#import "Member_favsDeleteRequest.h"
#import "Member_favsDeleteResponse.h"
#import "MessageAddRequest.h"
#import "MessageAddResponse.h"
#import "MessageDeleteRequest.h"
#import "MessageDeleteResponse.h"
#import "MessageListsRequest.h"
#import "MessageListsResponse.h"
#import "OrderAdd_order_refundRequest.h"
#import "OrderAdd_order_refundResponse.h"
#import "OrderDeleteRequest.h"
#import "OrderDeleteResponse.h"
#import "OrderGetRequest.h"
#import "OrderGetResponse.h"
#import "OrderNeedCommentCountRequest.h"
#import "OrderNeedCommentCountResponse.h"
#import "OrderOrderConfirmRequest.h"
#import "OrderOrderConfirmResponse.h"
#import "OrderPayRequest.h"
#import "OrderPayResponse.h"
#import "OrderRefundRequest.h"
#import "OrderRefundResponse.h"
#import "QuanExchange_quanRequest.h"
#import "QuanExchange_quanResponse.h"
#import "QuanGetRequest.h"
#import "QuanGetResponse.h"
#import "QuanListsRequest.h"
#import "QuanListsResponse.h"
#import "SmsSend_verify_codeRequest.h"
#import "SmsSend_verify_codeResponse.h"
#import "TeamAddRequest.h"
#import "TeamAddResponse.h"
#import "TestIndexRequest.h"
#import "TestIndexResponse.h"
#import "UserExistRequest.h"
#import "UserExistResponse.h"
#import "UserGetRequest.h"
#import "UserGetResponse.h"
#import "UserLoginRequest.h"
#import "UserLoginResponse.h"
#import "UserMemberReplyUncheckCountRequest.h"
#import "UserMemberReplyUncheckCountResponse.h"
#import "UserScore_listRequest.h"
#import "UserScore_listResponse.h"
#import "User_bindCallbackRequest.h"
#import "User_bindCallbackResponse.h"
#import "User_likeAddRequest.h"
#import "User_likeAddResponse.h"
#import "User_likeDeleteRequest.h"
#import "User_likeDeleteResponse.h"
#import "UserCheckRegCodeRequest.h"

@class CartAddRequest;
@class CartDeleteRequest;
@class CartListsRequest;
@class CartUpdateRequest;
@class Custom_itemAd_listRequest;
@class Custom_itemGetRequest;
@class Custom_itemIndexRequest;
@class Custom_itemListsRequest;
@class Custom_orderAddRequest;
@class Custom_orderListsRequest;
@class Custom_orderPayRequest;
@class IndexGetRequest;
@class ItemFollowRequest;
@class ItemGetRequest;
@class ItemUnfollowRequest;
@class MemberGetRequest;
@class MemberListsRequest;
@class Member_commentAddRequest;
@class Member_commentListsRequest;
@class Member_favsAddRequest;
@class Member_favsDeleteRequest;
@class MessageAddRequest;
@class MessageDeleteRequest;
@class MessageListsRequest;
@class OrderAdd_order_refundRequest;
@class OrderDeleteRequest;
@class OrderGetRequest;
@class OrderNeedCommentCountRequest;
@class OrderOrderConfirmRequest;
@class OrderPayRequest;
@class OrderRefundRequest;
@class QuanExchange_quanRequest;
@class QuanGetRequest;
@class QuanListsRequest;
@class SmsSend_verify_codeRequest;
@class TeamAddRequest;
@class TestIndexRequest;
@class UserExistRequest;
@class UserGetRequest;
@class UserLoginRequest;
@class UserMemberReplyUncheckCountRequest;
@class UserScore_listRequest;
@class User_bindCallbackRequest;
@class User_likeAddRequest;
@class User_likeDeleteRequest;
@class UserCheckRegCodeRequest;

typedef void (^beforeRequestBlock)(NSMutableDictionary *data,NSString *url,BOOL hideProgress);

typedef void (^afterRequestBlock)(NSMutableDictionary *data,NSString *url);
typedef NSString* (^getTokenBlock)();

typedef NSString* (^getApiUrlBlock)();

typedef void (^successBlock)(NSMutableDictionary *data,NSString *url);

typedef void (^failureBlock)(NSMutableDictionary *data,NSString *url);

@interface ApiClient: NSObject
- (instancetype)init:(beforeRequestBlock)beforeRequest
        afterRequest:(afterRequestBlock)afterRequest
            getToken:(getTokenBlock)getToken
           getApiUrl:(getApiUrlBlock)getApiUrl;

-(instancetype)hideProgress;           

- (instancetype)disableAfterRequest;

-(void)doCartAdd:(CartAddRequest *)request success:(successBlock)success;

-(void)doCartAdd:(CartAddRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doCartDelete:(CartDeleteRequest *)request success:(successBlock)success;

-(void)doCartDelete:(CartDeleteRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doCartLists:(CartListsRequest *)request success:(successBlock)success;

-(void)doCartLists:(CartListsRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doCartUpdate:(CartUpdateRequest *)request success:(successBlock)success;

-(void)doCartUpdate:(CartUpdateRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doCustom_itemAd_list:(Custom_itemAd_listRequest *)request success:(successBlock)success;

-(void)doCustom_itemAd_list:(Custom_itemAd_listRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doCustom_itemGet:(Custom_itemGetRequest *)request success:(successBlock)success;

-(void)doCustom_itemGet:(Custom_itemGetRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doCustom_itemIndex:(Custom_itemIndexRequest *)request success:(successBlock)success;

-(void)doCustom_itemIndex:(Custom_itemIndexRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doCustom_itemLists:(Custom_itemListsRequest *)request success:(successBlock)success;

-(void)doCustom_itemLists:(Custom_itemListsRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doCustom_orderAdd:(Custom_orderAddRequest *)request success:(successBlock)success;

-(void)doCustom_orderAdd:(Custom_orderAddRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doCustom_orderLists:(Custom_orderListsRequest *)request success:(successBlock)success;

-(void)doCustom_orderLists:(Custom_orderListsRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doCustom_orderPay:(Custom_orderPayRequest *)request success:(successBlock)success;

-(void)doCustom_orderPay:(Custom_orderPayRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doIndexGet:(IndexGetRequest *)request success:(successBlock)success;

-(void)doIndexGet:(IndexGetRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doItemFollow:(ItemFollowRequest *)request success:(successBlock)success;

-(void)doItemFollow:(ItemFollowRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doItemGet:(ItemGetRequest *)request success:(successBlock)success;

-(void)doItemGet:(ItemGetRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doItemUnfollow:(ItemUnfollowRequest *)request success:(successBlock)success;

-(void)doItemUnfollow:(ItemUnfollowRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doMemberGet:(MemberGetRequest *)request success:(successBlock)success;

-(void)doMemberGet:(MemberGetRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doMemberLists:(MemberListsRequest *)request success:(successBlock)success;

-(void)doMemberLists:(MemberListsRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doMember_commentAdd:(Member_commentAddRequest *)request success:(successBlock)success;

-(void)doMember_commentAdd:(Member_commentAddRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doMember_commentLists:(Member_commentListsRequest *)request success:(successBlock)success;

-(void)doMember_commentLists:(Member_commentListsRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doMember_favsAdd:(Member_favsAddRequest *)request success:(successBlock)success;

-(void)doMember_favsAdd:(Member_favsAddRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doMember_favsDelete:(Member_favsDeleteRequest *)request success:(successBlock)success;

-(void)doMember_favsDelete:(Member_favsDeleteRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doMessageAdd:(MessageAddRequest *)request success:(successBlock)success;

-(void)doMessageAdd:(MessageAddRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doMessageDelete:(MessageDeleteRequest *)request success:(successBlock)success;

-(void)doMessageDelete:(MessageDeleteRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doMessageLists:(MessageListsRequest *)request success:(successBlock)success;

-(void)doMessageLists:(MessageListsRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doOrderAdd_order_refund:(OrderAdd_order_refundRequest *)request success:(successBlock)success;

-(void)doOrderAdd_order_refund:(OrderAdd_order_refundRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doOrderDelete:(OrderDeleteRequest *)request success:(successBlock)success;

-(void)doOrderDelete:(OrderDeleteRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doOrderGet:(OrderGetRequest *)request success:(successBlock)success;

-(void)doOrderGet:(OrderGetRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doOrderNeedCommentCount:(OrderNeedCommentCountRequest *)request success:(successBlock)success;

-(void)doOrderNeedCommentCount:(OrderNeedCommentCountRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doOrderOrderConfirm:(OrderOrderConfirmRequest *)request success:(successBlock)success;

-(void)doOrderOrderConfirm:(OrderOrderConfirmRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doOrderPay:(OrderPayRequest *)request success:(successBlock)success;

-(void)doOrderPay:(OrderPayRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doOrderRefund:(OrderRefundRequest *)request success:(successBlock)success;

-(void)doOrderRefund:(OrderRefundRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doQuanExchange_quan:(QuanExchange_quanRequest *)request success:(successBlock)success;

-(void)doQuanExchange_quan:(QuanExchange_quanRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doQuanGet:(QuanGetRequest *)request success:(successBlock)success;

-(void)doQuanGet:(QuanGetRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doQuanLists:(QuanListsRequest *)request success:(successBlock)success;

-(void)doQuanLists:(QuanListsRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doSmsSend_verify_code:(SmsSend_verify_codeRequest *)request success:(successBlock)success;

-(void)doSmsSend_verify_code:(SmsSend_verify_codeRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doTeamAdd:(TeamAddRequest *)request success:(successBlock)success;

-(void)doTeamAdd:(TeamAddRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doTestIndex:(TestIndexRequest *)request success:(successBlock)success;

-(void)doTestIndex:(TestIndexRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doUserExist:(UserExistRequest *)request success:(successBlock)success;

-(void)doUserExist:(UserExistRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doUserCheckRegCode:(UserCheckRegCodeRequest *)request success:(successBlock)success;

-(void)doUserCheckRegCode:(UserCheckRegCodeRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doUserGet:(UserGetRequest *)request success:(successBlock)success;

-(void)doUserGet:(UserGetRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doUserLogin:(UserLoginRequest *)request success:(successBlock)success;

-(void)doUserLogin:(UserLoginRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doUserMemberReplyUncheckCount:(UserMemberReplyUncheckCountRequest *)request success:(successBlock)success;

-(void)doUserMemberReplyUncheckCount:(UserMemberReplyUncheckCountRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doUserScore_list:(UserScore_listRequest *)request success:(successBlock)success;

-(void)doUserScore_list:(UserScore_listRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doUser_bindCallback:(User_bindCallbackRequest *)request success:(successBlock)success;

-(void)doUser_bindCallback:(User_bindCallbackRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doUser_likeAdd:(User_likeAddRequest *)request success:(successBlock)success;

-(void)doUser_likeAdd:(User_likeAddRequest *)request success:(successBlock)success failure:(failureBlock)failure;

-(void)doUser_likeDelete:(User_likeDeleteRequest *)request success:(successBlock)success;

-(void)doUser_likeDelete:(User_likeDeleteRequest *)request success:(successBlock)success failure:(failureBlock)failure;

           
@end
