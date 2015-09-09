/*
 * Copyright 2012 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "ZXRawBarSpaceWriter.h"
#import "ZXBoolArray.h"

@implementation ZXRawBarSpaceWriter

- (ZXBitMatrix *)encode:(NSString *)contents format:(ZXBarcodeFormat)format width:(int)width height:(int)height hints:(ZXEncodeHints *)hints error:(NSError **)error {
    if (format != kBarcodeFormatRawBarSpace) {
        [NSException raise:NSInvalidArgumentException format:@"Can only encode Raw Bar Space"];
    }
    
    return [super encode:contents format:format width:width height:height hints:hints error:error];
}

- (ZXBoolArray *)encode:(NSString *)contents {
    int count = 0;
    NSInteger myArray[contents.length];
    for (int i = 0; i < contents.length ; i++) {
        NSString *ch = [contents substringWithRange:NSMakeRange(i, 1)];
        int value = ch.intValue;
        count += value;
        myArray[i] = value;
    }
    ZXBoolArray *result = [[ZXBoolArray alloc] initWithLength:count];
    [self appendPattern:result pos:0 pattern:myArray patternLen:sizeof(myArray)/sizeof(int) startColor:YES];
    return result;
}

@end
