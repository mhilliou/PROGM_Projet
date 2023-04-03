import 'dart:math';
import 'package:flutter/material.dart';

import 'game1.dart';
import 'home.dart';

class SoloPage extends StatefulWidget {
  const SoloPage({super.key});

  @override
  State<SoloPage> createState() => _SoloPageState();
}

class _SoloPageState extends State<SoloPage> {

  void choixJeu() {
    List<Widget> jeux = [const Game1()];
    int index = Random().nextInt(jeux.length);
    Navigator.push(context, MaterialPageRoute(builder: (context) => jeux[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, right: 20),
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 136, 136)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )
                    )
                  ),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),
            const SizedBox(height: 200),
            Column(
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(255, 255, 136, 136)),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text('MODE DE JEU', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,color: Colors.white)),
                    ),
                    Container(
                      width: 220,
                      height: 50,
                      decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(255, 255, 95, 20)),
                      child: TextButton(onPressed: () {
                        choixJeu();
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const Game1()));
                      }, child: const Text('ALÉATOIRE', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ,color: Colors.white)), )
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 220,
                      height: 50,
                      decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(255, 255, 95, 20)),
                      child: TextButton(onPressed: () {
                        
                      }, child: const Text('MINI-JEUX', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ,color: Colors.white)), )
                    ),
                    const SizedBox(height: 20),
                ]),),
              ],
            ),
            const SizedBox(height: 180),
            TextButton(onPressed: () {
              
            }, child: const Text('REGLES DU JEU', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ,color: Colors.black)), ),
          ]
        ),
      ),
    );
  }
}