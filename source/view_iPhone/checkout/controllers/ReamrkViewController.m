//
//  ReamrkViewController.m
//  chijidun
//
//  Created by iMac on 16/11/14.
//
//

#import "ReamrkViewController.h"

#define kReamrkTag 200
#define TextViewH S(225)
#define ItemH 35
#define kMaxCharacterCount 50
@interface ReamrkViewController ()
{
    UIScrollView *m_scrollView;
    UIButton *m_rightBtn;
    
    UITextView *m_textView;
    UILabel *_labPlaceHolder;
    
    NSMutableArray *m_arrayRemark;
    
    UILabel *m_labFooter;
}
@end

@implementation ReamrkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"填写备注";
    self.navigationItem.leftBarButtonItem = [self tbarBackButton];
    [self.navigationController.view.layer addSublayer:getLine(0, kMainScreen_Width, NAV_HEIGHT, NAV_HEIGHT, BORDER_COLOR)];

    m_arrayRemark=[NSMutableArray arrayWithArray:_selectArrsys];
    [self setMainView];
}
-(void)setMainView
{
    m_rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [m_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [m_rightBtn.titleLabel setFont:[UIFont LightFontOfSize:15]];
    [m_rightBtn setTitleColor:RED_COLOR forState:UIControlStateNormal];
    [m_rightBtn addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:m_rightBtn];
    
    m_scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [m_scrollView setBackgroundColor:BG_COLOR];
    [m_scrollView click:self action:@selector(removeKeyBorard:)];
    [self.view addSubview:m_scrollView];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(kMainScreen_Width*0.1, S(25), kMainScreen_Width*0.8, 15)];
    [label1 setText:@"——  快速选择备注  ——"];
    [label1 setTextColor:TEXT_LIGHT];
    [label1 setFont:[UIFont LightFontOfSize:14]];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [m_scrollView addSubview:label1];
   
    
    CGFloat itemY=CGRectGetMaxY(label1.frame)+S(20);
    CGFloat itemX=kDistance;
    
    for (int i=0; i<self.remark_list.count; i++) {
        NSArray *array=self.remark_list[i];
        if (array.count==1) {
            RemarkTable *item=array[0];
            UIButton *button=[[UIButton alloc]init];
            CGFloat width=getTextSize(item.title, kMainScreen_Width, [UIFont LightFontOfSize:14]).width+2*kDistanceMin;
            if (itemX+width+kDistance>kMainScreen_Width) {
                itemX=kDistance;
                itemY=itemY+ItemH+kDistance;
            }
            [button setFrame:CGRectMake(itemX, itemY, width, ItemH)];
            [button setTitle:item.title forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont LightFontOfSize:14]];
            [button setTitleColor:TEXT_MIDDLE forState:UIControlStateNormal];
            [button setTitleColor:WHITE_COLOR forState:UIControlStateSelected];
            button.layer.cornerRadius=5.0f;
            button.layer.masksToBounds=YES;
            button.adjustsImageWhenHighlighted=NO;
            [button setBackgroundImage:[UIImage imageWithColor:WHITE_COLOR] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:MAIN_COLOR] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag=i+kReamrkTag;
            for (RemarkTable *remak in m_arrayRemark) {
                if ([item.rid isEqualToString:remak.rid]) {
                    [button setSelected:YES];
                }
            }
            [m_scrollView addSubview:button];            
            itemX=itemX+width+kDistance;
        }else{
            
            CGFloat width = 0.0;
            for (RemarkTable *item in array) {
                width=width+getTextSize(item.title, kMainScreen_Width, [UIFont LightFontOfSize:14]).width+2*kDistanceMin;
            }
            if (itemX+width+kDistance>kMainScreen_Width) {
                itemX=kDistance;
                itemY=itemY+ItemH+kDistance;
            }
            RemarkButtonView *buttonsView=[[RemarkButtonView alloc]initWithFrame:CGRectMake(itemX, itemY, width, ItemH)];
            buttonsView.selectArrays=[NSArray arrayWithArray:m_arrayRemark];
            buttonsView.selectBlock=^(RemarkTable *item,BOOL select){
                if (select) {
                    [m_arrayRemark addObject:item];
                }else{
                    [m_arrayRemark removeObject:item];
                }
                [self printRemark];
            };
            [buttonsView setButtons:array];
            [m_scrollView addSubview:buttonsView];
            itemX=itemX+width+kDistance;
        }
        
    }
    
    CGFloat Y=itemY+S(40)+ItemH;
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(kMainScreen_Width*0.1, Y, kMainScreen_Width*0.8, 15)];
    [label2 setText:@"——  您也可以输入您的其他要求  ——"];
    [label2 setTextColor:TEXT_LIGHT];
    [label2 setFont:[UIFont LightFontOfSize:14]];
    [label2 setTextAlignment:NSTextAlignmentCenter];
    [m_scrollView addSubview:label2];
    
    m_textView=[[UITextView alloc]initWithFrame:CGRectMake(kDistance, CGRectGetMaxY(label2.frame)+S(20), kMainScreen_Width-2*kDistance, TextViewH)];
    m_textView.textContainerInset = UIEdgeInsetsMake(kDistance,kDistance, kDistance, kDistance);
    m_textView.scrollEnabled=NO;
    m_textView.returnKeyType=UIReturnKeyDone;
    m_textView.delegate=self;
    [m_textView setBackgroundColor:WHITE_COLOR];
    m_textView.layer.borderColor=BORDER_COLOR.CGColor;
    m_textView.layer.cornerRadius=4.0f;
    m_textView.layer.borderWidth=1.0f;
    [m_textView setFont:[UIFont LightFontOfSize:15]];
    [m_textView setTextColor:TEXT_DEEP];
    [m_scrollView addSubview:m_textView];
    [self addKeyboardNote:CGRectGetMaxY(m_textView.frame)];
    
    _labPlaceHolder=[[UILabel alloc]initWithFrame:CGRectMake(20, kDistance, 200, 20)];
    [_labPlaceHolder setTextColor:getUIColor(0xcccccc)];
    [_labPlaceHolder setFont:[UIFont LightFontOfSize:15]];
    [_labPlaceHolder setText:@"还可以填写一些其它的要求"];
    [m_textView addSubview:_labPlaceHolder];
    _labPlaceHolder.hidden=NO;
    if (_remarkText.length>0) {
        [m_textView setText:_remarkText];
        _labPlaceHolder.hidden=YES;
    }

    m_labFooter=[[UILabel alloc]initWithFrame:CGRectMake(W(m_textView)-kDistance-200, H(m_textView)-kDistance-15, 200, 15)];
    [m_labFooter setTextAlignment:NSTextAlignmentRight];
    [m_labFooter setTextColor:TEXT_LIGHT];
    [m_labFooter setFont:[UIFont LightFontOfSize:12]];
    [m_labFooter setText:@"50个字"];
    [m_textView addSubview:m_labFooter];
    
    CGFloat height=CGRectGetMaxY(m_textView.frame)+20+NAV_HEIGHT;
    if (height>kMainScreen_Height) {
        [m_scrollView setContentSize:CGSizeMake(kMainScreen_Width, height)];
    }
}
-(void)removeKeyBorard:(id)sender
{
    [m_textView resignFirstResponder];
}


