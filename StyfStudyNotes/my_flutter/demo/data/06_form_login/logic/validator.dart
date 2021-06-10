import '../bean/user_bean.dart';

class Validator {
  static String name(String name) {
    if (name.isEmpty) return "用户名不为空";
    if (name.length > 15) return "用户名不大于15位";
    return null;
  }

  static String passWord(String password) {
    return password.length < 6 ? "密码不小于6位" : null;
  }

  static String conformPassWord(String password, String conformPwd) {
    return conformPwd != password ? "密码不一致，请确认" : null;
  }

  static bool login(UserBean user, String name, String password) {
    if (password.isEmpty) return false;
    return user.name == name && user.password == password;
  }
}
