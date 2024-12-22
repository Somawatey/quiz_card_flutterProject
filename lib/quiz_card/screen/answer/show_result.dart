import 'package:flutter/material.dart';

class ShowResultScreen extends StatefulWidget {
  final List<Map<String, dynamic>> correctAnswers;
  final List<Map<String, dynamic>> incorrectAnswers;

  const ShowResultScreen({
    super.key,
    required this.correctAnswers,
    required this.incorrectAnswers,
  });

  @override
  State<ShowResultScreen> createState() => ShowResultScreenState();
}

class ShowResultScreenState extends State<ShowResultScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildQuestionList(List<Map<String, dynamic>> questions) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final questionData = questions[index];
        final question = questionData['question'];
        final userAnswer = questionData['userAnswer'];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text("Your answer: $userAnswer"),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Correct"),
            Tab(text: "Wrong"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildQuestionList(widget.correctAnswers),
          _buildQuestionList(widget.incorrectAnswers),
        ],
      ),
    );
  }
}