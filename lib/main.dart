import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PokemonScreen());
  }
}

class PokemonScreen extends StatefulWidget {
  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  String? pokemonName;
  String? pokemonImage;
  bool isLoading = false;

  Future<void> fetchPokemonData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon/charmander'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          pokemonName = data['name'];
          pokemonImage = data['sprites']['front_default'];
        });
      } else {
        throw Exception('Failed to load Pokémon data');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokémon'), backgroundColor: Colors.red),
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido principal
          Center(
            child:
                isLoading
                    ? CircularProgressIndicator()
                    : pokemonName != null && pokemonImage != null
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pokemonName!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Image.network(pokemonImage!, height: 200),
                      ],
                    )
                    : Text(
                      'Error al cargar datos del Pokémon',
                      style: TextStyle(color: Colors.white),
                    ),
          ),
        ],
      ),
    );
  }
}
