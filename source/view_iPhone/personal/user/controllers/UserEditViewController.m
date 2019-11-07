#import "UserEditViewController.h"
#import "UIImageView+Extend.h"
#import "ApiClient.h"

@implementation UserEditViewController
- (void)viewWillAppear:(BOOL)animated {
    self.user = [[App shared] currentUser];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.view.layer addSublayer:getLine(0, kMainScreen_Width, 64, 64, BORDER_COLOR)];
    
    self.backend = [UserBackend shared];
    self.title = @"我的资料";
    self.navigationItem.leftBarButtonItem = [self tbarBackButton];

    UIBarButtonItem *rbtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveEdit)];
    rbtn.tintColor = TEXT_COLOR_BLACK;
    self.navigationItem.rightBarButtonItem = rbtn;

    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.backgroundColor = BG_COLOR;
}


- (void)saveEdit {
    self.user.card_id = self.tfSFZ.text;
    self.user.email = self.tfEmail.text;
    self.user.name = self.tfName.text;
    self.user.birthday = self.tfBirthday.text;
    self.user.sex = [NSString stringWithFormat:@"%ld", (long) segmentedControl.selectedSegmentIndex];
    self.user.intro = self.tfDesc.text;
    [[self.backend requestSaveUser:self.user] subscribeNext:[self didUpdate:@"保存成功" withTableView:self.tableView]];
    //[self.backend clearStore];
    [self.backend.repository storage:self.user];
    [[App shared] setCurrentUser:self.user];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return 10.0f;
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 10)];
    [header setBackgroundColor:WHITE_COLOR];
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *_cell = [[UITableViewCell alloc] init];

    if (indexPath.row == 0) {

        UILabel *lb = [UILabel new];
        lb.text = @"头像:";
        [_cell addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cell).offset(20);
            make.centerY.equalTo(_cell);
        }];

        userImage = [[UIImageView alloc]init];
        userImage.layer.cornerRadius = 20;
        userImage.layer.masksToBounds = YES;
        [userImage load:self.user.avatarimg];
        [_cell addSubview:userImage];
        [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lb.mas_right).offset(40);
            make.centerY.equalTo(lb);
            make.height.equalTo(@40);
            make.width.equalTo(@40);
        }];
        [self addListener:userImage action:@selector(avatarTapped)];
    }

    if (indexPath.row == 1) {
        UILabel *lb = [UILabel new];
        lb.text = @"用户名:";
        [_cell addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cell).offset(20);
            make.centerY.equalTo(_cell);
        }];

        self.tfName = [UITextField new];
        self.tfName.placeholder = @"请输入用户名";
        self.tfName.text = self.user.name;
        self.tfName.delegate = self;
        [_cell addSubview:self.tfName];
        [self.tfName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lb.mas_right).offset(20);
            make.centerY.equalTo(lb);
            make.height.equalTo(_cell);
        }];

    }
    else if (indexPath.row == 2) {
        UILabel *lb = [UILabel new];
        lb.text = @"手机:";
        [_cell addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cell).offset(20);
            make.centerY.equalTo(_cell);
        }];

        UILabel *lbzh = [UILabel new];
        lbzh.text = [NSString stringWithFormat:@"%@", self.user.tele];
        [_cell addSubview:lbzh];

        [lbzh mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lb.mas_right).offset(40);
            make.centerY.equalTo(lb);
            make.height.equalTo(_cell);
        }];
    }
    else if (indexPath.row == 3) {
        UILabel *lb = [UILabel new];
        lb.text = @"性别:";
        [_cell addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cell).offset(20);
            make.centerY.equalTo(_cell);
        }];

        segmentedControl = [UISegmentedControl new];
        [segmentedControl insertSegmentWithTitle:@"女" atIndex:0 animated:YES];
        [segmentedControl insertSegmentWithTitle:@"男" atIndex:1 animated:YES];
        [segmentedControl setTintColor:MAIN_COLOR];
        segmentedControl.selectedSegmentIndex = [[[NSDecimalNumber alloc] initWithString:self.user.sex] integerValue];//设置默认选择项索
        [_cell addSubview:segmentedControl];
        [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lb.mas_right).offset(40);
            make.centerY.equalTo(lb);
            make.height.equalTo(@25);
            make.width.equalTo(@80);
        }];
    }
    else if (indexPath.row == 4) {
        UILabel *lb = [UILabel new];
        lb.text = @"地区:";
        [_cell addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cell).offset(20);
            make.centerY.equalTo(_cell);
        }];
        self.lbArea = [UILabel new];

        if (self.user.provence) {
            self.lbArea.text = [NSString stringWithFormat:@"%@ %@ %@", self.user.provence, self.user.city, self.user.area];
        }


        [_cell addSubview:self.lbArea];
        [self.lbArea mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lb.mas_right).offset(40);
            make.centerY.equalTo(lb);
            make.height.equalTo(_cell);
        }];
    }
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return _cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        if (locatePicker==nil) {
            locatePicker = [[TAreaPickerView alloc] initWithStyle:TAreaPickerWithStateAndCityAndDistrict frame:self.view.frame delegate:self];
            [locatePicker showInView:self.view];
        }else{
            [locatePicker showInView:self.view];
        }
    }
}

