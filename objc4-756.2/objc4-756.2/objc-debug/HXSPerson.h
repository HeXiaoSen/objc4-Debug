//
//  HXSPerson.h
//  objc-debug
//
//  Created by Helson on 2020/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXSPerson : NSObject {
    NSString *nickname;
}
@property (nonatomic, copy) NSString *nationality;

+ (void)walk;
- (void)fly;


@end

NS_ASSUME_NONNULL_END
