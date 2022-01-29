import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Offset> points = [];
  late Color brushColor = Colors.black;
  late double brushStrokeWidth = 2.0;

  @override
  void initState() {
    brushColor = Colors.black;
    brushStrokeWidth = 2.0;
    super.initState();
  }

  void changeBrushColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select any color'),
          content: SingleChildScrollView(
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
                  Color(0xFF2AFC89),
                  Color(0xFF82E0A0),
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
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onPanDown: (details) {
                      setState(() {
                        points.add(details.localPosition);
                      });
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        points.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        points.add(Offset.infinite);
                      });
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
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            changeBrushColor();
                          });
                        },
                        icon: const Icon(Icons.color_lens),
                        color: brushColor,
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: const SliderThemeData(
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                          ),
                          child: Slider(
                            value: brushStrokeWidth,
                            min: 1.0,
                            max: 10.0,
                            divisions: 10,
                            activeColor: brushColor,
                            inactiveColor: brushColor.withOpacity(0.3),
                            label: brushStrokeWidth.round().toString(),
                            onChanged: (value) {
                              setState(
                                () {
                                  brushStrokeWidth = value;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            points.clear();
                          });
                        },
                        icon: const Icon(Icons.layers_clear),
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
  List<Offset> points;
  Color brushColor;
  double brushStrokeWidth;

  ScreenPainter(
      {required this.points,
      required this.brushColor,
      required this.brushStrokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);

    Paint brush = Paint()
      ..color = brushColor
      ..strokeWidth = brushStrokeWidth
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;

    for (int x = 0; x < points.length - 1; x++) {
      if (points[x] != null && points[x + 1] != null) {
        canvas.drawLine(points[x], points[x + 1], brush);
      } else if (points[x] != null && points[x + 1] == null) {
        canvas.drawPoints(PointMode.points, [points[x]], brush);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