#pragma mark - TextField delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - HZAreaPicker delegate
- (void)pickerDidTapedOKBtn:(TAreaPickerView *)picker {
    self.user.provence = picker.locate.state;
    self.user.city = picker.locate.city;
    self.user.area = picker.locate.district;
    self.lbArea.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    [picker cancelPicker];
}

#pragma mark camera utility

- (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isRearCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL)doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *) kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)canUserPickVideosFromPhotoLibrary {
    return [self
            cameraSupportsMedia:(__bridge NSString *) kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)canUserPickPhotosFromPhotoLibrary {
    return [self
            cameraSupportsMedia:(__bridge NSString *) kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType {
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *) obj;
        if ([mediaType isEqualToString:paramMediaType]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
#define ORIGINAL_MAX_WIDTH 640.0f

- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;

        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;

        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;

    [sourceImage drawInRect:thumbnailRect];

    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) NSLog(@"could not scale image");

    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = info[@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        CGFloat width = super.view.frame.size.width;
        CGFloat height = super.view.frame.size.height;
        CGFloat top = (height - 200.0f) / 2.0f;
        CGFloat left = (width - 200.0f) / 2.0f;
        // 裁剪
        XZImageCropperViewController *imgEditorVC = [[XZImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(left, top, 200.0f, 200.0f) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self.navigationController presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];

    }];
}

- (void (^)(RACTuple *))didUpLoad {
    @weakify(self)
    return ^(RACTuple *parameters) {
        @strongify(self)
        ResponseResult *rs = (ResponseResult *) parameters;
        if (rs.success) {
        }
        else {
            [self.view showHUD:rs.messge];
        }

    };
}

//手动实现图片压缩，可以写到分类里，封装成常用方法。按照大小进行比例压缩，改变了图片的size。
- (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage scale:(double)imageScale {
    UIImage *thumbnail = nil;
    //CGSize imageSize = CGSizeMake(srcImage.size.width * imageScale, srcImage.size.height * imageScale);
    CGSize imageSize = CGSizeMake(100, 100);
    if (srcImage.size.width != imageSize.width || srcImage.size.height != imageSize.height) {
        UIGraphicsBeginImageContext(imageSize);
        CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
        [srcImage drawInRect:imageRect];
        thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else {
        thumbnail = srcImage;
    }
    return thumbnail;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^() {
    }];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

}

#pragma mark XZImageCropperDelegate

- (void)imageCropper:(XZImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {

    NSData *data = UIImageJPEGRepresentation(editedImage, 0.5);

    while ([data length] / 1024 > 300) {
        data = UIImageJPEGRepresentation(editedImage, 0.5);
    }
    NSString *_encodedImageStr = [data base64Encoding];

    self.user.avatarimg = _encodedImageStr;

    [[self.backend requestUpdateUserAvatar:self.user] subscribeNext:[self didUpdate]];

    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void (^)(RACTuple *))didUpdate {
    @weakify(self)
    return ^(RACTuple *parameters) {
        @strongify(self)
        ResponseResult *rs = (ResponseResult *) parameters;
        if (rs.success) {

            [userImage sd_setImageWithURL:[NSURL URLWithString:self.user.avatarimg]];

            self.user.avatarimg = rs.strdata;
            [[UserRepository shared] clearUserStore];
            [[UserRepository shared] storage:self.user];
            [[App shared] setCurrentUser:self.user];
            [self.tableView reloadData];
            [self.view showHUD:@"更新成功"];
            if ([_delegate respondsToSelector:@selector(userDidChangeData)]) {
                [_delegate userDidChangeData];
            }
        }
        else {
            [self.view showHUD:rs.messge];
        }
    };
}


- (void)imageCropperDidCancel:(XZImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)avatarTapped {
    UIActionSheet *headIconAction = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    //显示控件
    [headIconAction showInView:self.view];
}

#pragma mark - 实现UIActionSheetDelegate协议的方法

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //[self customizeInterface];
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.navigationBar.tintColor = [UIColor blackColor];
            controller.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor blackColor],
            };
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *) kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self.navigationController presentViewController:controller
                                                    animated:YES
                                                  completion:^(void) {
                                                      NSLog(@"Picker View Controller is presented");
                                                  }];
        }

    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.navigationBar.tintColor = [UIColor blackColor];
            controller.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor blackColor],
            };

            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *) kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self.navigationController presentViewController:controller
                                                    animated:YES
                                                  completion:^(void) {
                                                      NSLog(@"Picker View Controller is presented");
                                                  }];
        }
    }
}

@end



