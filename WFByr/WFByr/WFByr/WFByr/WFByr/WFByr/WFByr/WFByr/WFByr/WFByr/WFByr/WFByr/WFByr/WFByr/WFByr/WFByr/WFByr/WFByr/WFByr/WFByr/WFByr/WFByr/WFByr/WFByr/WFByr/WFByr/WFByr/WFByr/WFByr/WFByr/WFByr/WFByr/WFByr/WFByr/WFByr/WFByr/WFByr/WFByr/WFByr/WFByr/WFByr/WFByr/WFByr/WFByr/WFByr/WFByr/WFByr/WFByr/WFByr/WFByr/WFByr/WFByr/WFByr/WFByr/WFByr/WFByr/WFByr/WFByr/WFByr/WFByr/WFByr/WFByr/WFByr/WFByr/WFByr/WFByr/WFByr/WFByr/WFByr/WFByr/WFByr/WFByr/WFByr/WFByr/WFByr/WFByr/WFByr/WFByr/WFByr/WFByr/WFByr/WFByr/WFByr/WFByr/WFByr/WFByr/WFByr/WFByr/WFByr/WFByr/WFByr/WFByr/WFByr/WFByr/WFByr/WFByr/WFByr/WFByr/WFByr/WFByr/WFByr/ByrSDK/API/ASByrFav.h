//
//  ASByrFav.h
//  ASByr
//
//  Created by andy on 16/3/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"

@interface ASByrFav : ASByrBase

- (instancetype)initWithAccessToken:(NSString *)token;

- (void)fetchFavsWithLevel:(NSInteger)level
              successBlock:(ASSuccessCallback)success
              failureBlock:(ASSuccessCallback)failure;

- (void)addFavWithLevel:(NSInteger)level
                   name:(NSString*)name
                    dir:(NSInteger)dir
           successBlock:(ASSuccessCallback)success
           failureBlock:(ASSuccessCallback)failure;

- (void)deleteFavWithLevel:(NSInteger)level
                      name:(NSString*)name
                       dir:(NSInteger)dir
              successBlock:(ASSuccessCallback)success
              failureBlock:(ASSuccessCallback)failure;

@end
