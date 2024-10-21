// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _imageAnimation;
//   late Animation<double> _textBounceAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );

//     _imageAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
//         .animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOut,
//     ));

//     _textBounceAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.bounceInOut,
//       ),
//     );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 56, 64, 19),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SlideTransition(
//               position: _imageAnimation,
//               child: Image.asset(
//                 'assets/images/logo.png',
//                 width: 150,
//                 height: 150,
//               ),
//             ),
//             ScaleTransition(
//               scale: _textBounceAnimation,
//               child: const Text(
//                 'genie',
//                 style: TextStyle(
//                   fontFamily: "sans",
//                   fontSize: 40,
//                   color: Color.fromARGB(255, 184, 255, 43),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _imageAnimation;
  late Animation<double> _textBounceAnimation;
  bool _showSecondImage = false;
  bool _showThirdImage = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _imageAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));

    _textBounceAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );

    _controller.forward();

    // Change to second image after first animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _showSecondImage = true;
          });
          // Change to third image after a delay of 1 second after showing second image
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              _showThirdImage = true;
            });
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 64, 19),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _imageAnimation,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500), // Smooth image change
                child: _showThirdImage
                    ? Image.asset(
                        'assets/images/logo-3.png', // Third image
                        key: ValueKey<int>(2),
                        width: 140,
                        height: 140,
                      )
                    : _showSecondImage
                        ? Image.asset(
                            'assets/images/logo-2.png', // Second image
                            key: ValueKey<int>(1),
                            width: 140,
                            height: 140,
                          )
                        : Image.asset(
                            'assets/images/logo.png', // First image
                            key: ValueKey<int>(0),
                            width: 150,
                            height: 150,
                          ),
              ),
            ),
            ScaleTransition(
              scale: _textBounceAnimation,
              child: const Text(
                'genie',
                style: TextStyle(
                  fontFamily: "sans",
                  fontSize: 55,
                  color: Color.fromARGB(255, 184, 255, 43),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
