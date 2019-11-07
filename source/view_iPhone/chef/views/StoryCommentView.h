#import <UIKit/UIKit.h>

@protocol storyCommentDelegate <NSObject>

-(void)ClickStoryOrCommentWith:(NSInteger)index;

@end
@interface StoryCommentView : UIView
{
    __weak id<storyCommentDelegate> m_storyCommentDelegate;
}
@property(nonatomic,weak) id<storyCommentDelegate> p_storyCommentDelegate;

@end
