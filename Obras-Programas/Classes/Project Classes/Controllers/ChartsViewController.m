//
//  ChartsViewController.m
//  Prueba Graficas
//
//  Created by Pedro Contreras Nava on 02/10/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "ChartsViewController.h"
#import <ShinobiCharts/ShinobiCharts.h>
#import "ColumnChartDataSource.h"
#import "PieChartDataSource.h"
#import <ShinobiCharts/SChartCanvas.h>


@interface ChartsViewController ()
@property NSNumberFormatter *currencyFormatter;

@end

@implementation ChartsViewController
@synthesize _chart;
@synthesize _diccionario;
@synthesize columnDataSource;
@synthesize _donutChart;
@synthesize _pieChart;
@synthesize _barChart;
@synthesize pieDataSource;
@synthesize lineView;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //_diccionario = @{@"2012": @{@"CONACYT" : @5.65, @"CONAGUA" : @12.6, @"CFE" : @8.4},
    //                @"2013": @{@"CONACYT" : @4.35, @"CONAGUA" : @13.2, @"CFE" : @4.6, @"IMSS" : @0.6}};
    
    
    
    columnDataSource = [[ColumnChartDataSource alloc]initWithData:_diccionario displayReporte:@"totalInvertido"];
    pieDataSource = [[PieChartDataSource alloc] initWithData:_diccionario displayReporte:@"totalInvertido"];
    [self prepareBarChartWithTitle:@"totalInvertido"];
    [self preparePieChartWithTitle:@"totalInvertido"];
    [self prepareDonutChartWithTitle:@"totalInvertido"];
    [self prepareColumnChartWithTitle:@"totalInvertido"];
    [self updateChartsWithTitle:@"totalInvertido"];

    _currencyFormatter = [[NSNumberFormatter alloc] init];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    lineView = [[LineView alloc] init];
    [lineView setUserInteractionEnabled:NO];
    [lineView setBackgroundColor:[UIColor clearColor]];
    [_donutChart addSubview:lineView];
    
}

-(void)prepareColumnChartWithTitle:(NSString *)title{
    // Create the chart
    if(!self._chart){
    _chart = [[ShinobiChart alloc] initWithFrame:self.view.bounds];
    _chart.title = @"Total Invertido por Estado";
    [_chart setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    _chart.hidden = YES;
    _chart.tag = 1;

        _chart.backgroundColor = [UIColor clearColor];
        _chart.plotAreaBackgroundColor = [UIColor clearColor];
        _chart.canvasAreaBackgroundColor = [UIColor clearColor];
        _chart.gestureDoubleTapResetsZoom = YES;
        
        _chart.borderColor = [UIColor clearColor];
        
        _chart.plotAreaBorderColor = [UIColor clearColor];

        
        
    SChartCategoryAxis *xAxis = [[SChartCategoryAxis alloc] init];
    xAxis.style.interSeriesPadding = @.2;
    xAxis.enableGesturePanning = YES;
    xAxis.enableGestureZooming = NO;
    xAxis.defaultRange = [[SChartNumberRange alloc] initWithMinimum:@.5 andMaximum:@15];
    _chart.xAxis = xAxis;

    SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] init];
    yAxis.title = @"Inversion (MDP)";
    yAxis.rangePaddingHigh = @5.0;
    yAxis.enableGestureZooming = YES;
    yAxis.enableGesturePanning = YES;
    yAxis.zoomInLimit = 5;

//        
//    yAxis.style.majorGridLineStyle.lineWidth = @1;
//    yAxis.style.majorGridLineStyle.lineColor = [UIColor blackColor];
//    yAxis.style.majorGridLineStyle.showMajorGridLines = YES;



    _chart.yAxis = yAxis;
    columnDataSource.reporte = title;
    _chart.datasource = columnDataSource;
    _chart.delegate = self;
//        _chart.legend.hidden = YES;
        [self.view addSubview:_chart];
        [_chart redrawChart];
    }
    

}

