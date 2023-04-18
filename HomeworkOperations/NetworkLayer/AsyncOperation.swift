//
//  AsyncOperation.swift
//  HomeworkOperations
//
//  Created by Александр Ковбасин on 18.04.2023.
//

import Foundation

class AsyncOperation : Operation {
    override init() {
        super.init()
    }
    
    override var isAsynchronous: Bool {
        get {
            return true
        }
    }
    
    enum State : String {
        case ready, executing, finished
        var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override var isReady: Bool {
        get {
            return super.isReady && state == .ready
        }
    }
    
    override var isExecuting: Bool {
        get {
            return state == .executing
        }
    }
    
    override var isFinished: Bool {
        get {
            return state == .finished
        }
    }
    
    private var _isCancelled = false {
        willSet {
            willChangeValue(forKey: "isCancelled")
        }
        didSet {
            didChangeValue(forKey: "isCancelled")
        }
    }
    
    override var isCancelled: Bool {
        get {
            return _isCancelled
        }
    }
    
    override func start() {
        guard isCancelled == false else {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    
    override func cancel() {
        _isCancelled = true
    }
}
