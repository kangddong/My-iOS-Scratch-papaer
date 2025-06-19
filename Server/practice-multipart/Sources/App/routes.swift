import Vapor
import FluentKit

func routes(_ app: Application) throws {
    let test = app.grouped("test")
    try test.group(TestApiMiddleware()) { api in
        try api.register(collection: ImageUploadController())
    }
    
    
    let api = app.grouped("v1")
    try api.group(EnsureApiDomainMiddleware()) { api in
        try api.register(collection: ImageUploadController())
    }
}

