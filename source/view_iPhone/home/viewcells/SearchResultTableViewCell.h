//
//  SearchResultTableViewCell.h
//  chijidun
//
//  Created by iMac on 16/12/7.
//
//

#import <UIKit/UIKit.h>

@interface SearchResultTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDesc;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UIImageView *lineView;


@property(nonatomic,strong)NSString *searchText;
-(void)bindWith:(ItemTable *)item;


@end
