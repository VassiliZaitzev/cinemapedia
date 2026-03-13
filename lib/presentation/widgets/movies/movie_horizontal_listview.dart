import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String ? subtitle;

  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key, 
    required this.movies, 
    this.title, 
    this.subtitle,
    this.loadNextPage
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(title != null || subtitle != null)
          Row(
            children: [
              _Title(title: title, subtitle: subtitle,),
            ],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => _Slide(movie: movies[index]),
            )
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final textStle = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                fit: BoxFit.cover,
                movie.posterPath,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8),
                      child:  Center(child: CircularProgressIndicator(strokeWidth: 2)) ,
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          SizedBox(height: 5,),

          // title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStle.titleSmall,
            ),      
          ),

          //rating
          Row(
            children: [
              Icon(Icons.star_half_outlined, color: Colors.yellow,),
              SizedBox(width: 3,),
              Text(movie.voteAverage.toString(), style: textStle.bodyMedium?.copyWith(color: Colors.yellow.shade800), ),
              SizedBox(width: 10),
              Text(movie.popularity.toString(), style: textStle.bodySmall ),
            ],
          )
        ],
      )
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Title({ this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            if(title != null)
            Text(title!, style: titleStyle,),
            const Spacer(),
            if(subtitle != null)
            FilledButton.tonal(
              onPressed: (){},
              style: ButtonStyle(visualDensity: VisualDensity.compact), 
              child: Text(subtitle!),
            )
          ],
        ),
      ),
    );
  }
}