//
//  DeveloperPreview+Ext.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 02/04/24.
//

import SwiftUI
import FirebaseFirestore

struct DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let ticketOpen = Ticket(machineType: "Tester", machineName: "Bulb Tester", problem: "Machine not move", ticketStatus: "Open", createdBy: "Test User", createdAt: Timestamp())
    
    let tikcetOnprogress = Ticket(machineType: "Tester", machineName: "Bulb Tester", problem: "Machine not move", ticketStatus: "On Progress", createdBy: "Test User", createdAt: Timestamp(), closedAt: nil, respondBy: "Tim Cook", actions: nil, closedBy: nil)
    
    let ticketClose = Ticket(machineType: "Tester", machineName: "Bulb Tester", problem: "Machine Not Move", ticketStatus: "Closed", createdBy: "Test User", createdAt: Timestamp(), closedAt: Timestamp(), respondBy: "Tim Cook", actions: "Change power supply", closedBy: "Tim Cook")
}

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.shared
    }
}
