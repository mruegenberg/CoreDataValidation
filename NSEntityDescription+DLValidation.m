//
//  NSEntityDescription+DLValidation.m
//  Classes
//
//  Created by Marcel Ruegenberg on 15.11.13.
//  Copyright (c) 2013 Dustlab. All rights reserved.
//

#import "NSEntityDescription+DLValidation.h"

@implementation NSEntityDescription (DLValidation)

- (ValidationError)validateWith:(id)item errorProperty:(NSString **)errorProperty {
	for(NSPropertyDescription *prop in [self properties]) {
        id val = [item valueForKey:[prop name]];
        if(val == nil || val == [NSNull null]) val = nil;
        if((! [prop isOptional]) &&
           (val == nil || ([val isKindOfClass:[NSString class]] && [val isEqualToString:@""])))
        {
			if([prop isKindOfClass:[NSAttributeDescription class]]) {
				if([(NSAttributeDescription *)prop defaultValue] == nil) {
                    *errorProperty = [prop name];
                    return ValidationErrorMissingValue;
				}
			}
            else if([prop isKindOfClass:[NSRelationshipDescription class]]) {
                if(! [(NSRelationshipDescription *)prop isToMany]) {
                    *errorProperty = [prop name];
                    return ValidationErrorMissingValue;
                }
			}
		}
        else if([prop isKindOfClass:[NSRelationshipDescription class]] &&
                [(NSRelationshipDescription *)prop isToMany] &&
                (([(NSRelationshipDescription *)prop minCount] != 0 &&
                  [(NSRelationshipDescription *)prop minCount] > [[item valueForKey:[prop name]] count]) ||
                 ([(NSRelationshipDescription *)prop maxCount] != 0 &&
                  [(NSRelationshipDescription *)prop maxCount] < [[item valueForKey:[prop name]] count]))) {
                     if([prop isOptional]) continue;
                     *errorProperty = [prop name];
                     return ValidationErrorWrongCardinality;
                     // TODO: separate case for too many
                 }
	}

    return ValidationErrorNone;
}

@end
