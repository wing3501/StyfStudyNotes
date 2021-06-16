import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../Model/userinfo.dart';
import 'counter_view_model.dart';
import 'user_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => CounterViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => UserViewModel(UserInfo("styf", 30, "abc")),
  )
];
