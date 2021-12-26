

import 'package:firebase_auth/firebase_auth.dart';

abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {

}

class SocialRegisterErrorState extends SocialRegisterStates {
  final FirebaseAuthException error;
  SocialRegisterErrorState(this.error);
}

class SocialRegisterPasswordChangeVisibilityState extends SocialRegisterStates {}

class SocialUserCreateSuccessState extends SocialRegisterStates {

}

class SocialUserCreateErrorState extends SocialRegisterStates {
  final FirebaseAuthException error;
  SocialUserCreateErrorState(this.error);
}
