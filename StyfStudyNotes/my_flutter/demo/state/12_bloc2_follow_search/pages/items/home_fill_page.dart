import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/home/home_bloc.dart';
import '../../app/bloc/home/home_event.dart';
import '../../bean/follower.dart';

import '../../widgets/follow_result_item_widget.dart';

class HomeFillPage extends StatelessWidget {
  final List<Follower> followers;
  HomeFillPage(this.followers);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          BlocProvider.of<HomeBloc>(context).add(EventFetchData("JakeWharton")),
      child: ListView.builder(
          itemCount: followers?.length,
          itemBuilder: (_, index) => Card(
              child: FollowResultItemWidget(
                  user: followers[index], color: Colors.blue))),
    );
  }
}
