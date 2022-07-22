//
//  Observable.swift
//  Meanings
//
//  Created by 1964058 on 08/07/22.
//

import Foundation

class Observable<T> {
    
    private var listener: ((T?)->Void)?
    
    var value:T? {
        didSet {
            listener?(self.value)
        }
    }
        
    func bind(_ listener:@escaping (T?)->Void) {
        self.listener = listener
    }
}
