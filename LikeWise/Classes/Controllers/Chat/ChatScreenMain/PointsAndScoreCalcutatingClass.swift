//
//  PointsAndScoreCalcutatingClass.swift
//  LikeWise
//
//  Created by Aman Kumar on 22/04/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation


class PointsAndScoreCalcutatingClass {
    //TODO: Singleton object
    static let shared = PointsAndScoreCalcutatingClass()
    private init() {}
    
    public func returnPoints(matchPercentage:Double,matchedSuggesion:Double,round:Double)->Double{
        return (1 - matchPercentage / 100) * matchedSuggesion
    }
    
    public func returnScore(point:Double,bonus:Double,streak:Double)->Double{
        return (streak > 0.0) ? point*bonus*streak : point*bonus

    }
    
    
}
