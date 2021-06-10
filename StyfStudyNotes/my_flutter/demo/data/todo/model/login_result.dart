import 'package:equatable/equatable.dart';

import 'user_bean.dart';

/// create by 张风捷特烈 on 2020/6/1
/// contact me by email 1981462002@qq.com
/// 说明:

class LoginResult extends Equatable {
  final String msg;
  final UserBean user;
  final bool status;

  LoginResult({this.msg, this.user, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [msg, user, status];
}
