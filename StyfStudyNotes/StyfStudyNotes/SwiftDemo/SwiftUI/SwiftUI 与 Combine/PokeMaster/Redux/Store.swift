//
//  Store.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Combine

class Store: ObservableObject {
    @Published var appState = AppState()
    
    var disposeBag = Set<AnyCancellable>()
    
    init() {
//        我们更倾向于在 app 开始时就把所有内容设定好，并用声明式和响应式 的方法让 app 维护自己的状态，因此，订阅的一个比较好的时机是在 Store 的初始 化方法中
        setupObservers()
    }
    
    func setupObservers() {
        //驱动邮箱文字颜色
        appState.settings.checker.isEmailValid.sink { [weak self] isValid in
//            和通过 UI 事件改变状态一样，想要变更 Settings.isEmailValid，并以此影响 UI 状 态，我们只能通过发送 Action 来进行。
            self?.dispatch(.emailValid(valid: isValid))
        }.store(in: &disposeBag)
        
        //驱动按钮是否可用
        appState.settings.checker.isPasswordValid.sink { [weak self] isValid in
            self?.dispatch(.passwordValid(valid: isValid))
        }.store(in: &disposeBag)
    }
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        
        if let command = result.1 {
            #if DEBUG
            print("[COMMAND]:\(command)")
            #endif
            command.execute(in: self)
        }
    }
    //Reducer 的唯一职责是计算新的 State
    static func reduce(state: AppState,action: AppAction) -> (AppState,AppCommand?) {
        var appState = state
        var appCommand: AppCommand?
        
        switch action {
        case .login(let email, let password):
            
            guard !appState.settings.loginRequesting else {
                break
            }
            appState.settings.loginRequesting = true
            appCommand = LoginAppCommand(email: email, password: password)
        case .register(let email,let password):
            guard !appState.settings.loginRequesting else {
                break
            }
            appState.settings.loginRequesting = true
            appCommand = RegisterAppCommand(email: email, password: password)
        case .accountBehaviorDone(let result):
            appState.settings.loginRequesting = false
            
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                appState.settings.loginError = error
            }
        case .logOff:
            appState.settings.loginUser = nil
        case .emailValid(let valid):
            appState.settings.isEmailValid = valid
        case .loadPokemons:
            if appState.pokemonList.loadingPokemons {
                break
            }
            appState.pokemonList.loadingPokemons = true
            appCommand = LoadPokemonsCommand()
        case .loadPokemonsDone(let result):
            appState.pokemonList.loadingPokemons = false
            switch result {
            case .success(let models):
                appState.pokemonList.pokemons = Dictionary(uniqueKeysWithValues: models.map { ($0.id,$0) })
            case .failure(let error):
                print(error)
            }
        case .passwordValid(let valid):
            appState.settings.isButtonDisabled = !valid
        case .clearCache:
            appState.pokemonList.pokemons = nil
        case .expandPokemonInfoRow(let id):
            if appState.pokemonList.expandingIndex == id {
                appState.pokemonList.expandingIndex = nil
            }else {
                appState.pokemonList.expandingIndex = id
            }
        case .togglePanelPresenting(let target):
            appState.pokemonList.selectionState.panelPresented = target
        case .closeSafariView:
            appState.pokemonList.isSFViewActive = false
        case .sheetOpenSafariView:
            appState.pokemonList.isSFViewActive = true
        case .collect:
            appState.pokemonList.showCollectAlert = true
        case .changeTap(let tapIndex):
            appState.mainTab.selection = tapIndex
        }
        return (appState,appCommand)
    }
}
