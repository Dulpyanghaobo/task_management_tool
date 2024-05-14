//
//  RegisterViewModel.swift
//  task_management_tool
//
//  Created by i564407 on 5/13/24.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isRegistered: Bool = false
    @Published var isLoading: Bool = false
    @Published var userId: String = ""

    func register() {
        guard password == confirmPassword else {
            alertMessage = "Password and Confirm Password do not match"
            showAlert = true
            return
        }
        
        let userRegistrationRequest = UserRegistrationRequest(
            userName: username,
            avatar: "",
            email: email,
            password: password
        )
        
        isLoading = true
        let userNetworkManager = NetworkManager<AuthService>()
        userNetworkManager.request(target: .register(userRequest: userRegistrationRequest)) { [weak self] (result: Result<ApiResponse<String>, NetworkError>) in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success(let response):
                if response.status == 201 {
                    self.isRegistered = true
                    self.userId = response.data ?? ""
                } else {
                    self.alertMessage = response.message
                    self.showAlert = true
                }
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            }
        }
    }
}
