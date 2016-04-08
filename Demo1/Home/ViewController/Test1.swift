//
//  Test1.swift
//  Demo1
//
//  Created by speedx on 16/4/8.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import Foundation
import UIKit
import MapKit

@objc class Test1: NSObject {
    
    func testAction() -> String {
        return "xxxxx"
    }
    
    class func testAction1(str:String) -> String {
        return "xxxxx1"
    }
    
    
    class func testAction11111() -> String {
        return "xxxxx1"
    }
    
    class func testAction2(str:String) -> String {
        
       return "sdfsf";
        
        
    }
    
    
    /// 方法里面如果没有参数就 oc 就可以调用，否则不能调用。
    class func decodePolyline(encodedPolyline: String, precision: Double = 1e5) -> [CLLocationCoordinate2D]? {
        
        return nil;
    }
    
}