import 'package:flutter/material.dart';

void main() => runApp(PeliculasApp());

class PeliculasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Películas',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/catalogo': (context) => CatalogoScreen(),
        '/detalle': (context) => DetalleScreen(),
        '/admin': (context) => AdminScreen(),
      },
    );
  }
}

// Datos simulados
class Pelicula {
  final String titulo;
  final String anio;
  final String director;
  final String genero;
  final String sinopsis;
  final String imagenUrl;

  Pelicula(
    this.titulo,
    this.anio,
    this.director,
    this.genero,
    this.sinopsis,
    this.imagenUrl,
  );
}

List<Pelicula> peliculas = [
  Pelicula(
    'Thunderbolts',
    '2025',
    'Jake Schreier',
    'Acción',
    'Un grupo de antihéroes es reunido por el gobierno para llevar a cabo misiones encubiertas.',
    'https://m.media-amazon.com/images/M/MV5BNDIzNGUwZmYtODM0Yy00NjA3LTgxOGUtOTY0ZGM5MjBkM2I3XkEyXkFqcGc@._V1_.jpg',
  ),
  Pelicula(
    'Minecraft: La Película',
    '2025',
    'Jared Hess',
    'Aventura',
    'Una adolescente y su grupo de aventureros deben salvar su mundo de un Ender Dragon.',
    'https://m.media-amazon.com/images/S/pv-target-images/624fd859d0ee60c1dcfe59cdc4f2bb6ecbb5f27f29314a9581d43095f6240ca8.jpg',
  ),
  Pelicula(
    'Destino Final: Lazos de Sangre',
    '2025',
    'Zach Lipovsky & Adam B. Stein',
    'Terror',
    'Una nueva entrega de la franquicia donde la muerte persigue a un grupo de sobrevivientes.',
    'https://m.media-amazon.com/images/M/MV5BMTlmNDRiZjgtNmYxNi00NTc3LWFlNzEtNzE0ZGQ1ODdlMDQ5XkEyXkFqcGc@._V1_.jpg',
  ),
];

// Pantalla de Inicio
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Catálogo de Películas', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla Login (simulada)
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/catalogo'),
          child: Text('Entrar al Catálogo'),
        ),
      ),
    );
  }
}

// Pantalla de Catálogo
class CatalogoScreen extends StatefulWidget {
  @override
  _CatalogoScreenState createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  void eliminarPelicula(int index) {
    setState(() {
      peliculas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catálogo')),
      body: ListView.builder(
        itemCount: peliculas.length,
        itemBuilder: (context, index) {
          final pelicula = peliculas[index];
          return Card(
            margin: EdgeInsets.all(12),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.network(
                      pelicula.imagenUrl,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    pelicula.titulo,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed:
                            () => Navigator.pushNamed(
                              context,
                              '/detalle',
                              arguments: pelicula,
                            ),
                        child: Text('Ver Detalles'),
                      ),
                      ElevatedButton(
                        onPressed: () => eliminarPelicula(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Eliminar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/admin'),
        child: Icon(Icons.admin_panel_settings),
      ),
    );
  }
}

// Pantalla Detalle
class DetalleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula =
        ModalRoute.of(context)!.settings.arguments as Pelicula;
    return Scaffold(
      appBar: AppBar(title: Text(pelicula.titulo)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                pelicula.imagenUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text('Año: ${pelicula.anio}'),
            Text('Director: ${pelicula.director}'),
            Text('Género: ${pelicula.genero}'),
            SizedBox(height: 8),
            Text('Sinopsis:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(pelicula.sinopsis),
          ],
        ),
      ),
    );
  }
}

// Pantalla de Administración
class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final tituloCtrl = TextEditingController();
  final anioCtrl = TextEditingController();
  final directorCtrl = TextEditingController();
  final generoCtrl = TextEditingController();
  final sinopsisCtrl = TextEditingController();
  final imagenCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Administrar Películas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: tituloCtrl,
                  decoration: InputDecoration(labelText: 'Título'),
                ),
                TextFormField(
                  controller: anioCtrl,
                  decoration: InputDecoration(labelText: 'Año'),
                ),
                TextFormField(
                  controller: directorCtrl,
                  decoration: InputDecoration(labelText: 'Director'),
                ),
                TextFormField(
                  controller: generoCtrl,
                  decoration: InputDecoration(labelText: 'Género'),
                ),
                TextFormField(
                  controller: sinopsisCtrl,
                  decoration: InputDecoration(labelText: 'Sinopsis'),
                ),
                TextFormField(
                  controller: imagenCtrl,
                  decoration: InputDecoration(labelText: 'URL de Imagen'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final nueva = Pelicula(
                      tituloCtrl.text,
                      anioCtrl.text,
                      directorCtrl.text,
                      generoCtrl.text,
                      sinopsisCtrl.text,
                      imagenCtrl.text,
                    );
                    setState(() {
                      peliculas.add(nueva);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Película agregada.')),
                    );
                  },
                  child: Text('Agregar Película'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