-(void)preparePieChartWithTitle:(NSString *)title{
    


    // Create the chart
    if(!self._pieChart){
        _pieChart = [[ShinobiChart alloc] initWithFrame:self.view.bounds];
        
        _pieChart.hidden =YES;
        [self updatePieTitle:title];
        _pieChart.autoresizingMask =  ~UIViewAutoresizingNone;
        _pieChart.backgroundColor = [UIColor clearColor];
        _pieChart.plotAreaBackgroundColor = [UIColor clearColor];
        _pieChart.canvasAreaBackgroundColor = [UIColor clearColor];
        _pieChart.gestureDoubleTapResetsZoom = YES;
        _pieChart.borderColor = [UIColor clearColor];
        
        _pieChart.plotAreaBorderColor = [UIColor clearColor];
        _pieChart.plotAreaBorderThickness = 0.f;
        _pieChart.tag =2;
        
        pieDataSource.reporte = title;
        _pieChart.datasource = pieDataSource;

        _pieChart.delegate =self;
        _pieChart.legend.hidden = NO;


        [self.view addSubview:_pieChart];

    }
    

}


-(void)prepareDonutChartWithTitle:(NSString *)title{
    
    
    
    // Create the chart
    if(!self._donutChart){
        _donutChart = [[ShinobiChart alloc] initWithFrame:self.view.bounds];
        
        _donutChart.hidden =YES;
        [self updateDonutTitle:title];
        _donutChart.autoresizingMask =  ~UIViewAutoresizingNone;
        _donutChart.backgroundColor = [UIColor clearColor];
        _donutChart.plotAreaBackgroundColor = [UIColor clearColor];
        _donutChart.canvasAreaBackgroundColor = [UIColor clearColor];
        _donutChart.gestureDoubleTapResetsZoom = YES;
        
        _donutChart.borderColor = [UIColor clearColor];
        
        _donutChart.plotAreaBorderColor = [UIColor clearColor];
        _donutChart.plotAreaBorderThickness = 0.f;
        _donutChart.tag =3;
        pieDataSource.reporte = title;

        _donutChart.datasource = pieDataSource;
        _donutChart.delegate=self;
        _donutChart.legend.hidden = NO;
        [self.view addSubview:_donutChart];
        
    }
    
    
}


-(void)prepareBarChartWithTitle:(NSString *)title{
    // Create the chart
    if(!self._barChart){
        _barChart = [[ShinobiChart alloc] initWithFrame:self.view.bounds];
        
        _barChart.hidden =NO;
        [self updateBarTitle:title];
        _barChart.autoresizingMask =  ~UIViewAutoresizingNone;
        _barChart.backgroundColor = [UIColor clearColor];
        _barChart.plotAreaBackgroundColor = [UIColor clearColor];
        _barChart.canvasAreaBackgroundColor = [UIColor clearColor];
        _barChart.gestureDoubleTapResetsZoom = YES;
        
        _barChart.borderColor = [UIColor clearColor];
        
        _barChart.plotAreaBorderColor = [UIColor clearColor];
        _barChart.plotAreaBorderThickness = 0.f;
        _barChart.tag =4;
        
        columnDataSource.reporte = title;
        _barChart.datasource = columnDataSource;
        _barChart.legend.hidden = NO;
        

        // add a pair of axes
        SChartNumberAxis *xAxis = [[SChartNumberAxis alloc] init];
        xAxis.style.interSeriesPadding = @0;
        xAxis.enableGesturePanning = YES;
        xAxis.enableGestureZooming = YES;
        xAxis.zoomInLimit = 5;
        xAxis.title = @"Inversión (MDP)";
        [xAxis setRangeWithMinimum:@0.5 andMaximum:@30];
        xAxis.rangePaddingHigh = @1.0;

        xAxis.style.majorGridLineStyle.lineWidth = @1;
        //xAxis.style.majorGridLineStyle.lineColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        xAxis.style.majorGridLineStyle.lineColor = [UIColor blackColor];
        xAxis.style.majorGridLineStyle.showMajorGridLines = YES;

        
        xAxis.allowPanningOutOfDefaultRange =YES   ;
        _barChart.xAxis = xAxis;
        
        SChartCategoryAxis *yAxis = [[SChartCategoryAxis alloc] init];
        yAxis.rangePaddingHigh = @1.0;
        yAxis.enableGestureZooming = NO;
        yAxis.enableGesturePanning = YES;
        
        yAxis.style.majorGridLineStyle.lineWidth = @1;
        //xAxis.style.majorGridLineStyle.lineColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        yAxis.style.majorGridLineStyle.lineColor = [UIColor blackColor];
        yAxis.style.majorGridLineStyle.showMajorGridLines = YES;
        
        _barChart.yAxis = yAxis;
        _barChart.delegate = self;
        
        [self.view addSubview:_barChart];

        
    }
    
    
}

