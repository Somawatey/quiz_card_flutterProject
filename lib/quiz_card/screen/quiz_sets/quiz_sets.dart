import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';
import 'package:quiz_card_project/quiz_card/screen/questions/question_list.dart';
import 'package:quiz_card_project/quiz_card/screen/quiz_sets/quiz_form.dart';
import 'package:quiz_card_project/quiz_card/screen/quiz_sets/quiz_list.dart';
import 'package:quiz_card_project/quiz_card/data/quizSet_data.dart';
import 'package:quiz_card_project/quiz_card/screen/quiz_sets/quiz_test.dart';

class QuizSets extends StatefulWidget {
  const QuizSets({super.key});

  @override
  State<QuizSets> createState() => _QuizSetsState();
}

class _QuizSetsState extends State<QuizSets> {

  void _removeQuiz(QuizSet quizSet) {
    setState(() {
      quizzes_data.remove(quizSet);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Quiz removed.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              quizzes_data.add(quizSet);
            });
          },
        ),
      ),
    );
  }

  void _showQuizOptions(BuildContext context, QuizSet quizSet) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: Text('Options for ${quizSet.title}'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(ctx).pop();
              _showEditQuizForm(quizSet);
            },
            child: const Text('Update Quiz Set'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(ctx).pop();
              _startQuizTest(context, quizSet);
            },
            child: const Text('Start Quiz Test'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(ctx).pop();
              // Implement logic for Flash Card here
            },
            child: const Text('Flash Card'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(ctx).pop();
              _viewQuestions(context, quizSet);
            },
            child: const Text('View Details'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(ctx).pop();
            _removeQuiz(quizSet);
          },
          child: const Text('Delete'),
        ),
      ),
    );
  }

 


  void _showAddQuizForm() async {
    QuizSet? newQuizSet = await Navigator.of(context).push<QuizSet>(
      MaterialPageRoute(
        builder: (ctx) => QuizForm(
          onCreated: (quizSet) {
            Navigator.of(ctx).pop(quizSet);
          },
          mode: EditionMode.creating,
        ),
      ),
    );

    if (newQuizSet != null) {
      setState(() {
        quizzes_data.add(newQuizSet);
      });
    }
  }
  
  void _showEditQuizForm(QuizSet quizSet) async {
    QuizSet? editedQuizSet = await Navigator.of(context).push<QuizSet>(
      MaterialPageRoute(
        builder: (ctx) => QuizForm(
          onCreated: (updatedQuizSet) {
            Navigator.of(ctx).pop(updatedQuizSet);
          },
          quizSet: quizSet,
          mode: EditionMode.editing,
        ),
      ),
    );

    if (editedQuizSet != null) {
      int index = quizzes_data.indexOf(quizSet);
      setState(() {
        quizzes_data[index] = editedQuizSet;
      });
    }
  }

  // Start Quiz Test
  void _startQuizTest(BuildContext context, QuizSet quizSet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuizTestScreen(quizSet: quizSet),
      ),
    );
  }


  void _viewQuestions(BuildContext context, QuizSet quizSet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuestionListScreen(quizSet: quizSet),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz Card'),
        backgroundColor: Colors.purple[500],
      ),
      body: quizzes_data.isEmpty
          ? const Center(
              child: Text(
                'No quizzes added yet. Start adding some!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : QuizList(
              quizSets: quizzes_data,
              onQuizRemoved: _removeQuiz,
              onShowOptions: (quizSet) => _showQuizOptions(context, quizSet),
            ),
      // Add a floating action button to add a new quiz
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddQuizForm,
        backgroundColor: Colors.purple[500],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
