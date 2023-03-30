import 'package:flutter/material.dart';

class EndGamePage extends StatelessWidget {
  const EndGamePage({super.key});

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
            const SizedBox(height: 30),
            const Text('Bien joué !', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, color: Colors.white)),
            const SizedBox(height: 10),
            const Text('Votre score : ', 
              textAlign: TextAlign.center,style: TextStyle(fontSize: 30, color: Colors.white)),
            const SizedBox(height: 60),
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
                child: const Text('Suivant', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
              )
            ),
          ]
        ),
      ),
    );
  }
}