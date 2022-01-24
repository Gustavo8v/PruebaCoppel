//
//  NetworkManager.swift
//  PruebaCoppel
//
//  Created by Gustavo on 22/01/22.
//

import Foundation

class NetWorkManager {
    
    static let shared : NetWorkManager = NetWorkManager()
    var apiKey = "de6d3cd742a4e503165b11c969ee4c22"
    var endPonit = "https://api.themoviedb.org/3"
    var sessionID: CloseSessionDTO?
    
    func createToken(succesHandeler: @escaping(ModelGenericRequest?) -> Void, errorHandler: @escaping(Error?) -> Void){
        let url = URL(string: "\(endPonit)/authentication/token/new?api_key=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            switch httpResponse?.statusCode{
            case 200:
                do{
                    if let jData = data {
                        let decodedData = try JSONDecoder().decode(ModelGenericRequest.self,from: jData)
                        succesHandeler(decodedData)
                        print("jason: \(decodedData)")
                    }
                }catch{
                    errorHandler(error)
                    print("Error: \(error)")
                }
            default:
                errorHandler(error)
            }
        }.resume()
    }
    
    func logIn(user: logInDTO?, succesHandeler: @escaping(ModelGenericRequest?) -> Void, errorHandler: @escaping(Error?) -> Void){
        let url = URL(string: "\(endPonit)/authentication/token/validate_with_login?api_key=\(apiKey)")!
        var request = URLRequest(url: url)
        let bodyRequest = try! JSONEncoder().encode(user)
        request.httpMethod = "POST"
        request.httpBody = bodyRequest
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            switch httpResponse?.statusCode {
            case 200:
                do{
                    if let jData = data {
                        let decodedData = try JSONDecoder().decode(ModelGenericRequest.self,from: jData)
                        succesHandeler(decodedData)
                        print("jason: \(decodedData)")
                    }
                }catch{
                    errorHandler(error)
                    print("Error: \(error)")
                }
            default:
                errorHandler(error)
            }
        }.resume()
    }
    
    func createSession(token: CreateSessionDTO?, succesHandeler: @escaping(ModelGenericRequest?) -> Void, errorHandler: @escaping(Error?) -> Void){
        let url = URL(string: "\(endPonit)/authentication/session/new?api_key=\(apiKey)")!
        var request = URLRequest(url: url)
        let bodyRequest = try! JSONEncoder().encode(token)
        request.httpMethod = "POST"
        request.httpBody = bodyRequest
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            switch httpResponse?.statusCode{
            case 200:
                do{
                    if let jData = data {
                        let decodedData = try JSONDecoder().decode(ModelGenericRequest.self,from: jData)
                        self.sessionID = CloseSessionDTO(session_id: decodedData.session_id)
                        succesHandeler(decodedData)
                        print("jason: \(decodedData)")
                    }
                }catch{
                    errorHandler(error)
                    print("Error: \(error)")
                }
            default:
                errorHandler(error)
            }
        }.resume()
    }
    
    func getMovies(page:String, succesHandeler: @escaping(MoviesDTO?) -> Void, errorHandler: @escaping(Error?) -> Void){
        let url = URL(string: "\(endPonit)/movie/popular?api_key=\(apiKey)&language=es-MX&page=\(page)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            switch httpResponse?.statusCode{
            case 200:
                do{
                    if let jData = data {
                        let decodedData = try JSONDecoder().decode(MoviesDTO.self,from: jData)
                        succesHandeler(decodedData)
                        print("jason: \(decodedData)")
                    }
                }catch{
                    errorHandler(error)
                    print("Error: \(error)")
                }
            default:
                errorHandler(error)
            }
        }.resume()
    }
    
    func closeSession(session: CloseSessionDTO?, succesHandeler: @escaping(ModelGenericRequest?) -> Void, errorHandler: @escaping(Error?) -> Void){
        let url = URL(string: "\(endPonit)/authentication/session?api_key=\(apiKey)")!
        var request = URLRequest(url: url)
        let bodyRequest = try! JSONEncoder().encode(session)
        request.httpMethod = "DELETE"
        request.httpBody = bodyRequest
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            switch httpResponse?.statusCode{
            case 200:
                do{
                    if let jData = data {
                        let decodedData = try JSONDecoder().decode(ModelGenericRequest.self,from: jData)
                        self.sessionID = CloseSessionDTO(session_id: decodedData.session_id)
                        succesHandeler(decodedData)
                        print("jason: \(decodedData)")
                    }
                }catch{
                    errorHandler(error)
                    print("Error: \(error)")
                }
            default:
                errorHandler(error)
            }
        }.resume()
    }
}
