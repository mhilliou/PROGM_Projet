import 'package:flutter/material.dart';

class MultijoueursPage extends StatelessWidget {
  const MultijoueursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: Container(
        padding: const EdgeInsets.only(bottom: 130),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text('Mode Multijoueurs', style: TextStyle(fontFamily: 'Signatra', fontSize: 70, color: Colors.white),)),
            const SizedBox(height: 30),
            const Text('Bienvenue dans le mode multijoueurs !', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 10),
            const Text('3 défis vont vous être proposés aléatoirement, à vous de savoir les résoudre pour gagner un maximum de points.', 
              textAlign: TextAlign.center,style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 10),
            const Text('Bonne chance !', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 30),
            const Text('En attente des autres joueurs...', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(bottom: 10, left: 40, right: 40),
              height: 70,
              child: ElevatedButton(
                onPressed: () {}, 
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                  )
                ),
                child: const Text('Play', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
              )
            ),
          ]
        ),
      ),
    );
  }
}