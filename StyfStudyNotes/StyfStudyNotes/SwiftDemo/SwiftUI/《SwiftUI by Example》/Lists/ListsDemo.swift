//
//  ListsDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/16.
//

import SwiftUI

struct ListsDemo: View {
    var body: some View {
        // ✅ scrollTransitions 给滚动的视图加一点过渡动画
//        ScrollView(.horizontal) {
//            Button("Flash") {
//            }
//            .aspectRatio(16.0 / 9.0, contentMode: .fit)
//            .containerRelativeFrame([.horizontal], count: 1, spacing: 10)
//            .clipShape(.rect(cornerRadius: 20.0))
//            .scrollTransition(axis: .horizontal) { content, phase in
//                content
//                    .scaleEffect(x: phase.isIdentity ? 1.0 : 0.75, y: phase.isIdentity ? 1.0 : 0.75)
//            }
//        }
        // 但是并非所有视图修饰符都可以安全地用于 scrollTransition 中。例如，不支持自定义字体并且直接报错。
//        .scrollTransition(axis: .horizontal) { content, phase in
//            content
//                .scaleEffect(
//                    x: phase.isIdentity ? 1.0 : 0.75,
//                    y: phase.isIdentity ? 1.0 : 0.75)
//                .rotationEffect(
//                    .degrees(phase.isIdentity ? 0.0 : 90.0)
//                )
//                .offset(
//                    x: phase.isIdentity ? 0.0 : 20.0,
//                    y: phase.isIdentity ? 0.0 : 20.0
//                )
//        //        .font(phase.isIdentity ? .body : .title2) // Value of type 'some VisualEffect' has no member 'font'
//        }
        
        // ✅ scrollPosition 滚动到指定位置
//        @Binding var mainID: Palette.ID?
//
//        VStack {
//            GalleryHeroHeader(palettes: palettes, mainID: $mainID)
//            ScrollView(.horizontal) { ... }
//                .scrollPosition(id: $mainID)
//        }
//
//        // in GalleryHeroHeader
//        GalleryPaddle(edge: .leading) {
//            mainID = calPreviousID()
//        }
//        
        // ✅ scrollIndicatorsFlash(onAppear:)，它用来控制当滚动视图第一次出现时，是否闪烁其滚动指示器。
//        ScrollView(.horizontal) {
//            Button("Flash") {
//                flashTrigger.toggle()
//            }
//        }
//        .scrollIndicatorsFlash(onAppear: true) //但是经测试，scrollIndicatorsFlash(onAppear:) 只能在垂直方向的视图有效，水平无效
//        .scrollIndicatorsFlash(trigger: flashTrigger) //如果想使用过程控制滚动指示器的显示，可以设置某个值改变时闪烁滚动指示器，scrollIndicatorsFlash(trigger:) 修饰符帮能我们实现
        
        
        // ✅ 我们可以使用现有的 scrollIndicators 修饰符来实现移除滚动指示器
//        ScrollView(.horizontal) {
//            
//        }
//        .scrollIndicators(.hidden) // never
        
        // ✅ 我们在视图中添加上 containerRelativeFrame 修饰符，并指定了参数为水平轴。它使得该视图只占用其容器的宽度，此时，视图大小会自动适应容器的宽度。
        // 我们需要在 iOS 上展示一个，而在 iPad 上展示两个，我们可以根据 horizontalSizeClass 判断个数
//        ScrollView(.horizontal) {
//            blueView
//                .aspectRatio(16.0 / 9.0, contentMode: .fit)
//                .containerRelativeFrame([.horizontal], count: sizeClass == .regular ? 2 : 1, spacing: 10.0)
//        }
        
        
        // ✅ 我们可以使用 scrollTargetBehavior 修饰符来改变 ScrollView 计算 contentOffset 的方式
//        ScrollView(.horizontal) {
//        }
//        .scrollTargetBehavior(.paging)//分页滚动
//        .scrollTargetBehavior(.viewAligned)//viewAligned 对齐行为可以将 ScrollView 对齐到视图上。因此 ScrollView 需要知道哪些视图应该被考虑对齐，这些视图被称为滚动目标。
        //（当使用 lazy stack 时，使用 scrollTargetLayout 非常重要，即使可见区域之外的视图尚未创建，布局也知道将要创建哪些视图，因此它可以确保 ScrollView 滚动到正确的位置）。
        
        //✅ 我们可以使用 scrollClipDisabled 修饰符来禁用这种行为，从而避免阴影被裁剪
//        ScrollView(.horizontal) {
//            HStack(alignment: .center, spacing: 20) {
//                ForEach([Color.red,Color.green], id: \.self) { color in
//                    Rectangle()
//                        .frame(width: 100, height: 100)
////                        .clipShape(CustomShape())//自定义形状
//                        .foregroundColor(color)
//                        .shadow(color: .primary, radius: 20)
//                }
//            }
//        }
//        .scrollClipDisabled(true)
        
        
        //✅新的 contentMargins 允许我们给 ScrollView 的内容和滚动指示器分别插入边距
//        ScrollView {
//        }
//        .contentMargins(.vertical, 50)
//        .contentMargins(.vertical, 50, for: .scrollContent)
//        .contentMargins(.vertical, 50, for: .scrollIndicators)
        
        // 🚗 如何实践 ScrollView 新特性 https://mp.weixin.qq.com/s/48nr36QLqhiiBtphVa_wRw
        // ScrollView 内容缩进
//        ScrollView {
//        }
//        .safeAreaPadding(.horizontal, 10)
        
        //✅ 如何关闭弹性 https://stackoverflow.com/questions/59629390/swiftui-is-there-any-way-to-turn-off-bouncing-while-scrolling-the-scrollview/61851231?r=SearchResults#61851231
//        UITableView.appearance().bounces = false
        
        // ✅如何隐藏指示器  https://stackoverflow.com/questions/58320037/is-there-a-way-to-hide-scroll-indicators-in-a-swiftui-list
        // 1. 使用全局隐藏 UITableView.appearance().showsVerticalScrollIndicator = false
        // 2. 使用 ScrollView+LazyVStack
//        ScrollView(.vertical, showsIndicators: false) { // <- This argument
//                    LazyVStack {
//                        ForEach(1...100, id: \.self) {
//                            Text("\($0)").frame(height: 40)
//                        }
//                    }
//                }
        
        //✅ 禁止滚动 scrollDisabled  外部设置禁止滚动，内部所有滚动视图都会被禁止滚动，内部设置.scrollDisabled(false)不起作用
//        ScrollView {
//        }
//        .scrollDisabled(true)
        //✅ 内部想对禁止滚动做出反应，可以使用
//        @Environment(\.isScrollEnabled) private var isScrollEnabled
        
        //✅ 最小行高
//        List {
//            ....
//        }
//        .listStyle(.plain)
//        .environment(\.defaultMinListRowHeight, 80) // 设置 List 最小行高度
        
        //List消除每一行内边距
//        List{
//            Image("自己的图片")//此处可以换成其他控件
//            .listRowInsets(EdgeInsets())//重点在这句话
//        }
        
        //直接从绑定的数据创建列表
//        CreateFromBinding()
        //searchable给NavigationView添加搜索栏
//        AddASearchBar()
        
        //列表自定义滑动按钮
//        CustomSwipeActionButtons()
        //下拉刷新
//        PullToRefresh()
        //分隔线
//        ListRowSeparator()
        //默认情况下，List为每一行自动创建一个HStack
        
        //列表的选择
//        AllowRowSelection()
        //滚动到指定行
//        ScrollToASpecificRow()
        //展开二级列表
        CreateExpandingLists()
        //列表样式
//        CreateGroupedLists()
        //给行添加背景色
//        UsingListRowBackground()
        //添加编辑按钮编辑列表
//        UsingEditButton()
        //添加分段
//        AddSections()
        //移动行
//        MoveRows()
        //删除行
//        DeleteRows()
        //动态数据列表
//        ListOfDynamicItems()
        //静态数据列表
//        ListOfStaticItems()
    }
}
//-----------------------------
// 以这种方式使用绑定是修改列表的最有效方式，因为当只有一个项目发生更改时，它不会导致整个视图重新加载。
struct CreateFromBinding: View {
    @State private var users = [
            User1(name: "Taylor"),
            User1(name: "Justin"),
            User1(name: "Adele")
        ]
    var body: some View {
        TestWrap("直接从绑定的数据创建列表") {
            List($users) { $user in
                Text(user.name)
                Spacer()
                Toggle("User has been contacted", isOn: $user.isContacted)
                    .labelsHidden()
            }
        }
    }
}

