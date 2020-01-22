//
//  Requests.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/20/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    
    // MARK: - login
    static func userLogin(email: String, password: String, completion: @escaping (_ userData: UserData?) -> Void) {
        var loginData: UserData?
        guard let url = URL(string: KLOGIN) else {
            completion(nil)
            return
        }
        request(url, method: .post, parameters: ["email" : email, "password" : password, "firebase_token" : "0"], encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    let _data = try? JSONDecoder().decode(Login.self, from: data)
                    loginData = _data?.data!
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
                }
                return completion(loginData)
        }
    }
    
    // MARK: - Register
    static func userRegister(newUser: NewUser, completion: @escaping (_ newUserInfo: UserInfo?) -> Void) {
        var registerInfo: UserInfo?
        guard let url = URL(string: KREGISTER) else {
            completion(nil)
            return
        }
        let parameters = [
            "email" : newUser.email!,
            "name" : newUser.name!,
            "phone" : newUser.phoneNumber!,
            "password" : newUser.password!,
            "confirmpass" : newUser.password!,
            "firebase_token" : "0",
            "device_id" : "0",
            "city" : newUser.city!,
            "role" : newUser.userType!,
            "lat" : "0",
            "lng" : "0"
        ]
        request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    let _data = try? JSONDecoder().decode(Register.self, from: data)
                    registerInfo = _data?.data!
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
                }
                return completion(registerInfo)
        }
    }
    
    // MARK: - Get all items
    static func getAllItems(itemKeyword: String?, completinon: @escaping(_ allItemsData: [ItemData]) -> Void ) {
        var itemsData: [ItemData] = []
        guard let url = URL(string: KALLITEMS) else {
            completinon(itemsData)
            return
        }
        request(url, method: .post, parameters: ["keyword" : itemKeyword ?? ""], encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let allData = try JSONDecoder().decode(AllItems.self, from: data)
                        for _data in allData.data! {
                            itemsData.append(_data)
                        }
                    } catch {
                        print("There is no products")
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                return completinon(itemsData)
        }
    }
    
    // MARK: - Get all families
    static func getAllFamilies(completion: @escaping (_ allFamiliesData: [FamilyData]) -> Void) {
        var familiesData: [FamilyData] = []
        guard let url = URL(string: KALLFAMILIES) else {
            completion(familiesData)
            return
        }
        request(url, method: .post, parameters: ["" : ""], encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let allData = try JSONDecoder().decode(AllFamilies.self, from: data)
                        for _data in allData.data! {
                            familiesData.append(_data)
                        }
                    } catch {
                        print(error.localizedDescription)

                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                return completion(familiesData)
        }
    }
    
    // MARK: - profile request
    static func userProfile(userId: Int, completion: @escaping(_ userInfo: ProfileInfo?) -> ()) {
        var userInfo: ProfileInfo?
        guard let url = URL(string: KPROFILE) else {
            completion(nil)
            return
        }
        request(url, method: .post, parameters: ["user_id" : userId], encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let _data = try JSONDecoder().decode(Profile.self, from: data)
                        userInfo = _data.data!
                        completion(userInfo)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    // MARK: - Change password
    static func changePassword(userId: Int, oldPass: String, newPass: String, completion: @escaping(_ message: Bool?) -> Void ) {
        guard let url = URL(string: KCHANGEPASS) else {
            completion(nil)
            return
        }
        let parameters: [String : Any] = [
            "old_password" : oldPass,
            "new_password" : newPass,
            "confirmpassword" : newPass,
            "user_id" : userId
        ]
        request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let _data = try JSONDecoder().decode(Password.self, from: data)
                        completion(_data.message!)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    // MARK: - My favorites
    static func getFavoriteItems(userId: Int, completion: @escaping(_ allData: [ItemData]) -> Void) {
        var dataArray: [ItemData] = []
        guard let url = URL(string: KFAVORITE) else {
            completion(dataArray)
            return
        }
        request(url, method: .post, parameters: ["user_id" : userId], encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let allData = try JSONDecoder().decode(AllItems.self, from: data)
                        for _data in allData.data! {
                            dataArray.append(_data)
                        }
                    } catch {
                        print("There is no favorite items")
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                return completion(dataArray)
        }
    }
    
    // MARK: - OsraItems
    static func getOsraItems(osraId: Int, completion: @escaping(_ allData: [ItemData]) -> Void) {
        var dataArray: [ItemData] = []
        guard let url = URL(string: KOSRAITEMS) else {
            completion(dataArray)
            return
        }
        request(url, method: .post, parameters: ["user_id" : osraId], encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let allData = try JSONDecoder().decode(AllItems.self, from: data)
                        for _data in allData.data! {
                            dataArray.append(_data)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                return completion(dataArray)
        }
    }
    
    // MARK: - Make favorite
    static func makeFavorite(state: FavoriteState, itemId: Int, completion: @escaping(_ message: Bool) -> Void) {
        var key = ""
        if state == .add { key = KMAKEFAVORITE }
        else if state == .delete { key = KCANCELFAVORITE }
        guard let url = URL(string: key) else { return }
        guard let userId = getUserId() else { return }
        request(url, method: .post, parameters: ["user_id" : userId, "item_id" : itemId], encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let data = try JSONDecoder().decode(MakeFavorite.self, from: data)
                        return completion(data.message!)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    static func addToCart(parameters: [String : Any], completion: @escaping(_ message: Bool) -> Void) {
        guard let url = URL(string: KADDTOCART) else { return }
        request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let data = try JSONDecoder().decode(Cart.self, from: data)
                    return completion(data.message!)
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getCartItems(parameters: [String : Int], completion: @escaping(_ cartItems: [CartData]) -> Void) {
        guard let url = URL(string: KCARTITEMS) else { return }
        request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let _data = try JSONDecoder().decode(CartItems.self, from: data)
                    return completion(_data.data!)
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func deleteCartItem(parameters: [String : Int], completion: @escaping(_ message: Bool) -> Void) {
        guard let url = URL(string: KDELETECARTITEM) else { return }
        request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let message = try JSONDecoder().decode(DeleteCartItem.self, from: data)
                    completion(message.message!)
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - my order request
    static func getMyOrder(parameters: [String : Int], completion: @escaping(_ orderData: [MyOrderData]?) -> Void) {
        guard let url = URL(string: KMYORDER) else { return }
        request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let _data = try JSONDecoder().decode(MyOrder.self, from: data)
                    if _data.message! {
                        completion(_data.data!)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
