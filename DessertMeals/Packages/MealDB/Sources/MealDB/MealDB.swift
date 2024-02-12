// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class MealAPI {
    
    private let baseURL: String = "https://www.themealdb.com/api/json/v1/1/"
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    
    public init(){}
    
    func fetch<D:Decodable>(response: D.Type = D.self, from endpoint: String) async throws -> D {
        let urlString = baseURL + endpoint
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(D.self, from: data)

    }

}
