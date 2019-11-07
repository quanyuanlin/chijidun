//
//  UserAssembler.h
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  用户信息解析
 */
@interface UserAssembler : BackendAssembler
#pragma UserGrade
-(NSArray *)gradeListWithJSON:(NSArray *)JSON;
-(NSArray *)gradeAddListWithJSON:(NSArray *)JSON;


#pragma UserProfile
- (USER *)user:(NSDictionary *)anUser;
- (AccessToken *)accessToken:(NSDictionary *)anTokenJson;


@end
