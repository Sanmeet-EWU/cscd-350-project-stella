import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cscd350_takethat/pages/story_page.dart';

void main() {
  testWidgets('StoryPage displays app bar and user posts list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StoryPage(),
      ),
    );

    // Check AppBar logo
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Image), findsWidgets);

    // Find Nigel's post (force scroll into view)
    final nigelFinder = find.text('Nigel');
    await tester.scrollUntilVisible(
      nigelFinder,
      500.0,
      scrollable: find.byType(Scrollable),
    );
    await tester.pumpAndSettle();

    // Verify it's found
    expect(nigelFinder, findsOneWidget);
  });
}
