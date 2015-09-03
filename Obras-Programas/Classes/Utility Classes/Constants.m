//
//  Constants.m
//  Obras-Programas
//
//  Created by Abdiel on 9/25/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "Constants.h"

@implementation Constants

/////////////       SERVER
/******************************************************/

#define kAppBaseProtocol        @"https://"
#define kAppBaseURL             @"obrasapf.mx"
#define kAppBasePort            @""
#define kAppIntranetPath        @"/obras/api"
#define kAppMediaPath           @"/media/"
#define kAppFullURL             kAppBaseProtocol kAppBaseURL kAppBasePort kAppIntranetPath
#define kAppMediaURLBusqueda            kAppBaseProtocol kAppBaseURL kAppBasePort kAppMediaPath
#define kAppMediaURL          kAppBaseProtocol kAppBaseURL kAppBasePort


/////////////       GENERAL
/******************************************************/

NSString * const kDbName = @"oyp";
NSString * const kAppURL = kAppFullURL;
NSString * const kAppURLMediaBusqueda = kAppMediaURLBusqueda;
NSString * const kAppURLMedia = kAppMediaURL;


NSString * const kAppImagenesDependencia =  @"/media/";
NSString * const kAppImagenesObras       =  @"imagenesObras/";

NSString * const kImageNamePlaceHolder = @"no_image.jpg";
NSString * const kClientID = @"nJKmO290WGy5TY4GAmxK23cg8mgTDaYf9bgfE5Mx";
NSString * const kClientSecret = @"Ito4EuoY5hhWuOynPlOxJkgiAguO2tHpFsIZHgkh6HMjN4gHLsOdbOmHxMitMAdJs9FoJS5lK9DiVIiurS6CeocgCVgKHR6JEBt69HY1nsWXaE1bFA7ZpjNQLbrhlgpf";
NSString * const kStoreCredentialIdentifier = @"usuario";

//              Servlets
/******************************************************/

NSString * const kServletBuscar                     = @"busqueda";
NSString * const kServletBuscarUnico                = @"idIpad";
NSString * const kServletEstados                    = @"estados";
NSString * const kServletInauguradores              = @"inauguradores";
NSString * const kServletImpactos                   = @"impactos";
NSString * const kServletPoblacionesObjetivo        = @"consultarPoblacionesObjetivo";
NSString * const kServletConsultarInversiones       = @"inversiones";
NSString * const kServletConsultarClasificacion     = @"clasificaciones";
NSString * const kServletConsultarTipoObraPrograma  = @"tiposDeObra";
NSString * const kServletConsultarDependencias      = @"dependencias";
NSString * const kServletConsultarSubDependencias   = @"subdependenciasiPad";

NSString * const kServletConsultarSubclasificacion  = @"clasificaciones";

//              KEYS TO PERSIST DATA
/******************************************************/

NSString * const kKeyStoreDependencies              =  @"kdp";
NSString * const kKeyStoreSubDependencies              =  @"ksdp";

NSString * const kKeyStoreTypeWorkOrProgram         =  @"ktp";
NSString * const kKeyStoreStates                    =  @"kedo";
NSString * const kKeyStoreCity                      =  @"kmun";
NSString * const kKeyStoreImpact                    =  @"kimp";
NSString * const kKeyStoreClasification             =  @"kcs";
NSString * const kKeyStoreInvesments                =  @"kinv";
NSString * const kKeyStoreInaugurators              =  @"kina";
NSString * const kKeyStoreStartIniDate              =  @"ksid";
NSString * const kKeyStoreStartEndDate              =  @"ksed";
NSString * const kKeyStoreEndIniDate                =  @"keid";
NSString * const kKeyStoreEndEndDate                =  @"keed";
NSString * const kKeyStoreInauguradaOption          =  @"kiopt";
NSString * const kKeyStoreSusceptibleOption         =  @"ksopt";
NSString * const kKeyStoreDenomination              =  @"kdnt";
NSString * const kKeyStoreIDWorkOrProgram           =  @"kiwp";
NSString * const kKeyStoreMaxRange                  =  @"krgmx";
NSString * const kKeyStoreMinRange                  =  @"krgmn";
NSString * const kKeyStoreProgramYear               =  @"kpgy";
NSString * const kKeyStoreSublasificationsData      =  @"ksbsd";
NSString * const kKeyStoreSublasificationsSavedData =  @"ksbssd";
NSString * const kKeyStoreTodoSublasifications      =  @"kstsb";


//              KEYS JSON
/******************************************************/

//Estado

NSString * const kKeyDbIdEstado                 =  @"id";
NSString * const kKeyDbNombreEstado             =  @"nombreEstado";
NSString * const kKeyDbLatitud                  =  @"latitud";
NSString * const kKeyDbLongitud                 =  @"longitud";

//Inaugura
NSString * const kKeyDbIdCargoInaugura          =  @"id";
NSString * const kKeyDbNombreCargoInaugura      =  @"nombreCargoInaugura";


