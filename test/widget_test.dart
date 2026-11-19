import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grade_app/main.dart';

void main() {
  testWidgets('grade increase updates grade and average', (tester) async {
    await tester.pumpWidget(const GradeApp());
    expect(find.text('65.8'), findsOneWidget);
    expect(find.text('Grade: 88'), findsOneWidget);
    await tester.tap(find.byKey(const Key('increase-Dana')));
    await tester.pump();
    expect(find.text('Grade: 89'), findsOneWidget);
    expect(find.text('66.0'), findsOneWidget);
    await tester.tap(find.byKey(const Key('decrease-Dana')));
    await tester.pump();
    expect(find.text('Grade: 88'), findsOneWidget);
    expect(find.text('65.8'), findsOneWidget);
  });
}
