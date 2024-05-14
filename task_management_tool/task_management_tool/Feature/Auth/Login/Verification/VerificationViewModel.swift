//
//  VerificationViewModel.swift
//  task_management_tool
//
//  Created by i564407 on 5/13/24.
//

import Foundation
import SwiftUI

class VerificationViewModel: ObservableObject {
    
    @Published var code: [String] = Array(repeating: "", count: 6)
    @FocusState var focusedField: Int?
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isVerified: Bool = false
    
    private let userId: String?
    
    init(userId: String) {
        self.userId = userId
    }

    func handleTextChange(at index: Int, newValue: String) {
        if newValue.count > 1 {
            code[index] = String(newValue.prefix(1))
        } else if newValue.isEmpty && index > 0 {
            focusedField = index - 1
        } else if newValue.count == 1 && index < 5 {
            focusedField = index + 1
        }
    }
    
    func verify() {
        let verificationCode = code.joined()
        isLoading = true
        let userNetworkManager = NetworkManager<AuthService>()
        userNetworkManager.request(target: .verifyActivityCode(userId: self.userId ?? "", token: verificationCode)) { [weak self] (result: Result<ApiResponse<String>, NetworkError>) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let success):
                self.isVerified = true
            case .failure(let failure):
                self.alertMessage = failure.localizedDescription
                self.showAlert = true
            }
        }
    }
}
                                                                                                                            
