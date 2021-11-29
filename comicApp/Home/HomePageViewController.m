//
//  HomePageViewController.m
//  comicApp
//
//  Created by Furkan Özyürek on 23.11.2021.
//

#import "HomePageViewController.h"
#import "DetailsPageViewController.h"
#import "ComicTableViewCell.h"
#import "ComicResponse.h"
//POD
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <NSHash/NSString+NSHash.h>
#import <NSHash/NSData+NSHash.h>


@interface HomePageViewController () <UITableViewDelegate , UISearchBarDelegate , UITableViewDataSource>

@property (nonatomic) ComicResponse *comicResponse;
@property (nonatomic) Thumbnail *thumbnail;
@property (nonatomic) Result *selectedResult;
@property (nonatomic) NSInteger *numOfSections;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getComics:nil];
    self.title = @"MARVEL COMICS";
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1 green:0 blue:0.1 alpha:1];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.searchBar.backgroundColor =[UIColor colorWithRed:1 green:0 blue:0.1 alpha:1];
    self.searchBar.barTintColor =[UIColor colorWithRed:1 green:0 blue:0.1 alpha:1];
    self.searchBar.searchTextField.textColor = [UIColor whiteColor];
}

-(void)getComics:(NSString *)searchText {
    
    NSTimeInterval ts = [[NSDate date]timeIntervalSince1970];
    NSString *tsObj = [[NSNumber numberWithDouble:ts] stringValue];
    NSString *publicKey = @"4146e4ff167820b99352e0304bcdf067";
    NSString *privateKey = @"3688878ee71ac7a9a281fdbf9f28db3984ee63f8";
    NSString *path = [NSString stringWithFormat:@"%@%@%@",tsObj,privateKey,publicKey];
    NSLog(@"PATH: %@",path);
    NSLog(@"MD5 as NSString: %@",[path MD5]);
    NSString *urlPath = [NSString stringWithFormat:@"https://gateway.marvel.com:443/v1/public/comics"];
    NSLog(@"URL PATH: %@",urlPath);
    NSDictionary *request;
    if (searchText != nil && ![searchText isEqualToString:@""]) {
        request = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"50", @"limit",
                                 @"4146e4ff167820b99352e0304bcdf067", @"apikey",
                                 [path MD5], @"hash",
                                 tsObj, @"ts",
                                 searchText, @"title",
                                 nil];
    }
    else {
        request = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"50", @"limit",
                                 @"4146e4ff167820b99352e0304bcdf067", @"apikey",
                                 [path MD5], @"hash",
                                 tsObj, @"ts",
                                 nil];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlPath parameters:request headers:nil progress:nil

        success:^(NSURLSessionTask *task, id responseObject) {

        @try {
            ComicResponse *comic = [[ComicResponse alloc]initWithComic:responseObject];
            self.comicResponse = comic;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
           
            NSLog(@"%@",self.comicResponse);
            if(self.comicResponse.data.results.count == 0){
                NSLog(@"VERI YOKKKK");
                self.numOfSections = 0;
                self.errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
                self.errorLabel.text             = @"No data available";
                self.errorLabel.textColor        = [UIColor blackColor];
                self.errorLabel.textAlignment    = NSTextAlignmentCenter;
                self.tableView.backgroundView = self.errorLabel;
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                [self.errorLabel setHidden:NO];
              
            } else {
                [self.errorLabel setHidden:YES];
                self.numOfSections = 1;
            }
            NSLog(@"RESPONSE OBJECT::::: %@",responseObject);
            NSLog(@"NUM OF SECIONS %d",self.numOfSections);
        } @catch (NSException *exception) {
            NSLog(@"Error: %@",exception);
        }

    }

        failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);

        }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.numOfSections;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.comicResponse.data.results.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ComicTableViewCell *cell = (ComicTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor clearColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    if(indexPath.row % 2 == 0) {
        
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        
        cell.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }
    Result *result = self.comicResponse.data.results[indexPath.row];
    [cell.comicImageView setImage:[UIImage imageNamed:@"comicImage"]];
    cell.comicTitleLabel.text = result.title;
    NSString *formatImage = [NSString stringWithFormat:@"%@.%@",result.thumbnail.path,result.thumbnail.extension];
//TEST URL https://b.thumbs.redditmedia.com/q5wEnBMrwNwf4g9s6Ju35QfuE3cpw4Gjr883zJHGBUY.png
// JSON URL https://i.annihil.us/u/prod/marvel/i/mg/b/40/4bc64020a4ccc.jpg
    NSURL *imgUrl = [NSURL URLWithString:formatImage];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    UIImage *image = [UIImage imageWithData:imgData];
    [cell.comicImageView setImageWithURL:imgUrl];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedResult = [self.comicResponse.data.results objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"detailSegue"]) {
        
        DetailsPageViewController *detailVC = segue.destinationViewController;
        detailVC.selectedResult = self.selectedResult;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self getComics:searchBar.text];
}

@end

