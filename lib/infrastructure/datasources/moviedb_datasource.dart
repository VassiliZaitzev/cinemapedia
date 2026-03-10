

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource{

  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      'api_key': Environment.themovieDbKey,
      'language': 'es-MX'
    }
  ));


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    //ventajas de dio, a diferencia de http client y axios
    //dio gestor de peticiones http
    final response = await dio.get("/movie/now_playing");
    final movieDbResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDbResponse.results
    .where((element) => element.posterPath != 'no-poster')
    .map(
      (e) => MovieMapper.movieDBToEntity(e)
    ).toList();

    return movies;
  }

}