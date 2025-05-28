import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cscd350_takethat/pages/takethat_page.dart'; // adjust if path differs

void main() {
  testWidgets('UserHome displays main UI elements', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: UserHome(),
      ),
    );

    // Check for the "Sweet" title
    expect(find.text('Sweet'), findsOneWidget);

    // Check for the "Take a Photo" button
    expect(find.text('Take a Photo'), findsOneWidget);

    // Check for the placeholder text
    expect(find.text('No photo taken yet.'), findsOneWidget);

    // Check that the gradient button exists
    expect(find.byType(InkWell), findsOneWidget);
  });
}
