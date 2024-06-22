import 'package:flutter/material.dart';
import 'package:mireno_movie/provider/api/api_provider.dart';
import 'package:mireno_movie/provider/discover/discover_provider.dart';
import 'package:mireno_movie/provider/discover/nosotros.dart';
import 'package:mireno_movie/screen/carousel/carousel_screen.dart';
import 'package:mireno_movie/screen/widget/listview/movie_list.dart';

class MyMovieApp extends StatefulWidget {
  const MyMovieApp({Key? key}) : super(key: key);

  @override
  State<MyMovieApp> createState() => _MyMovieAppState();
}

class _MyMovieAppState extends State<MyMovieApp> {
  late Future<PeliculaProvider> nowPlayingMoviesFuture;
  late Future<PeliculaProvider> popularMoviesFuture;
  late Future<PeliculaProvider> topRateMoviesFuture;
  late Future<PeliculaProvider> upComingMoviesFuture;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    nowPlayingMoviesFuture = ApiService().fetchNowPlayingMovies();
    popularMoviesFuture = ApiService().fetchPopularMovies();
    topRateMoviesFuture = ApiService().fetchTopRateMovies();
    upComingMoviesFuture = ApiService().fetchUpComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Center(
          child: Text(
            'El Minero De Peliculas',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'En cines',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              expandedHeight: 290,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: <Widget>[
                  Image.network(
                    "${baseImageUrl}w500/bcM2Tl5HlsvPBnL8DKP9Ie6vU4r.jpg",
                    fit: BoxFit.cover,
                    width: 1000.0,
                    colorBlendMode: BlendMode.dstATop,
                    color: Colors.blue.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: FutureBuilder<PeliculaProvider>(
                      future: nowPlayingMoviesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          return CarouselSliderWidget(nowPlayingMovies: snapshot.data!);
                        }
                      },
                    ),
                  ),
                ]),
              ),
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            FutureBuilder<PeliculaProvider>(
              future: upComingMoviesFuture,
              builder: (context, content) {
                if (content.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (content.hasError) {
                  return Center(child: Text('Error: ${content.error}'));
                } else {
                  return MoviesListView(pelicula: content.data!, peliculaListTitle: "PROXIMAMENTE");
                }
              },
            ),
            FutureBuilder<PeliculaProvider>(
              future: popularMoviesFuture,
              builder: (context, content) {
                if (content.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (content.hasError) {
                  return Center(child: Text('Error: ${content.error}'));
                } else {
                  return MoviesListView(pelicula: content.data!, peliculaListTitle: "POPULARES");
                }
              },
            ),
            FutureBuilder<PeliculaProvider>(
              future: topRateMoviesFuture,
              builder: (context, content) {
                if (content.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (content.hasError) {
                  return Center(child: Text('Error: ${content.error}'));
                } else {
                  return MoviesListView(pelicula: content.data!, peliculaListTitle: "TOP");
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        fixedColor: Colors.redAccent,
        onTap: (int index) {
          setState(() {
            _index = index;
          });
          switch (index) {
            case 0:
              break; 
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Nosotros()));
              break; 
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_play),
            label: "Categorias",
            tooltip: "Categorias",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_device_information_sharp),
            label: "Sobre nosotros",
            tooltip: "Sobre nosotros",
          ),
        ],
      ),
    );
  }
}
