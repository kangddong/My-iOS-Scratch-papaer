//
//  TestController.swift
//
//
//  Created by 강동영 on 8/16/24.
//

import Vapor

struct TestController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let route = routes.grouped("test")
        route.get { req -> String in
            "Connected"
        }
    }
}
