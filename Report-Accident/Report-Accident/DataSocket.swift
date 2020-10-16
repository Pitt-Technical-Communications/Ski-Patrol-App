//
//  DataSocket.swift
//  Report-Accident
//
//  Created by Andrew Toader on 10.15.20.
//

import Foundation

struct DataSocket
{
    let ipAddress: String!
    let port: Int!
    
    init(ip: String, port_in: Int)
    {
        self.ipAddress = ip
        self.port = port_in
    }
}
