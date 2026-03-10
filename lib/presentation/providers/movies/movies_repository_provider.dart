import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//ESTE REPOSITORIO ES INMUTABLE, ES DE SÓLO LECTURA
final movieRepositoryProvider = Provider((ref) => MovieRepositoryImpl(MoviedbDatasource()));