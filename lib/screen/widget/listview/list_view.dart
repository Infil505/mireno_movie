import 'package:flutter/material.dart';
import 'package:mireno_movie/provider/discover/discover_provider.dart';

class MyWidget extends StatelessWidget {
  final PeliculaProvider movie;
  final String movieListTitlel;
  const MyWidget(
      {super.key, required this.movie, required this.movieListTitlel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 258.0,
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0, bottom: 7.0),
            child: Text(
              movieListTitlel,
              style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
