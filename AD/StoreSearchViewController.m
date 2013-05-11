//
//  StoreSearchViewController.m
//  AD
//
//  Created by Edward on 13-5-11.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "StoreSearchViewController.h"
#import<SDWebImage/UIImageView+WebCache.h>
@interface StoreSearchViewController ()

@end

@implementation StoreSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.table setDelegate:self];
        [self.table setDataSource:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"NIHAO";
    [self.table setFrame:CGRectMake(0, 0, 320, 480)];
	[self.view addSubview:_table];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark UITableViewDelegate

- (void)setImageFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath completion:(void (^)(void))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        UIImage *avatar = nil;
        avatar = [UIImage imageWithData:responseData];
        if (avatar) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableViewCell *cell = [_table cellForRowAtIndexPath:indexPath];
                cell.imageView.image = avatar;
                [_table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
            
        }
        
    });
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_table]) {
        return _array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"ILOVEYOU,DONGXUE";
    if ([tableView isEqual:_table]) {
        NSDictionary *dictionary = [_array objectAtIndex:[indexPath row]];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
        }
        
        [cell.imageView setImageWithURL:[[_array objectAtIndex:indexPath.row] objectForKey:@"img_url"] placeholderImage:[UIImage imageNamed:@"user_wde"]];
        return cell;
    }
    return nil;
}
@end
