import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/nav_drawer_view.dart';
import 'package:mute_motion_passenger/features/translator/presentation/views/translator_view.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TextToSignBody extends StatefulWidget {
  const TextToSignBody({super.key});

  @override
  State<TextToSignBody> createState() => _TextToSignBodyState();
}

class _TextToSignBodyState extends State<TextToSignBody> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String? record;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }
   void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }
   /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult,
    localeId: 'ar_EG',
    );
    setState(() {});
  }
  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      record =_lastWords;
      //print(record);
    });
  }
  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    return Scaffold(
      drawer: NavDrawerView(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Text To Sign',
          style: GoogleFonts.comfortaa(fontSize: 20, color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        backgroundColor: Colors.white,
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      body: Form(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 20,
            left: 15,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
             
                Text(  _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',),
                          const SizedBox(height: 10,),
                          Text(_lastWords,
                          style: GoogleFonts.comfortaa(fontSize: 20, color: kPrimaryColor),
                          ),
                          const SizedBox(height: 10,),
                Container(
                   padding: EdgeInsets.all( 10),
                 /* margin: EdgeInsets.only(right: 22, left: 10),
                  padding: EdgeInsets.all(8),
                  height: 200,
                  width: double.infinity,
                   decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kPrimaryColor),
                  ), */
                  child: defaultFormFeild(
                    
                    controller: messageController,
                    type: TextInputType.multiline,
                    min: 8,
                    max: 12,
                    label: 'Message',

                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                     
                    },

                    child: Text(
                      "Send",
                      style: GoogleFonts.comfortaa(
                          fontSize: 20, color: kPrimaryColor),
                    )),
                 const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 23, left: 13),
                  child: Center(child: Image.asset('assets/images/upDown.png')),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(right: 22, left: 10),
                  padding: EdgeInsets.all(8),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kPrimaryColor),
                  ),
                  child: Icon(
                   Icons.image,
                    size: 68,
                    color: Colors.grey, 
                   
                    
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.only(right: 22, left: 10),
                  //padding: EdgeInsets.all(8),
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                      color: const Color(0xff003248),
                      borderRadius: BorderRadius.circular(15)),
                  child: MaterialButton(
                      onPressed: () {
                        navigateTo(
                          context,
                          TranslatorView(),
                        );
                      },
                      child: Text(
                        "Done",
                        style: GoogleFonts.comfortaa(
                            fontSize: 20, color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
