//
//  ListaGeolocalizacionObras.h
//  Obras-Programas
//
//  Created by Pedro Contreras on 02/09/15.
//  Copyright (c) 2015 Edicomex. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface ListaGeolocalizacionObras : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *denominacion;
@property (nonatomic, strong) NSString *identificadorUnico;

@property (nonatomic, strong) NSNumber *inversionTotal;
@property (nonatomic, strong) NSNumber *latitud;
@property (nonatomic, strong) NSNumber *longitud;


@end
