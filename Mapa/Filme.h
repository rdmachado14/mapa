//
//  Filme.h
//  Mapa
//
//  Created by Rodrigo DAngelo Silva Machado on 5/12/15.
//  Copyright (c) 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface Filme : NSManagedObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *nome;
@property (nonatomic, retain) NSString *descricao;
@property (nonatomic, retain) NSString *horario;
@property (nonatomic, retain) NSString *preco;

@end
