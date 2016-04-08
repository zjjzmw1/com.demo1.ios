//
//  Polyline.swift
//  TransitApp
//
//  Created by Mohamed Salem on 12/17/15.
//  Copyright © 2015 Machometus. All rights reserved.
//

import Foundation
import UIKit
import MapKit

@objc class Polyline: NSObject {
    
    // Polyline error type
    
    enum PolylineError: ErrorType {
        
        case SingleCoordinateDecodingError
        case ChunkExtractingError
        
    }
    
    
    
    
    
    class func dddd(dd:String,xx:Double) -> [Int]?{
        return nil
    }
    
    class func eeee(dd:String,xx:CLLocationCoordinate2D) -> [Int]?{
        return nil
    }
    
    class func ffff(dd:String,xx:Double) -> [CLLocationCoordinate2D]?{
        return nil
    }
    
    
    
    
    
    
    // Decode google maps polyline string to coordinate
    
    class func decodeSingleCoordinate(byteArray byteArray: UnsafePointer<Int8>, length: Int, inout position: Int, precision: Double = 1e5) throws -> Double {
        
        guard position < length else { throw PolylineError.SingleCoordinateDecodingError }
        
        let bitMask = Int8(0x1F)
        
        var coordinate: Int32 = 0
        
        var currentChar: Int8
        var componentCounter: Int32 = 0
        var component: Int32 = 0
        
        repeat {
            
            currentChar = byteArray[position] - 63
            component = Int32(currentChar & bitMask)
            coordinate |= (component << (5*componentCounter))
            position++
            componentCounter++
            
        } while ((currentChar & 0x20) == 0x20) && (position < length) && (componentCounter < 6)
        
        if (componentCounter == 6) && ((currentChar & 0x20) == 0x20) {
            throw PolylineError.SingleCoordinateDecodingError
        }
        
        if (coordinate & 0x01) == 0x01 {
            coordinate = ~(coordinate >> 1)
        }
        else {
            coordinate = coordinate >> 1
        }
        
        return Double(coordinate) / precision
    }
    
    // Decode array of google maps polyline string to an array of coordinates
    
    
    
    
    class func decodePolyline(encodedPolyline: String, precision: Double = 1e5) -> [NSValue]? {
        
        let data = encodedPolyline.dataUsingEncoding(NSUTF8StringEncoding)!
        
        let byteArray = unsafeBitCast(data.bytes, UnsafePointer<Int8>.self)
        let length = Int(data.length)
        var position = Int(0)
        
//        var decodedCoordinates = [CLLocationCoordinate2D]()
        var result = [NSValue]()
        
        var lat = 0.0
        var lon = 0.0
        
        while position < length {
            
            do {
                
                let resultingLat = try decodeSingleCoordinate(byteArray: byteArray, length: length, position: &position, precision: precision)
                lat += resultingLat
                
                let resultingLon = try decodeSingleCoordinate(byteArray: byteArray, length: length, position: &position, precision: precision)
                lon += resultingLon
                
            }
            catch {
                return nil
            }
            
//            decodedCoordinates.append(CLLocationCoordinate2D(latitude: lat, longitude: lon))
            
            result.append(NSValue.init(MKCoordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)))

        }
        
        return result

//        return decodedCoordinates
    }
    
}
