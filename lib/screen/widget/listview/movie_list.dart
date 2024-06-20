import 'package:flutter/material.dart';
import 'package:mireno_movie/provider/discover/discover_provider.dart';
import 'package:mireno_movie/screen/widget/listview/item_list.dart';

class MoviesListView extends StatelessWidget {
  final PeliculaProvider pelicula;
  final String peliculaListTitle;
  
  const MoviesListView({super.key, required this.pelicula, required this.peliculaListTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 258.0,
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0, bottom: 7.0),
            child: Text(
              peliculaListTitle,
              style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Flexible(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: pelicula.results == null
                  ? <Widget>[
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ]
                  : pelicula.results!.map((movieItem) => Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 2.0),
                      child: MovieListItem(peliculaItem: movieItem),
                    )).toList(),
            ),
          )
        ],
      ),
    );
  }
}
