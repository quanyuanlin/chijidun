//
//  ChefItemTable.h
//  chijidun
//
//  Created by iMac on 16/9/23.
//
//

#import <Foundation/Foundation.h>

@interface ChefItemTable : NSObject

@property(nonatomic,strong) NSString *Id;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *item_desc;
@property(nonatomic,strong) NSString *price;
@property(nonatomic,strong) NSString *num;
@property(nonatomic,strong) NSString *mname;

@property(nonatomic,strong) NSString *material;
@property(nonatomic,strong) NSString *stock_perday;
@property(nonatomic,strong) NSString *img;

@property BOOL enable;

@end
