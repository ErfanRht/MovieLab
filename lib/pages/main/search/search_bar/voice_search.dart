import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/api_requester.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceSearchAlertDialog extends StatelessWidget {
  const VoiceSearchAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      TextEditingController controller =
          Get.find<SearchBarController>().controller;
      double halfScreen =
          ((MediaQuery.of(context).size.width.round().toDouble()) / 2) - 150;
      return GetBuilder<SearchBarController>(
        builder: (_) {
          SpeechToText speechToText = _.speechToText;
          _initSpeech() async {
            _.speechEnabled = await _.speechToText.initialize();
          }

          _initSpeech();
          Future<void> _onSpeechResult(SpeechRecognitionResult result) async {
            _.updateSpeechToText(recognized: result.recognizedWords);
            // _.controller.text = result.recognizedWords;
            //_.updateResult(result: []);
            //search(expression: result.recognizedWords);
            //await Future.delayed(const Duration(seconds: 1));
            //_.updateSpeechToText(listening: false);
            //Navigator.pop(context);
          }

          void _stopListening() async {
            await _.speechToText.stop();
            setState(() {});
          }

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
                    borderRadius: BorderRadius.circular(15),
                    color: kBackgroundColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: InkWell(
                        onTap: () async {
                          if (_.isListening) {
                            _stopListening();
                            _.updateSpeechToText(listening: false);
                          } else {
                            await _.speechToText
                                .listen(onResult: _onSpeechResult);
                            _.updateSpeechToText(listening: true);
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              !_.isListening ? Colors.white : kBlueColor,
                          radius: 35,
                          child: Icon(
                            FontAwesomeIcons.microphoneAlt,
                            color: _.isListening ? Colors.white : kBlueColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    _.recognizedText != ""
                        ? Text(
                            _.recognizedText,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        : !_.isListening
                            ? const Text(
                                "Tap to talk!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )
                            : Text(
                                "Talk now!",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
