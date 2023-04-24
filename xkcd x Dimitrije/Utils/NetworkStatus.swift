//
//  NetworkStatus.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//  Function to check network status
//

import Foundation
import Network

class NetworkStatus: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isOnline = false
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isOnline = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
            
        }
        networkMonitor.start(queue: workerQueue)
    }
}
