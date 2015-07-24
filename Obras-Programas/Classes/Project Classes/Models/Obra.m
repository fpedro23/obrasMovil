//
//  Obra.m
//  Obras-Programas
//
//  Created by Abdiel on 9/25/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Obra.h"
#import "Clasificacion.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation Obra


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"idObra"                  :kKeyDbIdObra,
             @"denominacion"            :kKeyDbDenominacion,
             @"tipoObra"                :kKeyDbTipoObra,
             @"dependencia"             :kKeyDbDependencia,
             @"estado"                  :kKeyDbEstado,
             @"impacto"                 :kKeyDbImpacto,
             @"inversiones"             :kKeyDbTipoInversion,
             @"clasificaciones"         :kKeyDbClasificacion,
             @"inaugurador"             :kKeyDbInaugurador,
             @"descripcion"             :kKeyDbDescripcion,
             @"observaciones"           :kKeyDbObservaciones,
             @"fechaInicio"             :kKeyDbFechaInicio,
             @"fechaTermino"            :kKeyDbFechaTermino,
             @"inversionTotal"          :kKeyDbInversionTotal,
             @"totalBeneficiarios"      :kKeyDbTotalBeneficiarios,
             @"senalizacion"            :kKeyDbSenalizacion,
             @"susceptibleInauguracion" :kKeyDbSusceptibleInauguracion,
             @"porcentajeAvance"        :kKeyDbPorcentajeAvance,
             @"fotoAntesURL"            :kKeyDbFotoAntes,
             @"fotoDuranteURL"          :kKeyDbFotoDurante,
             @"fotoDespuesURL"          :kKeyDbFotoDespues,
             @"fechaModificacion"       :kKeyDbFechaModificacion,
             @"tipoMoneda"              :kKeyDbTipoMoneda,
             @"inaugurada"              :kKeyDbInaugurada,
             @"poblacionObjetivo"       :kKeyDbPoblacionObjetivo,
             @"municipio"               :kKeyDbMunicipio,
             @"subclasificacion"        :@"subclasificacion",
             @"imagenDependencia"       :@"dependencia__imagenDependencia",
             @"estadoBusqueda"          :@"estado__nombreEstado"

             };
}

-(BOOL)isInaugurada{
    return [self.inaugurada boolValue];
}

+ (NSValueTransformer *)inauguradaJSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *str) {
        
        if (str == nil) {
            return [NSNumber numberWithBool:NO];
        }
        else if(![str boolValue]){
            
            return [NSNumber numberWithBool:NO];
        }else
            return [NSNumber numberWithBool:YES];
        
    }reverseBlock:^(NSDate *date) {
        return @"";
    }
    ];
}

+ (NSValueTransformer *)fotoAntesURLJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSURL *imageURL = nil;
        
        if (![str isEqualToString:@"null"]) {
            NSString *imageStrURL = [NSString stringWithFormat:@"%@%@", kAppURLMediaBusqueda, str];
            imageURL = [NSURL URLWithString:imageStrURL];
        }
        
        return imageURL;
        
    } reverseBlock:^(NSDate *date) {
        return @"";
    }];
}

+ (NSValueTransformer *)fotoDuranteURLJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSURL *imageURL = nil;
        
        if (![str isEqualToString:@"null"]) {
            NSString *imageStrURL = [NSString stringWithFormat:@"%@%@", kAppURLMediaBusqueda, str];
            imageURL = [NSURL URLWithString:imageStrURL];
        }
        
        return imageURL;
        
    } reverseBlock:^(NSDate *date) {
        return @"";
    }];
}

+ (NSValueTransformer *)fotoDespuesURLJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSURL *imageURL = nil;
        
        if (![str isEqualToString:@"null"]) {
            NSString *imageStrURL = [NSString stringWithFormat:@"%@%@", kAppURLMediaBusqueda, str];
            imageURL = [NSURL URLWithString:imageStrURL];
        }
        
        return imageURL;
        
    } reverseBlock:^(NSDate *date) {
        return @"";
    }];
}


+ (NSValueTransformer *)fechaModificacionJSONTransformer{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX" ]];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *dateStr) {
        return [dateFormatter dateFromString:dateStr];
    } reverseBlock:^(NSDate *date) {
        return [dateFormatter stringFromDate:date];
    }];
}


+ (NSValueTransformer *)clasificacionesJSONTransformer
{
    // tell Mantle to populate appActions property with an array of ChoosyAppAction objects
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Clasificacion class]];
}

+ (NSValueTransformer *)impactoJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Impacto class]];
}


+ (NSValueTransformer *)estadoJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Estado class]];
}

+ (NSValueTransformer *)tipoObraJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TipoObraPrograma class]];
}

+ (NSValueTransformer *)dependenciaJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Dependencia class]];
}

+ (NSValueTransformer *)inauguradorJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Inaugurador class]];
}

+ (NSValueTransformer *)subclasificacionJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Subclasificacion class]];
}

+ (NSValueTransformer *)imagenDependenciaJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSURL *imageURL = nil;
        
        if (![str isEqualToString:@"null"]) {
            NSString *imageStrURL = [NSString stringWithFormat:@"%@%@", kAppURLMediaBusqueda,  str];
            imageURL = [NSURL URLWithString:imageStrURL];
        }
        
        return imageURL;
        
    } reverseBlock:^(NSDate *date) {
        return @"";
    }];
}

@end
