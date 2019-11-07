

UIColor *getUIColor(int rgbValue);
UIColor *getColorWithRGB(float r ,float g ,float b);

CALayer *getBorderLayer(CGRect frame, CGFloat borderWidth, int RGBColor);

CALayer *getLine(int X,int toX,int Y,int toY,UIColor *color);
CALayer *getThinLine(int X,int toX,int Y,int toY,UIColor *color);

CGFloat getTextHeight(NSString *string, CGFloat width, UIFont *font);
CGSize getTextSize(NSString *string, CGFloat width, UIFont *font);

int parseInt(id object);

NSString *getAppName();

NSString *getAppVersion();

NSString *toNSString(id object);

NSString *getToday();

NSString *getTomorrow();

NSString *getNowTime();

NSDateComponents *dateComp();

UITextField *textField(CGRect frame, UIFont *fontSize,NSString *placeholder,NSString *text,BOOL border);

CGFloat getMiddleY(UIView *view);

double getCoordinateDistance(double lat1, double lng1, double lat2, double lng2);

NSString *getCoordinateDistanceFormat(double lat1, double lng1, double lat2, double lng2);

NSString *distanceFormat(double distance);

void runBlockAfterDelay(NSTimeInterval delay, void (^block)(void));

NSString  *getValue(float money);





