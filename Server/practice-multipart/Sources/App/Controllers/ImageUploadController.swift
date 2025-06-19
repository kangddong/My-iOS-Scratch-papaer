//
//  ImageUploadController.swift
//
//
//  Created by 강동영 on 8/16/24.
//

import Vapor

struct ImageUploadController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let route = routes.grouped("images")
        route.post("upload", use: create)
    }
    
    func create(req: Request) throws -> EventLoopFuture<Response> {
        do {
            print(req.body.description)
            req.headers.forEach {
                print("\($0.name), \($0.value)")
            }
            let imageUpload = try req.content.decode(ImageUpload.self)
            let file = imageUpload.file
            let savePath = "Public/images/\(file.filename)"
            print("savePath: \(savePath)")
            
            return req.fileio.writeFile(file.data, at: savePath)
                .map {
                    let response = ["status": "success upload", "fileName": file.filename]
                    return Response(status: .ok, body: .init(string: response.description))
                }
        } catch {
            let response = ["status": "error", "message": "Failed to decode request"]
            return req.eventLoop.makeSucceededFuture(
                Response(status: .ok, body: .init(string: response.description))
            )
        }
    }
}
