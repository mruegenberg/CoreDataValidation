CoreDataValidation
==================

Validation for Core Data objects

This project provides a simple extension for the `NSEntityDescription` class in Core Data.
If allows you to do some basic validation before creating NSManagedObjects.

Usage:

    #import "NSEntityDescription+DLValidation.h"
    
    // ...
    
    - (void)foo {
        NSEntityDescription *entity = ...;
        NSDictionary *item = ...; // a provisional object from which we intend to build a proper NSManagedObject
        
        NSString *errorProp;
        ValidationError err = [entity validateWith:item errorProperty:&errorProp];
        
        if(err == ValidationErrorNone) {
            // no error. build an object
            NSManagedObjectContext *context = ...; 
            NSManagedObject *obj = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            [obj setValuesForKeysWithDictionary:item];
        }
        else if(err & ValidationErrorMissingValue) {
            NSLog(@"Error: User didn't enter the value for %@", errorProp);
        }
        else if(err & ValidationErrorWrongCardinality) {
            NSLog(@"Error: There are too few or to many items in relationship %@", errorProp);
        }
        else if(err & ValidationErrorMissingRelationship) {
            NSLog(@"Error: Nothing is selected for to-one relationship %@", errorProp);
        }
    }
    
## Contact

![Travis CI build status](https://api.travis-ci.org/mruegenberg/CoreDataValidation.png)

Bug reports and pull requests are welcome! Just write an e-mail or (preferred) open an issue on GitHub.
