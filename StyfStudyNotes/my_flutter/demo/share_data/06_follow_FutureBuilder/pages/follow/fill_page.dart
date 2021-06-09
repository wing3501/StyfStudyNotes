import 'package:flutter/material.dart';

import '../../follow_panel.dart';
import '../../follower.dart';

class FillPage extends StatelessWidget {
  final List<Follower> followers;
  FillPage(this.followers);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: followers?.length,
        itemBuilder: (_, index) => Card(
            child: FollowPanel(user: followers[index], color: Colors.blue)));
  }
}
