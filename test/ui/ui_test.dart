import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cscd350_takethat/pages/login_page.dart';
import 'package:cscd350_takethat/pages/signup_page.dart';

void main() {
  testWidgets('Login page has a Login button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    await tester.pumpAndSettle();
    final loginButton = find.text('Log in');
    expect(loginButton, findsOneWidget);
  });
  testWidgets('Signup page has email, password, and username fields', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignupPage()));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField,'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField,'Password'), findsOneWidget);
    expect(find.widgetWithText(TextFormField,'Username'), findsOneWidget);
  });
}