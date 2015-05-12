//
//  FilmeStore.m
//  Mapa
//
//  Created by Rodrigo DAngelo Silva Machado on 5/12/15.
//  Copyright (c) 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

#import "FilmeStore.h"
#import "AppDelegate.h"

@interface FilmeStore()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation FilmeStore

static NSString *DATA_MODEL_ENTITY_NAME = @"Filme";

+ (instancetype)sharedStore
{
    static FilmeStore *sharedStore = nil;
    
    if (!sharedStore) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        sharedStore = [[self alloc] initPrivate];
        sharedStore.managedObjectContext = appDelegate.managedObjectContext;
        
        [sharedStore resetStoredData];
    }
    
    return sharedStore;
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[FilmeStore sharedStore]"
                                 userInfo:nil];
}

- (void)resetStoredData
{
    
    // Delete all objects
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:DATA_MODEL_ENTITY_NAME];
    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error fetching objects: %@", error.userInfo);
    }
    
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    for (NSManagedObject *object in objects) {
        [self.managedObjectContext deleteObject:object];
    }
    
    // Populate with defaults
    NSArray *nome = @[@"Star Wars"];
    NSArray *descricao = @[@"Chewie"];
    NSArray *horario = @[@"00:00"];
    NSArray *preco = @[@"1,00"];
    
    for (int i; i < [nome count]; ++i)
    {
        [self createFilmeWithNome:[nome objectAtIndex:i] andHorario:[horario objectAtIndex:i] andPreco:[preco objectAtIndex:i] andDescricao:[descricao objectAtIndex:i]];
    }
    
}

- (Filme *)createFilmeWithNome:(NSString *)nome andHorario:(NSString *)horario andPreco:(NSString *)preco andDescricao:(NSString *)descricao
{
    Filme *f = [NSEntityDescription
                                insertNewObjectForEntityForName:DATA_MODEL_ENTITY_NAME
                                inManagedObjectContext:self.managedObjectContext];
    
    f.id = [[[NSUUID alloc] init] UUIDString];
    f.nome = nome;
    f.horario = horario;
    f.preco = preco;
    f.descricao = descricao;
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Could not save %@, %@", error, error.userInfo);
    }
    
    return f;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:DATA_MODEL_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
        
        [fetchRequest setEntity:entity];
        
        // Set the batch size to a suitable number.
        [fetchRequest setFetchBatchSize:20];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"code" ascending:YES];
        NSArray *sortDescriptors = @[sortDescriptor];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        // _fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        if (![_fetchedResultsController performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    return _fetchedResultsController;
}

@end
