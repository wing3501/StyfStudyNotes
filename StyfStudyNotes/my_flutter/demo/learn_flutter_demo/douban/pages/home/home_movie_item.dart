import 'package:flutter/material.dart';

import '../../model/home_model.dart';
import '../../widgets/dashed_line.dart';
import '../../widgets/star_rating.dart';

class YFHomeMovieItem extends StatelessWidget {
  final MovieItem movie;

  YFHomeMovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 8, color: Color(0xffeeeeee)))),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(),
            SizedBox(
              height: 8,
            ),
            buildContent(),
            SizedBox(
              height: 8,
            ),
            buildFooter()
          ],
        ));
  }

  Widget buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 238, 205, 144),
          borderRadius: BorderRadius.circular(3)),
      child: Text(
        "NO.${movie.rank}",
        style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 131, 95, 36)),
      ),
    );
  }

  Widget buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContentImage(),
        SizedBox(
          width: 8,
        ),
        Expanded(
            child: IntrinsicHeight(
          child: Row(
            children: [
              buildContentInfo(),
              SizedBox(
                width: 8,
              ),
              buildContentLine(),
              buildContentWish()
            ],
          ),
        ))
      ],
    );
  }

  Widget buildContentImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        "${movie.imageURL}",
        height: 180,
      ),
    );
  }

  Widget buildContentInfo() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildContentInfoTitle(),
        buildContentInfoRate(),
        buildContentInfoDesc()
      ],
    ));
  }

  Widget buildContentInfoTitle() {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
          child: Icon(
            Icons.play_circle_outline,
            color: Colors.redAccent,
            size: 40,
          ),
          alignment: PlaceholderAlignment.middle),
      ...movie.title.runes.map((rune) {
        return WidgetSpan(
            child: Text(
              new String.fromCharCode(rune),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            alignment: PlaceholderAlignment.middle);
      }).toList(),
      WidgetSpan(
          child: Text("(${movie.playDate})",
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          alignment: PlaceholderAlignment.middle),
    ]));
  }

  Widget buildContentInfoRate() {
    return FittedBox(
      child: Row(
        children: [
          StarRating(
            rating: movie.rating,
            size: 20,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "${movie.rating}",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget buildContentInfoDesc() {
    final genresString = movie.genres.join(" ");
    final directorString = movie.director.name;
    final actorString = movie.casts.map((e) => e.name).toList().join(" ");
    return Text(
      "$genresString / $directorString / $actorString",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildContentLine() {
    return Container(
      height: 100,
      child: DashedLine(
        dashedWidth: .5,
        dashedHeight: 6,
        count: 10,
        color: Color.fromARGB(255, 255, 170, 60),
        axis: Axis.vertical,
      ),
    );
  }

  Widget buildContentWish() {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/home/wish.png"),
          Text(
            "想看",
            style: TextStyle(
                fontSize: 18, color: Color.fromARGB(255, 255, 170, 60)),
          )
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Color(0xffe2e2e2), borderRadius: BorderRadius.circular(6)),
      child: Text(
        movie.originalTitle,
        style: TextStyle(fontSize: 20, color: Color(0xff666666)),
      ),
    );
  }
}