-(void)rightBarButtonClick:(id)sender
{
    if (self.selectBlock) {
        self.selectBlock(m_textView.text,m_arrayRemark);
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self goBack];
    });
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)buttonClicked:(UIButton *)button
{
    button.selected=!button.selected;
    
    NSArray *array=_remark_list[button.tag-kReamrkTag];
    RemarkTable *item=array[0];
    if (button.selected) {
        [m_arrayRemark addObject:item];
    }else{
        [m_arrayRemark removeObject:item];
    }
    [self printRemark];
}
-(void)printRemark
{
    NSMutableArray *array=[NSMutableArray array];
    for (RemarkTable *item in m_arrayRemark) {
        [array addObject:item.title];
    }
    NSString *remark=[array componentsJoinedByString:@","];
    NSLog(@"%@",remark);
}
-(void)textViewDidChange:(UITextView *)textView
{
    NSInteger number = [textView.text length];
    if (number > kMaxCharacterCount) {
        textView.text = [textView.text substringToIndex:kMaxCharacterCount];
        number = kMaxCharacterCount;
        NSUInteger num=50-number;
        [m_labFooter setText:[NSString stringWithFormat:@"还可以输入%lu字",(unsigned long)num]];
    }else{
        NSUInteger num=50-number;
        [m_labFooter setText:[NSString stringWithFormat:@"还可以输入%lu字",(unsigned long)num]];
    }
    if (textView.text.length>0) {
        [_labPlaceHolder setHidden:YES];
    }else{
        [_labPlaceHolder setHidden:NO];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text{
    if ([text isEqualToString:@"\n"]) {
        [m_textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length>=50) {
        if (text.length == 0) {
            return YES;
        }
        return NO;
    }
    return YES;
}


@end








