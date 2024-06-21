import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mireno_movie/provider/discover/discover_provider.dart';
import 'package:mireno_movie/screen/widget/listview/pelicula_item.dart';

class MovieListItem extends StatelessWidget {
  final Results peliculaItem;
  
  const MovieListItem({super.key, required this.peliculaItem});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: 128.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: PeliculaItem(peliItem: peliculaItem),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, top: 2.0),
              child: Text(
                peliculaItem.title as String,
                style: const TextStyle(fontSize: 8.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, top: 2.0),
              child: Text(
                DateFormat('yyyy').format(DateTime.parse(peliculaItem.releaseDate as String)),
                style: const TextStyle(fontSize: 8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
