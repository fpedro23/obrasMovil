//
//  listaReporteEstado.m
//  Obras-Programas
//
//  Created by Abdiel on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "ListaReporteEstado.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation ListaReporteEstado


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"numeroObras"     :@"numeroObras",
             @"totalInvertido"  :@"sumatotal",
             @"estado"          :@"estado"
             };
}

+ (NSValueTransformer *)estadoJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Estado class]];
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
