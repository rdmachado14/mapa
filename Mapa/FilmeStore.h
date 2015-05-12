//
//  FilmeStore.h
//  Mapa
//
//  Created by Rodrigo DAngelo Silva Machado on 5/12/15.
//  Copyright (c) 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Filme.h"
@import CoreData;

@interface FilmeStore : NSObject

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

+ (instancetype)sharedStore;

- (Filme *)createFilmeWithNome:(NSString *)nome andHorario:(NSString *)horario andPreco:(NSString *)preco andDescricao:(NSString *)descricao;

@end
