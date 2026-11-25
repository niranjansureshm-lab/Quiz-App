import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

// ---------------- QUESTION MODEL ----------------

class Question {
  final String text;
  final List<String> options;
  final int answerIndex;

  const Question(this.text, this.options, this.answerIndex);
}

// ---------------- QUESTIONS LIST ----------------

const List<Question> questions = [
  Question(
    'Which language is used by Flutter?',
    ['Java', 'Dart', 'Python', 'C++'],
    1,
  ),
  Question(
    'Who developed Flutter?',
    ['Microsoft', 'Google', 'Apple', 'Amazon'],
    1,
  ),
  Question(
    'What does CPU stand for?',
    [
      'Central Processing Unit',
      'Computer Personal Unit',
      'Central Program Utility',
      'Control Processing User'
    ],
    0,
  ),
  Question(
    'Which language is mainly used for web development?',
    ['HTML', 'Python', 'C', 'Swift'],
    0,
  ),
  Question(
    'Which widget is used for a scrollable list in Flutter?',
    ['Container', 'ListView', 'Text', 'Icon'],
    1,
  ),
  Question(
    'What does RAM stand for?',
    [
      'Random Access Memory',
      'Read Access Machine',
      'Run Active Memory',
      'Rapid Action Module'
    ],
    0,
  ),
  Question(
    'Which company developed Android?',
    ['Apple', 'Google', 'Intel', 'IBM'],
    1,
  ),
  Question(
    'Which symbol is used to write comments in Dart?',
    ['#', '//', '<!--', '**'],
    1,
  ),
  Question(
    'Which database is a popular NoSQL database?',
    ['MySQL', 'MongoDB', 'Oracle', 'SQLite'],
    1,
  ),
  Question(
    'What does UI stand for?',
    [
      'Universal Internet',
      'User Interface',
      'United Information',
      'User Internet'
    ],
    1,
  ),
];

// ---------------- MAIN APP ----------------

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6750A4),
        fontFamily: 'Roboto',
      ),
      home: const QuizPage(),
    );
  }
}

// ---------------- QUIZ PAGE ----------------

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  int score = 0;
  int? selected;

  void choose(int i) {
    if (selected != null) return;

    setState(() {
      selected = i;

      if (i == questions[index].answerIndex) {
        score++;
      }
    });
  }

  void next() {
    setState(() {
      index++;
      selected = null;
    });
  }

  void restart() {
    setState(() {
      index = 0;
      score = 0;
      selected = null;
    });
  }

  Color optionColor(int i, Question q) {
    if (selected == null) {
      return Colors.white;
    }

    if (i == q.answerIndex) {
      return Colors.green.shade100;
    }

    if (i == selected) {
      return Colors.red.shade100;
    }

    return Colors.white;
  }

  Color optionBorder(int i, Question q) {
    if (selected == null) {
      return Colors.grey.shade300;
    }

    if (i == q.answerIndex) {
      return Colors.green;
    }

    if (i == selected) {
      return Colors.red;
    }

    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    // ---------------- RESULTS SCREEN ----------------

    if (index >= questions.length) {
      double percentage = (score / questions.length) * 100;

      String message;

      if (score >= 8) {
        message = 'Excellent Performance!';
      } else if (score >= 5) {
        message = 'Good Job! Keep Practicing!';
      } else {
        message = 'Keep Learning and Try Again!';
      }

      return Scaffold(
        backgroundColor: const Color(0xFFF5F3FF),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.10),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.emoji_events_rounded,
                    size: 85,
                    color: Colors.amber,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Quiz Completed!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2EEFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$score / ${questions.length}',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),

                        const Text(
                          'Your Score',
                          style: TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          '${percentage.toStringAsFixed(0)}% Accuracy',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: restart,
                      icon: const Icon(Icons.refresh),
                      label: const Text(
                        'Try Again',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // ---------------- QUESTION SCREEN ----------------

    final q = questions[index];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'QUIZ APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // QUESTION NUMBER

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'General Knowledge Quiz',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    '${index + 1} / ${questions.length}',
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // PROGRESS INDICATOR

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (index + 1) / questions.length,
                  minHeight: 10,
                  backgroundColor: Colors.deepPurple.shade100,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 30),

              // QUESTION CARD

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6750A4),
                      Color(0xFF9575CD),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'QUESTION',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      q.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Choose Your Answer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              // ANSWER OPTIONS

              ...List.generate(q.options.length, (i) {
                bool isCorrect = i == q.answerIndex;
                bool isSelected = i == selected;

                return Container(
                  margin: const EdgeInsets.only(bottom: 13),
                  decoration: BoxDecoration(
                    color: optionColor(i, q),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: optionBorder(i, q),
                      width: 1.5,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),

                    leading: CircleAvatar(
                      backgroundColor: selected == null
                          ? Colors.deepPurple.shade100
                          : isCorrect
                              ? Colors.green
                              : isSelected
                                  ? Colors.red
                                  : Colors.deepPurple.shade100,

                      child: selected != null && (isCorrect || isSelected)
                          ? Icon(
                              isCorrect ? Icons.check : Icons.close,
                              color: Colors.white,
                            )
                          : Text(
                              String.fromCharCode(65 + i),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                    ),

                    title: Text(
                      q.options[i],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    trailing: selected != null && isCorrect
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : null,

                    onTap: selected == null ? () => choose(i) : null,
                  ),
                );
              }),

              // FEEDBACK MESSAGE

              if (selected != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: selected == q.answerIndex
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selected == q.answerIndex
                            ? Icons.check_circle
                            : Icons.error,
                        color: selected == q.answerIndex
                            ? Colors.green.shade800
                            : Colors.red.shade800,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          selected == q.answerIndex
                              ? 'Correct Answer! Well done.'
                              : 'Wrong Answer! Correct answer: ${q.options[q.answerIndex]}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selected == q.answerIndex
                                ? Colors.green.shade900
                                : Colors.red.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 25),

              // NEXT BUTTON

              if (selected != null)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      index == questions.length - 1
                          ? 'View Results'
                          : 'Next Question',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}