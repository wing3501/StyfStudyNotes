//
//  ProfileContentProvider.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//

import SwiftUI
import Combine

protocol ProfileContentProviderProtocol: ObservableObject {
    var privacyLevel: PrivacyLevel { get }
    var canSendMessage: Bool { get }
    var canStartVideoChat: Bool { get }
    var photosView: AnyView { get }
    var feedView: AnyView { get }
    var friendsView: AnyView { get }
}

final class ProfileContentProvider<Store>: ProfileContentProviderProtocol where Store: PreferencesStoreProtocol {
    let privacyLevel: PrivacyLevel
    private let user: ProfileUser
    
    private var store: Store
    private var cancellables: Set<AnyCancellable> = []
    
    init(privacyLevel: PrivacyLevel = DIContainer.shared.resolve(type: PrivacyLevel.self)!,
         user: ProfileUser = DIContainer.shared.resolve(type: ProfileUser.self)!,
         store: Store = DIContainer.shared.resolve(type: Store.self)!) {
        self.privacyLevel = privacyLevel
        self.user = user
        self.store = store
        
        store.objectWillChange.sink { _ in
          self.objectWillChange.send() //当store中的属性发生更改时，也会使ProfileContentProviderProtocol的发布者发出
        }
        .store(in: &cancellables)
    }

    var canSendMessage: Bool {
//        privacyLevel > .everyone
        privacyLevel >= store.messagePreference
    }

    var canStartVideoChat: Bool {
//        privacyLevel > .friend
        privacyLevel >= store.videoCallsPreference
    }
    
    var photosView: AnyView {
//        privacyLevel > .friend ? PhotosView(photos: user.photos) : EmptyView()
//        privacyLevel >= store.photosPreference ? PhotosView(photos: user.photos) : EmptyView()
        privacyLevel >= store.photosPreference ? AnyView(PhotosView(photos: user.photos)) : AnyView(EmptyView())
    }

    var feedView: AnyView {
//        privacyLevel > .everyone ? HistoryFeedView(posts: user.historyFeed) : RestrictedAccessView()
//        privacyLevel >= store.feedPreference ? HistoryFeedView(posts: user.historyFeed) : RestrictedAccessView()
        privacyLevel >= store.feedPreference ? AnyView(HistoryFeedView(posts: user.historyFeed)) : AnyView(EmptyView())
    }

    var friendsView: AnyView {
//        privacyLevel > .everyone ? UsersView(title: "Friends", users: user.friends) : EmptyView()
//        privacyLevel >= store.friendsListPreference ? UsersView(title: "Friends", users: user.friends) : EmptyView()
        privacyLevel >= store.friendsListPreference ?
              AnyView(UsersView(title: "Friends", users: user.friends)) :
              AnyView(EmptyView())
    }
}
