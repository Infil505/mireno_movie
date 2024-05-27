import 'package:flutter/material.dart';
import 'package:mireno_movie/provider/api/api_provider.dart';
import 'package:mireno_movie/provider/discover/discover_provider.dart';
import 'package:mireno_movie/screen/carousel/carousel_screen.dart';
import 'package:mireno_movie/screen/widget/heder_widget.dart';

class MyMovieApp extends StatefulWidget {
  const MyMovieApp({super.key});

  @override
  State<MyMovieApp> createState() => _MyMovieAppState();
}

class _MyMovieAppState extends State<MyMovieApp> {
  late Future<PeliculaProvider> nowPlayingMoviesFuture;

  @override
  void initState() {
    super.initState();
    nowPlayingMoviesFuture = ApiService().fetchNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'El Minero De Peliculas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // falta poner lo que se vera aqui
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // falta aqui el buscar
            },
          )
        ],
      ),
      
      body: FutureBuilder<PeliculaProvider>(
        future: nowPlayingMoviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  HeaderWidget(
                    carouselSlider: CarouselSliderWidget(
                      nowPlayingMovies: snapshot.data!,
                    ), title: '',
                  )
                ];
              },
              body: const Center(child: Text('Scrollme')),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}