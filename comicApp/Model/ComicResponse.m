//
//  ComicResponse.m
//  comicApp
//
//  Created by Furkan Özyürek on 23.11.2021.
//

#import "ComicResponse.h"

@implementation Result

- (NSArray *)getResults:(NSArray *)results {
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    for (NSDictionary *result in results) {
        Result *resultModel =[[Result alloc] init];
        resultModel.title = [result valueForKey:@"title"];
        resultModel.format =  [result valueForKey:@"format"];
        resultModel.pageCount =  [result valueForKey:@"pageCount"];
        [resultList addObject:resultModel];
    }
    
    return [NSArray arrayWithArray:resultList];
}

@end

@implementation Data
 
-(instancetype) initWithData:(NSDictionary*) data {

    self.count = [data valueForKey:@"count"];
    self.limit = [data valueForKey:@"limit"];
    self.offset = [data valueForKey:@"offset"];
    self.total = [data valueForKey:@"total"];
    self.results = [[Result alloc] getResults:[data valueForKey:@"results"]];

    return self;
}


@end

@implementation ComicResponse

-(instancetype) initWithComic:(NSDictionary *) comic {
   
    self.attributionHTML = [comic valueForKey:@"attributionHTML"];
    self.code = [comic valueForKey:@"code"];
    self.status = [comic valueForKey:@"status"];
    self.copyright = [comic valueForKey:@"copyright"];
    self.attributionText = [comic valueForKey:@"attributionText"];
    self.etag = [comic valueForKey:@"etag"];
    self.data = [[Data alloc]initWithData:[comic objectForKey:@"data"]];
   
   return self;
}


@end