-(void)activateColumn{
    for( ShinobiChart *view in self.view.subviews){
        view.hidden = YES;
    }
    _chart.hidden =NO;
    [_chart redrawChart];
}

-(void)updateColumnTitle:(NSString*)title{
    if([title isEqualToString:@"totalInvertido"]){
        _chart.title = @"Total Invertido por Estado";
        _chart.yAxis.title = @"Total Invertido (MDP)";
    }else if([title isEqualToString:@"numeroObras"]){
        _chart.title = @"Obras por Estado";
        _chart.yAxis.title = @"Numero de Obras";

    }else if ([title isEqualToString:@"totalInvertidoDependencias"]){
        _chart.title = @"Total invertido por Dependencia";
        _chart.yAxis.title = @"Total Invertido (MDP)";

    }else if ([title isEqualToString:@"numeroObrasDependencias"]){
        _chart.title = @"Número de obras por dependencia";
        _chart.yAxis.title = @"Número de obras";
    }
    
    unsigned int  max = [_diccionario[title]count];
    NSNumber *yourNumber = [NSNumber numberWithInt:max];
    [_chart.xAxis setDefaultRange:[[SChartNumberRange alloc] initWithMinimum:@0 andMaximum:yourNumber]];
    
    columnDataSource.reporte = title;
    [_chart reloadData];
    [_chart redrawChart];
}

-(void)activatePie{
    for( ShinobiChart *view in self.view.subviews){
        view.hidden = YES;
    }
    _pieChart.hidden =NO;
    
    [_pieChart redrawChart];
}

-(void)updatePieTitle:(NSString*)title{
    if([title isEqualToString:@"totalInvertido"]){
        _pieChart.title = @"Total Invertido por Estado";
        
    }else if([title isEqualToString:@"numeroObras"]){
        _pieChart.title = @"Obras por Estado";
    }else if ([title isEqualToString:@"totalInvertidoDependencias"]){
        _pieChart.title = @"Total invertido por Dependencia";
        
    }else if ([title isEqualToString:@"numeroObrasDependencias"]){
        _pieChart.title = @"Número de obras por dependencia";
    }
    
    columnDataSource.reporte = title;
    [_pieChart reloadData];
    [_pieChart redrawChart];
}


-(void)activateDonut{
    for( ShinobiChart *view in self.view.subviews){
        view.hidden = YES;
    }
    _donutChart.hidden =NO;
    
    [_donutChart redrawChart];
}

-(void)updateDonutTitle:(NSString*)title{
    if([title isEqualToString:@"totalInvertido"]){
        _donutChart.title = @"Total Invertido por Estado";
    }else if([title isEqualToString:@"numeroObras"]){
        _donutChart.title = @"Obras por Estado";
    }else if ([title isEqualToString:@"totalInvertidoDependencias"]){
        _donutChart.title = @"Total invertido por Dependencia";
    }else if ([title isEqualToString:@"numeroObrasDependencias"]){
        _donutChart.title = @"Número de obras por dependencia";
    }
    
    pieDataSource.reporte = title;
    [_donutChart reloadData];
    [_donutChart redrawChart];
}

-(void)activateBar{
    for( ShinobiChart *view in self.view.subviews){
        view.hidden = YES;
    }
    _barChart.hidden =NO;
    
    [_barChart redrawChart];
}

