//
//  DetailsPageViewController.m
//  comicApp
//
//  Created by Furkan Özyürek on 23.11.2021.
//

#import "DetailsPageViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "ComicResponse.h"

@interface DetailsPageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *comicImage;
@property (weak, nonatomic) IBOutlet UILabel *comicTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *formatValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *pageCountValueLabel;

@end

@implementation DetailsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setComicDetails];
}

-(void)setComicDetails {

    NSString *pageCount = [self.selectedResult.pageCount stringValue];
    [self.comicImage setImageWithURL:[NSURL URLWithString:self.selectedResult.resourceURI] placeholderImage:[UIImage imageNamed:@"comicImage"]];
    NSString *formatImage = [NSString stringWithFormat:@"%@.%@",self.selectedResult.thumbnail.path,self.selectedResult.thumbnail.extension];
    NSURL *imgUrl = [NSURL URLWithString:formatImage];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    UIImage *image = [UIImage imageWithData:imgData];
    [self.comicImage setImage: image];
    
    
    
    self.title = self.selectedResult.title;
    if(self.selectedResult.format == nil || [self.selectedResult.format isEqualToString:@""]) {
        self.formatValueLabel.text = @"Format: No Data!";
    } else {
        self.formatValueLabel.text = [NSString stringWithFormat:@"Format: %@",self.selectedResult.format];
    }
    if(self.selectedResult.pageCount == nil) {
        self.pageCountValueLabel.text = @"Page Count: No Data!";
    } else {
        self.pageCountValueLabel.text = [NSString stringWithFormat:@"Page Count: %@",pageCount];
    }
    
    self.comicTitleLabel.text = [NSString stringWithFormat:@"Title: %@",self.selectedResult.title];
}

@end
