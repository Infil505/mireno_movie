import 'package:flutter/material.dart';
import 'package:mireno_movie/provider/api/api_provider.dart';
import 'package:mireno_movie/provider/discover/discover_provider.dart';
import '../.././detalle_pelicula.dart';
class PeliculaItem extends StatelessWidget {
  final Results peliItem;
  static int counter = 0;

  const PeliculaItem({super.key, required this.peliItem});

  @override
  Widget build(BuildContext context) {
    counter += 1;
    peliItem.counter = counter;
    return Material(
      elevation: 15.0,
      child: InkWell( 
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=> Detalles(movie: peliItem)));  
        },
        child: Hero(   
          tag: counter, 
          child: Image.network(
            "${baseImageUrl}w342${peliItem.posterPath}",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}
