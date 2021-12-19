import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:questions_app/util/Consts.dart';
import 'package:rive/rive.dart';

class TestScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TestScreenState();
  
}




class TestScreenState extends State<TestScreen> {





  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<bool>? _hoverInput;
  SMIInput<bool>? _pressInput;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load(Consts.BEAR_RIVE_ANIMATION).then(
          (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
        if (controller != null) {
          artboard.addController(controller);
          _hoverInput = controller.findInput('Correct');
          _pressInput = controller.findInput('Incorrect');
        }else{
          print("did not find this state machine");
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [

          background(),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: (){
                  print("aaa");

                    _pressInput?.value = true;

                },
                onDoubleTap: (){
                  _hoverInput?.value = true;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400,
                      height: 400,
                      child: _riveArtboard == null
                          ? const SizedBox()
                          : Rive(
                        artboard: _riveArtboard!,
                      ),
                    ),
                  ],
                ),
              ),
              Container(),Container(),

            ],
          ),
        ],
      ),
    );
  }

  Widget background() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Consts.HOME_SCREEN_BG_IMAGE),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}