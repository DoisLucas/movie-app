import 'package:get_it/get_it.dart';
import 'package:movieapp/utils/http_client.dart';

import 'domain/usecases/movie_by_title.dart';
import 'domain/usecases/movie_details.dart';
import 'domain/usecases/movie_upcoming.dart';
import 'external/imdb/imdb_movie_datasource.dart';
import 'infra/repositories/movie_repository_impl.dart';

final GetIt inject = GetIt.I;

Future<void> setupInjection() async {
  inject.registerFactory(() => HttpClient());
  inject.registerFactory(() => ImdbMovieDataSource(inject.get<HttpClient>()));

  inject.registerFactory(
      () => MovieRepositoryImpl(inject.get<ImdbMovieDataSource>()));

  inject
      .registerFactory(() => MoviesUpcoming(inject.get<MovieRepositoryImpl>()));
  inject.registerFactory(() => MovieDetails(inject.get<MovieRepositoryImpl>()));
  inject.registerFactory(() => MovieByTitle(inject.get<MovieRepositoryImpl>()));
}