-(void)updateBarTitle:(NSString*)title{
    if([title isEqualToString:@"totalInvertido"]){
        _barChart.title = @"Total Invertido por Estado";
        _barChart.xAxis.title = @"Total Invertido (MDP)";
    }else if([title isEqualToString:@"numeroObras"]){
        _barChart.title = @"Obras por Estado";
        _barChart.xAxis.title = @"Número de Obras";

    }else if ([title isEqualToString:@"totalInvertidoDependencias"]){
        _barChart.title = @"Total invertido por Dependencia";
        _barChart.xAxis.title = @"Total Invertido (MDP)";
        
    }else if ([title isEqualToString:@"numeroObrasDependencias"]){
        _barChart.title = @"Número de obras por dependencia";
        _barChart.xAxis.title = @"Número de obras";
    }
    
    columnDataSource.reporte = title;
    [_barChart reloadData];
    [_barChart redrawChart];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateChartsWithTitle:(NSString*)title{
    if (_chart)[self updateColumnTitle:title];
    if(_pieChart)    [self updatePieTitle:title];
    if(_donutChart) [self updateDonutTitle:title];
    if(_barChart)[self updateBarTitle:title];

}


//-(void)sChart:(ShinobiChart *)chart alterDataPointLabel:(SChartDataPointLabel *)label forDataPoint:(SChartDataPoint *)datapoint inSeries:(SChartSeries *)series
//{
//    //Do some additional label styling
//    label.layer.cornerRadius = 10;
//    label.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
//    label.textAlignment = NSTextAlignmentCenter;
//}

#define EXTRUSION 90
- (void)sChart:(ShinobiChart *)chart alterLabel:(UILabel *)label forDatapoint:(SChartRadialDataPoint *)datapoint atSliceIndex:(NSInteger)index inRadialSeries:(SChartRadialSeries *)series {
    
//    if (chart == _pieChart) {
//        label.adjustsFontSizeToFitWidth = YES;
//        if (datapoint.value.floatValue < 5.f) {
//
//            label.text = @"";
//            
//        }  else if (datapoint.value.floatValue < 15.f) {
//            label.adjustsFontSizeToFitWidth = YES;
//            CGRect f = label.frame;
//            f.size.width = 35.f;
//            label.frame = f;
//        }
//    } else
//    if( chart == _donutChart){

        SChartDonutSeries *pieSeries = (SChartDonutSeries *)series;
        NSNumber *total = [pieSeries.dataSeries.allYValues valueForKeyPath:@"@sum.self"];
        
        //Determinar el porcentaje
        NSNumber *porcentaje;
        NSUInteger numero;
        
        numero = pieSeries.dataSeries.allYValues.count;
        
        porcentaje = numero < 10 ? @5 :
        numero >= 10 && numero < 20 ? @10 :
        numero >= 20 && numero < 40 ? @15 : @15
        ;
        
        
        
        if(datapoint.value.floatValue/total.floatValue*100>porcentaje.floatValue || datapoint.selected){
            //get our radial point from our datasource method
            
            // three points:
            CGPoint pieCenter;      // chart center for trig calculations
            CGPoint oldLabelCenter; // original label center
            CGPoint labelCenter;    // new label center
            CGPoint endOfLine;     // we want our line to finish just short of our label
            
            pieCenter = [pieSeries getDonutCenter];
            oldLabelCenter = labelCenter = [pieSeries getSliceCenter:index];
            
            // find the angle of the slice, and add on a little to the label's center
            float xChange, yChange;
            
            xChange = pieCenter.x - labelCenter.x;
            yChange = pieCenter.y - labelCenter.y;
            
            float angle = atan2f(xChange, yChange) + M_PI / 2.f;
            // we do the M_PI / 2 adjustment because of how the pie is drawn internally
            
            labelCenter.x = oldLabelCenter.x + EXTRUSION * cosf(angle);
            labelCenter.y = oldLabelCenter.y - EXTRUSION * sinf(angle);
            
            endOfLine.x = oldLabelCenter.x + (EXTRUSION-30.f) * cosf(angle);
            endOfLine.y = oldLabelCenter.y - (EXTRUSION-30.f) * sinf(angle);
            
            
            if ([self.reporteSeleccionado isEqualToString:@"numeroObras"] || [self.reporteSeleccionado isEqualToString:@"numeroObrasDependencias"]) {
                [label setText:[NSString stringWithFormat:@"%@, %@ Obras.", datapoint.xValue, datapoint.yValue]];
            }else{
                [label setText:[NSString stringWithFormat:@"%@, %@ mdp.", datapoint.xValue, [_currencyFormatter stringFromNumber:datapoint.yValue]]];

            }
            
            label.textColor = [UIColor blackColor];
            [label sizeToFit];
            [label setCenter:labelCenter]; // this must be after sizeToFit
            [label setHidden:NO];
            
            // connect our old label point to our new label
            [lineView addPointPair:oldLabelCenter second:endOfLine forLabel:label];
        }else{
            label.text = @"";
            label.hidden = YES;
        }
        

//    }

}

-(void)sChart:(ShinobiChart *)chart alterDataPointLabel:(SChartDataPointLabel *)label forDataPoint:(SChartDataPoint *)dataPoint inSeries:(SChartSeries *)series{
    if ([self.reporteSeleccionado isEqualToString:@"numeroObras"] || [self.reporteSeleccionado isEqualToString:@"numeroObrasDependencias"]) {
        
        CGRect newLabelFrame = label.frame;

        
        label.text = [NSString stringWithFormat:@"%@ obras.", dataPoint.yValue];
        // Calculate the size of the string label with the supplied font, and no existing constraints on size.
        NSDictionary *attributes = @{NSFontAttributeName:label.font};
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:label.text attributes:attributes];
        CGFloat labelWidth = [attributedString boundingRectWithSize:CGSizeZero
                                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                            context:nil].size.width;
        
        
        newLabelFrame.size.width = labelWidth;
        newLabelFrame.size.height = 10;
        newLabelFrame.origin.x = CGRectGetMidX(label.frame) - (newLabelFrame.size.width + 20);
        newLabelFrame.origin.y = CGRectGetMidY(label.frame) - newLabelFrame.size.height / 2;
        label.frame = newLabelFrame;

    }else if ([self.reporteSeleccionado isEqualToString:@"totalInvertido"] || [self.reporteSeleccionado isEqualToString:@"totalInvertidoDependencias"]){
        
        CGRect newLabelFrame = label.frame;
        
        
        label.text = [NSString stringWithFormat:@"%@ mdp.", [_currencyFormatter stringFromNumber: dataPoint.yValue]];
        // Calculate the size of the string label with the supplied font, and no existing constraints on size.
        NSDictionary *attributes = @{NSFontAttributeName:label.font};
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:label.text attributes:attributes];
        CGFloat labelWidth = [attributedString boundingRectWithSize:CGSizeZero
                                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                            context:nil].size.width;
        
        
        newLabelFrame.size.width = labelWidth;
        newLabelFrame.size.height = 20;
        newLabelFrame.origin.x = CGRectGetMidX(label.frame) - (newLabelFrame.size.width + 20);
        newLabelFrame.origin.y = CGRectGetMidY(label.frame) - newLabelFrame.size.height / 2;
        label.frame = newLabelFrame;
        
    }
}


- (void) sChartRenderStarted:(ShinobiChart *)chart withFullRedraw:(BOOL)fullRedraw {
    // position our view over the top of the GL canvas
    CGRect glFrame = chart.canvas.glView.frame;
    glFrame.origin.y = chart.canvas.frame.origin.y;
    [lineView setFrame:glFrame];
    // remove the old point-pairs from the line view
    [lineView reset];
}

- (void)sChartDidFinishLoadingData:(ShinobiChart *)chart {
    NSNumber * padding = @(chart.yAxis.dataRange.span.doubleValue * 0.05);
    chart.yAxis.rangePaddingHigh = padding;
}

@end
