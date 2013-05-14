//
//  SetCityViewController.m
//  AD
//
//  Created by Edward on 13-5-13.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "SetCityViewController.h"
//#import "NSString+SortedString.h"
//#import "pinyin.h"

@interface SetCityViewController ()

@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSArray *citySourceArray;
@property (nonatomic, retain) NSArray *searchResultArray;
@property (nonatomic, retain) NSMutableArray *sectionArray;
@property (nonatomic, retain) NSIndexPath *lastIndexPath;
@property (nonatomic, copy) NSString *currentCity;
@end

@implementation SetCityViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lastIndexPath = nil;
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar = search;
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    [_searchBar sizeToFit];
    
    UISearchDisplayController *searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    self.searchController = searchDisplay;
    self.searchController.delegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.delegate = self;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.table = tableView;
    self.table.tableHeaderView = _searchBar;
    [self.table setDelegate:self];
    [self.table setDataSource:self];
    [self.table setContentSize:CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] applicationFrame]), CGRectGetHeight([[UIScreen mainScreen] applicationFrame])-70.0)];
    self.table.contentOffset = CGPointMake(0, CGRectGetHeight(_searchBar.bounds));
    [self.view setBackgroundColor:[UIColor blueColor]];
	[self.view addSubview:_table];
    
    
    
    //__weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cityPlist = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        NSArray *allCityArray = [NSArray arrayWithContentsOfFile:cityPlist];
        self.citySourceArray = allCityArray;
        UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
        NSMutableArray *unsortedSections = [NSMutableArray arrayWithCapacity:[[collation sectionTitles]count]];
        for (NSUInteger i=0; i<[[collation sectionTitles] count]; i++) {
            [unsortedSections addObject:[NSMutableArray arrayWithCapacity:0]];
        }
        
        for (NSString *cityName in allCityArray) {
            NSInteger index = [collation sectionForObject:cityName collationStringSelector:@selector(description)];
            [[unsortedSections objectAtIndex:index] addObject:cityName];
        }
        
        self.sectionArray = [NSMutableArray arrayWithCapacity:unsortedSections.count];
        for (NSMutableArray *section in unsortedSections) {
            [_sectionArray addObject:[collation sortedArrayFromArray:section collationStringSelector:@selector(description)]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
    });
    
    
    if ([US objectForKey:CITYKEY]) {
        self.title = [US objectForKey:CITYKEY];
    } else {
        self.title = nil;
    }
}
- (void)setCurrentCity:(NSString *)currentCity {
    NSLog(@"NewCity:%@",currentCity);
    if (currentCity != _currentCity) {
        //[_currentCity release];
        _currentCity = [currentCity copy];
        self.title = _currentCity;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITableViewDelegate
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //NSLog(@"%s",__func__);
    NSArray *sectonIndexTitlesArray = nil;
    if ([tableView isEqual:self.table]) {
        if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
            sectonIndexTitlesArray = nil;
        } else {
            sectonIndexTitlesArray = [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
        }
    }
    return sectonIndexTitlesArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    //NSLog(@"%s",__func__);
    if ([title isEqualToString:UITableViewIndexSearch]) {
        return NSNotFound;
    } else {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index]-1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSLog(@"%s",__func__);
    NSUInteger sections = 0;

        if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
            sections = 1;
        } else {
            sections = _sectionArray.count;
        }

    return sections;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%s",__func__);
    NSUInteger rows = 0;

        if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
            rows = _searchResultArray.count;
        } else {
            rows = [[_sectionArray objectAtIndex:section] count];
        }

    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //NSLog(@"%s",__func__);
    NSString *title = nil;
        if ([tableView isEqual:self.searchDisplayController.searchResultsTableView ]) {
            title = nil;
        } else {
            if ([[self.sectionArray objectAtIndex:section] count] > 0) {
                title = [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
            } else {
            
                title = nil;
            }
            
        }
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"ILOVEYOU,DONGXUE";
    UITableViewCell *cell = nil;
    
    UITableViewCell *lastCellInSearchResultTableView = nil,
                    *currentCellInSearchResultTableView = nil,
                    *lastCellInNormalTableView = nil,
                    *currentCellInNormalTableView = nil;
    
        @autoreleasepool {
            if([tableView isEqual:self.searchDisplayController.searchResultsTableView ]){
                cell = [tableView dequeueReusableCellWithIdentifier:CellID];
                if(!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
                }
                cell.textLabel.text = [_searchResultArray objectAtIndex:indexPath.row];
                lastCellInSearchResultTableView = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:_lastIndexPath];
                currentCellInSearchResultTableView = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
                
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:CellID];
                if(!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
                }
                cell.textLabel.text = [[_sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                lastCellInNormalTableView = [tableView cellForRowAtIndexPath:_lastIndexPath];
                currentCellInNormalTableView = [tableView cellForRowAtIndexPath:indexPath];
                }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        if (lastCellInSearchResultTableView == lastCellInNormalTableView) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

        if ([cell.textLabel.text isEqualToString:[US objectForKey:CITYKEY]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
            BOOL isSlected = [[self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:self.lastIndexPath]accessoryType] == UITableViewCellAccessoryCheckmark ? YES : NO;
            
            //当前选择的行与上一次不同
            if (![indexPath isEqual:self.lastIndexPath]) {
                UITableViewCell *newCell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
                newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                self.currentCity = [_searchResultArray objectAtIndex:indexPath.row];
                [US setObject:_currentCity forKey:CITYKEY];
                
                UITableViewCell *oldCell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:_lastIndexPath];
                oldCell.accessoryType = UITableViewCellAccessoryNone;
                self.lastIndexPath = indexPath;
            }
            else {
                UITableViewCell *newCell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
                if (isSlected) {
//                    self.currentCity = @"";
//                    [US removeObjectForKey:CITYKEY];
//                    newCell.accessoryType = UITableViewCellAccessoryNone;
                    
                } else {
                    newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                    self.currentCity = [_searchResultArray objectAtIndex:indexPath.row];
                    [US setObject:_currentCity forKey:CITYKEY];
                }
            }
        [self.searchDisplayController.searchResultsTableView reloadData];
        }
        else {
            //[tableView mo];
            BOOL isSelected = [[tableView cellForRowAtIndexPath:self.lastIndexPath] accessoryType] == UITableViewCellAccessoryCheckmark ? YES : NO;
            if (!(indexPath.row==_lastIndexPath.row && indexPath.section == _lastIndexPath.section)) {
                UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
                newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                self.currentCity = [[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                [US setObject:_currentCity forKey:CITYKEY];
                
                UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastIndexPath];
                oldCell.accessoryType = UITableViewCellAccessoryNone;
                self.lastIndexPath = indexPath;
            } else {
                UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
                if (isSelected) {
//                    self.currentCity = @"";
//                    [US removeObjectForKey:CITYKEY];
//                    newCell.accessoryType = UITableViewCellAccessoryNone;
                } else {
                    newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                    self.currentCity = [[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    [US setObject:_currentCity forKey:CITYKEY];
                    
                }
            }
        }
    [self.table reloadData];
    [US synchronize];
}

#pragma mark -
#pragma mark - UISearchBarDelegate
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    if ([controller isEqual:self.searchDisplayController]) {
        
    }
}
- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    self.searchResultArray = [self.citySourceArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[cd]%@",searchText]];
    if ([_searchResultArray count] > 0) {
        
    }

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}
@end
