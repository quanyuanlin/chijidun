//
//  VersionTable.m
//  chijidun
//
//  Created by iMac on 16/9/2.
//
//

#import "VersionTable.h"

@implementation VersionTable

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        self.Id = [aDecoder decodeObjectForKey:@"Id"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
        self.up_version = [aDecoder decodeObjectForKey:@"up_version"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.os = [aDecoder decodeObjectForKey:@"os"];
        self.force = [aDecoder decodeObjectForKey:@"force"];
        self.add_time = [aDecoder decodeObjectForKey:@"add_time"];
        self.update_time = [aDecoder decodeObjectForKey:@"update_time"];
        self.app_type = [aDecoder decodeObjectForKey:@"app_type"];
        self.startup_img = [aDecoder decodeObjectForKey:@"startup_img"];
        self.show_time = [aDecoder decodeObjectForKey:@"show_time"];
        self.end_time = [aDecoder decodeObjectForKey:@"end_time"];
        self.ordid = [aDecoder decodeObjectForKey:@"ordid"];
        self.img_link = [aDecoder decodeObjectForKey:@"img_link"];
        self.startup_default_img = [aDecoder decodeObjectForKey:@"startup_default_img"];
        self.show_type = [aDecoder decodeObjectForKey:@"show_type"];
        self.img_title = [aDecoder decodeObjectForKey:@"img_title"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.Id forKey:@"Id"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.version forKey:@"version"];
    [aCoder encodeObject:self.up_version forKey:@"up_version"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.os forKey:@"os"];
    [aCoder encodeObject:self.force forKey:@"force"];
    [aCoder encodeObject:self.add_time forKey:@"add_time"];
    [aCoder encodeObject:self.update_time forKey:@"update_time"];
    [aCoder encodeObject:self.app_type forKey:@"app_type"];
    [aCoder encodeObject:self.startup_img forKey:@"startup_img"];
    [aCoder encodeObject:self.show_time forKey:@"show_time"];
    [aCoder encodeObject:self.end_time forKey:@"end_time"];
    [aCoder encodeObject:self.ordid forKey:@"ordid"];
    [aCoder encodeObject:self.img_link forKey:@"img_link"];
    [aCoder encodeObject:self.startup_default_img forKey:@"startup_default_img"];
    [aCoder encodeObject:self.show_type forKey:@"show_type"];
    [aCoder encodeObject:self.img_title forKey:@"img_title"];
}


@end
