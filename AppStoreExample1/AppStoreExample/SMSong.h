//
//  SMSong.h
//  AppStoreExample
//
//  Created by Cesare Rocchi on 4/29/14.
//  Copyright (c) 2014 Cesare Rocchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMSong : NSObject

@property (nonatomic, copy, readonly) NSString *trackName;
@property (nonatomic, copy, readonly) NSString *trackImageURL;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