//Impacto
NSString * const kKeyDbIdImpacto                =  @"id";
NSString * const kKeyDbNombreImpacto            =  @"nombreImpacto";

//Clasificación
NSString * const kKeyDbIdClasificacion          =  @"id";
NSString * const kKeyDbNombreClasificacion      =  @"nombreTipoClasificacion";

//Dependencia

NSString * const kKeyDbIdDependencia            =  @"id";
NSString * const kKeyDbNombreDependencia        =  @"nombreDependencia";

//Inversion

NSString * const kKeyDbIdTipoInversion          =  @"id";
NSString * const kKeyDbNombreTipoInversion      =  @"nombreTipoInversion";

//Tipo Obra Programa

NSString * const kKeyDbIdTipoObra               =  @"id";
NSString * const kKeyDbNombreTipoObra           =  @"nombreTipoObra";

//Obras

NSString * const kKeyDbIdObra                   = @"identificador_unico";
NSString * const kKeyDbDenominacion             = @"denominacion";
NSString * const kKeyDbTipoObra                 = @"tipoObra";
NSString * const kKeyDbDependencia              = @"dependencia";
NSString * const kKeyDbEstado                   = @"estado";
NSString * const kKeyDbImpacto                  = @"impacto";
NSString * const kKeyDbTipoInversion            = @"tipoInversion";
NSString * const kKeyDbClasificacion            = @"tipoClasificacion";
NSString * const kKeyDbInaugurador              = @"inaugurador";
NSString * const kKeyDbDescripcion              = @"descripcion";
NSString * const kKeyDbObservaciones            = @"observaciones";
NSString * const kKeyDbFechaInicio              = @"fechaInicio";
NSString * const kKeyDbFechaTermino             = @"fechaTermino";
NSString * const kKeyDbInversionTotal           = @"inversionTotal";
NSString * const kKeyDbSenalizacion             = @"senalizacion";
NSString * const kKeyDbSusceptibleInauguracion  = @"susceptibleInauguracion";
NSString * const kKeyDbPorcentajeAvance         = @"porcentajeAvance";
NSString * const kKeyDbFotoAntes                = @"fotoAntes";
NSString * const kKeyDbFotoDurante              = @"fotoDurante";
NSString * const kKeyDbFotoDespues              = @"fotoDespues";
NSString * const kKeyDbFechaModificacion        = @"fechaModificacion";
NSString * const kKeyDbTotalBeneficiarios       = @"totalBeneficiarios";
NSString * const kKeyDbTipoMoneda               = @"tipoMoneda.nombreTipoDeMoneda";
NSString * const kKeyDbInaugurada               = @"inaugurada";
NSString * const kKeyDbPoblacionObjetivo        = @"poblacionObjetivo";
NSString * const kKeyDbMunicipio                = @"municipio";

//General Response

NSString * const kKeyListaObras                 = @"obras";
NSString * const kKeyListaProgramas             = @"listaProgramas";
NSString * const kKeyListaReporteEstado         = @"reporte_estado";
NSString * const kKeyListaReporteDependencia    = @"reporte_dependencia";
NSString * const kKeyListaReporteGeneral        = @"reporte_general";
NSString * const kKeyListaReporteSubDependencia = @"reporte_subdependencia";


//              Parameters Servlet Search
/******************************************************/

NSString * const kParamDenominacion         = @"denominacion";
NSString * const kParamIdObra               = @"idObra";
NSString * const kParamIdPrograma           = @"idPrograma";
NSString * const kParamBusquedaRapida       = @"busquedaRapida";
NSString * const kParamTipoDeObra           = @"tipoDeObra";
NSString * const kParamDependencia          = @"dependencia";
NSString * const kParamSubDependencia       = @"subdependencias";

NSString * const kParamEstado               = @"estado";
NSString * const kParamInversionMinima      = @"inversionMinima";
NSString * const kParamImversionMaxima      = @"inversionMaxima";
NSString * const kParamTipoDeInversion      = @"tipoDeInversion";
NSString * const kParamFechaInicio          = @"fechaInicio";
NSString * const kParamFechaInicioSegunda   = @"fechaInicioSegunda";
NSString * const kParamFechaFin             = @"fechaFin";
NSString * const kParamFechaFinSegunda      = @"fechaFinSegunda";
NSString * const kParamImpacto              = @"impacto";
NSString * const kParamClasificacion        = @"clasificacion";
NSString * const kParamInaugurador          = @"inaugurador";
NSString * const kParamSusceptible          = @"susceptible";
NSString * const kParamInaugurada           = @"inaugurada";
NSString * const kParamLimiteMin            = @"limiteMin";
NSString * const kParamLimiteMax            = @"limiteMax";
NSString * const kParamSubclasificacion     = @"subclasificacion";
NSString * const kParamAnoPrograma          = @"anoPrograma";

//              Alerts Messages and HUD Messages
/******************************************************/

//Dependencia

NSString * const kHUDMsgLoading          =  @"Buscando...";

@end
