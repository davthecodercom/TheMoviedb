import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/src/models/trailers/results.dart';
import 'package:themoviedb_flutter/src/models/trailers/trailer_item.dart';
import 'package:themoviedb_flutter/src/resources/movie_api_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetail extends StatefulWidget {

  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;
  
  MovieDetail({
    this.posterUrl, 
    this.description, 
    this.releaseDate, 
    this.title, 
    this.voteAverage, 
    this.movieId
  });

  @override
  _MovieDetailState createState() => _MovieDetailState(
    posterUrl: posterUrl, 
    description: description, 
    releaseDate: releaseDate, 
    title: title, 
    voteAverage: voteAverage, 
    movieId: movieId
  );
}

class _MovieDetailState extends State<MovieDetail> {

  final String YOUTUBE_KEY = "YouTube";

  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;
  
  _MovieDetailState({
    this.posterUrl, 
    this.description, 
    this.releaseDate, 
    this.title, 
    this.voteAverage, 
    this.movieId
  });

  final marginTop = Container(
    margin: EdgeInsets.only(top: 10.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget> [
              SliverAppBar(
                expandedHeight: 200.0,
                elevation: 0.0,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'https://image.tmdb.org/t/p/w300/$posterUrl',
                    fit: BoxFit.cover,
                ),
                ),
              )
            ];
          }, 
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, 
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                  )
                ),
                marginTop,
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      voteAverage,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.yellow,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                    ),
                    Text(
                      releaseDate,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ],
                ),
                marginTop,
                Text(description),
                marginTop,
                Text(
                  'Trailers',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                FutureBuilder<TrailerItem>(
                  future: MovieApiProvider().getVideos(movieId),
                  builder: (context, trailerSnapShot) {
                    if(trailerSnapShot.hasData) {
                      if(trailerSnapShot.data.results.length > 0) {
                        return trailerLayout(trailerSnapShot.data);
                      } else {
                        return noTrailer();
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget trailerLayout(TrailerItem data) {
    var widget = <Widget>[];
    for (int i = 0; i < data.results.length && i < 2; i++) {
      widget.add(createItemLayouts(data.results[i]));
    }
    return Row(children: widget,);
  }

  Widget noTrailer() {
    return Center(child: Text("There is not trailers available"));
  }

  createItemLayouts(Results results) {
    return Expanded(
    child:Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 100.0,
            color: Colors.grey,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.play_circle_filled),
                onPressed: () {
                  _verVideo(results);
                },
              ),
            ),
          ),
          Text(
            results.name,
            maxLines: 1,
            overflow: TextOverflow.fade,
          )
        ],
      )
    );
  }

  Future<void> _verVideo(Results result) async {
    String videoUrl;
    if(result.site == YOUTUBE_KEY) {
      videoUrl = "https://www.youtube.com/watch?v=${result.key}";
    } else {
      videoUrl = "https://vimeo.com/${result.key}";
    }

    if(await canLaunch(videoUrl)) {
      await launch(videoUrl);
    } else {
      throw 'Is not possible to launch the video trailer';
    }
  }

}