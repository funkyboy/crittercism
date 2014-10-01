//
//  SMMasterViewController.m
//  AppStoreExample
//
//  Created by Cesare Rocchi on 4/29/14.
//  Copyright (c) 2014 Cesare Rocchi. All rights reserved.
//

#import "SMMasterViewController.h"
#import "SMSong.h"

@interface SMMasterViewController () {
    NSMutableArray *_songs;
}


@end

@implementation SMMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _songs = [NSMutableArray array];
    [self loadSongs];
    
}

- (void) loadSongs {

    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *URL = [NSURL URLWithString:@"https://itunes.apple.com/search?term=jack+johnson"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                      NSArray *songsResult = resultDictionary[@"results"];
                                      
                                      for (NSDictionary *d in songsResult) {
                                          
                                          SMSong *song = [[SMSong alloc] initWithDictionary:d];
                                          [_songs addObject:song];
                                          
                                      }
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          [self.tableView reloadData];
                                          NSLog(@"songs loaded %i", _songs.count);

                                      });
                                      
                                  }];
    
    [task resume];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    SMSong *song = _songs[indexPath.row];
    cell.textLabel.text = song.trackName;
    
    // 1. get reference to a background queue
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2. perform the image loading on the background queue
    dispatch_async(backgroundQueue, ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:song.trackImageURL]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imageView.image = [UIImage imageWithData:imageData];
            [cell setNeedsLayout];
            
        });
        
    });
    
    return cell;
}



@end
