//
//  ListaReporteSubDependencia.h
//  Obras-Programas
//
//  Created by Pedro Contreras on 25/07/15.
//  Copyright (c) 2015 Edicomex. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "Dependencia.h"

@interface ListaReporteSubDependencia : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *numeroObras;
@property (nonatomic, strong) NSNumber *totalInvertido;
@property (nonatomic, strong) Dependencia *dependencia;

@end
