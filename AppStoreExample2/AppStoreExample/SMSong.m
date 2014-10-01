//
//  SMSong.m
//  AppStoreExample
//
//  Created by Cesare Rocchi on 4/29/14.
//  Copyright (c) 2014 Cesare Rocchi. All rights reserved.
//

#import "SMSong.h"

@implementation SMSong

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    
    if (self) {
        
        _trackName = dictionary[@"trackName"];
        _trackImageURL = dictionary[@"artworkUrl60"];
        
    }
    
    return self;
    
}

@end
