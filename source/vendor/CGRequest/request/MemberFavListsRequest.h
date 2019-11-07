//
//  MemberFavListsRequest.h
//  chijidun
//
//  Created by iMac on 16/11/19.
//
//

#import <Foundation/Foundation.h>

@interface MemberFavListsRequest : NSObject

@property(nonatomic,strong)NSString *page;
@property(nonatomic,strong)NSString *perPage;
@property(nonatomic,strong)NSString *userid;

@end
