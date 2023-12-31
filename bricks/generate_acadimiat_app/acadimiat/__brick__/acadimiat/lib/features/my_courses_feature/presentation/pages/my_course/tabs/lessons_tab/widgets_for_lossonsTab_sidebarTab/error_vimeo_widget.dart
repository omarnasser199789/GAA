import 'package:flutter/material.dart';
// import 'package:remedi_vimeo_player/remedi_vimeo_player.dart';
class ErrorVimeoWidget extends StatelessWidget {
  const ErrorVimeoWidget({Key? key, required this.snapshot}) : super(key: key);
  final AsyncSnapshot<dynamic> snapshot ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade700)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: Center(
            // child: Text(
            //   "${(snapshot.data as VimeoError).developerMessage}" +
            //       "\n${(snapshot.data as VimeoError).errorCode ?? ""}" +
            //       "\n\n${(snapshot.data as VimeoError).error}",
            //   textAlign: TextAlign.center,
            // ),
          ),
        ),
      ),
    );
  }
}
