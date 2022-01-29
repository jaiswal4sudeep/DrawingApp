// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DrawingBoard {
  Offset points;
  Paint brush;

  DrawingBoard({required this.brush, required this.points});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DrawingBoard> points = [];
  late Color brushColor = Colors.black;
  late double brushStrokeWidth = 5.0;

  @override
  void initState() {
    brushColor = Colors.black;
    brushStrokeWidth = 5.0;
    super.initState();
  }

  void changeBrushColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select any color'),
          content: SizedBox(
            height: 300,
            child: BlockPicker(
              pickerColor: brushColor,
              onColorChanged: (color) {
                setState(
                  () {
                    brushColor = color;
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void changeBrushSize() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select brush size'),
          content: SizedBox(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        brushStrokeWidth = 1;
                      },
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        brushStrokeWidth = 2;
                      },
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        brushStrokeWidth = 3;
                      },
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 3,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        brushStrokeWidth = 4;
                      },
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 4,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        brushStrokeWidth = 5;
                      },
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 5,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        brushStrokeWidth = 6;
                      },
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 6,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        brushStrokeWidth = 7;
                      },
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 7,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        brushStrokeWidth = 8;
                      },
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 8,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(
                  () {
                    Navigator.of(context).pop();
                  },
                );
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFfdf4f4),
                  Color(0xFFd4cdcd),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFece4e4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFc9c2c2),
                        blurRadius: 15.0,
                        spreadRadius: 0.15,
                        offset: Offset(15, 15),
                      ),
                      BoxShadow(
                        color: Color(0xFFfff7f7),
                        blurRadius: 15.0,
                        spreadRadius: 0.15,
                        offset: Offset(-15, -15),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onPanDown: (details) {
                      setState(
                        () {
                          points.add(
                            DrawingBoard(
                              points: details.localPosition,
                              brush: Paint()
                                ..strokeCap = StrokeCap.round
                                ..color = brushColor
                                ..isAntiAlias = true
                                ..strokeWidth = brushStrokeWidth,
                            ),
                          );
                        },
                      );
                    },
                    onPanUpdate: (details) {
                      setState(
                        () {
                          points.add(
                            DrawingBoard(
                              points: details.localPosition,
                              brush: Paint()
                                ..strokeCap = StrokeCap.round
                                ..color = brushColor
                                ..isAntiAlias = true
                                ..strokeWidth = brushStrokeWidth,
                            ),
                          );
                        },
                      );
                    },
                    onPanEnd: (details) {
                      setState(
                        () {
                          points.add(
                            DrawingBoard(
                              brush: Paint()
                                ..strokeCap = StrokeCap.round
                                ..strokeWidth = brushStrokeWidth
                                ..color = brushColor
                                ..isAntiAlias = true,
                              points: Offset.infinite,
                            ),
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomPaint(
                        painter: ScreenPainter(
                          points: points,
                          brushColor: brushColor,
                          brushStrokeWidth: brushStrokeWidth,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xFFece4e4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFc9c2c2),
                        blurRadius: 15.0,
                        spreadRadius: 0.15,
                        offset: Offset(15, 15),
                      ),
                      BoxShadow(
                        color: Color(0xFFfff7f7),
                        blurRadius: 15.0,
                        spreadRadius: 0.15,
                        offset: Offset(-15, -15),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            changeBrushColor();
                          });
                        },
                        child: Icon(
                          Icons.circle,
                          color: brushColor,
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(
                              () {
                                changeBrushSize();
                              },
                            );
                          },
                          child: Container(
                            height: brushStrokeWidth,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            points.clear();
                          });
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  List<DrawingBoard> points;
  Color brushColor;
  double brushStrokeWidth;

  ScreenPainter(
      {required this.points,
      required this.brushColor,
      required this.brushStrokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = const Color(0xFFece4e4);
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);

    for (int x = 0; x < points.length - 1; x++) {
      if (points[x] != null && points[x + 1] != null) {
        Paint brush = points[x].brush;
        canvas.drawLine(points[x].points, points[x + 1].points, brush);
      } else if (points[x] != null && points[x + 1] == null) {
        Paint brush = points[x].brush;
        canvas.drawPoints(PointMode.points, [points[x].points], brush);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
