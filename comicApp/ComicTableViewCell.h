//
//  ComicTableViewCell.h
//  comicApp
//
//  Created by Furkan Özyürek on 23.11.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComicTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *comicImageView;
@property (weak, nonatomic) IBOutlet UILabel *comicTitleLabel;

@end

NS_ASSUME_NONNULL_END
