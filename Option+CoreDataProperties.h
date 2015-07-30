//
//  Option+CoreDataProperties.h
//  QuickPolls
//
//  Created by John Blanchard on 7/28/15.
//  Copyright © 2015 John Blanchard. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Option.h"

NS_ASSUME_NONNULL_BEGIN

@interface Option (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *count;
@property (nullable, nonatomic, retain) Poll *poll;

@end

NS_ASSUME_NONNULL_END
