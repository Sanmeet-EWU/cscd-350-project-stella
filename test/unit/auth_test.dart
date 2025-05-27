import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {
  group('Auth Tests', () {
    test('Login with correct email and password', () async {
      final auth = MockFirebaseAuth(
        mockUser: MockUser(
          email: 'correct@test.com',
        ),
      );
      final user = await auth.signInWithEmailAndPassword(
        email: 'correct@test.com',
        password: 'password',
      );
      expect(user.user, isNotNull);
      expect(user.user?.email, 'correct@test.com');
    });

    //add more test

  });
}
