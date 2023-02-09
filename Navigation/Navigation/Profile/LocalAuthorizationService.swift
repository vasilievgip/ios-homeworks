//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Андрей Васильев on 06.02.2023.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {

    enum BiometricType {
        case none
        case faceID
        case touchID
        case unknown
    }

    private func biometricType(for type: LABiometryType) -> BiometricType {
        switch type {

        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        @unknown default:
            return .unknown
        }
    }

    enum BiometricError: LocalizedError {
        case authenticationFailed
        case userCancel
        case userFallback
        case biometryNotAvailable
        case biometryNotEnrolled
        case biometryLockout
        case unknown

        var errorDescription: String? {
            switch self {
            case .authenticationFailed:
                return "biometricErrorAuthenticationFailed".localized
            case .userCancel:
                return "biometricErrorUserCancel".localized
            case .userFallback:
                return "biometricUserFallback".localized
            case .biometryNotAvailable:
                return "biometricBiometryNotAvailable".localized
            case .biometryNotEnrolled:
                return "biometricBiometryNotEnrolled".localized
            case .biometryLockout:
                return "biometricBiometryLockout".localized
            case .unknown:
                return "biometricUnknown".localized
            }
        }
    }

    private func biometricError(from nsError: NSError) -> BiometricError {
        let error: BiometricError

        switch nsError {
        case LAError.authenticationFailed:
            error = .authenticationFailed
        case LAError.userCancel:
            error = .userCancel
        case LAError.userFallback:
            error = .userFallback
        case LAError.biometryNotAvailable:
            error = .biometryNotEnrolled
        case LAError.biometryLockout:
            error = .biometryLockout
        default:
            error = .unknown
        }
        return error
    }

    private let context = LAContext()
    private let policy: LAPolicy
    private let localizedReason: String
    private var error: NSError?

    init(
        policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
        localizedReason: String = "localizedReason".localized,
        localizedFallbackTitle: String = "localizedFallbackTitle".localized
    ) {
        self.policy = policy
        self.localizedReason = localizedReason
        context.localizedFallbackTitle = localizedFallbackTitle
        context.localizedCancelTitle = "localizedCancelTitle".localized

    }

    func canEvaluate(completion: (Bool, BiometricType, BiometricError?) -> Void) {
        guard context.canEvaluatePolicy(policy, error: &error) else {
            let type = biometricType(for: context.biometryType)
            guard let error = error else {
                return completion(false, type, nil)
            }
            return completion(false, type, biometricError(from: error))
        }
        completion(true, biometricType(for: context.biometryType), nil)
    }

    func evaluate(completion: @escaping (Bool, BiometricError?) -> Void) {
        context.evaluatePolicy(policy, localizedReason: localizedReason) {
            [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    completion(true, nil)
                } else {
                    guard let error = error else {
                        return completion(false, nil)
                    }
                    completion(false, self?.biometricError(from: error as NSError))
                }
            }
        }
    }
}
