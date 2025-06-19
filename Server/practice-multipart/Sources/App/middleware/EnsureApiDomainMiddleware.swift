//
//  EnsureApiDomainMiddleware.swift
//
//
//  Created by 강동영 on 8/16/24.
//

import Vapor

struct EnsureApiDomainMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        return next.respond(to: request)
    }
}