struct User1: Identifiable {
    let id = UUID()
    var name: String
    var isContacted = false
}
//-----------------------------
struct AddASearchBar: View {
    @State private var searchText = ""
    var body: some View {
        TestWrap("searchable给NavigationView添加搜索栏") {
//            NavigationView {
//                Text("Searching for \(searchText)")
////                    .searchable(text: $searchText)
//                    .searchable(text: $searchText, prompt: "Look for something")//占位文字
//                    .navigationTitle("Searchable Example")
//            }
            
            
//            AddASearchBarPractice()
            AddASearchBarPractice1()
        }
    }
}
//搜索栏在列表中使用
struct AddASearchBarPractice: View {
    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink(destination: Text(name)) {
                        Text(name)
                    }
                }
            }
            //当搜索栏出现在一个列表中时，它通常会隐藏起来——用户需要在顶部轻轻向下拖动列表以显示它
            .searchable(text: $searchText)
            .navigationTitle("Contacts")
        }
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}
// 搜索栏带建议列表
struct AddASearchBarPractice1: View {
    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink(destination: Text(name)) {
                        Text(name)
                    }
                }
            }
            .searchable(text: $searchText) {
                ForEach(searchResults, id: \.self) { result in
                    Text("Are you looking for \(result)?").searchCompletion(result)
                }
            }
            .navigationTitle("Contacts")
        }
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}


