#import "UICollectionView+Extend.h"


@implementation UICollectionView (Extend)
- (instancetype)registerClass:(Class)cls {
    [self registerClass:cls forCellWithReuseIdentifier:[cls description]];
    return self;
}

- (instancetype)registerNib:(Class)cls {
    [self registerNib:[UINib nibWithNibName:[cls description] bundle:nil] forCellWithReuseIdentifier:[cls description]];
    return self;
}

@end