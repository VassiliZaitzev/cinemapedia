import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource{
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    //ventajas de dio, a diferencia de http client y axios
    return [];
  }

}