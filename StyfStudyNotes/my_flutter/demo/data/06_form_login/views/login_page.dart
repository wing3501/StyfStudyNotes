import 'package:flutter/material.dart';

import '../dao/local_dao.dart';

import '../logic/validator.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment(0, -.5),
      children: <Widget>[
        Image.asset(
          'assets/images/login_bg.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(child: LoginFrom()),
      ],
    ));
  }
}

class LoginFrom extends StatefulWidget {
  const LoginFrom({Key key}) : super(key: key);

  @override
  _LoginFromState createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //1.全局FormState泛型key
  String _name; //姓名
  String _pwd; //密码

  Color get enabledColor => Colors.white70;

  Color get focusedColor => Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 340,
      child: Form(
          key: _formKey, //2.使用key
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: FlutterLogo(
                    textColor: Colors.white70,
                    // colors: Colors.purple,
                    size: 150,
                    style: FlutterLogoStyle.horizontal,
                  )),
              _buildUsernameInput(),
              SizedBox(
                height: 20,
              ),
              _buildPasswordInput(),
              SizedBox(
                height: 20,
              ),
              _buildBtns()
            ],
          )),
    );
  }

  Widget _buildBtns() => Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        height: 40,
        width: 300,
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                color: focusedColor.withAlpha(140),
                onPressed: _onFieldSubmitted,
                child: Text("注 册",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                color: focusedColor.withAlpha(140),
                onPressed: _onFieldSubmitted,
                child: Text("登 录",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      );

  Widget _buildUsernameInput() => TextFormField(
        cursorColor: focusedColor,
        style: TextStyle(
            textBaseline: TextBaseline.alphabetic,
            color: focusedColor,
            shadows: [
              Shadow(color: Colors.white, offset: Offset(0, 0), blurRadius: 10)
            ]),
        decoration: _getInputDecoration(Icons.person_add, '用户名', '敢问阁下尊姓大名'),
        onSaved: (value) => _name = value,
        validator: Validator.name,
      );

  Widget _buildPasswordInput() => TextFormField(
        cursorColor: focusedColor,
        style: TextStyle(
            textBaseline: TextBaseline.alphabetic, color: focusedColor),
        decoration:
            _getInputDecoration(Icons.lock_outline, '密码', '暗号:天王盖地虎...'),
        obscureText: true,
        onSaved: (value) => _pwd = value,
        validator: Validator.passWord,
      );

  InputDecoration _getInputDecoration(
      IconData iconData, String label, String hint) {
    return InputDecoration(
        icon: Icon(iconData, color: enabledColor),
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12, color: enabledColor),
        labelStyle: TextStyle(color: enabledColor, fontSize: 12),
        contentPadding: EdgeInsets.only(top: 3, left: 10),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        disabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: focusedColor)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: enabledColor)));
  }

  _onFieldSubmitted() async {
    FormState formState = _formKey.currentState; //3.从_formKey中获取FormState
    formState.save(); //回调onSave
    if (formState.validate()) {
      //验证成功执行逻辑------------
      await LocalDao.dao.initLocalStorage();
      var user = await LocalDao.dao.queryUser();
      var success = Validator.login(user, _name, _pwd);
      print(success);
      if (success) _saveSuccess(); //Todo 写入xml配置 --> 跳转主页
    }
  }

  void _saveSuccess() async {}
}
