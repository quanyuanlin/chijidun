#import <Foundation/Foundation.h>
#import "Backend.h"
#import "Models.h"
#import "UserRepository.h"
#import "UserAssembler.h"

/**
 *  用户信息解析
 */
@interface UserBackend : Backend
@property(strong, nonatomic) UserRepository *repository;
@property(strong, nonatomic) UserAssembler *assembler;

+ (instancetype)shared;

#pragma userSetting 其他设置

- (RACSignal *)requestUpdateUserSetting:(NSInteger)type withValue:(NSString *)value;

#pragma 优惠券

- (RACSignal *)requestCouponList:(FILTER *)filter withUser:(USER *)user;

- (RACSignal *)requestCheckoutCouponList:(FILTER *)filter withUser:(USER *)user;

- (RACSignal *)requestCouponDetails:(FILTER *)filter withUser:(USER *)user;

#pragma UserFav 农户

- (RACSignal *)requestUserFavList:(FILTER *)filter withUser:(USER *)user;

- (RACSignal *)requestAddUserFavItems:(GOODS *)item;

- (RACSignal *)requestRemoveUserFavItems:(NSMutableArray *)items;

- (RACSignal *)requestRemoveUserFavItems2:(NSMutableArray *)items;

#pragma UserAddress

- (RACSignal *)requestAddressList:(FILTER *)filter withUser:(USER *)anUser;

- (RACSignal *)requestUpdateAddress:(ADDRESS *)address;

- (RACSignal *)requestDelAddressWithID:(NSInteger)addressID user:(USER *)anUser;

#pragma UserLike

- (RACSignal *)requestUserLikeList:(FILTER *)filter withUser:(USER *)user;

- (RACSignal *)requestAddUserLikeItems:(GOODS *)item;

- (RACSignal *)requestRemoveUserLikeItems:(NSMutableArray *)items;

#pragma UserLogiin

- (RACSignal *)requestAuthenticate:(USER *)user;

- (RACSignal *)requestAuthenticateUserBind:(USER *)user;

- (RACSignal *)requestAuthenticateUserBindAdd:(USER *)user;

- (RACSignal *)requestRegister:(USER *)user;

- (RACSignal *)requestUser;

- (RACSignal *)requestSaveUser:(USER *)user;

- (RACSignal *)requestUpdateUserAvatar:(USER *)user;

//更新头像
- (RACSignal *)requestResetPsw:(USER *)user;

- (USER *)restore;
@end
