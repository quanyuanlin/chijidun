//
//  SearchAddressCellHeader.h
//  chijidun
//
//  Created by iMac on 16/12/7.
//
//

#import <UIKit/UIKit.h>

@interface SearchAddressCellHeader : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *labTitle;

-(void)bindWith:(NSInteger)index;

@property (strong,nonatomic) void(^clickCurrentBlock)();
@property (strong,nonatomic) void(^clickAddBlock)();

@end
