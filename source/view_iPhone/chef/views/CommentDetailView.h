#import <UIKit/UIKit.h>

@class Item_commentTable;
@class ApiClient;

@interface CommentDetailView : UIView {
}

@property(nonatomic, strong) ApiClient *apiClient;
@property(nonatomic) NSString  *mid;

@property(nonatomic,strong)NSString *reply;

-(void)refreshWith:(NSString *)reply;
- (void)load;

@end
