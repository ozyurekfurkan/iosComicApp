//
//  ComicResponse.h
//  comicApp
//
//  Created by Furkan Özyürek on 23.11.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface Thumbnail : NSObject

@property (nonatomic) NSString *path;
@property (nonatomic) NSString *extension;

-(instancetype) getThumbnail:(NSDictionary*) thumbnail;

@end


@interface Result : NSObject

@property (nonatomic) NSNumber *resultId;
@property (nonatomic) NSNumber *digitalId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSNumber *issueNumber;
@property (nonatomic) NSString *variantDescription;
@property (nonatomic) NSString *resultDescription;
@property (nonatomic) NSString *modified;
@property (nonatomic) NSString *isbn;
@property (nonatomic) NSString *upc;
@property (nonatomic) NSString *diamondCode;
@property (nonatomic) NSString *ean;
@property (nonatomic) NSString *issn;
@property (nonatomic) NSString *format;
@property (nonatomic) NSNumber *pageCount;
@property (nonatomic) NSString *resourceURI;
@property (nonatomic) NSString *path;
@property (nonatomic) NSString *extension;
@property (nonatomic) NSNumber *available;
@property (nonatomic) NSString *collectionURI;
@property (nonatomic) NSString *series;
@property (nonatomic) Thumbnail *thumbnail;

- (NSArray *)getResults:(NSArray *)results;

@end

@interface Data : NSObject

@property (nonatomic) NSNumber *offset;
@property (nonatomic) NSNumber *limit;
@property (nonatomic) NSNumber *total;
@property (nonatomic) NSNumber *count;
@property (nonatomic) NSArray<Result *> *results;

- (instancetype)initWithData:(NSDictionary*)data;

@end

@interface ComicResponse : NSObject

@property(nonatomic) NSNumber *code;
@property(nonatomic) NSString *status;
@property(nonatomic) NSString *copyright;
@property(nonatomic) NSString *attributionText;
@property(nonatomic) NSString *attributionHTML;
@property(nonatomic) NSString *etag;
@property(nonatomic) Data *data;

-(instancetype)initWithComic:(NSDictionary *)comic;

@end

NS_ASSUME_NONNULL_END
