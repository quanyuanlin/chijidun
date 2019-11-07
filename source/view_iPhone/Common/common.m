#import "common.h"

UIColor *getUIColor(int rgbValue) {
    return [UIColor
            colorWithRed:(CGFloat) ((((rgbValue & 0xFF0000) >> 16)) / 255.0)
                   green:(CGFloat) (((CGFloat) ((rgbValue & 0x00FF00) >> 8)) / 255.0)
                    blue:(CGFloat) (((CGFloat) (rgbValue & 0x0000FF)) / 255.0)
                   alpha:1.0];
}
UIColor *getColorWithRGB(float r ,float g ,float b){
    return [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1.0];
}
CALayer *getBorderLayer(CGRect frame, CGFloat borderWidth, int RGBColor) {
    CALayer *borderLayer = [CALayer layer];
    CGRect borderFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer setFrame:borderFrame];
    [borderLayer setCornerRadius:0];
    [borderLayer setBorderWidth:borderWidth];
    [borderLayer setBorderColor:[getUIColor(RGBColor) CGColor]];
    return borderLayer;
}
CALayer *getLine(int X,int toX,int Y,int toY,UIColor *color){
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 0.5f;
    lineShape.lineCap = kCALineCapRound;
    lineShape.strokeColor = color.CGColor;
    CGPathMoveToPoint(linePath, NULL, X, Y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    return lineShape;
}
CALayer *getThinLine(int X,int toX,int Y,int toY,UIColor *color){
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 0.8f;
    lineShape.lineCap = kCALineCapRound;
    lineShape.strokeColor = color.CGColor;
    CGPathMoveToPoint(linePath, NULL, X, Y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    return lineShape;
}
CGFloat getTextHeight(NSString *string, CGFloat width, UIFont *font) {
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName : font}
                                       context:nil].size;
    return size.height;
}
CGSize getTextSize(NSString *string, CGFloat width, UIFont *font) {
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName : font}
                                       context:nil].size;
    return size;
}

int parseInt(id object) {
    return [[NSString alloc] initWithFormat:@"%@", object].intValue;
}

NSString *getAppName() {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return infoDict[@"CFBundleName"];
}

NSString *getAppVersion() {
    //NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return Current_Version;
}

NSString *toNSString(id object) {
    return [[NSString alloc] initWithFormat:@"%@", object];
}

NSString *getToday() {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateformatter stringFromDate:date];
    return today;
}

NSString *getTomorrow() {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:([components day] + 1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    NSString *tomorrow = [dateday stringFromDate:beginningOfWeek];
    return tomorrow;
}

NSDateComponents *dateComp(){
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDate *now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    return comps;
}
NSString *getNowTime() {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *now = [dateformatter stringFromDate:date];
    return now;
}

UITextField *textField(CGRect frame, UIFont *fontSize,NSString *placeholder,NSString *text,BOOL border) {
    UITextField *textfield=[[UITextField alloc]initWithFrame:frame];
    [textfield setBackgroundColor:WHITE_COLOR];
    [textfield setFont:fontSize];
    [textfield setPlaceholder:placeholder];
    if (border) {
        textfield.layer.borderWidth=1.0f;
        textfield.layer.borderColor=COLOR_LIGHT_GRAY.CGColor;
        textfield.layer.cornerRadius=5.0f;
    }
    [textfield setText:text];
    UIView *sview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 30)];
    textfield.leftView=sview;
    textfield.leftViewMode=UITextFieldViewModeAlways;
    return textfield;
}

CGFloat getMiddleY(UIView *view) {
    return CGRectGetMinY(view.frame) + (CGRectGetMaxY(view.frame) - CGRectGetMinY(view.frame)) / 2;
}

double getCoordinateDistance(double lat1, double lng1, double lat2, double lng2) {
    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    double distance = [curLocation distanceFromLocation:otherLocation];
    return distance;
}

NSString *getCoordinateDistanceFormat(double lat1, double lng1, double lat2, double lng2) {
    double distance = getCoordinateDistance(lat1, lng1, lat2, lng2);
    return distanceFormat(distance);
}

NSString *distanceFormat(double distance) {
    if (distance > 1000) {
        return [[NSString alloc] initWithFormat:@"%.2f公里", distance * 0.001];
    } else {
        return [[NSString alloc] initWithFormat:@"%.0f米", distance];
    }
}

void runBlockAfterDelay(NSTimeInterval delay, void (^block)(void)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (NSEC_PER_SEC * delay)),
            dispatch_get_current_queue(), block);
}

NSString *getValue(float money)
{
    int t=(int)money;
    NSString *result=[NSString stringWithFormat:@"%.1f",money];
    if (money==t) {
        result=[NSString stringWithFormat:@"%d",t];
    }
    return result;
}


