import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quizz_app/colors.dart';
import 'package:quizz_app/global_data.dart';

class ResultPage extends StatefulWidget {
  final int reset;
  final int answer;
  const ResultPage({super.key, required this.reset, required this.answer});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    double percentage = (widget.answer / quizQuestions.length).clamp(0.0, 1.0);
    double multiple = percentage * 100.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz Score'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            'Your Score',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 40,
          ),
          Center(
              child: CircularPercentIndicator(
            radius: 120,
            backgroundColor: lightgreyColor,
            progressColor: purpleColor,
            lineWidth: 8,
            animation: true,
            animationDuration: 1200,
            percent: percentage,
            center: Text(
              '${multiple.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          )),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: purpleColor, borderRadius: BorderRadius.circular(50)),
              child: const Center(
                child: Text(
                  'Restart',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
