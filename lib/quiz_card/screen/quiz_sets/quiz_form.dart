import 'package:flutter/material.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';

class QuizForm extends StatefulWidget {
  final void Function(QuizSet) onCreated;

  const QuizForm({required this.onCreated, super.key});

  @override
  State<QuizForm> createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  //Category _selectedCategory = Category.learning;

  void _submitQuiz() {
    final enteredTitle = _titleController.text.trim();
    final enteredDescription = _descriptionController.text.trim();

    if (enteredTitle.isEmpty || enteredDescription.isEmpty) return;

    final newQuiz = QuizSet(
      title: enteredTitle,
      description: enteredDescription,
      date: DateTime.now(),
    //  option: _selectedOption,
    );

    widget.onCreated(newQuiz);
    Navigator.of(context).pop();
  }
  void onCancel() {
    // Close modal
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 16),
          Row(children: [
          
            ElevatedButton(
                  onPressed: onCancel,
                  child: const Text('Cancel'),
            ),
            Spacer(),
            ElevatedButton(
            onPressed: _submitQuiz,
            child: const Text('Add Quiz',style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[500]),
          ),
          ],)
          
          
        ],
      ),
    );
  }
}