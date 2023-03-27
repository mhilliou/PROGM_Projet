import 'package:flutter/material.dart';
import 'game1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      /*home: const MyHomePage(),*/
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/1player': (context) => const MyPage1Player(),
        '/2players': (context) => const MyPage2Players(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Widget elements = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Jeu',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.red,
            padding: const EdgeInsets.all(16.0),
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/1player');
          },
          child: const Text('1 player'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.red,
            padding: const EdgeInsets.all(16.0),
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/2players');
          },
          child: const Text('2 players'),
        ),
      ],
    );

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/image_1.png"),
              fit: BoxFit.cover,
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: elements),
    );
  }
}

class MyPage1Player extends StatefulWidget {
  const MyPage1Player({super.key});

  @override
  State<MyPage1Player> createState() => _MyPage1PlayerState();
}

class _MyPage1PlayerState extends State<MyPage1Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            child: Text("Go back"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Game1(),
                ),
              );
            },
            child: Text('Play'),
          ),
        ],
      ),
    );
  }
}

class MyPage2Players extends StatefulWidget {
  const MyPage2Players({super.key});

  @override
  State<MyPage2Players> createState() => _MyPage2PlayersState();
}

class _MyPage2PlayersState extends State<MyPage2Players> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        child: Text("Go back"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
