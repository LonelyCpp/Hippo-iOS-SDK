//
//  HippoProperty.swift
//  Hippo
//
//  Created by Vishal on 14/02/19.
//

import Foundation

class HippoProperty: NSObject {
    static var current = HippoProperty()
    
    //Inital Form collector info
    var forms: [FormData] = []
    var formCollectorTitle: String = ""
    var botGroupId: Int = -1
    
    //Properties
    var showMessageSourceIcon: Bool = false
    private(set) var isPaymentRequestEnabled: Bool = false
    var hideCallIconOnNavigationForCustomer: Bool = true
    
    
    func updatePaymentRequestStatus(enable: Bool) {
        isPaymentRequestEnabled = enable
    }
    
    class func setBotGroupID(id: Int) {
        current.botGroupId = id
    }
    
    func shouldSendBotGroupId() -> Bool {
        return botGroupId > 0
    }
}



