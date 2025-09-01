// This is a basic test to see if the app starts
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:attendance_system/main.dart'; // Adjust import if needed

void main() {
  testWidgets('App starts correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
await tester.pumpWidget(const MyApp());

    // Verify that the app title is present
    expect(find.text('University Attendance'), findsOneWidget);
  });
}
