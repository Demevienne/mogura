//
//  RandomIntCreate.swift
//  mogura
//
//  Created by 上田 志雄 on 2016/01/11.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import Foundation

class CreateRandomInt {
    // 最小値と最大値の間で乱数を作成する
    class func minMaxDesignation(min _min: Double, max _max: Double) -> Double {
        if _min < _max {
            let diff = _max - _min + 1
            let random : Double = Double(arc4random_uniform(UInt32(diff)))
            return random + _min
        }else {
            print("error")
            return 0
        }
    }
    
    // 最小値から指定の範囲までの乱数を作成する
    class func minRange(min _min: Double, range _range: Double) -> Double {
        let random : Double = Double(arc4random_uniform(UInt32(_range)))
        return _min + random
    }
    
    // 最大値から指定の範囲までの乱数を作成する
    class func maxRange(max _max: Double,range _range: Double) -> Double {
        let random : Double = Double(arc4random_uniform(UInt32(_range)))
        let min = _max - _range + 1
        return min + random
    }
}