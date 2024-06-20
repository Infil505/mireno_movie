import 'package:flutter/material.dart';
import 'package:mireno_movie/provider/api/api_provider.dart';
import 'package:mireno_movie/provider/discover/discover_provider.dart';

class PeliculaItem extends StatelessWidget {
  final Results peliItem;
  static int _counter = 0;

  const PeliculaItem({super.key, required this.peliItem});

  @override
  Widget build(BuildContext context) {
    _counter += 1;
    return Material(
      elevation: 15.0,
      child: InkWell( // este nos permite ver los datos de la pelicula y nos deja ver una animacion 
        onTap: () {
          
        },
        child: Hero(   // widget de animacion
          tag: _counter, //peliItem.id as int,
          child: Image.network(
            "${baseImageUrl}w342${peliItem.posterPath}",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  static int get counter => _counter;
}
