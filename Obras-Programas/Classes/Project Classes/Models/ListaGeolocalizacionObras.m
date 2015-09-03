//
//  ListaGeolocalizacionObras.m
//  Obras-Programas
//
//  Created by Pedro Contreras on 02/09/15.
//  Copyright (c) 2015 Edicomex. All rights reserved.
//

#import "ListaGeolocalizacionObras.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "MTLValueTransformer.h"

@implementation ListaGeolocalizacionObras

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"denominacion"     :@"denominacion",
             @"inversionTotal"  :@"inversionTotal",
             @"latitud"     :@"latitud",
             @"longitud"     :@"longitud",
             };
}



+ (NSValueTransformer *)inversionTotalJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        
        float value = [str floatValue];
        NSNumber *numero = [NSNumber numberWithFloat:value];
        return numero;
    } reverseBlock:^(NSDate *date) {
        return [NSNumber numberWithFloat:0.0];
    }];
}

+ (NSValueTransformer *)latitudJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        
        float value = [str floatValue];
        NSNumber *total = [NSNumber numberWithFloat:value];
        return total;
    } reverseBlock:^(NSDate *date) {
        return [NSNumber numberWithFloat:0.0];
    }];
}


+ (NSValueTransformer *)longitudJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        
        float value = [str floatValue];
        NSNumber *total = [NSNumber numberWithFloat:value];
        return total;
    } reverseBlock:^(NSDate *date) {
        return [NSNumber numberWithFloat:0.0];
    }];
}

@end
