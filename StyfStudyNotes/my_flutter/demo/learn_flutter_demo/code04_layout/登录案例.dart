import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: HomeContent(),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[TextFieldDemo()],
      ),
    );
  }
}

class TextFieldDemo extends StatefulWidget {
  @override
  _TextFieldDemoState createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          icon: Icon(Icons.people),
          labelText: "username",
          hintText: "请输入用户名",
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.lightGreen),
      onChanged: (value) {
        print("onChanged:$value");
      },
      onSubmitted: (value) {
        print("onSubmitted:$value");
      },
    );
  }
}

class FormDemo extends StatefulWidget {
  @override
  _FormDemoState createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
  final registerFormKey = GlobalKey<FormState>();
  String username, password;

  void registerForm() {
    registerFormKey.currentState.save();

    print("username:$username password:$password");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration:
                InputDecoration(icon: Icon(Icons.people), labelText: "用户名或手机号"),
            onSaved: (value) {
              this.username = value;
            },
          ),
          TextFormField(
            obscureText: true,
            decoration:
                InputDecoration(icon: Icon(Icons.lock), labelText: "密码"),
            onSaved: (value) {
              this.password = value;
            },
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 44,
            child: RaisedButton(
              color: Colors.lightGreen,
              child: Text(
                "注 册",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: registerForm,
            ),
          )
        ],
      ),
    );
  }
}
