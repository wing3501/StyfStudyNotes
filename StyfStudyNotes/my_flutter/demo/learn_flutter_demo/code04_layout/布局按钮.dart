import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('基础widget'),
      ),
      body: HomeContent(),
    ));
  }
}

class HomeContent extends StatefulWidget {
  HomeContent({Key key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final usernameTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: usernameTextEditController,
            decoration: InputDecoration(
                labelText: "username",
                icon: Icon(Icons.people),
                hintText: "请输入用户名",
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                filled: true,
                fillColor: Colors.red[100]),
            onChanged: (val) {
              print(val);
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: passwordTextEditController,
            decoration: InputDecoration(
                labelText: "password",
                icon: Icon(Icons.lock),
                hintText: "请输入密码",
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                filled: true,
                fillColor: Colors.red[100]),
            onChanged: (val) {
              print(val);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
                onPressed: () {
                  final username = usernameTextEditController.text;
                  final password = passwordTextEditController.text;
                  print("账号:$username,密码：$password");
                  usernameTextEditController.text = "";
                  passwordTextEditController.text = "";
                },
                child: Text(
                  "登 录",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(EdgeInsets.zero))),
          ),
        ],
      ),
    );
  }
}
