import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/usecases/movie_by_title.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final MovieByTitle _movieByTitle;

  final _listMovies = BehaviorSubject<List<Movie>>.seeded([]);
  int _pageIndicator = 1;

  String titleSearch;
  bool isFetching = false;

  SearchBloc(this._movieByTitle);

  get listMovies => _listMovies;

  Future<void> searchTitle(String title) async {
    _pageIndicator = 1;
    titleSearch = title;
    _listMovies.add([]);
    await getMoviesByTitle();
  }

  Future<void> getMoviesByTitle({int page = 1}) async {
    isFetching = true;
    listMovies.add(listMovies.value + await _movieByTitle(titleSearch, page));
    isFetching = false;
  }

  void nextPage() async {
    if (!isFetching) {
      _pageIndicator++;
      await getMoviesByTitle(page: _pageIndicator);
      print("Total ${listMovies.value.length}");
    }
  }

  void dispose() {
    _listMovies.close();
  }
}
