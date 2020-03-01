//
//  CoreDataManager.h
//  GithubSearchApp
//
//  Created by Francisco Herranz on 01/03/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

+ (CoreDataManager *)sharedInstance;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

@end
