//
//  ExamsAPITarget.swift
//  Remote examination
//
//  Created by Anna Abdeeva on 22.03.2022.
//

import Foundation
import Moya

enum StudentAPIEndpoint {
    case production
    
    var url: URL {
        switch self {
        case .production: return URL(string: "http://217.71.129.139:4502")!
        }
    }
}

enum StudentAPIRoute {
    case ticket(String)
    case login(String)
}

// MARK: - Target

struct ExamsAPITarget: TargetType {
    let endpoint: StudentAPIEndpoint
    let route: StudentAPIRoute
    
    var baseURL: URL {
        endpoint.url
    }

    var path: String {
        switch route {
        case .ticket:
            return "/student/ticket"
            
        case .login:
            return "login"
        }
    }

    var method: Moya.Method {
        switch route {
        case .ticket:
            return .get
            
        case .login:
            return .post
        }
    }

    var task: Task {
        switch route {
        case .ticket:
            return .requestPlain
            
        case .login:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch route {
        case let .login(credentials):
            return ["X-Authentication": credentials]
            
        case let .ticket(token):
            return ["X-Access-Token": token]
        }
        
    }
}
