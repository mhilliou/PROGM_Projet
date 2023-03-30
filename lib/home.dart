import 'package:flutter/material.dart';
import 'multijoueurs.dart';
import 'solo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            const Center(child: Text('Game', style: TextStyle(fontFamily: 'Signatra', fontSize: 100, color: Colors.white),)),
            const SizedBox(height: 30),
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
                child: const Text('Mode Solo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
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
                child: const Text('Mode Multijoueurs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
              )
            ),
          ]
        ),
      ),
    );
  }
}