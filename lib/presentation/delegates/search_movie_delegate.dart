
import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback =Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?>{
  
  
  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies
  });

  void _clearStreams(){
    debounceMovies.close();
  }

  void _onQueryChanged(String query){
    if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(microseconds: 500), () async{
      if(query.isEmpty){
        debounceMovies.add([]);
        return;
      }

      final movies = await searchMovies(query);
      debounceMovies.add(movies);
    });

  }

  @override
  String get searchFieldLabel => "Buscar película";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = "", 
          icon: Icon(Icons.clear)
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: ()  {
        _clearStreams();
        close(context, null);
      }, 
      icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return StreamBuilder(
      //future: searchMovies(query), 
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie){
              _clearStreams();
              close(context, movie);
            },
          )
        );
      },
    );
  }

}



class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //IMAGE
            SizedBox(
              width: size.width * 0.20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) {
                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
            //DESCRIPTION
            SizedBox(width: 10,),
            SizedBox(
              width: size.width * 0.70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium,),
                  movie.overview.length > 100
                  ? Text("${movie.overview.substring(0,100)} ...")
                  : Text(movie.overview),
      
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800,),
                      SizedBox(width: 5,),
                      Text(
                        HumanFormat.humanReadbleNumber(movie.voteAverage, 1).toString(),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}