import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/src/models/movie/movie_item.dart';
import 'package:themoviedb_flutter/src/models/movie/results.dart';
import 'package:themoviedb_flutter/src/resources/movie_api_provider.dart';
import 'package:themoviedb_flutter/src/ui/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  MovieApiProvider api;

  @override
  void initState() {
    super.initState();
    api = new MovieApiProvider();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieItem>(
        future: api.getMovieList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildMovieGrids(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

Widget buildMovieGrids(AsyncSnapshot<MovieItem> snapshot) {
  return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, 
          childAspectRatio: 0.7
        ),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: InkResponse(
            enableFeedback: true,
            child: Image.network(
              'https://image.tmdb.org/t/p/w185/${snapshot.data.results[index].poster_path}',
              fit: BoxFit.cover,
            ),
            onTap: () => openDetailPelicula(context, snapshot.data.results[index]),
          )
          // child: Text('${snapshot.data.results[index].title}'),
        );
      }
  );
}

openDetailPelicula(BuildContext context, [Results result]) {
  Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) {
      return MovieDetail(
        posterUrl: result.backdrop_path, 
        description: result.overview, 
        releaseDate: result.release_date, 
        title: result.title, 
        voteAverage: result.vote_average, 
        movieId: result.id
      );
    })
  );

}
