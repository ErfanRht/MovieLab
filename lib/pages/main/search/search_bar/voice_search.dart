import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/api/api_requester.dart';
import 'package:movielab/pages/main/search/search.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class VoiceSearchAlertDialog extends StatefulWidget {
  const VoiceSearchAlertDialog({Key? key}) : super(key: key);

  @override
  State<VoiceSearchAlertDialog> createState() => _VoiceSearchAlertDialogState();
}

class _VoiceSearchAlertDialogState extends State<VoiceSearchAlertDialog> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final apiRequester = APIRequester();

  bool _isListening = false;
  double _confidence = 1.0;
  TextEditingController controller = Get.find<SearchBarController>().controller;
  String _text = "Tap to talk!";

  @override
  Widget build(BuildContext context) {
    double halfScreen =
        ((MediaQuery.of(context).size.width.round().toDouble()) / 2) - 150;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: halfScreen),
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Container(
          height: 200.0,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: kBackgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: _listen,
                  child: AvatarGlow(
                    animate: _isListening,
                    glowColor: kLightBlueColor,
                    endRadius: 50.0,
                    duration: const Duration(milliseconds: 2000),
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    repeat: true,
                    child: CircleAvatar(
                      backgroundColor:
                          !_isListening ? Colors.white : kBlueColor,
                      radius: 35,
                      child: Icon(
                        FontAwesomeIcons.microphoneLines,
                        color: _isListening ? Colors.white : kBlueColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                _text,
                style: TextStyle(
                    color: _isListening
                        ? kLightBlueColor.withOpacity(0.75)
                        : Colors.white,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if (kDebugMode) {
            print('onStatus: $val');
          }
        },
        onError: (val) {
          if (kDebugMode) {
            print('onError: $val');
          }
        },
      );
      if (available) {
        setState(() => _isListening = true);
        setState(() => _text = "Listening...");
        if (kDebugMode) {
          print('>>> Listening started...');
        }

        _speech.listen(
          onResult: (val) => setState(() async {
            _text = val.recognizedWords;
            _confidence = val.confidence;

            if (val.hasConfidenceRating && val.confidence > 0) {
              SearchBarController state = Get.find<SearchBarController>();
              if (kDebugMode) {
                print('Word: $_text, Confidence: $_confidence');
              }
              state.controller.text = _text;
              state.fieldText = _text;
              await Future.delayed(const Duration(seconds: 1));
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              doSearch();
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      setState(() => _text = "Tap to talk!");
      _speech.stop();
      if (kDebugMode) {
        print('>>> Listening stopped.');
      }
    }
  }
}
