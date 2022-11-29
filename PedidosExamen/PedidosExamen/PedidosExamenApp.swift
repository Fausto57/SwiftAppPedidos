//
//  PedidosExamenApp.swift
//  PedidosExamen
//
//  Created by CCDM03 on 14/11/22.
//

import SwiftUI

@main
struct PedidosExamenApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(CoreData: NSCoreDataManager())
        }
    }
}