//-----------------------------

struct CustomSwipeActionButtons: View {
    let friends = ["Antoine", "Bas", "Curt", "Dave", "Erica"]
    var body: some View {
        TestWrap("列表自定义滑动按钮") {
            NavigationView {
                List {
                    ForEach(friends, id: \.self) { friend in
                        Text(friend)
                            
                            .swipeActions(allowsFullSwipe: false) {//全滑触发
                                Button {
                                    print("Muting conversation")
                                } label: {
                                    Label("Mute", systemImage: "bell.slash.fill")
                                }
                                .tint(.indigo)//设置颜色

                                Button(role: .destructive) {
                                    print("Deleting conversation")
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                            //两侧都添加按钮
//                            .swipeActions(edge: .leading) {
//                                Button {
//                                    total += i
//                                } label: {
//                                    Label("Add \(i)", systemImage: "plus.circle")
//                                }
//                                .tint(.indigo)
//                            }
//                            .swipeActions(edge: .trailing) {
//                                Button {
//                                    total -= i
//                                } label: {
//                                    Label("Subtract \(i)", systemImage: "minus.circle")
//                                }
//                            }
                    }
                }
            }
        }
    }
}

//-----------------------------
struct PullToRefresh: View {
    @State private var news = [
        NewsItem(id: 0, title: "Want the latest news?", strap: "Pull to refresh!")
    ]

    var body: some View {
        TestWrap("下拉刷新") {
            NavigationView {
                List(news) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.strap)
                            .foregroundColor(.secondary)
                    }
                }
                .refreshable {
                    //这里已经在一个异步上下文中了
                    do {
                        // Fetch and decode JSON into news items

                        let url = URL(string: "https://www.hackingwithswift.com/samples/news-1.json")!
                        let (data, _) = try await URLSession.shared.data(from: url)
                        news = try JSONDecoder().decode([NewsItem].self, from: data)
                    } catch {
                        // Something went wrong; clear the news
                        news = []
                    }
                }
            }
        }
    }
}
struct NewsItem: Decodable, Identifiable {
    let id: Int
    let title: String
    let strap: String
}
//-----------------------------
struct ListRowSeparator: View {
    var body: some View {
        TestWrap("分隔线") {
            List {
                ForEach(1..<3) { index in
                    Text("Row \(index)")
//                        .listRowSeparator(.hidden)// 隐藏分隔线
//                        .listRowSeparator(.hidden, edges: .top) // 隐藏某一侧的分隔线
                        .listRowSeparatorTint(.red)//分隔线颜色
//                        .listRowSeparatorTint(.pink, edges: .top)//处理顶部、底部的分隔线
                    //如果要更多控制，就去调整row本身
                }
            }
        }
    }
}

//-----------------------------

struct AllowRowSelection: View {
    @State private var selection: String?
//    @State private var selection = Set<String>() //支持多选
    let names = [
        "Cyril",
        "Lana",
        "Mallory",
        "Sterling"
    ]
    var body: some View {
        TestWrap("列表的选择") {
            NavigationView {
                List(names, id: \.self, selection: $selection) { name in
                    Text(name)
                }
                .navigationTitle("List Selection")
                .toolbar {
                    //列表必须处于编辑模式才能支持选择。
                    EditButton()
                }
            }
        }
    }
}

//-----------------------------

struct ScrollToASpecificRow: View {
    var body: some View {
        TestWrap("滚动到指定行") {
            ScrollViewReader { proxy in
                VStack {
                    Button("Jump to #50") {
                        proxy.scrollTo(50)
//                        withAnimation {
//                            proxy.scrollTo(50, anchor: .top).
//                        }
                    }

                    List(0..<100, id: \.self) { i in
                        Text("Example \(i)")
                        .id(i)
                        //注意id会导致全渲染，数据量过大时会出现卡顿
                        
//                        优化在 SwiftUI List 中显示大数据集的响应效率
//                    https://www.fatbobman.com/posts/optimize_the_response_efficiency_of_List/
                    }
                }
            }
        }
    }
}
//-----------------------------
struct CreateExpandingLists: View {
    let items: [Bookmark] = [.example1, .example2, .example3]
    
    var body: some View {
        TestWrap("展开二级列表") {
            List(items, children: \.items) { row in
                Image(systemName: row.icon)
                Text(row.name)
            }
        }
    }
}

