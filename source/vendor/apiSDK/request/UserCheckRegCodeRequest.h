//
//  UserCheckRegCodeRequest.h
//  chijidun
//
//  Created by iMac on 16/12/19.
//
//

#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface UserCheckRegCodeRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *tele;
@property(strong, nonatomic) NSString *code;


@end
