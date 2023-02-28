import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../style/colors.dart' as color;
import 'package:flutter/material.dart';

enum BrickShapeEnum { square, lShape, rLShape, miniLShape, zigzag, rZigZag, tShape, line }

class BrickShapeStatic {
  static List<List<List<double>>> rotateLShape = [
    [
      [0, 0, 1],
      [1, 1, 1],
      [0, 0, 0]
    ],
    [
      [0, 1, 0],
      [0, 1, 0],
      [0, 1, 1]
    ],
    [
      [0, 0, 0],
      [1, 1, 1],
      [1, 0, 0]
    ],
    [
      [1, 1, 0],
      [0, 1, 0],
      [0, 1, 0]
    ],
  ];
  static List<List<List<double>>> rotateRLShape = [
    [
      [1, 0, 0],
      [1, 1, 1],
      [0, 0, 0]
    ],
    [
      [0, 1, 1],
      [0, 1, 0],
      [0, 1, 0]
    ],
    [
      [0, 0, 0],
      [1, 1, 1],
      [0, 0, 1]
    ],
    [
      [0, 1, 0],
      [0, 1, 0],
      [1, 1, 0]
    ]
  ];
  static List<List<List<double>>> rotateMiniLShape = [
    [
      [1, 0],
      [1, 1]
    ],
    [
      [1, 1],
      [1, 0]
    ],
    [
      [1, 1],
      [0, 1]
    ],
    [
      [0, 1],
      [1, 1]
    ]
  ];
  static List<List<List<double>>> rotateZigZag = [
    [
      [0, 0, 0],
      [1, 1, 0],
      [0, 1, 1]
    ],
    [
      [0, 1, 0],
      [1, 1, 0],
      [1, 0, 0]
    ],
    [
      [1, 1, 0],
      [0, 1, 1],
      [0, 0, 0]
    ],
    [
      [0, 0, 1],
      [0, 1, 1],
      [0, 1, 0]
    ]
  ];
  static List<List<List<double>>> rotateRZigZag = [
    [
      [0, 0, 0],
      [0, 1, 1],
      [1, 1, 0]
    ],
    [
      [1, 0, 0],
      [1, 1, 0],
      [0, 1, 0]
    ],
    [
      [0, 1, 1],
      [1, 1, 0],
      [0, 0, 0]
    ],
    [
      [0, 1, 0],
      [0, 1, 1],
      [0, 0, 1]
    ]
  ];
  static List<List<List<double>>> rotateTShape = [
    [
      [0, 1, 0],
      [1, 1, 1],
      [0, 0, 0]
    ],
    [
      [0, 1, 0],
      [0, 1, 1],
      [0, 1, 0]
    ],
    [
      [0, 0, 0],
      [1, 1, 1],
      [0, 1, 0]
    ],
    [
      [0, 1, 0],
      [1, 1, 0],
      [0, 1, 0]
    ]
  ];
  static List<List<List<double>>> rotateLine = [
    [
      [0, 0, 0, 0],
      [1, 1, 1, 1],
      [0, 0, 0, 0],
      [0, 0, 0, 0]
    ],
    [
      [0, 1, 0, 0],
      [0, 1, 0, 0],
      [0, 1, 0, 0],
      [0, 1, 0, 0]
    ],
    [
      [0, 0, 0, 0],
      [1, 1, 1, 1],
      [0, 0, 0, 0],
      [0, 0, 0, 0]
    ],
    [
      [0, 1, 0, 0],
      [0, 1, 0, 0],
      [0, 1, 0, 0],
      [0, 1, 0, 0]
    ]
  ];

