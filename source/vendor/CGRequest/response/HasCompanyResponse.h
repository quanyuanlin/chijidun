//
//  HasCompanyResponse.h
//  chijidun
//
//  Created by iMac on 16/9/21.
//
//

#import <Foundation/Foundation.h>

@interface HasCompanyResponse : NSObject

@property(nonatomic,strong) NSString *apply;
@property(nonatomic,strong) NSString *has;
@property(nonatomic,strong) NSString *status;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@end
