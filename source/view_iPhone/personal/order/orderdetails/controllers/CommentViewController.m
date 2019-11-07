//
//  CommentViewController.m
//  insuny
//
//  Created by iMac on 15/8/24.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "CommentViewController.h"

#define ItemWidth 60
#define ItemHeight 60
#define MaxItemCount 4

@interface CommentViewController () {
    NSMutableArray *_photoItems;
    NSMutableArray *_imgArray;
}
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    self.navigationItem.leftBarButtonItem = [self tbarBackButton];

    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.commentBtn.backgroundColor = MAIN_COLOR;
    self.view.backgroundColor = BG_COLOR;

    self.addImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotos:)];
    [self.addImgView addGestureRecognizer:gesture];
    self.scrollView.scrollEnabled = NO;
}

- (void)addPhotos:(id)sender {
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.navigationBar.tintColor = [UIColor blackColor];
    picker.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor blackColor],
    };
    picker.maximumNumberOfSelection = 4;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset *) evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset *) evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)reloadDataWithImage:(UIImage *)image {
    [_photoItems addObject:image];
    [self initlizerScrollView:_photoItems];
}

#pragma mark - ZYQAssetPickerController Delegate

- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _photoItems = [NSMutableArray arrayWithArray:assets];
    [self initlizerScrollView:_photoItems];
}

- (void)initlizerScrollView:(NSArray *)imgList {
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _imgArray = [NSMutableArray array];
    for (int i = 0; i < imgList.count; i++) {
        ALAsset *asset = imgList[i];
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [_imgArray addObject:tempImg];
        MessagePhotoMenuItem *photoItem = [[MessagePhotoMenuItem alloc] initWithFrame:CGRectMake(i * (ItemWidth + 10), 0, ItemWidth + 10, ItemHeight + 20)];
        photoItem.delegate = self;
        photoItem.index = i;
        photoItem.contentImage = tempImg;
        [_scrollView addSubview:photoItem];
    }
    if (imgList.count < MaxItemCount) {
        UIButton *btnphoto = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnphoto setFrame:CGRectMake((ItemWidth + 10) * imgList.count, 0, ItemWidth, ItemHeight)];
        [btnphoto setImage:[UIImage imageNamed:@"selectPicture"] forState:UIControlStateNormal];
        //给添加按钮加点击事件
        [btnphoto addTarget:self action:@selector(addPhotos:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btnphoto];
    }

    NSInteger count = MIN(imgList.count + 1, MaxItemCount);
    [_scrollView setContentSize:CGSizeMake(20 + (ItemWidth + 10) * count, 0)];
}

#pragma mark - MessagePhotoItemDelegate

- (void)messagePhotoItemView:(MessagePhotoMenuItem *)messagePhotoItemView didSelectDeleteButtonAtIndex:(NSInteger)index {
    [_photoItems removeObjectAtIndex:index];
    [self initlizerScrollView:_photoItems];
}

#pragma mark textview delegate

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.labPlaceholder.hidden = NO;
    } else {
        self.labPlaceholder.hidden = YES;
    }

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![text isEqualToString:@""]) {
        if (range.location>140) {
            return NO;
        }
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//提交评论
- (IBAction)commitComment:(id)sender {
    if (self.textView.text.length > 0) {
        [self loadData];
    } else {
        [self.view showHUD:@"请填写评论内容哦"];
    }
}

- (void)loadData {
    NSMutableArray *dataArray = [NSMutableArray array];

    [_imgArray enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL *stop) {
        NSData *imageData = [self imageData:obj];
        NSString *encodedImageStr = [imageData base64Encoding];
        [dataArray addObject:encodedImageStr];
    }];
    Member_commentAddRequest *request = [[Member_commentAddRequest alloc] init];
    request.mid = self.order.order_info.member_id;
    request.info = self.textView.text;
    if (dataArray.count>0) {
        request.imgs = [NSMutableArray arrayWithArray:dataArray];
    }
    request.order_id = [[NSString alloc] initWithFormat:@"%@", self.order.rec_id];
    [self->apiClient doMember_commentAdd:request success:^(NSMutableDictionary *data, NSString *url) {
        //Member_commentAddResponse *response = [[Member_commentAddResponse alloc] fromJSON:data];
        [self.view showHUD:@"评论成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self goBack];
        });

    }];
}
- (UIImage *)scaleFromImage:(UIImage *)image
{
    if (!image) {
        return image;
    }
    NSInteger kb=1024*2;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    NSLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}
-(NSData *)imageData:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        if (data.length>2*1024*1024) {//2M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length>512*1024) {//0.5M-2M
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}

@end
