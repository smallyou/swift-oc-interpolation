//
//  IMInner.swift
//  imsdk
//
//  Created by harvy on 2022/10/23.
//

import Foundation
@_implementationOnly import IMEngine

class IMWeakProxy {
    weak var target: AnyObject?
    init(target: AnyObject) {
        self.target = target
    }
}

class IMSDKListenerProxy : NSObject {
    weak var delegate: IMManager?
}


extension IMSDKListenerProxy : IMEngine.IMSDKListener {
    func onLogined() {
        if let delegate = delegate {
            delegate.sdkListenerSet.forEach { item in
                if let target = item.target as? IMSDKListener {
                    target.onLogined()
                }
            }
        }
    }
}


extension IMManager {
    
    func getEngine() -> IMEngine.IMManager {
        return IMEngine.IMManager.share()
    }
    
    func checkIfAddListener() {
        if sdkListenerSet.isEmpty {
            getEngine().remove(listenerProxy)
        } else {
            getEngine().add(listenerProxy)
        }
    }
    
    func addSDKListenerInternal(listener: IMSDKListener) {
        self.removeIMSDKListenerInternal(listener: listener)
        DispatchQueue.main.async { [weak self] in
            self?.sdkListenerSet.append(IMWeakProxy(target: listener))
            self?.checkIfAddListener()
        }
    }
    
    func removeIMSDKListenerInternal(listener: IMSDKListener) {
        DispatchQueue.main.async { [weak self] in
            self?.sdkListenerSet.removeAll { item in
                guard let target = item.target else {
                    return true
                }
                return target.isEqual(listener)
            }
            self?.checkIfAddListener()
        }
    }
    
    func loginInternal() {
        getEngine().login()
    }
}
