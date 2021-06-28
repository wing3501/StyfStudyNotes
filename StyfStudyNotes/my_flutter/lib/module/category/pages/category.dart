import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/module/category/bloc/bloc/category_bloc.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = "/category";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(CategoryPageInitEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('分类'),
        ),
        body: Row(
          children: [
            //侧边栏
            _buildLeftNavigation(),
            Expanded(child: Center(
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return Text(
                    "选择Index:" +
                        (state as CategoryExtendedState)
                            .selectedIndex
                            .toString(),
                    style: TextStyle(fontSize: 30),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  //增加NavigationRail组件为侧边栏
  Widget _buildLeftNavigation() {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      return NavigationRail(
        backgroundColor: Colors.white,
        elevation: 3,
        extended: (state as CategoryExtendedState).isExtended,
        labelType: (state as CategoryExtendedState).isExtended
            ? NavigationRailLabelType.none
            : NavigationRailLabelType.selected,
        //侧边栏中的item
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.add_to_queue),
            selectedIcon: Icon(Icons.add_to_photos),
            label: Text("测试一"),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: Text("测试二"),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.bubble_chart),
            selectedIcon: Icon(Icons.broken_image),
            label: Text("测试三"),
          ),
        ],
        //顶部widget
        leading: _buildNavigationTop(),
        //底部widget
        trailing: _buildNavigationBottom(),
        selectedIndex: (state as CategoryExtendedState).selectedIndex,
        onDestinationSelected: (int index) {
          ///添加切换tab事件
          BlocProvider.of<CategoryBloc>(context)
              .add(SwitchTabEvent(selectedIndex: index));
        },
      );
    });
  }

  Widget _buildNavigationTop() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3383029432,2292503864&fm=26&gp=0.jpg",
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBottom() {
    return Container(
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              ///添加NavigationRail展开,收缩事件
              BlocProvider.of<CategoryBloc>(context).add(IsExtendEvent());
            },
            child: Icon((state as CategoryExtendedState).isExtended
                ? Icons.send
                : Icons.navigation),
          );
        },
      ),
    );
  }
}
