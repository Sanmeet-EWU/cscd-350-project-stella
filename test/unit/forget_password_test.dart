import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Forget Password Unit Tests', () {
    late MockFirebaseAuth mockAuth;
    setUp(() {
      mockAuth = MockFirebaseAuth();
    });

    test('Send password reset email - success', () async {
      await mockAuth.sendPasswordResetEmail(email: 'test@example.com');
      expect(
        mockAuth.sendPasswordResetEmail(email: 'test@example.com'),
        completes,
      );
    });

    test('Send password reset email - fail', () async {
      try {
        throw FirebaseAuthException(code: 'invalid-email', message: 'Invalid email');
      } catch (e) {
        expect(e, isA<FirebaseAuthException>());
        expect((e as FirebaseAuthException).code, 'invalid-email');
      }
    });
  });
}
