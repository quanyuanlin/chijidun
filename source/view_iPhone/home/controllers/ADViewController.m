//
//  ADViewController.m
//  
//
//  Created by iMac on 16/1/27.
//
//

#import "ADViewController.h"
#define kFooterDistance 0
@interface ADViewController ()
{
    UIImageView *m_imgView;
}
@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *backView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    if (_version==nil) {
        backView.image = [self getLaunchImage];
    }else{
        [backView load:_version.startup_default_img];
    }
    [self.view addSubview:backView];
    
    
    
    if (_version.startup_img.length>0) {
        m_imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
        [m_imgView click:self action:@selector(clickAdImg:)];
        [m_imgView load:_version.startup_img];
        [self.view addSubview:m_imgView];
    }
    
}
-(void)clickAdImg:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:_version.img_title forKey:@"img_title"];
    [[NSUserDefaults standardUserDefaults] setObject:_version.img_link forKey:@"img_link"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.clickAdBlock) {
        self.clickAdBlock();
    }
}
-(UIImage *)getLaunchImage
{
    UIImage *imageP = [self launchImageWithType:@"Portrait"];
    if(imageP) return imageP;
    UIImage *imageL = [self launchImageWithType:@"Landscape"];
    if(imageL) return imageL;
    NSLog(@"获取LaunchImage失败!请检查是否添加启动图,或者规格是否有误.");
    return nil;
}
-(UIImage *)launchImageWithType:(NSString *)type
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = type;
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if([viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            if([dict[@"UILaunchImageOrientation"] isEqualToString:@"Landscape"])
            {
                imageSize = CGSizeMake(imageSize.height, imageSize.width);
            }
            if(CGSizeEqualToSize(imageSize, viewSize))
            {
                launchImageName = dict[@"UILaunchImageName"];
                UIImage *image = [UIImage imageNamed:launchImageName];
                return image;
            }
        }
    }
    return nil;
}


@end
