//
//  SMMasterViewController.m
//  AppStoreExample
//
//  Created by Cesare Rocchi on 4/29/14.
//  Copyright (c) 2014 Cesare Rocchi. All rights reserved.
//

#import "SMMasterViewController.h"
#import "SMSong.h"

@interface SMMasterViewController () <NSURLConnectionDelegate>
{
    NSMutableArray *_songs;
    NSOperationQueue *_loadImageQueue;
    NSMutableData *_data;
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
    _loadImageQueue = [NSOperationQueue new];
    [self loadSongs];
    
}

- (void) loadSongs {

    NSURL *URL = [NSURL URLWithString:@"https://itunes.apple.com/search?term=jack+johnson"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    __unused NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *jsonParsingError = nil;
    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:_data options:0 error:&jsonParsingError];
    NSArray *songsResult = resultDictionary[@"results"];
    for (NSDictionary *d in songsResult) {
        
        SMSong *song = [[SMSong alloc] initWithDictionary:d];
        [_songs addObject:song];
    }
    
    [self.tableView reloadData];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    SMSong *song = _songs[indexPath.row];
    cell.textLabel.text = song.trackName;
    
    [_loadImageQueue addOperationWithBlock:^{

        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:song.trackImageURL]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imageView.image = [UIImage imageWithData:imageData];
            [cell setNeedsLayout];
            
        });
        
    }];
    
    return cell;
    
}

- (void) loadImage:(NSURL *)URL {

    
    
}

@end