  static List<List<double>> getListBrickOnEnum(BrickShapeEnum shapeEnum,
      {int direction = 0}) {
    List<List<double>> shapeList;

    if (shapeEnum == BrickShapeEnum.square) {
      shapeList = [
        [1, 1],
        [1, 1]
      ];
    } else if (shapeEnum == BrickShapeEnum.lShape) {
      shapeList = rotateLShape[direction % 4];
    } else if (shapeEnum == BrickShapeEnum.rLShape) {
      shapeList = rotateRLShape[direction % 4];
    } else if (shapeEnum == BrickShapeEnum.miniLShape) {
      shapeList = rotateMiniLShape[direction % 4];
    } else if (shapeEnum == BrickShapeEnum.zigzag) {
      shapeList = rotateZigZag[direction % 4];
    } else if (shapeEnum == BrickShapeEnum.rZigZag) {
      shapeList = rotateRZigZag[direction % 4];
    } else if (shapeEnum == BrickShapeEnum.tShape) {
      shapeList = rotateTShape[direction % 4];
    } else if (shapeEnum == BrickShapeEnum.line) {
      shapeList = rotateLine[direction % 4];
    } else {
      shapeList = [];
    }
    return shapeList;
  }
}

class BrickObject {
  bool enable;

  BrickObject({this.enable = false});
}

class BrickObjectPosDone {
  Color? color;
  int index;

  BrickObjectPosDone(this.index, {this.color});
}

class BrickObjectPos {
  Offset offset;
  BrickShapeEnum shapeEnum;
  int rotation;
  bool isDone;
  Size? sizeLayout;
  Size? size;
  List<int> pointArray = [];
  Color color;

  static clone(BrickObjectPos object) {
    return BrickObjectPos(
        offset: object.offset,
        shapeEnum: object.shapeEnum,
        rotation: object.rotation,
        isDone: object.isDone,
        sizeLayout: object.sizeLayout,
        size: object.size,
        color: object.color);
  }

  BrickObjectPos(
      {this.size,
        this.sizeLayout,
        this.isDone = false,
        this.offset = Offset.zero,
        this.shapeEnum = BrickShapeEnum.line,
        this.rotation = 0,
        this.color = Colors.amber}) {
    calculateHit();
  }

  setShape(BrickShapeEnum shapeEnum) {
    this.shapeEnum = shapeEnum;
    calculateHit();
  }

  calculateRotation(int flag) {
    rotation += flag;
    calculateHit();
  }

  calculateHit({Offset? predict}) {
    List<int> lists =
    BrickShapeStatic.getListBrickOnEnum(shapeEnum, direction: rotation)
        .expand((element) => element)
        .map((e) => e.toInt())
        .toList();

    List<int> tempPoint = lists
        .asMap()
        .entries
        .map((e) => calculateOffset(e, lists.length, predict ?? offset))
        .toList();

    if (predict != null) {
      return tempPoint;
    } else {
      pointArray = tempPoint;
    }
  }

  int calculateOffset(MapEntry<int, int> entry, int length, Offset offsetTemp) {
    int value = entry.value;

    if (size != null) {
      if (value == 0) {
        value = -99999;
      } else {
        double left = offsetTemp.dx / size!.width + entry.key % sqrt(length);
        double top = offsetTemp.dy / size!.height + entry.key ~/ sqrt(length);

        int index =
            left.toInt() + (top * (sizeLayout!.width / size!.width)).toInt();

        value = (index).toInt();
      }
    }

    return value;
  }
}

class Scoring {
  int level;
  int score;
  int lineDestroy = 1;

  Scoring({
    this.level = 1,
    this.score = 0,
    this.lineDestroy = 1
  });

  void calcScore({int line = 1}) {
    int sum;
    setlineDestroy(line);

    if(line == 1) {
      sum = 40 * (level);
    } else if (line == 2) {
      sum = 100 * (level);
    } else if (line == 3) {
      sum = 300 * (level);
    } else {
      sum = 1200 * (level);
    }

    score += sum;
  }

  void setlineDestroy(int line) {
    lineDestroy += line;

    level = (lineDestroy ~/ 2) + 1;
  }

  void resetScore() {
    level = 1;
    lineDestroy = 0;
    score = 0;
  }
}

class TetrisGamePage extends StatefulWidget {
  const TetrisGamePage({Key? key}) : super(key: key);

  @override
  State<TetrisGamePage> createState() => _TetrisGamePageState();
}

