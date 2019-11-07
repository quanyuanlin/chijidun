//
//  ChefTable.h
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import <Foundation/Foundation.h>

@interface ChefTable : NSObject

@property(nonatomic,strong) NSString *mid;
@property(nonatomic,strong) NSString *category;
@property(nonatomic,strong) NSString *limit;
@property(nonatomic,strong) NSString *mname;
@property(nonatomic,strong) NSString *status;

@property(nonatomic,strong) NSArray /*ChefItemTable */ *list;



@end
