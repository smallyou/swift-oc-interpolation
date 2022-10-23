//
//  IMManager.swift
//  imsdk
//
//  Created by harvy on 2022/10/23.
//

// import oc module
@_implementationOnly import IMEngine
import ObjectiveC
import Foundation


public protocol IMSDKListener : AnyObject {
    func onLogined();
}

public class IMManager {
    
    // proxy
    lazy var sdkListenerSet          = [IMWeakProxy]()
    
    // proxy of IMSDKListener
    lazy var listenerProxy: IMSDKListenerProxy = {
        [weak self] in
        let proxy = IMSDKListenerProxy()
        proxy.delegate = self
        return proxy
    }()
    
    public static let shared: IMManager = IMManager()
    
    
    public func addSDKListener(listener: IMSDKListener) {
        addSDKListenerInternal(listener: listener)
    }
    
    public func login() {
        loginInternal()
    }
}