class _TetrisGamePageState extends State<TetrisGamePage> {

  GlobalKey<_TetrisWidgetState> keyGlobal = GlobalKey();
  ValueNotifier<List<BrickObjectPos>> brickObjectPosValue =
      ValueNotifier<List<BrickObjectPos>>(List<BrickObjectPos>.from([]));
  ValueNotifier<Scoring> scoring = ValueNotifier<Scoring>(Scoring());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double sizePerSquare = 25;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              color.AppColorMode.firstColor,
              color.AppColorMode.secondColor
            ])),
        alignment: Alignment.center,
        child: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ValueListenableBuilder(
                              valueListenable: scoring,
                              builder: (context, Scoring value, child) {
                                return Column(
                                  children: [
                                    Text('Scores: ${value.score}', style: const TextStyle(color: Colors.white)),
                                    Text('Level: ${value.level}', style: const TextStyle(color: Colors.white)),
                                    Text('Line Destroy: ${value.lineDestroy}', style: const TextStyle(color: Colors.white)),
                                  ],
                                );
                              }
                              ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    keyGlobal.currentState!.resetGame();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.blue)),
                                  child: const Text('Start',
                                      style: TextStyle(color: Colors.white))),
                              ElevatedButton(
                                  onPressed: () {
                                    keyGlobal.currentState!.pauseGame();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.blue)),
                                  child: const Text('Pause',
                                      style: TextStyle(color: Colors.white)))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: constraints.biggest.width / 2,
                      child: Column(
                        children: [
                          const Text('Next: ',
                              style: TextStyle(color: Colors.white)),
                          ValueListenableBuilder(
                              valueListenable: brickObjectPosValue,
                              builder:
                                  (context, List<BrickObjectPos> value, child) {
                                BrickShapeEnum tempShapeEnum = value.isNotEmpty
                                    ? value.last.shapeEnum
                                    : BrickShapeEnum.line;
                                int rotation =
                                    value.isNotEmpty ? value.last.rotation : 0;
                                return BrickShape(
                                    BrickShapeStatic.getListBrickOnEnum(
                                        tempShapeEnum,
                                        direction: rotation));
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                alignment: Alignment.center,
                width: 300,
                height: 400,
                child: LayoutBuilder(builder: (context, constraints) {
                  return TetrisWidget(
                      constraints.biggest,
                      key: keyGlobal,
                      sizePerSquare: sizePerSquare,
                      setCallbackScore: (Scoring score) {
                        scoring.value = score;
                        scoring.notifyListeners();
                      },
                      setNextBrick: (List<BrickObjectPos> brickObjectPos) {
                        brickObjectPosValue.value = brickObjectPos;
                        brickObjectPosValue.notifyListeners();
                      });
                }),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => keyGlobal.currentState!.transformBrick(move: const Offset(-sizePerSquare, 0)),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(13))
                                ),
                                child: const Icon(FontAwesomeIcons.arrowLeft)
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => keyGlobal.currentState!.transformBrick(move: const Offset(0, sizePerSquare)),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(13))
                                ),
                                child: const Icon(FontAwesomeIcons.arrowDown)
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => keyGlobal.currentState!.transformBrick(move: const Offset(sizePerSquare, 0)),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(13))
                                ),
                                child: const Icon(FontAwesomeIcons.arrowRight)
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () => keyGlobal.currentState!.transformBrick(rotate: true),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(13))
                                ),
                                child: const Icon(FontAwesomeIcons.rotate),
                              ),
                            ),
                            Container()
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        })),
      ),
    );
  }
}

class TetrisWidget extends StatefulWidget {
  final Size size;
  final double? sizePerSquare;
  Function(List<BrickObjectPos> brickObjectPos)? setNextBrick;
  Function(Scoring score)? setCallbackScore;

  TetrisWidget(this.size, {Key? key, this.setNextBrick, this.sizePerSquare, this.setCallbackScore})
      : super(key: key);

  @override
  State<TetrisWidget> createState() => _TetrisWidgetState();
}

