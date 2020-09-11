import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/usecases/movie_by_title.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final MovieByTitle _movieByTitle;

  final listMovies = BehaviorSubject<List<Movie>>.seeded([]);
  final titleSearch = BehaviorSubject<String>();

  bool _isFetching = false;
  int _pageIndicator = 1;

  SearchBloc(this._movieByTitle);

  Future<void> searchTitle(String title) async {
    if (title.isNotEmpty) {
      listMovies.add(null);
      _pageIndicator = 1;
      titleSearch.add(title);
      await getMoviesByTitle();
    }
  }

  Future<void> getMoviesByTitle({int page = 1}) async {
    _isFetching = true;

    if (listMovies.value == null) {
      List<Movie> movies = await _movieByTitle(titleSearch.value, page);
      listMovies.add(<Movie>[] + movies);
    } else {
      List<Movie> movies = await _movieByTitle(titleSearch.value, page);
      listMovies.add(listMovies.value + movies);
    }

    Future.delayed(Duration(seconds: 1), () {
      _isFetching = false;
    });
  }

  void nextPage() async {
    if (!_isFetching) {
      _pageIndicator++;
      await getMoviesByTitle(page: _pageIndicator);
      print("Total ${listMovies.value.length}");
    }
  }

  void dispose() {
    listMovies.close();
  }
}
