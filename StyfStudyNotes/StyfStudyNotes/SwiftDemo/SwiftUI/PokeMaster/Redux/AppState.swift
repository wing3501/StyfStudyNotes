//
//  AppState.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Combine

struct AppState {
    var settings = Settings()
    var pokemonList = PokemonList()
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        enum AccountBehavior: CaseIterable {
            case register, login
        }
//        对于通过绑定来更新的状态，由于不会经过 Store 的 reduce 方法来返回 Command，我们缺少一种有效的手段来在它们改变时执行副作用。
//        比如：可以在用户还在输入 时，就对内容做以下两点检查:
//        1. 用户的输入是否为有效邮箱地址
//        2. 这个邮箱地址是否已经在服务器注册过
//        var accountBehavior = AccountBehavior.login
//        var email = ""
//        var password = ""
//        var verifyPassword = ""
        
        var isEmailValid = false
        var isButtonDisabled = true
        
        class AcountChecker {
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            var isEmailValid: AnyPublisher<Bool,Never> {
                
                //远程检查
                let remoteVerify = $email
                    .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                    .removeDuplicates()
                    .flatMap { email -> AnyPublisher<Bool,Never> in
                        let validEmail = email.isValidEmailAddress
                        let canSkip = self.accountBehavior == .login
                        
                        switch (validEmail,canSkip) {
                        case (false, _):
                            return Just(false).eraseToAnyPublisher()
                        case (true, false):
                            return EmailCheckingRequest(email: email)//注册页面需要请求请求验证邮箱是否重复
                                .publisher
                                .eraseToAnyPublisher()
                        case (true, true):
                            return Just(true).eraseToAnyPublisher()
                        }
                    }
                
                let emailLocalValid = $email.map { $0.isValidEmailAddress }
                let canSkipRemoteVerify = $accountBehavior.map { $0 == .login }
                return Publishers.CombineLatest3(emailLocalValid, canSkipRemoteVerify, remoteVerify)
                    .map { $0 && ($1 || $2) }
                    .eraseToAnyPublisher()
            }
            
            var isPasswordValid: AnyPublisher<Bool,Never> {
                return $password
                    .combineLatest($verifyPassword)
                    .flatMap { (str1,str2) -> AnyPublisher<Bool,Never> in
                        let canSkip = self.accountBehavior == .login
                        if (!str1.isEmpty && !str2.isEmpty && str1 == str2 && !canSkip) || (!str1.isEmpty && canSkip) {
                            return Just(true).eraseToAnyPublisher()
                        }else {
                            return Just(false).eraseToAnyPublisher()
                        }
                    }
                    .eraseToAnyPublisher()
            }
            
            var isButtonDisabled: AnyPublisher<Bool,Never> {
                return isEmailValid
                    .combineLatest(isPasswordValid)
                    .flatMap { (emailValid,passwordValid) in
                        return Just(emailValid && passwordValid).eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
        }
//        使用一个 class 来持有这些内容，这样一来，我们就可以将变量声明为 @Published，并使用前缀美元符号 $ 来获取 Publisher 了。
        var checker = AcountChecker()
        
        @UserDefaultsStorage(key: .showEnglishName, defaultValue: false)
        var showEnglishName: Bool
        
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
//        在这个架构中，我们规定一个特例，那就是对于 “纯副作用”，我们可以考虑通过属 性的 didSet 来执行这个副作用，而跳过严格的 Command 流程。像是将 loginUser 写入磁盘或者从磁盘读出这样的任务，就非常符合这个情景。
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
        var loginRequesting = false
        var loginError: AppError?
    }
    
}

extension AppState {
    struct PokemonList {
        @FileStorage(directory: .cachesDirectory, fileName: "pokemons.json")
        var pokemons: [Int: PokemonViewModel]?
        var loadingPokemons = false
        
        var allPokemonsByID: [PokemonViewModel] {
            guard let pokemons = pokemons?.values else {
                return []
            }
            return pokemons.sorted { $0.id < $1.id }
        }
    }
}