class _TetrisWidgetState extends State<TetrisWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late Size sizeBox;
  late List<int> levelBases;
  int blockCounter = 0;

  ValueNotifier<List<BrickObjectPos>> brickObjectPosValue =
      ValueNotifier<List<BrickObjectPos>>([]);
  ValueNotifier<List<BrickObjectPosDone>> donePointsValue =
      ValueNotifier<List<BrickObjectPosDone>>([]);
  ValueNotifier<int> animationPosTickValue = ValueNotifier<int>(0);

  ValueNotifier<Scoring> scoring = ValueNotifier<Scoring>(Scoring());

  pauseGame() async {
    animationController.stop();
    await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                const Text('Pause Game'),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      animationController.forward();
                    },
                    child: const Text('Resume'))
              ],
            ));
  }

  resetGame() async {
    animationController.stop();
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SimpleDialog(
              children: [
                const Text('Reset Game'),
                ElevatedButton(
                    onPressed: () {
                      donePointsValue.value = [];
                      donePointsValue.notifyListeners();

                      brickObjectPosValue.value = [];
                      brickObjectPosValue.notifyListeners();

                      scoring.value.resetScore();
                      widget.setCallbackScore?.call(scoring.value);
                      scoring.notifyListeners();


                      Navigator.of(context).pop();

                      calculateSizeBox();
                      randomBrick(start: true);
                      animationController.reset();
                      animationController.stop();
                      animationController.forward();
                    },
                    child: const Text('Start / Reset'))
              ],
            ));
  }

  animationLoop() async {
    if (animation.isCompleted && brickObjectPosValue.value.length > 1) {
      BrickObjectPos currentObj =
          brickObjectPosValue.value[brickObjectPosValue.value.length - 2];

      Offset target = currentObj.offset.translate(0, widget.sizePerSquare!);

      if (checkTargetMove(target, currentObj)) {
        currentObj.offset = target;
        currentObj.calculateHit();
        brickObjectPosValue.notifyListeners();
      } else {
        currentObj.pointArray
            .where((element) => element != -99999)
            .toList()
            .forEach((element) {
          donePointsValue.value
              .add(BrickObjectPosDone(element, color: currentObj.color));
        });
        donePointsValue.notifyListeners();

        brickObjectPosValue.value
            .removeAt(brickObjectPosValue.value.length - 2);

        await checkCompleteLine();

        bool status = await checkGameOver();

        if (!status) {
          randomBrick();
        } else {
          print('Game Over');
        }
      }

      animationController.reset();
      animationController.forward();
    }
  }

  Future<bool> checkGameOver() async {
    return donePointsValue.value
        .where((element) => element.index < 0 && element.index != -99999)
        .isNotEmpty;
  }

  checkCompleteLine() async {
    List<int> leftIndex =
        List.generate(sizeBox.height ~/ widget.sizePerSquare!, (index) {
      return index * ((sizeBox.width ~/ widget.sizePerSquare!));
    });

    int totalCol = (sizeBox.width ~/ widget.sizePerSquare!) - 2;

    List<int> linetoDestroys = leftIndex
        .where((element) {
          return donePointsValue.value
              .where((point) => point.index == element + 1)
              .isNotEmpty;
        })
        .where((donePoint) {
          List<int> rows =
              List.generate(totalCol, (index) => donePoint + 1 + index)
                  .toList();

          return rows.where((row) {
                return donePointsValue.value
                    .where((element) => element.index == row)
                    .isNotEmpty;
              }).length ==
              rows.length;
        }).toList();

    int lineDestroy = linetoDestroys.length;

    linetoDestroys = linetoDestroys.map((e) {
      return List.generate(totalCol, (index) => e + 1 + index).toList();
    }).expand((element) => element).toList();

    List<BrickObjectPosDone> tempDonePoints = donePointsValue.value;

    if (linetoDestroys.isNotEmpty) {

      scoring.value.calcScore(line: lineDestroy);
      scoring.notifyListeners();
      widget.setCallbackScore?.call(scoring.value);

      linetoDestroys.sort((a, b) => a.compareTo(b));
      tempDonePoints.sort((a, b) => a.index.compareTo(b.index));

      int firstIndex = tempDonePoints
          .indexWhere((element) => element.index == linetoDestroys.first);

      if (firstIndex >= 0) {
        tempDonePoints.removeWhere((element) {
          return linetoDestroys
              .where((line) => line == element.index)
              .isNotEmpty;
        });

        donePointsValue.value = tempDonePoints.map((element) {
          if (element.index < linetoDestroys.first) {
            int totalRowDelete = linetoDestroys.length ~/ totalCol;
            element.index = element.index + ((totalCol + 2) * totalRowDelete);
          }

          return element;
        }).toList();

        donePointsValue.notifyListeners();
      }
    }
  }

  bool checkTargetMove(Offset targetPos, BrickObjectPos object) {
    List<int> pointsPredict = object.calculateHit(predict: targetPos);
    List<int> hitsIndex = [];

    hitsIndex.addAll(levelBases);
    hitsIndex.addAll(donePointsValue.value.map((e) => e.index));

    int numberHitBase = pointsPredict
        .map((e) => hitsIndex.indexWhere((element) => element == e) > -1)
        .where((element) => element)
        .length;

    return numberHitBase == 0;
  }

  randomBrick({start = false}) {
    brickObjectPosValue.value.add(getNewBrickPos());

    if (start) {
      brickObjectPosValue.value.add(getNewBrickPos());
    }

    widget.setNextBrick!.call(brickObjectPosValue.value);
    brickObjectPosValue.notifyListeners();
  }

  BrickObjectPos getNewBrickPos() {
    setState(() {
      blockCounter++;
    });
    print(blockCounter);
    if(blockCounter >= 60) {
      animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
      print('Velocitá cambiata a 350ms');
    } else if(blockCounter >= 40) {
      animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
      print('Velocitá cambiata a 500ms');
    } else if(blockCounter >= 3) {
      animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 750));
      print('Velocitá cambiata a 750ms');
    }

    return BrickObjectPos(
        size: Size.square(widget.sizePerSquare!),
        sizeLayout: sizeBox,
        color: Colors
            .primaries[Random().nextInt(Colors.primaries.length)].shade800,
        rotation: Random().nextInt(4),
        offset: Offset(widget.sizePerSquare! * 4, -widget.sizePerSquare! * 4),
        shapeEnum: BrickShapeEnum
            .values[Random().nextInt(BrickShapeEnum.values.length)]);
  }

  calculateSizeBox() {
    sizeBox = Size(
        (widget.size.width ~/ widget.sizePerSquare!) * widget.sizePerSquare!,
        (widget.size.height ~/ widget.sizePerSquare!) * widget.sizePerSquare!);

    levelBases = List.generate(sizeBox.width ~/ widget.sizePerSquare!, (index) {
      return (((sizeBox.height ~/ widget.sizePerSquare!) - 1) *
              (sizeBox.width ~/ widget.sizePerSquare!)) +
          index;
    });

    levelBases
        .addAll(List.generate(sizeBox.height ~/ widget.sizePerSquare!, (index) {
      return index * (sizeBox.width ~/ widget.sizePerSquare!);
    }));

    levelBases
        .addAll(List.generate(sizeBox.height ~/ widget.sizePerSquare!, (index) {
      return (index * (sizeBox.width ~/ widget.sizePerSquare!)) +
          (sizeBox.width ~/ widget.sizePerSquare! - 1);
    }));
  }

  checkIndexHitBase(int index) {
    return levelBases.indexWhere((element) => element == index) != -1;
  }

  transformBrick({Offset? move, bool? rotate}) {
    if (move != null || rotate != null) {
      BrickObjectPos currentObj =
          brickObjectPosValue.value[brickObjectPosValue.value.length - 2];
      late Offset target;
      if (move != null) {
        target = currentObj.offset.translate(move.dx, move.dy);

        if (checkTargetMove(target, currentObj)) {
          currentObj.offset = target;
          currentObj.calculateHit();
          brickObjectPosValue.notifyListeners();
        }
      } else {
        currentObj.calculateRotation(1);

        if (checkTargetMove(currentObj.offset, currentObj)) {
          currentObj.calculateHit();
          brickObjectPosValue.notifyListeners();
        } else {
          currentObj.calculateRotation(-1);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    calculateSizeBox();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(animationLoop);
    animationController.forward();
  }

  @override
  void dispose() {
    animation.removeListener(animationLoop);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: sizeBox.width,
        height: sizeBox.height,
        color: Colors.white,
        alignment: Alignment.center,
        child: ValueListenableBuilder(
            valueListenable: donePointsValue,
            builder: (context, List<BrickObjectPosDone> donePoints, child) {
              return ValueListenableBuilder(
                  valueListenable: brickObjectPosValue,
                  builder:
                      (context, List<BrickObjectPos> brickObjectPoses, child) {
                    return Stack(
                      children: [
                        ...List.generate(
                            sizeBox.width ~/
                                widget.sizePerSquare! *
                                sizeBox.height ~/
                                widget.sizePerSquare!, (index) {
                          return Positioned(
                              left: index %
                                  (sizeBox.width / widget.sizePerSquare!) *
                                  widget.sizePerSquare!,
                              top: index ~/
                                  (sizeBox.width / widget.sizePerSquare!) *
                                  widget.sizePerSquare!,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: checkIndexHitBase(index)
                                        ? Colors.black87
                                        : Colors.transparent,
                                    border: Border.all(width: 0.1)),
                                width: widget.sizePerSquare!,
                                height: widget.sizePerSquare!,
                              ));
                        }).toList(),
                        if (brickObjectPoses.length > 1)
                          ...brickObjectPoses
                              .where((element) => !element.isDone)
                              .toList()
                              .asMap()
                              .entries
                              .map((e) => Positioned(
                                  left: e.value.offset.dx,
                                  top: e.value.offset.dy,
                                  child: BrickShape(
                                    BrickShapeStatic.getListBrickOnEnum(
                                        e.value.shapeEnum,
                                        direction: e.value.rotation),
                                    sizePerSquare: widget.sizePerSquare!,
                                    points: e.value.pointArray,
                                    color: e.value.color,
                                  )))
                              .toList(),
                        if (donePoints.isNotEmpty)
                          ...donePoints.map((e) => Positioned(
                              left: e.index %
                                  (sizeBox.width / widget.sizePerSquare!) *
                                  widget.sizePerSquare!,
                              top: (e.index ~/
                                      (sizeBox.width / widget.sizePerSquare!) *
                                      widget.sizePerSquare!)
                                  .toDouble(),
                              child: SizedBox(
                                  width: widget.sizePerSquare!,
                                  height: widget.sizePerSquare!,
                                  child: boxBrick(e.color!, text: e.index))))
                      ],
                    );
                  });
            }),
      ),
    );
  }
}

class BrickShape extends StatefulWidget {
  List<List<double>> list;
  List? points;
  double sizePerSquare;
  Color? color;

  BrickShape(this.list,
      {Key? key, this.color, this.points, this.sizePerSquare = 20})
      : super(key: key);

  @override
  State<BrickShape> createState() => _BrickShapeState();
}

class _BrickShapeState extends State<BrickShape> {
  @override
  Widget build(BuildContext context) {
    int totalPointList = widget.list.expand((element) => element).length;
    int columnNum = (totalPointList ~/ widget.list.length);

    return SizedBox(
      width: widget.sizePerSquare * columnNum,
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: totalPointList,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnNum, childAspectRatio: 1),
          itemBuilder: (context, index) {
            return Offstage(
              offstage:
                  widget.list.expand((element) => element).toList()[index] == 0,
              child: boxBrick(widget.color ?? Colors.red,
                  text: widget.points?[index] ?? ''),
            );
          }),
    );
  }
}

Widget boxBrick(Color color, {text = ''}) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(color: color, border: Border.all(width: 1)),
  );
}
