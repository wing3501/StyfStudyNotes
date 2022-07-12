//
//  PreferencesStore.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//

import Combine
import Foundation

protocol PreferencesStoreProtocol: ObservableObject {
  var friendsListPreference: PrivacyLevel { get set }
  var photosPreference: PrivacyLevel { get set }
  var feedPreference: PrivacyLevel { get set }
  var videoCallsPreference: PrivacyLevel { get set }
  var messagePreference: PrivacyLevel { get set }
  func resetPreferences()
}

final class PreferencesStore: PreferencesStoreProtocol {
  @Published var friendsListPreference = value(for: .friends, defaultValue: .friend) {
    didSet {
      set(value: photosPreference, for: .friends)
    }
  }

  @Published var photosPreference = value(for: .photos, defaultValue: .friend) {
    didSet {
      set(value: photosPreference, for: .photos)
    }
  }

  @Published var feedPreference = value(for: .feed, defaultValue: .friend) {
    didSet {
      set(value: feedPreference, for: .feed)
    }
  }

  @Published var videoCallsPreference = value(for: .videoCall, defaultValue: .closeFriend) {
    didSet {
      set(value: videoCallsPreference, for: .videoCall)
    }
  }

  @Published var messagePreference: PrivacyLevel = value(for: .message, defaultValue: .friend) {
    didSet {
      set(value: messagePreference, for: .message)
    }
  }

  func resetPreferences() {
    let defaults = UserDefaults.standard
    PrivacySetting.allCases.forEach { setting in
      defaults.removeObject(forKey: setting.rawValue)
    }
  }

  private static func value(for key: PrivacySetting, defaultValue: PrivacyLevel) -> PrivacyLevel {
    let value = UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    return PrivacyLevel.from(string: value) ?? defaultValue
  }

  private func set(value: PrivacyLevel, for key: PrivacySetting) {
    UserDefaults.standard.setValue(value.title, forKey: key.rawValue)
  }
}
