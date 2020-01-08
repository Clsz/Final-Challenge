import Foundation

class Service{
    
    static func sendNotification(message:String, token:[String], idSender:String, idRequest:String, tabBar:Int, completion : @escaping (Error?) -> Void) {
        
        let session = URLSession(configuration: .default)
        let components = URLComponents(string: ConstantManager.baseURL)!
        var request = URLRequest(url: components.url!)
//        let json = "message=\(message)&token=\(token)&id_request=\(idRequest)&tab_bar_index=\(tabBar)&id_sender=\(idSender)"
        let json = ["message":message,
                    "token":token,
                    "id_request":idRequest,
                    "tab_bar_index":tabBar,
                    "id_sender":idSender] as [String : Any]
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(err)
            }
            completion(nil)
        }
        task.resume()
    }
    
}
