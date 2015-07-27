
// Programador: Abdiel Soto
// Origen: EdicoMex
// Fecha inicio: Septiembre
// Fecha ultima modificación: 18/09/2014
// Descripción: Clase que muestra los elementos por de la lista en un TableView dentro de la clase UIPopover

#import "PopupListTableViewController.h"
#import "DetailTableViewController.h"
#import "NSUserDefaults+RMSaveCustomObject.h"
#import "Estado.h"
#import "Inaugurador.h"
#import "Impacto.h"
#import "Clasificacion.h"
#import "Dependencia.h"
#import "TipoObraPrograma.h"
#import "Inversion.h"
#import "Inaugurador.h"
#import "DBHelper.h"
#import "Subclasificacion.h"
#import "UIColor+Colores.h"
#import "LoginViewController.h"

typedef NS_OPTIONS(NSInteger, TypeSelection)
{
    t_DeleteAllWithoutTodo  = 3,
    t_Disable_Todo          = 1,
    t_Enable_Todo           = 2
};


const NSInteger rowHeight = 45;

@interface PopupListTableViewController ()

@property (nonatomic, strong) NSArray *subclasificationsSavedData;
@property (nonatomic, strong) NSArray *dataToMark;
@property  CGSize size;
@property TypeSelection typeSelection;
@property TypeSelection cleanSelection;
@property (nonatomic, strong) Clasificacion *subclasificacion;
@property BOOL rowPressed;
@property BOOL todoPressed;
@property BOOL isProgramsSelected;

@end

@implementation PopupListTableViewController

