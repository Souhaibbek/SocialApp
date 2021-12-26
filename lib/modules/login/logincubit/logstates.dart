import 'package:firebase_auth/firebase_auth.dart';

abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uid;

  SocialLoginSuccessState(this.uid);
}

class SocialLoginErrorState extends SocialLoginStates {
  final FirebaseAuthException error;

  SocialLoginErrorState(this.error);
}

class SocialLoginPasswordChangeVisibilityState extends SocialLoginStates {}
