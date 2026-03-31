import 'package:cinemapedia/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(pupularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initalLoading = ref.watch(initialLoagingProvider);
    if (initalLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);


    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);    
    final popularMovies = ref.watch(pupularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);


    
    
    return CustomScrollView(      
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            title: CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
              
                  
                  MoviesSlideshow(
                    movies: slideShowMovies
                  ),
              
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: "En cines",
                    subtitle: "Lunes 20",
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),
              
              
                  MovieHorizontalListview(
                    movies: upcomingMovies,
                    title: "Próximamente",
                    subtitle: "En este mes",
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                  ),
              
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: "Populares",
                    //subtitle: "",
                    loadNextPage: () => ref.read(pupularMoviesProvider.notifier).loadNextPage(),
                  ),
              
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: "Mejor calificadas",
                    subtitle: "Desde siempre",
                    loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                  ),


                  SizedBox(height: 50,)
                  /*Expanded(
                    child: ListView.builder(
                      itemCount: nowPlayingMovies.length,
                      itemBuilder: (context, index) {
                        final movie = nowPlayingMovies[index];
                        return ListTile(
                          title: Text(movie.title),
                        );
                      },
                    ),
                  )*/
                ],
              );
            },
            childCount: 1
          )
        )
      ]
      
    );
  }
}