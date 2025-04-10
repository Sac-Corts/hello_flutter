import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Widgets Básicos')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Widget Text
              Text(
                'Hola, Flutter!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20), // Espaciado entre widgets
              // Widget Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.star, color: Colors.blue),
                  Icon(Icons.favorite, color: Colors.red),
                  Icon(Icons.thumb_up, color: Colors.green),
                ],
              ),
              SizedBox(height: 20),

              // Widget Stack
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 100, height: 100, color: Colors.blue),
                  Text(
                    'Stack',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Widget Container
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Soy un Container', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
