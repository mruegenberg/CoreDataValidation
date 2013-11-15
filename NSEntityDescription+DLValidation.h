//
//  NSEntityDescription+DLValidation.h
//  Classes
//
//  Created by Marcel Ruegenberg on 15.11.13.
//  Copyright (c) 2013 Dustlab. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

typedef enum {
    ValidationErrorNone = 0,
    ValidationErrorMissingValue = 1 << 0, // a required attribute was not set
    ValidationErrorMissingRelationship = 1 << 1, // a to-one relationship does not have a value
    ValidationErrorWrongCardinality = 1 << 2 // a to-many relationship does not have the right numer of objects set
} ValidationError;

/**
 * Simple validation for Core Data entities. 
 * Check for all required properties whether they are set;
 * includes proper handling of default values, NSNull and to-many relationships.
 */
@interface NSEntityDescription (DLValidation)

// `object` needs to be an object that is KVC (key-value coding)-compatible for all of the entities' keys.
// if multiple error occur, only one of them is returned.
// if an error occured, `errorProperty` is set to the name of the problematic property
- (ValidationError)validateWith:(id)object errorProperty:(NSString **)errorProperty;

@end
