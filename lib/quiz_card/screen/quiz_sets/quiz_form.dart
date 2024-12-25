import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz_card_project/quiz_card/screen/questions/question.dart';
import 'package:quiz_card_project/quiz_card/widget/custom_button.dart';
import 'package:uuid/uuid.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';

const uuid = Uuid();

class QuizForm extends StatefulWidget {
  final Function(QuizSet) onCreated;
  final QuizSet? quizSet;
  final EditionMode mode;

  const QuizForm(
      {super.key, required this.onCreated, this.quizSet, required this.mode});

  @override
  State createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Color selectedColor = Colors.purple;
  final List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    if (editingMode) {
      _titleController.text = widget.quizSet!.title;
      _descriptionController.text = widget.quizSet!.description ?? '';
      selectedDate = widget.quizSet!.date;
      selectedColor = widget.quizSet!.color;
      _questions.addAll(widget.quizSet!.questions);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

 void _saveQuizSet() {
  if (_formKey.currentState!.validate()) {
    if (_questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one question')),
      );
      return;
    }

    final newQuizSet = QuizSet(
      id: const Uuid().v4(),
      title: _titleController.text,
      description: _descriptionController.text,
      date: selectedDate,
      color: selectedColor,
      questions: _questions,
    );
    
    widget.onCreated(newQuizSet); // Pass back to parent
    Navigator.of(context).popUntil((route) => route.isFirst); // Return to previous screen
  }
}

  bool get editingMode => widget.mode == EditionMode.editing;
  bool get creatingMode => widget.mode == EditionMode.creating;

  String get buttonLabel => creatingMode ? "Add" : "Edit";
  String get headerLabel =>
      creatingMode ? "Add a new quiz set" : "Edit quiz set";

  void _resetForm() {
    _formKey.currentState!.reset();
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      selectedDate = DateTime.now();
      selectedColor = Colors.purple;
      _questions.clear();
    });
  }

  Future<void> setDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _addQuestion() async {
  if (_titleController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please add quiz title first')),
    );
    return;
  }

  final question = await Navigator.of(context).push<Question>(
    MaterialPageRoute(
      builder: (ctx) => QuestionScreen(
        onQuestionAdded: (question) => Navigator.pop(ctx, question),
        mode: EditionMode.creating,
      ),
    ),
  );

  if (question != null && mounted) {
    setState(() {
      _questions.add(question); // Add to local list
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(headerLabel),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                maxLength: 100,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate == null
                        ? DateFormat('yyyy-MM-dd')
                            .format(DateTime.now()) // Display fallback
                        : DateFormat('yyyy-MM-dd')
                            .format(selectedDate), // Display selected
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: setDate,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButton<Color>(
                value: selectedColor,
                onChanged: (Color? newValue) {
                  setState(() {
                    selectedColor = newValue!;
                  });
                },
                items: [Colors.purple, Colors.red, Colors.green, Colors.blue]
                    .map<DropdownMenuItem<Color>>((Color color) {
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: ReuseButton(
                      onPress: _resetForm,
                      label: 'Reset',
                      color: Colors.red[300]!,
                      icon: Icons.refresh,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ReuseButton(
                      onPress: _addQuestion,
                      label: 'Question',
                      icon: Icons.add,
                      color: Colors.blue[300]!,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ReuseButton(
                      onPress: _saveQuizSet,
                      label: buttonLabel,
                      icon: Icons.save,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
