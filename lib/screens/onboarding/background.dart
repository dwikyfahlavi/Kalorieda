import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Background extends StatefulWidget {
  final Widget childWidget;

  const Background({Key? key, required this.childWidget}) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  late VideoPlayerController _playerController;
  late VoidCallback playerListener;

  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.asset('assets/videos/food.mp4')
      ..initialize().then((value) => playerListener);
    playerListener = () {
      setState(() {});
    };
    _playerController.setVolume(0.5);
    _playerController.setLooping(true);
    _playerController.play();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_createVideo();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _playerController.removeListener(playerListener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Transform.scale(
              scale: 3.3, //scale as your video size
              child: AspectRatio(
                aspectRatio: _playerController.value.aspectRatio,
                child: SizedBox(
                  width: _playerController.value.size.width,
                  height: _playerController.value.size.height,
                  child: (_playerController != null)
                      ? VideoPlayer(
                          _playerController,
                        )
                      : Container(),
                ),
              ),
            ),
            widget.childWidget,
          ],
        ),
      ),
    );
  }
}
