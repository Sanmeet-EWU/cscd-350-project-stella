import 'package:firebase_auth/firebase_auth.dart';
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
    test('Signup succeeds with valid email and password', () async {
      final auth = MockFirebaseAuth();

      final userCred = await auth.createUserWithEmailAndPassword(
        email: 'newuser@test.com',
        password: 'securePassword123',
      );

      expect(userCred.user, isNotNull);
      expect(userCred.user?.email, 'newuser@test.com');
    });

  });
}
