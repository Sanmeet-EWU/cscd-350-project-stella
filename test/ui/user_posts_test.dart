import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cscd350_takethat/pages/userposts.dart'; // Adjust if needed

void main() {
  testWidgets('UsersPosts widget displays name and icons correctly', (WidgetTester tester) async {
    // Arrange
    const testName = 'Brayden';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UsersPosts(name: testName),
        ),
      ),
    );

    // Assert: Text name
    expect(find.text(testName), findsOneWidget);

    // Assert: Icons
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.emoji_emotions_outlined), findsOneWidget);
    expect(find.byIcon(Icons.share), findsOneWidget);

    // Assert: Liked by text
    expect(find.text('Liked by '), findsOneWidget);
    expect(find.text('sam'), findsOneWidget);
    expect(find.textContaining('and'), findsOneWidget);
    expect(find.text('others'), findsOneWidget);
  });
}
