import 'package:flutter/material.dart';
import 'package:mireno_movie/screen/discover/discover_screen.dart';

class Nosotros extends StatelessWidget {
  const Nosotros({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minero de Peliculas APP'), 
      ),
      body: const SingleChildScrollView( 
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                'Sobre nosotros',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0), 
              Text(
                'Aplicacion creada con fines academicos, diseñada para ver informacion de peliculas ademas de ver las que estan en cines y cuales son las mas populares en la API The Movie DB', 
              ),
              SizedBox(height: 16.0),
              Text(
                'Versión: 1.0.0', 
              ),
              SizedBox(height: 16.0),
              Text(
                'Creado por:', 
              ),
              SizedBox(height: 16.0),
              Text(
                'desarrollador: Darwin Silva Gadea', 
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, 
        fixedColor: Colors.redAccent,
        onTap: (int index) {
          switch (index) {
            case 0:
            Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const MyMovieApp()));
              break;
            case 1:
              // es el mismo por lo que para que poner algo
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
