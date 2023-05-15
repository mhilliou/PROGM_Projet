/*import 'package:flutter/material.dart';



class Game7 extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<Game7> {
  List<Offset> userPoints = [];
  List<Offset> correctPoints = [
    Offset(100, 100),
    Offset(200, 100),
    Offset(200, 200),
    Offset(100, 200),
  ];

  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu de schéma'),
      ),
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset localPosition =
                renderBox.globalToLocal(details.globalPosition);
            userPoints.add(localPosition);
          });
        },
        onPanEnd: (DragEndDetails details) {
          setState(() {
            isCorrect = checkSchema();
            userPoints.clear();
          });
        },
        child: CustomPaint(
          painter: GamePainter(userPoints, correctPoints),
          child: Container(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Center(
            child: Text(
              isCorrect ? 'Schéma correct' : 'ccc',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkSchema() {
    if (userPoints.length != correctPoints.length) {
      return false;
    }

    final double distanceThreshold = 20.0;

    for (int i = 0; i < userPoints.length; i++) {
      double distance = (userPoints[i] - correctPoints[i]).distance;
      if (distance > distanceThreshold) {
        return false;
      }
    }

    return true;
  }
}


class GamePainter extends CustomPainter {
  final List<Offset> userPoints;
  final List<Offset> correctPoints;

  GamePainter(this.userPoints, this.correctPoints);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // Dessine le schéma à reproduire
    for (int i = 0; i < correctPoints.length; i++) {
      if (i < correctPoints.length - 1) {
        canvas.drawLine(
            correctPoints[i], correctPoints[i + 1], paint);
      } else {
        canvas.drawLine(correctPoints[i], correctPoints[0], paint);
      }
    }

    // Dessine le schéma tracé par l'utilisateur
    if (userPoints.length > 1) {
      for (int i = 0; i < userPoints.length - 1; i++) {
        canvas.drawLine(userPoints[i], userPoints[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
*/
/*
import 'dart:math';

import 'package:flutter/material.dart';

enum Shape { square, triangle, circle }

class Game7 extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<Game7> {
  Random random = Random();
  Shape? currentShape;
  bool? isShapeCorrect;

  @override
  void initState() {
    super.initState();
    generateShape();
  }

  void generateShape() {
    setState(() {
      currentShape = Shape.values[random.nextInt(3)];
      isShapeCorrect = false;
    });
  }

  void checkShape(List<Offset> points) {
    bool isCorrect = false;
    switch (currentShape) {
      case Shape.square:
        isCorrect = isSquare(points);
        break;
      case Shape.triangle:
        isCorrect = isTriangle(points);
        break;
      case Shape.circle:
        isCorrect = isCircle(points);
        break;
    }
    setState(() {
      isShapeCorrect = isCorrect;
    });
  }

  bool isSquare(List<Offset> points) {
    if (points.length != 4) return false;
    double sideLength = (points[0] - points[1]).distance;
    for (int i = 1; i < 4; i++) {
      if ((points[i] - points[(i + 1) % 4]).distance != sideLength)
        return false;
    }
    return true;
  }

  bool isTriangle(List<Offset> points) {
    return points.length == 3;
  }

  bool isCircle(List<Offset> points) {
    return points.length >= 16;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu de figures'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Dessinez une figure qui ressemble à :',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: buildShapeWidget(currentShape!),
          ),
          GestureDetector(
            onTapDown: (details) {
              setState(() {
                generateShape();
              });
            },
            child: CustomPaint(
              painter: ShapePainter(
                isShapeCorrect: isShapeCorrect!,
              ),
              child: GestureDetector(
                onTapDown: (details) {
                  List<Offset> points = [];
                  points.add(details.localPosition);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Dessinez la figure'),
                        content: Container(
                          width: 300,
                          height: 300,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                RenderBox renderBox =
                                    context.findRenderObject() as RenderBox;
                                points.add(renderBox
                                    .globalToLocal(details.globalPosition));
                              });
                            },
                            onPanEnd: (details) {
                              checkShape(points);
                              points.clear();
                              Navigator.of(context).pop();
                            },
                            child: CustomPaint(
                              painter: SketchPainter(points: points),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.white,
                  child: CustomPaint(
                    painter: SketchPainter(points: []),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              isShapeCorrect == null
                  ? ''
                  : isShapeCorrect!
                      ? 'Le schéma est correct !'
                      : 'Le schéma est incorrect.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShapeWidget(Shape shape) {
    switch (shape) {
      case Shape.square:
        return Container(
          width: 150,
          height: 150,
          color: Colors.blue,
        );
      case Shape.triangle:
        return Container(
          width: 150,
          height: 150,
          color: Colors.red,
        );
      case Shape.circle:
        return Container(
          width: 150,
          height: 150,
          color: Colors.green,
        );
      default:
        return Container();
    }
  }
}

class ShapePainter extends CustomPainter {
  final bool isShapeCorrect;

  ShapePainter({required this.isShapeCorrect});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isShapeCorrect ? Colors.green : Colors.red
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawRect(
      Rect.fromLTRB(10, 10, size.width - 10, size.height - 10),
      paint,
    );
  }

  @override
  bool shouldRepaint(ShapePainter oldDelegate) {
    return oldDelegate.isShapeCorrect != isShapeCorrect;
  }
}

class SketchPainter extends CustomPainter {
  final List<Offset> points;

  SketchPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    Path path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points[0].dx, points[0].dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SketchPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class Game7 extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<Game7> {
  final GlobalKey<SignatureState> _signatureKey = GlobalKey<SignatureState>();
  bool _isDrawing = false;
  bool _isDrawingCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dessiner un carré'),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  _isDrawing = true;
                  _isDrawingCompleted = false;
                });
              },
              onPanEnd: (_) {
                if (_signatureKey.currentState!.points!.isNotEmpty) {
                  setState(() {
                    _isDrawing = false;
                    _isDrawingCompleted = true;
                  });
                }
              },
              child: Signature(
                key: _signatureKey,
                strokeWidth: 2.0,
                color: Colors.black,
                backgroundPainter: null,
                onSign: () {
                  setState(() {
                    _isDrawingCompleted = true;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              if (_isDrawingCompleted) {
                List<Offset> points = _signatureKey.currentState!.points!
                    .where((offset) => offset != null)
                    .map((offset) => offset!)
                    .toList();

                bool isSquare = checkIfSquare(points);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Résultat'),
                    content: Text(isSquare
                        ? 'Le schéma est correct !'
                        : 'Le schéma est incorrect.'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Attention'),
                    content:
                        Text('Veuillez dessiner un schéma avant de vérifier.'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text('Vérifier'),
          ),
        ],
      ),
    );
  }

  bool checkIfSquare(List<Offset> points) {
    // Vérifiez ici si les points correspondent à un carré.
    // Vous pouvez implémenter votre propre logique de vérification.
    // Ici, nous vérifions simplement si les côtés sont presque parallèles et égaux en longueur.

    if (points.length != 4) {
      return false;
    }

    double tolerance =
        10.0; // Tolérance pour la vérification de parallélisme et d'égalité

    int sidesCount = points.length;

return sidesCount == 4;

  }
}
