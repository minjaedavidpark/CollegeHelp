import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Tap Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _score = 0;
  double _targetX = 100;
  double _targetY = 100;
  final Random _random = Random();
  double _targetSize = 60;
  int _timeLeft = 30; // Game duration in seconds
  Timer? _timer;
  bool _gameActive = false;
  int _highScore = 0;
  String _difficultyLevel = 'Medium';

  // Animation controller for target
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _score = 0;
      _gameActive = true;
      _timeLeft = 30;
      _moveTarget();
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _endGame();
        }
      });
    });
  }

  void _endGame() {
    _timer?.cancel();
    setState(() {
      _gameActive = false;
      if (_score > _highScore) {
        _highScore = _score;
      }
    });

    // Show game over dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Game Over'),
            content: Text('Your score: $_score\nHigh score: $_highScore'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _moveTarget() {
    if (!_gameActive) return;

    setState(() {
      _score++;

      // Get the screen size
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight =
          MediaQuery.of(context).size.height * 0.6; // Game area height

      // Calculate new position ensuring target is fully visible
      _targetX = _random.nextDouble() * (screenWidth - _targetSize);
      _targetY = _random.nextDouble() * (screenHeight - _targetSize);

      // Play animation
      _animationController.reset();
      _animationController.forward();
    });
  }

  void _changeDifficulty(String level) {
    setState(() {
      _difficultyLevel = level;
      switch (level) {
        case 'Easy':
          _targetSize = 80;
          break;
        case 'Medium':
          _targetSize = 60;
          break;
        case 'Hard':
          _targetSize = 40;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score: $_score',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Time: $_timeLeft',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          if (!_gameActive)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Difficulty: '),
                  DropdownButton<String>(
                    value: _difficultyLevel,
                    items:
                        ['Easy', 'Medium', 'Hard'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        _changeDifficulty(newValue);
                      }
                    },
                  ),
                ],
              ),
            ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child:
                  _gameActive
                      ? Stack(
                        children: [
                          Positioned(
                            left: _targetX,
                            top: _targetY,
                            child: GestureDetector(
                              onTap: _moveTarget,
                              child: ScaleTransition(
                                scale: _animation,
                                child: Container(
                                  width: _targetSize,
                                  height: _targetSize,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'TAP',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_highScore > 0)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'High Score: $_highScore',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ElevatedButton(
                              onPressed: _startGame,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                'Start Game',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _gameActive
                  ? 'Tap the target quickly!'
                  : 'Tap Start to play the game',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
