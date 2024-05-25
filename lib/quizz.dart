import 'package:flutter/material.dart';
import 'package:quizz_app/colors.dart';
import 'package:quizz_app/global_data.dart';
import 'package:quizz_app/result.dart';

class Quizz extends StatefulWidget {
  const Quizz({super.key});

  @override
  State<Quizz> createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  int next = 0;
  int resetValue = 0;
  List<String> correctOptions = ['A', 'B', 'C', 'D'];
  int tappedIndex = -1;
  int correctAnswers = 0;
  bool optionSelected = false;
  final text = const TextStyle(
      color: purpleColor, fontSize: 27, fontWeight: FontWeight.bold);
  final alpha = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Questions ${next + 1}/10',
              style: text,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: Column(
            children: [
              Text(
                quizQuestions[next]['question'].toString(),
                style: alpha,
                selectionColor: Colors.black,
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: correctOptions.length,
                    itemBuilder: (context, index) {
                      final question = quizQuestions[next];
                      final correct = question['correctAnswer'];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {});
                            if (!optionSelected) {
                              //if option selected is true
                              tappedIndex = index;
                              optionSelected =
                                  true; //disable the user from selecting another option
                            if (question['options'][index] == correct) {
                                correctAnswers++;
                              }
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                                color: tappedIndex == index
                                    ? (question['options'][index] == correct
                                        ? Colors.green
                                        : question['options'][index] != correct
                                            ? Colors.red
                                            : Colors.transparent)
                                    : lightgreyColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: Container(
                                width: 40.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black)),
                                child: CircleAvatar(
                                  backgroundColor: lightgreyColor,
                                  radius: 20,
                                  child: Text(correctOptions[index]),
                                ),
                              ),
                              title: Text(
                                question['options'][index].toString(),
                                style: alpha,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          )),
          GestureDetector(
            onTap: () {
              setState(() {
                if (next >= quizQuestions.length - 1) {
                  print('Last Qustions $next');

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    next = resetValue;
                    return ResultPage(reset: next, answer: correctAnswers);
                  })).then((_) {
                    // Reset the state when coming back from the ResultPage
                    setState(() {
                      next = 0;
                      correctAnswers = 0;
                      optionSelected = false;
                      tappedIndex = -1;
                    });
                  });
                } else {
                  next++;
                  optionSelected = false;
                }
                tappedIndex = -1; //reset
              });
            },
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: purpleColor, borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Text(
                  next == quizQuestions.length - 1 ? 'Show Result' : 'Next',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
