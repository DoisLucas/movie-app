import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/entities/movie_details.dart';
import 'package:movieapp/external/imdb/imdb_base_url.dart';
import 'package:movieapp/infra/datasource/movie_datasource.dart';
import 'package:movieapp/infra/mappers/movie_details_mapper.dart';
import 'package:movieapp/infra/mappers/movie_model_mapper.dart';
import 'package:movieapp/utils/http_client.dart';

class ImdbMovieDataSource implements MovieDatasource {
  final HttpClient _httpClient;

  ImdbMovieDataSource(this._httpClient);

  @override
  Future<List<Movie>> movieUpComing(int page) async {
    Response result = await this._httpClient.get(
        "${imdbBaseUrl.base_url}/upcoming?api_key=${imdbBaseUrl.api_key}&language=${imdbBaseUrl.default_language}&page=$page");
    if (result.statusCode == 200) {
      var jsonList = result.data['results'] as List;
      List<Movie> list =
          jsonList.map((item) => MovieMapper.fromJson(item)).toList();
      return list;
    } else {
      throw Exception();
    }
  }

  @override
  Future<MovieDetail> movieDetails(int movieId) async {
    Response result = await this._httpClient.get(
        "${imdbBaseUrl.base_url}/$movieId?api_key=${imdbBaseUrl.api_key}&language=${imdbBaseUrl.default_language}");
    if (result.statusCode == 200) {
      return MovieDetailMapper.fromJson(result.data);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Movie>> movieByTitle(String title, int page) async {
    Response result = await this._httpClient.get(
        "${imdbBaseUrl.base_url}?api_key=${imdbBaseUrl.api_key}&language=${imdbBaseUrl.default_language}&query=$title&page=$page&include_adult=false");
    if (result.statusCode == 200) {
      var jsonList = result.data['results'] as List;
      List<Movie> list =
          jsonList.map((item) => MovieMapper.fromJson(item)).toList();
      return list;
    } else {
      throw Exception();
    }
  }
}
