import 'package:flutter/material.dart';
import 'multijoueurs.dart';
import 'solo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 160),
            Stack(
              alignment: Alignment.center,
              children: [
              Center(child: Container(width: 170, height: 170, decoration: BoxDecoration(shape: BoxShape.circle, color: const Color.fromARGB(255, 255, 71, 71), border: Border.all(color: const Color.fromARGB(255, 255, 136, 136)),)),),
              Center(child: Container(width: 150, height: 150, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 255, 136, 136))),),
              const Text('NomJeu', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Signatra', fontSize: 100, color: Colors.white),),
            ]),
            const SizedBox(height: 150),
            Container(
              padding: const EdgeInsets.only(bottom: 10, left: 40, right: 40),
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SoloPage()));
                }, 
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                  )
                ),
                child: const Text('JOUER', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
              )
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(bottom: 10, left: 40, right: 40),
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MultijoueursPage()));
                }, 
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                  )
                ),
                child: const Text('MULTIJOUEUR', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
              )
            ),
          ]
        ),
      ),
    );
  }
}