struct Bookmark: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var items: [Bookmark]?

    // some example websites
    static let apple = Bookmark(name: "Apple", icon: "1.circle")
    static let bbc = Bookmark(name: "BBC", icon: "square.and.pencil")
    static let swift = Bookmark(name: "Swift", icon: "bolt.fill")
    static let twitter = Bookmark(name: "Twitter", icon: "mic")

    // some example groups
    static let example1 = Bookmark(name: "Favorites", icon: "star", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    static let example2 = Bookmark(name: "Recent", icon: "timer", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    static let example3 = Bookmark(name: "Recommended", icon: "hand.thumbsup", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
}
//-----------------------------
struct CreateGroupedLists: View {
    var body: some View {
        TestWrap("列表样式") {
            List {
                Section(header: Text("Important tasks")) {
                    TaskRow()
                    TaskRow()
                    TaskRow()
                }
            }
            .listStyle(.grouped)//.insetGrouped
        }
    }
}

//-----------------------------
struct UsingListRowBackground: View {
    var body: some View {
        TestWrap("给行添加背景色") {
            List {
                ForEach(0..<2) {
                    Text("Row \($0)")
                }
                .listRowBackground(Color.red)
            }
        }
    }
}
//-----------------------------
struct UsingEditButton: View {
    @State private var users = ["Paul", "Taylor", "Adele"]
    var body: some View {
        TestWrap("添加编辑按钮编辑列表") {
            NavigationView {
                List {
                    ForEach(users, id: \.self) { user in
                        Text(user)
                    }
                    .onDelete(perform: delete)
                }
                .toolbar {
                    EditButton()
                }
            }
        }
    }
    func delete(at offsets: IndexSet) {
        users.remove(atOffsets: offsets)
    }
}

//-----------------------------
struct AddSections: View {
    var body: some View {
        TestWrap("添加分段") {
            List {
                Section(header: Text("Important tasks")) {
                    TaskRow()
                    TaskRow()
                    TaskRow()
                }

                Section(header: Text("Other tasks")) {
                    TaskRow()
                    TaskRow()
                    TaskRow()
                }
                Section(header: Text("Other tasks"), footer: Text("End")) {
                    Text("Row 1")
                    Text("Row 2")
                    Text("Row 3")
                }
                Section(header: Text("Header")) {
                    Text("Row")
                }
                .headerProminence(.increased)//大号字
            }
        }
    }
}
struct TaskRow: View {
    var body: some View {
        Text("Task data goes here")
    }
}
//-----------------------------
struct MoveRows: View {
    @State private var users = ["Paul", "Taylor", "Adele"]
    var body: some View {
        TestWrap("移动行") {
            NavigationView {
                        List {
                            ForEach(users, id: \.self) { user in
                                Text(user)
                            }
                            .onMove(perform: move)
                        }
                        .toolbar {
                            EditButton()
                        }
                    }
        }
    }
    func move(from source: IndexSet, to destination: Int) {
        users.move(fromOffsets: source, toOffset: destination)
    }
}

//-----------------------------

struct DeleteRows: View {
    @State private var users = ["Paul", "Taylor", "Adele"]
    //注意：onDelete是属于ForEach的
    var body: some View {
        TestWrap("删除行") {
            List {
                ForEach(users, id: \.self) { user in
                    Text(user)
                }
                .onDelete(perform: delete)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
            users.remove(atOffsets: offsets)
    }
}

//-----------------------------
struct ListOfDynamicItems: View {
    let restaurants = [
            Restaurant(name: "Joe's Original"),
            Restaurant(name: "The Real Joe's Original"),
            Restaurant(name: "Original Joe's")
        ]
    
    var body: some View {
        TestWrap("动态数据列表") {
            List(restaurants) { restaurant in
                RestaurantRow(restaurant: restaurant)
            }
            
            List(restaurants, rowContent: RestaurantRow.init)
        }
    }
}
// A struct to store exactly one restaurant's data.
struct Restaurant: Identifiable {
    let id = UUID()
    let name: String
}

// A view that shows the data for one Restaurant.
struct RestaurantRow: View {
    var restaurant: Restaurant

    var body: some View {
        Text("Come and eat at \(restaurant.name)")
    }
}
//-----------------------------
struct ListOfStaticItems: View {
    var body: some View {
        TestWrap("静态数据列表") {
            List {
                Pizzeria(name: "Joe's Original")
                Pizzeria(name: "The Real Joe's Original")
                Pizzeria(name: "Original Joe's")
            }
        }
    }
}
struct Pizzeria: View {
    let name: String

    var body: some View {
        Text("Restaurant: \(name)")
    }
}
//-----------------------------

struct ListsDemo_Previews: PreviewProvider {
    static var previews: some View {
        ListsDemo()
    }
}
