import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {
  group('Auth Tests', () {
    late MockFirebaseAuth auth;
    setUp(() {
      auth = MockFirebaseAuth();
    });

    test('Signup succeeds with valid email and password', () async {
      final user = await auth.createUserWithEmailAndPassword(
        email: 'newuser@test.com',
        password: 'Password123',
      );
      expect(user.user, isNotNull);
      expect(user.user?.email, 'newuser@test.com');
      expect(auth.currentUser?.email, 'newuser@test.com');
    });

    test('Login with correct email and password', () async {
      await auth.createUserWithEmailAndPassword(
        email: 'correct@test.com',
        password: 'password',
      );
      final user = await auth.signInWithEmailAndPassword(
        email: 'correct@test.com',
        password: 'password',
      );
      expect(user.user, isNotNull);
      expect(user.user?.email, 'correct@test.com');
      expect(auth.currentUser?.email, 'correct@test.com');
    });

    test('Login with wrong email', () async {
      final auth = MockFirebaseAuth(
        mockUser: MockUser(email: 'wrong@test.com'),
      );
      final user = await auth.signInWithEmailAndPassword(
        email: 'wrong@test.com',
        password: 'password',
      );
      expect(user.user, isNotNull);
      expect(user.user?.email, isNot('correct@test.com'));
    });

    test('Sign out clears current user', () async {
      await auth.createUserWithEmailAndPassword(
        email: 'user@test.com',
        password: 'password',
      );
      expect(auth.currentUser, isNotNull);
      await auth.signOut();
      expect(auth.currentUser, isNull);
    });
  });
}
