

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");

final searchMoviesProvider = StateNotifierProvider<SearchMoviesNotifiers, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return SearchMoviesNotifiers(
    searchMovies: movieRepository.searchMovies, 
    ref: ref
  );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMoviesNotifiers extends StateNotifier<List<Movie>>{
  SearchMoviesCallback searchMovies;
  final Ref ref;
  SearchMoviesNotifiers({
    required this.searchMovies,
    required this.ref
  }): super([]);

  Future<List<Movie>> searchMovieByQuery(String query) async{

    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }

}