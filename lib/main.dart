import 'package:flutter/material.dart';

void main() => runApp(const GradeApp());

class Student {
  Student(this.name, this.grade);
  final String name;
  int grade;
}

class GradeApp extends StatelessWidget {
  const GradeApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    ),
    home: const GradeHome(),
  );
}

class GradeHome extends StatefulWidget {
  const GradeHome({super.key});
  @override
  State<GradeHome> createState() => _GradeHomeState();
}

class _GradeHomeState extends State<GradeHome> {
  static const passingGrade = 60;
  final students = [
    Student('Dana', 88),
    Student('Noam', 54),
    Student('Maya', 76),
    Student('Omar', 45),
  ];

  double get average =>
      students.fold<int>(0, (sum, student) => sum + student.grade) /
      students.length;

  void increase(Student student) => setState(() {
    if (student.grade < 100) student.grade++;
  });

  void decrease(Student student) => setState(() {
    if (student.grade > 0) student.grade--;
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Grade App')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text('Class average'),
                    Text(
                      average.toStringAsFixed(1),
                      key: const Key('average'),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            for (final student in students)
              Card(
                child: ListTile(
                  leading: Icon(
                    student.grade >= passingGrade
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: student.grade >= passingGrade
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text(student.name),
                  subtitle: Text('Grade: ${student.grade}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        key: Key('decrease-${student.name}'),
                        tooltip: 'Decrease ${student.name} grade',
                        onPressed: () => decrease(student),
                        icon: const Icon(Icons.remove),
                      ),
                      IconButton(
                        key: Key('increase-${student.name}'),
                        tooltip: 'Increase ${student.name} grade',
                        onPressed: () => increase(student),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
