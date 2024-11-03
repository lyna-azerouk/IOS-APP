import Foundation

struct APIResponse: Codable {
    let code: Int
    let resource: Resource
}

struct Resource: Codable {
    let email: String
    let password: String
}
