import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
//import 'package:progm_projet/game1.dart';
import 'package:progm_projet/game1multi.dart';

import 'endgamemulti.dart';

_AdversairePageState? adversairePageState;

class AdversairePage extends StatefulWidget {
  final FlutterP2pConnection flutterP2pConnectionPlugin;
  final String? pseudo;
  final WifiP2PInfo? wifiP2PInfo;

  const AdversairePage(
      {super.key,
      required this.flutterP2pConnectionPlugin,
      required this.pseudo,
      required this.wifiP2PInfo});

  @override
  State<AdversairePage> createState() => _AdversairePageState();

  Future<void> callsendMessage(String text) async {
    print("send message");
      adversairePageState?.sendMessage(text);  
  }

  _AdversairePageState? of(BuildContext context) {
    final state = context.findAncestorStateOfType<_AdversairePageState>();
    adversairePageState = state;
    return state;
  }

}

class _AdversairePageState extends State<AdversairePage> {
  String? adversaire;
  bool startGame = false;
  Widget? jeu;
  int? scoreAdversaire;
  Game1Multi? game1;

  AdversairePage? _adversairePageState;

  @override
  void initState() {
    super.initState();
    _adversairePageState = widget;
    _init();
  }

  void _init() async {
    await widget.flutterP2pConnectionPlugin.initialize();
    if (widget.wifiP2PInfo!.isGroupOwner) {
      //il est l'hote creer un socket
      await startSocket();
    } else {
      //il est le client se connecter au socket
      await connectToSocket();
    }
    await sendMessage("nom:${(widget.pseudo)}");
  }

  Future startSocket() async {
    if (widget.wifiP2PInfo != null) {
      await widget.flutterP2pConnectionPlugin.startSocket(
        groupOwnerAddress: widget.wifiP2PInfo!.groupOwnerAddress,
        downloadPath: "/storage/emulated/0/Download/",
        maxConcurrentDownloads: 2,
        deleteOnError: true,
        onConnect: (name, address) {
          print("$name connected to socket with address: $address");
        },
        transferUpdate: (transfer) {
          print(
              "ID: ${transfer.id}, FILENAME: ${transfer.filename}, PATH: ${transfer.path}, COUNT: ${transfer.count}, TOTAL: ${transfer.total}, COMPLETED: ${transfer.completed}, FAILED: ${transfer.failed}, RECEIVING: ${transfer.receiving}");
        },
        // handle string transfer from server
        receiveString: (req) async {
          print("receiveStartConnect $req");
          setState(() {
            List<String> splitted = req.split(":");
            if (splitted.first == "nom") {
              adversaire = splitted[1];
            } else if (splitted.first == "score") {
              scoreAdversaire = int.parse(splitted[1]);
              print('page score');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EndGameMultiPage(
                          score: game1!.getScore(),
                          scoreAdversaire: scoreAdversaire!,
                          pseudo: widget.pseudo,
                          adversaire: adversaire,
                          wifiP2PInfo: widget.wifiP2PInfo,
                          flutterP2pConnectionPlugin:
                              widget.flutterP2pConnectionPlugin)));
            }
          });
        },
      );
    }
  }

