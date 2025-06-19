import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.routes.defaultMaxBodySize = "10mb"
    // Device에서 사용하고 싶을시에
//    let homeIP = "111.22.3.44" // ifconfig | grep inet
//    app.http.server.configuration.hostname = homeIP
    
    // MARK: Routes
    // register routes
    try routes(app)
}
