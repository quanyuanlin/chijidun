//
//  codeView.m
//  chijidun
//
//  Created by iMac on 15/10/21.
//
//

#import "codeView.h"

@interface codeView ()
{
    UIView *m_clearView;
    UIView *m_backView;
    UIImageView *m_codeView;
    CAShapeLayer *lineShape;
}
@end
@implementation codeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews
{
    m_clearView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
    [m_clearView setBackgroundColor:[UIColor blackColor]];
    [m_clearView setAlpha:0.5];
    [m_clearView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapApproveView:)];
    [m_clearView addGestureRecognizer:gesture];
    [self addSubview:m_clearView];
    
    m_backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width*0.8, kbigCell*1.6)];
    m_backView.center=CGPointMake(kMainScreen_Width*0.5, kMainScreen_Height*0.45);
    [m_backView setBackgroundColor:WHITE_COLOR];
    m_backView.layer.cornerRadius=5.0f;
    [m_backView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapApproveView:)];
    [m_backView addGestureRecognizer:gesture2];
    [self addSubview:m_backView];
    
    CGSize sizeBack=m_backView.frame.size;
    UILabel *labTitle=[[UILabel alloc]initWithFrame:CGRectMake(sizeBack.width*0.3, 0,sizeBack.width*0.4 , kCellHeight)];
    [labTitle setTextAlignment:NSTextAlignmentCenter];
    [labTitle setTextColor:[UIColor blackColor]];
    [labTitle setText:@"扫码分享"];
    [m_backView addSubview:labTitle];
    
    [self addLineViewWith:0 With:sizeBack.width and:kCellHeight and:kCellHeight];
    
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(0, sizeBack.height-1.5*kCellHeight,sizeBack.width, kCellHeight)];
    [lab2 setTextAlignment:NSTextAlignmentCenter];
    [lab2 setTextColor:[UIColor blackColor]];
    [lab2 setText:@"邀请好友扫一扫分享给他"];
    [m_backView addSubview:lab2];
    
    m_codeView=[[UIImageView alloc]initWithFrame:CGRectMake(sizeBack.width*0.2, 2*kCellHeight, sizeBack.width*0.6, sizeBack.width*0.6)];
    [m_backView addSubview:m_codeView];
}
- (void)tapApproveView:(UIGestureRecognizer *)gesture {
    [self removeFromSuperview];
}

-(void)addLineViewWith:(int)x With:(int)toX and:(int)y and:(int)toY
{
    lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 1.0f;
    lineShape.lineCap = kCALineCapRound;
    lineShape.strokeColor = COLOR_LIGHT_GRAY.CGColor;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    [m_backView.layer addSublayer:lineShape];
    
}
-(void)codeViewSetUrl:(NSString *)url
{
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认
    [filter setDefaults];
    
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = url;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    //m_codeView.image = [UIImage imageWithCIImage:outputImage];
    // 5.显示二维码
    m_codeView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
    
    UILongPressGestureRecognizer *gesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    gesture.minimumPressDuration=1.0f;
    gesture.numberOfTouchesRequired = 1;
    m_codeView.userInteractionEnabled=YES;
    [m_codeView addGestureRecognizer:gesture];
}
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
-(void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state==UIGestureRecognizerStateBegan) {
        [UIAlertView_Extend showAlertWithTiTle:@"保存图片?" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"确认"] withCompletionBlock:^(NSInteger index) {
            UIImage *image=m_codeView.image;
            if (image) {
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
        } andCancelBlock:^{
        } ];
    }else{
        return;
    }
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(id)context{
    NSString *msg = nil ;
    if(error != NULL)
    {
        msg = @"保存失败";
        [MBProgressHUD showError:msg];
    }else{
        msg = @"图片已保存" ;
        [MBProgressHUD showSuccess:msg];
    }
}
@end









