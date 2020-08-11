//
//  HXSPerson.h
//  objc-debug
//
//  Created by Helson on 2020/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXSPerson : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) long height;
@property (nonatomic, assign) char c1;
@property (nonatomic, assign) char c2;

@end

NS_ASSUME_NONNULL_END