-(id)initWithData:(NSArray *)datasource isMenu:(BOOL)option markData:(NSArray *)loadData searchField:(MainSearchFields)field{
    
    if ([super initWithStyle:UITableViewStylePlain] !=nil) {
        _todoPressed = [[NSUserDefaults standardUserDefaults]boolForKey:kKeyStoreTodoSublasifications];
        _isProgramsSelected = [[NSUserDefaults standardUserDefaults]boolForKey:@"isProgramsSelected"];

        /* Initialize instance variables */
        self.hideTitle = YES;
        self.dataSource     = datasource;
        self.dataToMark     = [loadData count] > 0 ? loadData : [NSArray new];
        self.dataSelected   = [NSMutableArray arrayWithArray:self.dataToMark];
        
        if (_dataSelected.count == 0 && _field != e_Tipo) {
            _typeSelection = t_Enable_Todo;
        }
        
        self.isMenu         = option;
        self.field          = field;
        
        self.tableView.allowsMultipleSelection = _isMenu || _field == e_Sort_Result ? NO : YES;
        NSInteger rowsCount = [self.dataSource count];
        NSInteger totalRowsHeight = (rowsCount * rowHeight);
        self.tableView.backgroundColor = [UIColor clearColor];
        //Calcula el ancho que debe tener la vista buscando que ancho de cada string se espera que sea
        
        CGFloat largestLabelWidth = 0;
        for (id objectModel in self.dataSource) {
            
            NSString *strValue = [self textToDisplay:objectModel];
            //Verifica el tamaño del texto usado la fuente del textLabel por defecto del UITableViewCell
            
            CGSize labelSize = [strValue sizeWithAttributes:
                           @{NSFontAttributeName:
                                 [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]}];
            
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        //Agrega un pequeño padding al ancho
        CGFloat popoverWidth = largestLabelWidth + 50;
        popoverWidth = _isMenu || _field == e_Inaugurada || _field == e_Suscpetible  || _field == e_Tipo  || _field == e_AnioPrograma || _field == e_SubClasifications ? popoverWidth + 50 : popoverWidth;
        _size = CGSizeMake(popoverWidth, totalRowsHeight);
        
        //Establece la propiedad para decirle al contenedor del popover que tan grande sera su vista
        self.preferredContentSize = _size;
        self.tableView.frame = CGRectMake(0, 0, _size.width, _size.height);
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(CGSize)preferredContentSize{
    return _size;
}

-(void)viewDidAppear:(BOOL)animated{
    
    _subclasificationsSavedData = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreSublasificationsSavedData];
    _todoPressed = [[NSUserDefaults standardUserDefaults]boolForKey:kKeyStoreTodoSublasifications];
    
    if (_field == e_Clasificacion) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        if (_subclasificationsSavedData.count > 0  || _todoPressed) {
            [cell setBackgroundColor:[UIColor colorForButtonSelection]];
            cell.textLabel.textColor = [UIColor whiteColor];
        }else{
            [cell setBackgroundColor:[UIColor clearColor]];
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:_hideTitle animated:YES];
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if(!_isMenu && _field != e_Sort_Result){
        if ([_delegate respondsToSelector:@selector(popupListView:dataForMultipleSelectedRows:rowPressed:)]) {
            [_delegate popupListView:self dataForMultipleSelectedRows:_dataSelected rowPressed:_rowPressed];
        }
        
        if (_field == e_SubClasifications) {
            
            if (_subclasificacion) {
                if (_dataSelected.count >0) {
                    [_dataSelected addObject:_subclasificacion];
                }else{
                    [_dataSelected removeObject:_subclasificacion];
                }
            }
            [[NSUserDefaults standardUserDefaults]rm_setCustomObject:_dataSelected forKey:kKeyStoreSublasificationsSavedData];

        }
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _isMenu || _field == e_Sort_Result || _field == e_Tipo ? self.dataSource.count : self.dataSource.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id objecModel = nil;
    NSString *value = @"";

    if (_isMenu || _field == e_Sort_Result || _field == e_Tipo) {
        objecModel  = [self.dataSource objectAtIndex:indexPath.row];
    }else if (indexPath.row != 0) {
        objecModel  = [self.dataSource objectAtIndex:indexPath.row-1];
    }
    value = [self textToDisplay:objecModel];

    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld", (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    if (_isMenu) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"busquedas-icon"];
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"favorito-icon"];
        }else if (indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"info"];
        }else if (indexPath.row == 3){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = value;
        
    }else if(!_isMenu && _field != e_Sort_Result){
        if ((_field != e_Tipo && indexPath.row != 0)  || (_field == e_Tipo)) {
            cell.textLabel.text = value;
            if (_cleanSelection == t_DeleteAllWithoutTodo) {
                cell.accessoryType = UITableViewCellAccessoryNone;

            }else{
                for (id objectModel in _dataSelected) {
                    NSString *valueToCheck = [self textToDisplay:objectModel];
                    
                    if ([valueToCheck isEqualToString:value]) {
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                    }
                }
            }
            if (!_isProgramsSelected) {
                if ([value isEqualToString:@"Compromiso de Gobierno"] || [value isEqualToString:@"Plan Michoacán"]) {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }
            
            
        }else if(_field != e_Tipo){
            cell.textLabel.text = @"TODO";
            if (_typeSelection == t_Enable_Todo) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else if (_typeSelection == t_Disable_Todo) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            if (_todoPressed && _field == e_SubClasifications){
                [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }else {
        cell.textLabel.text = value;
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *obrasAndProgramsData = [NSMutableArray array];
    _rowPressed = YES;
   
    //Si la seleccion no es menu, agregamos nuevos elementos de busqueda para almacenarlos
    if (!_isMenu && _field != e_Sort_Result) {
       
        if (indexPath.row !=0) {
            if (_field == e_SubClasifications) {
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:kKeyStoreTodoSublasifications];

            }

            id dataForSelectedRow = _field == e_Tipo ? [self.dataSource objectAtIndex:indexPath.row] : [self.dataSource objectAtIndex:indexPath.row-1];
            NSString *value = [self textToDisplay:dataForSelectedRow];
            
            if (!_isProgramsSelected) {
                BOOL pushView = NO;
                NSArray *data = [NSArray array];
                if ([value isEqualToString:@"Compromiso de Gobierno"]) {
                    _subclasificacion = dataForSelectedRow;
                    data = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreSublasificationsData];
                    pushView = YES;
                }else if ([value isEqualToString:@"Plan Michoacán"]){
                    
                    pushView = YES;
                }
                
                if (pushView) {
                    PopupListTableViewController *popUpTableView = [[PopupListTableViewController alloc]initWithData:data
                                                                                                              isMenu:NO
                                                                                                            markData:_subclasificationsSavedData
                                                                                                         searchField:e_SubClasifications];
                    popUpTableView.hideTitle = NO;
                    
                    [self.navigationController pushViewController:popUpTableView animated:YES];
                    return;
                }

            }
            if ([value isEqualToString:@"PROGRAMAS"]) {
                //Cuando la selección es PROGRMAS
                //Deshabilitamos las OBRAS TOTALES
                [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
                //Desahbilitamos las demas selecciones
                for (int i= 0; i<self.dataSource.count+1; i++) {
                    if (i!= self.dataSource.count) {
                        [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
                        id dataForSelectedRow = [self.dataSource objectAtIndex:i];
                        [_dataSelected removeObject:dataForSelectedRow];
                    }
                }
                _typeSelection = t_Disable_Todo;

                [self.tableView reloadData];

                //Seleccionamos la celda de PROGRAMAS
                [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];
                //Quitamos las demas selecciones
                [_dataSelected addObject:dataForSelectedRow];

                //[self.dataSelected removeAllObjects];

            }else{
                _typeSelection = t_Disable_Todo;
                _cleanSelection = t_Disable_Todo;
                [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
                [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
                
                //Para la selección de tipo de obra o programa, deseleccionamos el ulitmo registro que corresponde a programas
                if (_field == e_Tipo) {
                    [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_dataSource.count-1 inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
                    TipoObraPrograma *dataForSelectedRow = [self.dataSource objectAtIndex:_dataSource.count-1];
                    [_dataSelected removeObject:dataForSelectedRow];
                    
                    [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
                    TipoObraPrograma *obrasTotalesRow = [self.dataSource objectAtIndex:0];
                    [_dataSelected removeObject:obrasTotalesRow];
                }
                [_dataSelected addObject:dataForSelectedRow];
            }

        }else{
            //Cuando la selección es TODO
            if (_field == e_Clasificacion) {
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                [cell setBackgroundColor:[UIColor clearColor]];
                cell.textLabel.textColor = [UIColor blackColor];
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:kKeyStoreTodoSublasifications];

                [[NSUserDefaults standardUserDefaults]rm_setCustomObject:[NSArray array] forKey:kKeyStoreSublasificationsSavedData];
            }else if (_field == e_SubClasifications){
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kKeyStoreTodoSublasifications];
            }
            
            
            [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];
            //Para la selección de tipo de obra o programa, deseleccionamos el ulitmo registro que corresponde a obras
        
            for (int i= 0; i<self.dataSource.count; i++) {
                if (i!=0) {
                    [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
                }
            }
            _typeSelection = t_Enable_Todo;
            [self.dataSelected removeAllObjects];
            
            if (_field == e_Tipo) {
                [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_dataSource.count inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
                id dataForSelectedRow = [self.dataSource objectAtIndex:indexPath.row];
                [self.dataSelected addObject:dataForSelectedRow];
            }else {
                _cleanSelection = t_DeleteAllWithoutTodo;
            }
            [self.tableView reloadData];
        }
    }else if (_isMenu ){
    /* MENU */
        NSString *value  = [self.dataSource objectAtIndex:indexPath.row];
        NSArray *dataSource = [NSArray array];
        MenuOptions option;
        if (indexPath.row == 0) {
            dataSource =  [DBHelper getAllQueriesSaved];
            obrasAndProgramsData = [dataSource mutableCopy];
            option = o_Consultas;
            if (dataSource.count == 0) {
                [[[UIAlertView alloc]initWithTitle:@"No hay consultas"
                                           message:@"Aún no tienes consultas guardadas"
                                          delegate:nil
                                 cancelButtonTitle:@"Aceptar"
                                 otherButtonTitles:nil, nil]show];
                return;
            }
        }else if (indexPath.row == 1){
            NSArray *dataSourceObras =  [DBHelper getAllObras];
            [obrasAndProgramsData addObject:dataSourceObras];
            NSArray *dataSourceProgramas =  [DBHelper getAllProgramas];
            [obrasAndProgramsData addObject:dataSourceProgramas];

            option = o_Favoritos;
            if (dataSourceProgramas.count == 0 && dataSourceObras.count == 0) {
                [[[UIAlertView alloc]initWithTitle:@"No hay registros"
                                           message:@"Aún no tienes registros guardados"
                                          delegate:nil
                                 cancelButtonTitle:@"Aceptar"
                                 otherButtonTitles:nil, nil]show];
                return;
            }

        }else if (indexPath.row == 2){
            [obrasAndProgramsData addObject:@"Manual de usuario (PDF)"];
            [obrasAndProgramsData addObject:@"Tutorial (Video)"];
            option = o_Ayuda;

        }else if (indexPath.row == 3){
            //TODO implementar el cierre de sesión
            option = o_logout;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
            return;
        }
        
        DetailTableViewController *detailViewController = [[DetailTableViewController alloc]initWithDataSource:obrasAndProgramsData menuOption:option];
        detailViewController.title = value;
        [self.navigationController pushViewController:detailViewController animated:YES];   
    }else if (_field == e_Sort_Result){
        NSString *value  = [self.dataSource objectAtIndex:indexPath.row];
        if ([_delegate respondsToSelector:@selector(popupListView:dataForSingleSelectedRow:)]) {
            [_delegate popupListView:self dataForSingleSelectedRow:value];
        }
    }
    NSLog(@"add %@", _dataSelected);
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_isMenu && _field != e_Sort_Result) {
        if (indexPath.row !=0) {
            id dataForSelectedRow = _field == e_Tipo ? [self.dataSource objectAtIndex:indexPath.row] : [self.dataSource objectAtIndex:indexPath.row-1];
            if (!_isProgramsSelected) {
                if (_field == e_Clasificacion) {
                    NSString *value = [self textToDisplay:dataForSelectedRow];
                    
                    BOOL pushView = NO;
                    NSArray *data = [NSArray array];
                    if ([value isEqualToString:@"Compromiso de Gobierno"]) {
                        data = [[NSUserDefaults standardUserDefaults]rm_customObjectForKey:kKeyStoreSublasificationsData];
                        pushView = YES;
                    }else if ([value isEqualToString:@"Plan Michoacán"]){
                        pushView = YES;
                    }
                    
                    if (pushView) {
                        PopupListTableViewController *popUpTableView = [[PopupListTableViewController alloc]initWithData:data
                                                                                                                  isMenu:NO
                                                                                                                markData:_subclasificationsSavedData
                                                                                                             searchField:e_SubClasifications];
                        popUpTableView.hideTitle = NO;
                        
                        [self.navigationController pushViewController:popUpTableView animated:YES];
                        return;
                    }
                }

            }
            
            [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
            [_dataSelected removeObject:dataForSelectedRow];
        }else if (_field == e_SubClasifications && indexPath.row == 0){
            //Habilitamos la deselección para TODO en la subclasificación
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:kKeyStoreTodoSublasifications];
            [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];

        }
    }
    NSLog(@"delete %@", _dataSelected);
}

-(NSString *)textToDisplay:(id)objectModel{
    
    NSString *value = @"";

    if (_isMenu || _field == e_Sort_Result || _field == e_AnioPrograma) {
        value = objectModel;
    }else if (_field == e_Estado) {
        Estado *state = (Estado *)objectModel;
        value = state.nombreEstado;
    }else if (_field == e_Nombre_Inaugura){
        Inaugurador *inaugurator = (Inaugurador *)objectModel;
        value = inaugurator.nombreCargoInaugura;
    }else if (_field == e_Impacto){
        Impacto *impact = (Impacto *)objectModel;
        value = impact.nombreImpacto;
    }else if (_field == e_Clasificacion){
        Clasificacion *clasification = (Clasificacion *)objectModel;
        value = clasification.nombreTipoClasificacion;
    }else if (_field == e_Dependencia){
        Dependencia *dependency = (Dependencia *)objectModel;
        value = dependency.nombreDependencia;
    }else if (_field == e_Tipo_Inversion){
        Inversion *invesment = (Inversion *)objectModel;
        value = invesment.nombre;
    }else if (_field == e_Tipo){
        TipoObraPrograma *tipo = (TipoObraPrograma *)objectModel;
        value = tipo.nombreTipoObra;
    }else if (_field == e_Inaugurada || _field == e_Suscpetible){
        value = (NSString *)objectModel;
    }else if (_field == e_SubClasifications){
        Subclasificacion *sub = (Subclasificacion *)objectModel;
        value = sub.nombreSubclasificacion;
    }
    
    return value;
}

@end
