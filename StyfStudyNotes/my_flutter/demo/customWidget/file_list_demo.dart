import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

void main() => runApp(App());

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var show = FileList(
      "/Users/styf/Documents/workspace/StyfStudyNotes",
      maxWith: 250,
    );

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('主页'),
          ),
          body: show,
        ));
  }
}

class FileList extends StatefulWidget {
  final String path;
  final double maxWith;

  FileList(this.path, {this.maxWith = 150});

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  FileNode fileNode;

  @override
  void initState() {
    fileNode = formFileNode(widget.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: mapFile2Node(fileNode),
    );
  }

  Widget mapFile2Node(FileNode root) {
    var treeWidget = NodeWidget(
      node: Node(
          me: buildItem(
            Icons.play_arrow,
            Icons.folder,
            root.name,
          ),
          children: iHaveChildrenOrNot(root)),
    );
    return treeWidget;
  }

  FileNode formFileNode(String path) {
    FileSystemEntity me;
    if (FileSystemEntity.isDirectorySync(path)) {
      me = Directory(path);
    }
    return FileNode(me: me, children: formChildNodeOfDir(me));
  }

  List<Node> iHaveChildrenOrNot(FileNode file) {
    List<Node> result;
    if (FileSystemEntity.isDirectorySync(file.me.path)) {
      //如果是文件夹
      result = file.children.map((e) {
        if (FileSystemEntity.isDirectorySync(e.me.path)) {
          //如果是文件夹
          return Node(
              me: NodeWidget(
            node: Node(
                me: buildItem(
                  Icons.play_arrow,
                  Icons.folder,
                  e.name,
                ),
                children: iHaveChildrenOrNot(e)),
          ));
        } else {
          return Node(
              me: buildFileItem(
            Icons.star_border,
            Icons.insert_drive_file,
            e,
          ));
        }
      }).toList();
    }
    return result;
  }

  Widget buildFileItem(IconData iconArrow, IconData iconSym, FileNode node) {
    var show = Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: <Widget>[
          Icon(
            iconArrow,
            color: Colors.grey,
            size: 20,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(iconSym, color: Colors.grey),
          SizedBox(
            width: 5,
          ),
          LimitedBox(
            maxWidth: widget.maxWith,
            child: Text(
              node.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: () {
        print(node.me.path);
      },
      child: show,
    );
  }
}

List<FileNode> formChildNodeOfDir(Directory dir) {
  return dir.listSync().map((e) {
    if (FileSystemEntity.isDirectorySync(e.path)) {
      return FileNode(me: Directory(e.path), children: formChildNodeOfDir(e));
    }
    return FileNode(
      me: e,
    );
  }).toList();
}

Widget buildItem(IconData iconArrow, IconData iconSym, String name) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Row(
      children: <Widget>[
        Icon(
          iconArrow,
          color: Colors.grey,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Icon(iconSym, color: Colors.grey),
        SizedBox(
          width: 5,
        ),
        LimitedBox(
          maxWidth: 120,
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

class FileNode {
  FileSystemEntity me;
  List<FileNode> children;
  String get name => path.basename(me.path);
  FileNode({this.me, this.children});
}

class Node {
  Widget me; //节点自身Widget
  List<Node> children; //节点所包含的Node
  Node({this.me, this.children});
}

class NodeWidget extends StatefulWidget {
  NodeWidget({Key key, this.node, this.onClickCallback}) : super(key: key);
  final Node node;
  final OnClickCallback onClickCallback;

  @override
  _NodeWidgetState createState() => _NodeWidgetState();
}

typedef OnClickCallback = void Function(bool closed);

class _NodeWidgetState extends State<NodeWidget> {
  Node node;
  bool showList = false;

  @override
  Widget build(BuildContext context) {
    return showNode(widget.node, showList);
  }

  Widget showNode(Node node, bool show) {
    var me = InkWell(
        child: node.me,
        onTap: () {
          showList = !showList;
          if (widget.onClickCallback != null) {
            widget.onClickCallback(!showList);
          }
          setState(() {});
        });
    if (show) {
      var children = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: node.children.map((node) => node.me).toList(),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          me,
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: children,
          )
        ],
      );
    } else {
      return me;
    }
  }
}
