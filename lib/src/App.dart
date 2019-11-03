import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/src/ui/movie_list.dart';

class App extends StatelessWidget {
  final Text appBarTitle = const Text('TheMovieDB Flutter');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: appBarTitle,
        ),
        body: MovieList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.movie),
          onPressed: null,
        )
      ),
    );
  }
}
