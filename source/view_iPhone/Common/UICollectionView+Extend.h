#import <Foundation/Foundation.h>

@interface UICollectionView (Extend)
- (instancetype)registerClass:(Class)cls;

- (instancetype)registerNib:(Class)cls;

@end