// Connect to socket
  Future connectToSocket() async {
    if (widget.wifiP2PInfo != null) {
      await widget.flutterP2pConnectionPlugin.connectToSocket(
        groupOwnerAddress: widget.wifiP2PInfo!.groupOwnerAddress,
        downloadPath: "/storage/emulated/0/Download/",
        maxConcurrentDownloads: 2,
        deleteOnError: true,
        onConnect: (address) {
          print("connected to socket: $address");
        },
        transferUpdate: (transfer) {
          print(
              "ID: ${transfer.id}, FILENAME: ${transfer.filename}, PATH: ${transfer.path}, COUNT: ${transfer.count}, TOTAL: ${transfer.total}, COMPLETED: ${transfer.completed}, FAILED: ${transfer.failed}, RECEIVING: ${transfer.receiving}");
        },
        // handle string transfer from server
        receiveString: (req) async {
          print("receiveString: $req");
          setState(() {
            List<String> splitted = req.split(":");
            print("splitted $splitted");
            print("splitted.first ${splitted.first}");
            if (splitted.first == "nom") {
              adversaire = splitted[1];
            } else if (splitted.first == "startGame") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => game1 = Game1Multi(
                          aleatoire: true,
                          nbJeu: 0,
                          scoreJeu: 0,
                          flutterP2pConnectionPlugin:
                              widget.flutterP2pConnectionPlugin,
                          pseudo: widget.pseudo,
                          wifiP2PInfo: widget.wifiP2PInfo,
                          adversairePage: AdversairePage(
                              flutterP2pConnectionPlugin:
                                  widget.flutterP2pConnectionPlugin,
                              pseudo: widget.pseudo,
                              wifiP2PInfo: widget.wifiP2PInfo))));
            } else if (splitted.first == "score") {
              scoreAdversaire = int.parse(splitted[1]);
              print('page score');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EndGameMultiPage(
                          score: game1!.getScore(),
                          scoreAdversaire: scoreAdversaire!,
                          pseudo: widget.pseudo,
                          adversaire: adversaire,
                          wifiP2PInfo: widget.wifiP2PInfo,
                          flutterP2pConnectionPlugin:
                              widget.flutterP2pConnectionPlugin)));
            }
          });
        },
      );
    }
  }

  //Lancer le jeu en même temps que l'adversaire
  void lancerGame() {
    //Attendre un delay avant de lancer le jeu
    Future.delayed(const Duration(seconds: 3), () {
      //Lancer le jeu
      sendMessage("startGame:true");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => game1 = Game1Multi(
                  aleatoire: true,
                  nbJeu: 0,
                  scoreJeu: 0,
                  flutterP2pConnectionPlugin: widget.flutterP2pConnectionPlugin,
                  pseudo: widget.pseudo,
                  wifiP2PInfo: widget.wifiP2PInfo,
                  adversairePage: AdversairePage(
                      flutterP2pConnectionPlugin:
                          widget.flutterP2pConnectionPlugin,
                      pseudo: widget.pseudo,
                      wifiP2PInfo: widget.wifiP2PInfo))));
    });
  }

  void choixJeu() {
    List<Widget> jeux = [
      game1 = Game1Multi(
          aleatoire: true,
          nbJeu: 0,
          scoreJeu: 0,
          flutterP2pConnectionPlugin: widget.flutterP2pConnectionPlugin,
          pseudo: widget.pseudo,
          wifiP2PInfo: widget.wifiP2PInfo,
          adversairePage: AdversairePage(
              flutterP2pConnectionPlugin: widget.flutterP2pConnectionPlugin,
              pseudo: widget.pseudo,
              wifiP2PInfo: widget.wifiP2PInfo))
    ];
    print("jeu avant if $jeu");
    if (jeu == null) {
      int index = Random().nextInt(jeux.length);
      jeu = jeux[index];
    }
    print("jeu après if $jeu");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => jeu as Widget));
    jeu = null;
  }

  Future sendMessage(String text) async {
    print("text $text");
    widget.flutterP2pConnectionPlugin.sendStringToSocket(text);
    List<String> splitted = text.split(":");
    if(splitted.first == "score") {
              //scoreAdversaire = int.parse(splitted[1]);
              print('page score');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EndGameMultiPage(
                          score: int.parse(splitted[1]),//game1!.getScore(),
                          scoreAdversaire: scoreAdversaire!,
                          pseudo: widget.pseudo,
                          adversaire: adversaire,
                          wifiP2PInfo: widget.wifiP2PInfo,
                          flutterP2pConnectionPlugin:
                              widget.flutterP2pConnectionPlugin)));
            }

  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    adversairePageState = this;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: screenHeight,
                  width: screenWidth / 2,
                  color: const Color.fromARGB(255, 255, 71, 71),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 0.05 * screenWidth,
                      top: 0.2 * screenHeight,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${widget.pseudo}",
                      style: TextStyle(
                        fontSize: 0.04 * screenWidth,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: screenHeight,
                  width: screenWidth / 2,
                  color: const Color.fromARGB(255, 255, 32, 32),
                  child: Container(
                    padding: EdgeInsets.only(
                      right: 0.05 * screenWidth,
                      bottom: 0.2 * screenHeight,
                    ),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$adversaire",
                      style: TextStyle(
                        fontSize: 0.04 * screenWidth,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    width: 0.2 * screenWidth,
                    height: 0.2 * screenWidth,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 255, 71, 71),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 136, 136),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 0.16 * screenWidth,
                    height: 0.16 * screenWidth,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 255, 136, 136),
                    ),
                  ),
                ),
                Text(
                  'VS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 0.08 * screenWidth,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                bottom: 0.05 * screenHeight,
              ),
              child: ElevatedButton(
                onPressed: () {
                  lancerGame();
                },
                child: const Text("Lancer le jeu"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
