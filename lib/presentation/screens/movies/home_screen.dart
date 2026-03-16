import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static String name = "home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Home Screen"),
      ),*/
      body: _HomeView(),
      bottomNavigationBar: CustomButtonNavigation()
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    if (nowPlayingMovies.isEmpty) return Center(child: CircularProgressIndicator());
    
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
                    movies: nowPlayingMovies,
                    title: "Próximamente",
                    subtitle: "En este mes",
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),
              
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: "Populares",
                    subtitle: "",
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),
              
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: "Mejor calificadas",
                    subtitle: "Desde siempre",
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
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
          )
        )
      ]
      
    );
  }
}