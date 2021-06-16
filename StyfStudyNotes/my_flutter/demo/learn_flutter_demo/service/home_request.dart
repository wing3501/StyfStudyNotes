import '../douban/model/home_model.dart';
import 'config.dart';
import 'http_request.dart';

class YFHomeRequest {
  static Future<List<MovieItem>> requestMovieList(int start) async {
    final movieURL =
        "https://api.douban.com/v2/movie/new_movies?apikey=0df993c66c0c636e29ecbb5344252a4a&start=$start&count=${HomeConfig.movieCount}";
    final result = await HttpRequest.request(movieURL);
    final subjects = result["subjects"];
    List<MovieItem> movies = [];
    for (var item in subjects) {
      movies.add(MovieItem.fromMap(item));
    }
    return movies;
  }
}
