import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logstates.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);



  void userLogin({

    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      print(value.user!.email);

      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SocialLoginErrorState(error));
    });

  }

  IconData suffix = Icons.visibility;
  bool isPassShow = true;

  void changeSuffixIcon() {
    isPassShow = !isPassShow;
    suffix = isPassShow ? Icons.visibility : Icons.visibility_off;
    emit(SocialLoginPasswordChangeVisibilityState());
  }
}
