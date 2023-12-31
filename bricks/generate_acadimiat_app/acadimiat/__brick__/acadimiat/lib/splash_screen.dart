import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/functions.dart';
import 'features/authentication_feature/presentation/pages/login_page.dart';
import 'launch_page.dart';
import 'nav_page.dart';
import 'package:video_player/video_player.dart';
import 'package:signalr_core/signalr_core.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Future<void> initConnection() async {
  if (connection.state == HubConnectionState.disconnected) {
    await connection.start();
  }
  if (kDebugMode) {

    print("ConnectionState: ${connection.connectionId}");
  }


  connection.onclose((error) {
    if (kDebugMode) {
      print("Connection Closed:$error");
    }
  });


}

class _SplashScreenState extends State<SplashScreen> {
  bool allowGo = true;
  bool isAuth = false;
  bool loading = true;
  bool videoInitialized = false;
  final VideoPlayerController _controller = VideoPlayerController.asset("assets/video.mp4",videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true,));

  @override
  void initState()  {
    super.initState();
    authorized();
    initConnection();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _initializeVideoController();

  }

  void _initializeVideoController() async {
    await _controller.initialize();
    setState(() {
      videoInitialized = true;
    });
    _controller.setVolume(0.0);
    _controller.addListener(videoListener);
    _controller.setLooping(false);
    _controller.play();
  }

  void videoListener(){
    if(_controller.value.position == _controller.value.duration && allowGo==true) {
      allowGo = false;
      navigatorToHomeOrLoginPage();
    }
  }

  navigatorToHomeOrLoginPage() async {
    // isAuth = await isAuthorized();
      Future.delayed(const Duration(milliseconds: 300), ()async {
        if(isLoggedIn()){
          if(isAuth){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const NavPage()));
          }else{
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const LoginPage()));
          }
        }else{
          Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const    LoginPage()));
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      // _controller = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:
         (!videoInitialized)?
      Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)):
      _getVideoBackground(size)
    );
  }

  _getVideoBackground(Size size) {
    return Stack(alignment: Alignment.center,
      children: [

        /// Background Video
        SizedBox(
            width: size.width,
            height: size.height,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(
                _controller,
              ),
            )
        ),

        ///Gray Layer
        Container(
          width: size.width,
          height: size.height,
          color: Colors.black.withOpacity(0.2),
        ),

        ///Floating video within a frame
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
              width: 320,
              height: 570,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              )
          ),
        ),
      ],
    );
  }

  Future<void> authorized() async {
    isAuth = await isAuthorized();
  }

}
