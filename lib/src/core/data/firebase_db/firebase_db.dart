import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_db/i_db.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/user.dart';

class FirebaseDb implements IDb {
  @override
  Future<Either<Exception, String>> login(
      {required String email, required String password}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      log('Logged in :${FirebaseAuth.instance.currentUser}');
      return const Right('Success');
    } on FirebaseAuthException catch (e) {
      log('Exception:::: ${e.code}');
      switch (e.code) {
        case 'invalid-credential':
          return Left(Exception(
              'Invalid credentials. Please check your email and password.'));
        case 'user-not-found':
          return Left(Exception('No user found with this email/username.'));
        case 'wrong-password':
          return Left(Exception(
              'The password is invalid or the user does not have a password.'));
        default:
          return Left(
              Exception('Something went wrong please try again later.'));
      }
    }
  }

  @override
  Future<Either<Exception, String>> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      log('Logged in :${FirebaseAuth.instance.currentUser}');
      if (userCredential.additionalUserInfo!.isNewUser) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': email,
          'registerDate': DateTime.now().toIso8601String(),
          'name': name,
          'userId': userCredential.user!.uid,
        });
      }
      return const Right('Success');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return Left(Exception('The email address is badly formatted.'));
        case 'email-already-in-use':
          return Left(Exception(
              'The email address is already in use by another account.'));
        case 'weak-password':
          return Left(Exception('Password should be at least 6 characters.'));
        default:
          return Left(
              Exception('Something went wrong please try again later.'));
      }
    }
  }

  @override
  Future<Either<Exception, UserModel>> fetchUser() async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      log('user: ${UserModel.fromJson(user.data()!, FirebaseAuth.instance.currentUser!.uid).toJson()}');

      return Right(UserModel.fromJson(
          user.data()!, FirebaseAuth.instance.currentUser!.uid));
    } catch (e) {
      log('Exception:::: $e');
      return Left(Exception(e));
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    log('Logged out :${FirebaseAuth.instance.currentUser}');
  }
}
