import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/layout/social_layout/sociallayout.dart';
import 'package:socialapp/modules/register/registerscreen.dart';
import 'package:socialapp/modules/socialcubit/socubit.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/cacherhelper/cachehelper.dart';
import 'logincubit/logcubit.dart';
import 'logincubit/logstates.dart';

class SocialLoginScreen extends StatefulWidget {
  @override
  _SocialLoginScreenState createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  var logEmailController = TextEditingController();
  var logPasswordController = TextEditingController();
  var logFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) {
              uId = state.uid;
              print(uId);
              SocialCubit.get(context).getUsersData();
              navigateAndFinish(context, SocialLayout());
            });
          }
          if (state is SocialLoginErrorState) {
            showToast(
              msg: state.error.toString(),
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: logFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            controller: logEmailController,
                            prefix: Icons.email,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Insert Email';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                            controller: logPasswordController,
                            prefix: Icons.lock,
                            onSubmit: (value) {
                              if (logFormKey.currentState!.validate()) {
                                // SocialLoginCubit.get(context).userLogin(
                                //     email: logEmailController.text,
                                //     password: logPasswordController.text);
                              }
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Insert Password';
                              }
                            },
                            isPass: SocialLoginCubit.get(context).isPassShow,
                            suffix: SocialLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              SocialLoginCubit.get(context).changeSuffixIcon();
                            }),
                        SizedBox(
                          height: 30.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! SocialLoginLoadingState,
                          fallbackBuilder: (context) =>
                              Center(child: CircularProgressIndicator()),
                          widgetBuilder: (context) {
                            return defaultButton(
                              onPressed: () {
                                if (logFormKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                      email: logEmailController.text,
                                      password: logPasswordController.text);
                                }
                              },
                              text: 'Login',
                              isUpperCase: true,
                            );
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('D\'ont have an account ?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text('Register !'.toUpperCase()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
