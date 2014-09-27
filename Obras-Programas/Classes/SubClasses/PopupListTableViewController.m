
// Programador: Abdiel Soto
// Origen: EdicoMex
// Fecha inicio: Septiembre
// Fecha ultima modificación: 18/09/2014
// Descripción: Clase que muestra los elementos por de la lista en un TableView dentro de la clase UIPopover

#import "PopupListTableViewController.h"
#import "Estado.h"
#import "Inaugurador.h"
#import "Impacto.h"

const NSInteger rowHeight = 45;

@interface PopupListTableViewController ()

@property (nonatomic, strong) NSArray *dataToMark;

@end

@implementation PopupListTableViewController

-(id)initWithData:(NSArray *)datasource isMenu:(BOOL)option markData:(NSArray *)loadData searchField:(MainSearchFields)field{
    
    if ([super initWithStyle:UITableViewStylePlain] !=nil) {
        
        /* Initialize instance variables */
        
        self.dataSource     = datasource;
        self.dataToMark     = loadData;
        
        self.dataToMark =   self.dataToMark == nil ? [NSArray new] : self.dataToMark;
        
        self.dataSelected   = [NSMutableArray arrayWithArray:self.dataToMark];
        self.isMenu         = option;
        _field              = field;
        
        self.clearsSelectionOnViewWillAppear = NO;
        self.tableView.allowsMultipleSelection = _isMenu ? NO : YES;
        
        NSInteger rowsCount = [self.dataSource count];
        NSInteger totalRowsHeight = rowsCount * rowHeight + 5;
        
        //Calcula el ancho que debe tener la vista buscando que ancho de cada string se espera que sea
        
        CGFloat largestLabelWidth = 0;
        for (id objectModel in self.dataSource) {
            
            NSString *strValue = [self textToDisplay:objectModel];
            //Verifica el tamaño del texto usado la fuente del textLabel por defecto del UITableViewCell
            
            CGSize labelSize = [strValue sizeWithAttributes:
                           @{NSFontAttributeName:
                                 [UIFont systemFontOfSize:20.0f]}];
            
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        //Agrega un pequeño padding al ancho
        CGFloat popoverWidth = largestLabelWidth + 100;
        
        //Establece la propiedad para decirle al contenedor del popover que tan grande sera su vista
        self.preferredContentSize = CGSizeMake(popoverWidth, totalRowsHeight);
    }
    
    return self;
}

#pragma mark - View Lifecycle


- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if ([_delegate respondsToSelector:@selector(popupListView:dataForMultipleSelectedRows:)]) {
        [_delegate popupListView:self dataForMultipleSelectedRows:_dataSelected];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id objecModel = [self.dataSource objectAtIndex:indexPath.row];
    NSString *value = @"";
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        value = [self textToDisplay:objecModel];
        
        if (_isMenu) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"favoritos"];
        }else{
            for (NSString *valeToCheck in _dataToMark) {
                
                if ([valeToCheck isEqualToString:value]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

                }
            }
        }
        
        cell.textLabel.text = value;
    }
    
    return cell;
}


-(NSString *)textToDisplay:(id)objectModel{
    
    NSString *value = @"";

    if (_isMenu) {
        
        value = objectModel;
        
    }else if (_field == e_Estado) {
        
        Estado *state = (Estado *)objectModel;
        value = state.nombreEstado;
        
    }else if (_field == e_Nombre_Inaugura){
        
        Inaugurador *inaugurator = (Inaugurador *)objectModel;
        value = inaugurator.nombreCargoInaugura;
        
    }else if (_field == e_Impacto){
        
        Impacto *inaugurator = (Impacto *)objectModel;
        value = inaugurator.nombreImpacto;
    }
    
    return value;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isMenu) {
        [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        
        NSString *dataForSelectedRow = [self.dataSource objectAtIndex:indexPath.row];
        
        if ([_delegate respondsToSelector:@selector(popupListView:dataForSingleSelectedRow:)]) {
            [_delegate popupListView:self dataForSingleSelectedRow:dataForSelectedRow];
        }
        [_dataSelected addObject:dataForSelectedRow];
    }else{
        
    }
    
    
    NSLog(@"Insert %@", _dataSelected);

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_isMenu) {
        NSString *dataForSelectedRow = [self.dataSource objectAtIndex:indexPath.row];
        
        [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
        [_dataSelected removeObjectIdenticalTo:dataForSelectedRow];
        
        NSLog(@"Remove %@", _dataSelected);
    }
}



@end