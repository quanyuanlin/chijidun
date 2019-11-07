#import "MYTextField.h"

@implementation MYTextField {

}
- (id)initWithFrame:(CGRect)frame drawingLeft:(NSString *)icon {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 30)];
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 14, 14)];
        [iconView setImage:[UIImage imageNamed:icon]];
        [leftView addSubview:iconView];
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}
- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.origin.y+=3;
    originalRect.size.height = self.font.lineHeight -4;
    originalRect.size.width = 1;
    return originalRect;
}


@end
