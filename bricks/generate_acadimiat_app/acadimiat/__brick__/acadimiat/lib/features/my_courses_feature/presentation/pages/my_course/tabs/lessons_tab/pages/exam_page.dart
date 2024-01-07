import 'package:flutter/material.dart';
import '../../../../../../../../core/functions.dart';
import '../../../../../../data/models/my_lecture_model.dart';


class ExamPage extends StatefulWidget {
  const ExamPage({Key? key,required this.quizz}) : super(key: key);

  final Quizz quizz;

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Text(widget.quizz.name),

          Container(
            height: 400,
            child: ListView.builder(
                itemCount: widget.quizz.questions.length,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 20,
                  height: 40,
                  color: Colors.red,
                  child: Text(parseHtmlString(widget.quizz.questions[index].question)),

                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
