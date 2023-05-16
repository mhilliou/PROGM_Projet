import 'package:flutter/material.dart';
import 'multijoueurs.dart';
import 'solo/solo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight * 0.2),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: screenWidth * 0.34,
                        height: screenWidth * 0.34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 255, 71, 71),
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 136, 136)),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: screenWidth * 0.3,
                        height: screenWidth * 0.3,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 255, 136, 136),
                        ),
                      ),
                    ),
                    const Text(
                      'QuickPlay',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Signatra',
                          fontSize: 100,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.15),
                Container(
                  padding: EdgeInsets.only(
                      bottom: 10,
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1),
                  height: screenHeight * 0.09,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SoloPage()));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.09),
                        ),
                      ),
                    ),
                    child: const Text(
                      'JOUER',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  padding: EdgeInsets.only(
                      bottom: 10,
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1),
                  height: screenHeight * 0.09,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MultijoueursPage()));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.09),
                        ),
                      ),
                    ),
                    child: const Text(
                      'MULTIJOUEUR',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
