//
//  listaReporteGeneral.m
//  Obras-Programas
//
//  Created by Abdiel on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "ListaReporteGeneral.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation ListaReporteGeneral

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"numeroObras"     :@"obras_totales",
             @"totalInvertido"  :@"total_invertido"
             };
}

+ (NSValueTransformer *)numeroObrasJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        
        float value = [str floatValue];
        NSNumber *numero = [NSNumber numberWithFloat:value];
        return numero;
    } reverseBlock:^(NSNumber *numero) {
        return [NSNumber numberWithFloat:0.0];
    }];
}

+ (NSValueTransformer *)totalInvertidoJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        
        float value = [str floatValue];
        NSNumber *total = [NSNumber numberWithFloat:value];
        return total;
    } reverseBlock:^(NSNumber *numero) {
        return [NSNumber numberWithFloat:0.0];
        
    }];
}

@end
