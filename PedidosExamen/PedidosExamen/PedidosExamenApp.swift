//
//  PedidosExamenApp.swift
//  PedidosExamen
//
//  Created by CCDM03 on 14/11/22.
//

import SwiftUI
import CoreData

@main
struct Examen1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(CoreDM:CoreDataManager())
        }
    }
}
