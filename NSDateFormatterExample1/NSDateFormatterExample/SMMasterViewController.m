//
//  SMMasterViewController.m
//  NSDateFormatterExample
//
//  Created by Cesare Rocchi on 4/30/14.
//  Copyright (c) 2014 Cesare Rocchi. All rights reserved.
//

#import "SMMasterViewController.h"

@interface SMMasterViewController () {
    NSMutableArray *_dates;
}
@end

@implementation SMMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dates = [NSMutableArray array];
    
    NSDate *now = [NSDate date];
    
    for (NSInteger i = 0; i < 5000; i++) {
    
        [_dates addObject:[now dateByAddingTimeInterval:60*i]];
        sleep(0.1);
        
    }
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
    return _dates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDate *date = _dates[indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd HH:mm:ss.SSS"];
    cell.textLabel.text = [dateFormatter stringFromDate:date];
    return cell;
    
}


@end
