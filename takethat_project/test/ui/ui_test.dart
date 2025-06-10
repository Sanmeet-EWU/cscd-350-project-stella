import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cscd350_takethat/pages/login_page.dart';
import 'package:cscd350_takethat/pages/signup_page.dart';
import 'package:cscd350_takethat/pages/setting_page.dart';
import 'package:cscd350_takethat/pages/forget_password_page.dart';

class MockLoginPage extends StatelessWidget {
  const MockLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Login Page')),
    );
  }
}
void main() {
  //test 1
  testWidgets('Login page has a Login button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    await tester.pumpAndSettle();
    final loginButton = find.text('Log in');
    expect(loginButton, findsOneWidget);
  });

  //test 2
  testWidgets('Signup page has email, password, and username fields', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignupPage()));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField,'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField,'Password'), findsOneWidget);
    expect(find.widgetWithText(TextFormField,'Username'), findsOneWidget);
  });

  //test 3
  testWidgets('Logout navigates to LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const SettingPage(),
      routes: {
        '/login': (context) => const MockLoginPage(),
      },
    ));
    final logoutTile = find.widgetWithText(ListTile, 'Log out');
    expect(logoutTile, findsOneWidget);
    await tester.tap(logoutTile);
    await tester.pumpAndSettle();
    // LoginPage has 'Welcome Back' title
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });

  //test 4
  testWidgets('SettingPage handles name change', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SettingPage()));
    await tester.tap(find.text('Change Name'));
    await tester.pumpAndSettle();
    // Enter new name
    await tester.enterText(find.byType(TextField), 'Ashley');
    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(find.text('Name changed to Ashley'), findsOneWidget);
  });

  //test 5
  testWidgets('ForgetPasswordPage sends reset email', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ForgetPasswordPage()));
    final emailField = find.byType(TextFormField);
    await tester.enterText(emailField, 'test@example.com');
    final sendButton = find.text('Send Reset Email');
    await tester.tap(sendButton);
    await tester.pump();
  });

}