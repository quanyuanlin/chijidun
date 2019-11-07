/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Member_comment_imgTable.h"
#import "UserTable.h"

@class Member_comment_imgTable;
@class UserTable;

@interface Member_commentTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSMutableArray/*Member_comment_imgTable*/ *imgs;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *likes;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *order_type;
@property(strong, nonatomic) NSString *orderid;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *reply_id;
@property(strong, nonatomic) NSString *reply_info;
@property(strong, nonatomic) NSString *reply_name;
@property(strong, nonatomic) NSString *reply_time;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *uname;
@property(strong, nonatomic) UserTable *user;

@end