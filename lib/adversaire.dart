import 'package:flutter/material.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';

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
}

class _AdversairePageState extends State<AdversairePage> {
  @override
  void initState() {
    super.initState();
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
    await sendMessage("${(widget.pseudo)}");
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
          // transfer.count is the amount of bytes transfered
          // transfer.total is the file size in bytes
          // if transfer.receiving is true, you are receiving the file, else you're sending the file.
          // call `transfer.cancelToken?.cancel()` to cancel transfer. This method is only applicable to receiving transfers.
          print(
              "ID: ${transfer.id}, FILENAME: ${transfer.filename}, PATH: ${transfer.path}, COUNT: ${transfer.count}, TOTAL: ${transfer.total}, COMPLETED: ${transfer.completed}, FAILED: ${transfer.failed}, RECEIVING: ${transfer.receiving}");
        },
        // handle string transfer from server
        receiveString: (req) async {
          print(req);
        },
      );
    }
  }

  final _flutterP2pConnectionPlugin = FlutterP2pConnection();
  WifiP2PInfo? wifiP2PInfo;

// Connect to socket
  Future connectToSocket() async {
    if (wifiP2PInfo != null) {
      await _flutterP2pConnectionPlugin.connectToSocket(
        groupOwnerAddress: wifiP2PInfo!.groupOwnerAddress,
        downloadPath: "/storage/emulated/0/Download/",
        maxConcurrentDownloads: 2,
        deleteOnError: true,
        onConnect: (address) {
          print("connected to socket: $address");
        },
        transferUpdate: (transfer) {
          // transfer.count is the amount of bytes transfered
          // transfer.total is the file size in bytes
          // if transfer.receiving is true, you are receiving the file, else you're sending the file.
          // call `transfer.cancelToken?.cancel()` to cancel transfer. This method is only applicable to receiving transfers.
          print(
              "ID: ${transfer.id}, FILENAME: ${transfer.filename}, PATH: ${transfer.path}, COUNT: ${transfer.count}, TOTAL: ${transfer.total}, COMPLETED: ${transfer.completed}, FAILED: ${transfer.failed}, RECEIVING: ${transfer.receiving}");
        },
        // handle string transfer from server
        receiveString: (req) async {
          print(req);
        },
      );
    }
  }

  Future sendMessage(String text) async {
    print(text);
    _flutterP2pConnectionPlugin.sendStringToSocket(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 71, 71),
      body: SafeArea(
        child: Stack(children: [
          Row(children: [
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              color: const Color.fromARGB(255, 255, 71, 71),
              child: Container(
                padding: const EdgeInsets.only(left: 30, top: 120),
                alignment: Alignment.topLeft,
                child: Text("${widget.pseudo}", style: const TextStyle(fontSize: 20, color: Colors.white),),
                ),
            ),
            Container(
              alignment: Alignment.centerRight,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              color: const Color.fromARGB(255, 255, 32, 32),
              child: Container(
                padding: const EdgeInsets.only(right: 30, bottom: 120),
                alignment: Alignment.bottomRight,
                child: Text("Adversaire", style: const TextStyle(fontSize: 20, color: Colors.white),),
                ),
            )
          ],),
          Stack(
              alignment: Alignment.center,
              children: [
              Center(child: Container(width: 100, height: 100, decoration: BoxDecoration(shape: BoxShape.circle, color: const Color.fromARGB(255, 255, 71, 71), border: Border.all(color: const Color.fromARGB(255, 255, 136, 136)),)),),
              Center(child: Container(width: 80, height: 80, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 255, 136, 136))),),
              const Text('VS', textAlign: TextAlign.center, style: TextStyle(fontSize: 40, color: Colors.white),),
            ]),
        ]),
      ),
    );
  }
}
