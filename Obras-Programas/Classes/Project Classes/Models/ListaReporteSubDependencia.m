//
//  ListaReporteSubDependencia.m
//  Obras-Programas
//
//  Created by Pedro Contreras on 25/07/15.
//  Copyright (c) 2015 Edicomex. All rights reserved.
//

#import "ListaReporteSubDependencia.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation ListaReporteSubDependencia

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"numeroObras"     :@"numero_obras",
             @"totalInvertido"  :@"sumatotal",
             @"dependencia"     :@"subdependencia"
             };
}

+ (NSValueTransformer *)dependenciaJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Dependencia class]];
}

+ (NSValueTransformer *)numeroObrasJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        
        float value = [str floatValue];
        NSNumber *numero = [NSNumber numberWithFloat:value];
        return numero;
    } reverseBlock:^(NSDate *date) {
        return [NSNumber numberWithFloat:0.0];
    }];
}

+ (NSValueTransformer *)totalInvertidoJSONTransformer
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
