import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/entities/movie_details.dart';
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
        "https://api.themoviedb.org/3/movie/upcoming?api_key=c5850ed73901b8d268d0898a8a9d8bff&language=en-US&page=$page");
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
        "https://api.themoviedb.org/3/movie/$movieId?api_key=c5850ed73901b8d268d0898a8a9d8bff&language=en-US");
    if (result.statusCode == 200) {
      return MovieDetailMapper.fromJson(result.data);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Movie>> movieByTitle(String title, int page) async {
    Response result = await this._httpClient.get(
        "https://api.themoviedb.org/3/search/movie?api_key=c5850ed73901b8d268d0898a8a9d8bff&language=en-US&query=$title&page=$page&include_adult=false");
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
