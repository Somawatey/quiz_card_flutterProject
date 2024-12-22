import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';
import 'package:quiz_card_project/quiz_card/widget/custom_button.dart';

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
  String get title => _titleController.text;
  // DateTime? selectedDate;
  DateTime selectedDate = DateTime.now(); //set default date to today for user who don't select date
  Color selectedColor = Colors.blue;//set defualt color to blue for user who don't select color


  @override
   void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
      super.dispose();
    }

   void _onAddQuiz() {
    final enteredTitle = _titleController.text.trim();
    final enteredDescription = _descriptionController.text.trim();

    if (enteredTitle.isEmpty || enteredDescription.isEmpty) return;

    QuizSet quizSet = QuizSet(
      title: enteredTitle,
      description: enteredDescription,
      date: selectedDate,
      color: selectedColor,
      //  option: _selectedOption,
    );

    widget.onCreated(quizSet);
    Navigator.pop(context);
  }

  void onCancel() {
    // Close modal
    Navigator.pop(context);
  }

  Future<void> setDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // ignore: unnecessary_null_comparison
                  selectedDate == null
                      ? DateFormat('yyyy-MM-dd').format(DateTime.now()) // Display fallback
                      : DateFormat('yyyy-MM-dd').format(selectedDate), // Display selected
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: setDate,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text("Select Color: "),
              DropdownButton<Color>(
                value: selectedColor,
                onChanged: (Color? newColor) {
                  setState(() {
                    selectedColor = newColor!;
                  });
                },
                items: [
                  Colors.purple,
                  Colors.blue,
                  Colors.green,
                  Colors.orange,
                  Colors.red,
                ].map((Color color) {
                  return DropdownMenuItem<Color>(
                    value: color,
                    child: Container(
                      width: 24,
                      height: 24,
                      color: color,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ReuseButton(
                onPress: onCancel,
                label: 'Cancel',
               
                color: Colors.purple[100]!,
                
              ),
              Spacer(),
              ReuseButton(
                onPress: _onAddQuiz,
                label: 'Add Quiz',
            
              ),
            ],
          )
        ],
      ),
    );
  }
}
