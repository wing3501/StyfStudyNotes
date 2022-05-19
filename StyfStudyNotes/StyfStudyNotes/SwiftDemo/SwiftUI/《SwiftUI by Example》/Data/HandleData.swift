//
//  HandleData.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/19.
//

import SwiftUI
import CoreData
import UniformTypeIdentifiers //这样就可以引入统一类型标识符，这是说明文档可以使用哪些数据类型的固定方式。

import CoreLocation
import CoreLocationUI

struct HandleData: View {
    let persistenceController = PersistenceController.shared
//    let persistenceController = PersistenceController.preview
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        
        //处理NSUserActivity
        
        //创建文档型应用
        
        //限制抓取数据的数量
        LimitTheNumberFetch()
        //删除Core Data数据
//        DeleteCoreDataObjects()
        //添加Core Data数据
//        AddCoreDataObjects()
        //使用谓词过滤FetchRequest
//        FilterFetchRequest()
        //使用FetchRequest抓取数据
//        UsingFetchRequest()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .onChange(of: scenePhase) { _ in
            persistenceController.save()//前后台切换的时候，持久化数据
        }
    }
}

//------------------------------------
struct UsingLocationButton : View {
    //SwiftUI有一个专用的LocationButton视图，用于显示用于请求用户位置的标准UI
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        TestWrap("使用LocationButton") {
            VStack {
                if let location = locationManager.location {
                    Text("Your location: \(location.latitude), \(location.longitude)")
                }
//                LocationButton（.shareMyCurrentLocation）。 其他样式
                LocationButton {
                    locationManager.requestLocation()
                }
                .frame(height: 44)
                .padding()
            }
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
}
//------------------------------------
// 处理 NSUserActivity
//func handleSpotlight(_ userActivity: NSUserActivity) {
//    if let id = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
//        print("Found identifier \(id)")
//    }
//}

//WindowGroup {
//    ContentView()
//        .onContinueUserActivity(CSSearchableItemActionType, perform: handleSpotlight)
//}
//------------------------------------
//2 创建某种视图，允许用户编辑其文档。
struct UsingFileDocument : View {
    @Binding var document: TextFile
    
    var body: some View {
//        TestWrap("创建文档型应用") {
            TextEditor(text: $document.text)
//        }
    }
}

// 3 创建一个能够创建文件并将其加载到用户界面的文档组。
//@main
//struct YourAwesomeApp: App {
//    var body: some Scene {
//        DocumentGroup(newDocument: TextFile()) { file in
//            ContentView(document: file.$document)
//        }
//    }
//}

//4 正在更新plist文件，表示要使用系统的文档浏览器。 “Supports Document Browser” = YES

//1 定义文档内容，包括如何保存和加载文档。
struct TextFile: FileDocument {
    // tell the system we support only plain text
    static var readableContentTypes = [UTType.plainText]  //只支持文本

    // by default our document is empty
    var text = ""

    // a simple initializer that creates new, empty documents
    init(initialText: String = "") {
        text = initialText
    }

    // this initializer loads data that has been saved previously
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    // this will be called when the system wants to write our data to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}

//------------------------------------
struct LimitTheNumberFetch : View {
    
    @FetchRequest var languages: FetchedResults<ProgrammingLanguage>
    
    init() {
        //抓取前10条
        let request: NSFetchRequest<ProgrammingLanguage> = ProgrammingLanguage.fetchRequest()
        //加点过滤条件
//        request.predicate = NSPredicate(format: "active = true")
        //加点排序规则
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \ProgrammingLanguage.name, ascending: true)
        ]
        
        request.fetchLimit = 10
        _languages = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        TestWrap("限制抓取数据的数量") {
            List {
                ForEach(languages) { language in
                    Text("Creator: \(language.creator ?? "Anonymous")")
                }
                
            }
        }
    }
}

//------------------------------------
struct DeleteCoreDataObjects : View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.name)
        ]
    ) var languages: FetchedResults<ProgrammingLanguage>
    var body: some View {
        TestWrap("删除Core Data数据") {
            List {
                ForEach(languages) { language in
                    Text("Creator: \(language.creator ?? "Anonymous")")
                }
                .onDelete(perform: removeLanguages)//滑动删除
            }
        }
//        .toolbar {  如果想要添加编辑模式，还要包在NavigationView
//            EditButton()
//        }
    }
    
    func removeLanguages(at offsets: IndexSet) {
        for index in offsets {
            let language = languages[index]
            managedObjectContext.delete(language)
            //在适当的时候保存上下文
            PersistenceController.shared.save()
        }
    }
}
//------------------------------------
struct AddCoreDataObjects : View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        TestWrap("添加Core Data数据") {
            VStack {
                Button("Insert example language") {
                    let language = ProgrammingLanguage(context: managedObjectContext)
                    language.name = "Python"
                    language.creator = "Guido van Rossum"
                    // more code here
                    
//                    在适当的时候保存上下文—可能是在添加了一组对象之后，当应用程序的状态发生变化时，等等。
                    PersistenceController.shared.save()
                }
            }
        }
    }
}

//------------------------------------
struct FilterFetchRequest : View {
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)],
        predicate: NSPredicate(format: "name == %@", "Python")
    ) var languages: FetchedResults<ProgrammingLanguage>

    var body: some View {
        TestWrap("使用谓词过滤FetchRequest") {
            VStack {
                //结果都可以直接在SwiftUI视图中使用
                List(languages) { language in
                    Text(language.name ?? "Unknown")
                }
            }
        }
    }
}

//------------------------------------
struct UsingFetchRequest : View {
    //要查询的实体和确定结果返回顺序的排序描述符
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var languages: FetchedResults<ProgrammingLanguage>
    //设置更多排序选项
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.name), SortDescriptor(\.creator, order: .reverse)]) var languages: FetchedResults<ProgrammingLanguage>

    var body: some View {
        TestWrap("使用FetchRequest抓取数据") {
            VStack {
                //结果都可以直接在SwiftUI视图中使用
                List(languages) { language in
                    Text(language.name ?? "Unknown")
                }
            }
        }
    }
}


//------------------------------------
//Core Data配置使用
//1.新建文件类型Data Model，文件名Main
//2.添加实体Entry,添加属性
//3.创建管理类PersistenceController
//4.把管理类单例注入环境
//5.从环境中取出，使用。@Environment(\.managedObjectContext) var managedObjectContext  （使用@FetchRequest执行fetch请求时，不需要为托管对象上下文添加本地属性–您只需要在保存、删除和其他一些任务时使用它。）
struct ConfigureCoreData : View {
    
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        TestWrap("Core Data配置使用") {
            VStack {
                
            }
        }
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .onChange(of: scenePhase) { _ in
            persistenceController.save()//前后台切换的时候，持久化数据
        }
    }
}

//-------------------------------------

struct HandleData_Previews: PreviewProvider {
    static var previews: some View {
        HandleData()
    }
}
