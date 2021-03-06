import 'package:flutter/material.dart';

import 'package:upcomming_movies_flutter/src/model/movie.dart';
import 'package:upcomming_movies_flutter/src/ui/detail_page.dart';
import 'package:upcomming_movies_flutter/src/utils.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final int _index;

  MovieListItem(this.movie, this._index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(movie, _index),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Container(
          height: 180,
          child: Stack(children: <Widget>[
            Row(
              children: <Widget>[
                _moviePoster(),
                new Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _movieTitle(),
                        SizedBox(height: 8),
                        _movieGenre(),
                        SizedBox(height: 8),
                        _movieOverview(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 130,
              left: 90,
              child:
                  Container(height: 42, width: 42, child: _movieAverageVote()),
            )
          ]),
        ),
      ),
    );
  }

  _moviePoster() =>
      Container(
        height: 180,
        width: 111,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(child: CircularProgressIndicator()),
            Hero(
                tag: movie.posterPath ?? _index.toString() + "poster_detail",
                child: Image.network(
                  Utils.getPosterImage(false, movie.posterPath),
                  fit: BoxFit.fitHeight,
                ))
          ],
        ),
      );

  _movieTitle() => Hero(
        tag: movie.id.toString() + "title",
        child: Material(
          color: Colors.transparent,
          child: Text(
            movie.title ?? "N/A",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Lato'),
          ),
        ),
      );

  _movieGenre() => Hero(
        tag: movie.id.toString() + "genre",
        child: Material(
          color: Colors.transparent,
          child: Text(
            Utils.getGeners(movie.genreIds),
            style: TextStyle(fontSize: 14, fontFamily: 'Lato'),
          ),
        ),
      );

  _movieOverview() => Hero(
        tag: movie.id.toString() + "overview",
        child: Material(
          color: Colors.transparent,
          child: Text(
            movie.overview ?? "N/A",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, fontFamily: 'Lato'),
          ),
        ),
      );

  _movieAverageVote() => Container(
      height: 42,
      width: 42,
      child: RawMaterialButton(
        fillColor: Colors.orangeAccent,
        elevation: 8,
        shape: CircleBorder(),
        child: Text(
          "${movie.voteAverage ?? ""}",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato'),
        ),
        onPressed: () {},
      ));
}
