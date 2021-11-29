//
//  HomePageViewController.h
//  comicApp
//
//  Created by Furkan Özyürek on 23.11.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) IBOutlet UILabel *errorLabel;

@end

NS_ASSUME_NONNULL_END
