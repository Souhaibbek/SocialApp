import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}






// Conditional.single(
// context: context,
// conditionBuilder: (context) =>
// SocialCubit.get(context).model != null,
// widgetBuilder: (context) {
// var model = SocialCubit.get(context).model;
// return Column(
// children: [
// if (!FirebaseAuth.instance.currentUser!.emailVerified)
// Container(
// width: double.infinity,
// height: 40.0,
// color: Colors.yellow[500],
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20.0),
// child: Row(
// children: [
// Icon(IconBroken.Info_Circle),
// SizedBox(
// width: 10.0,
// ),
// Expanded(
// child: Text(
// 'Please verify your email',
// style: TextStyle(
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// TextButton(
// onPressed: () {
// FirebaseAuth.instance.currentUser!
//     .sendEmailVerification()
//     .then((value) {
// showToast(
// msg: 'Please check your email',
// state: ToastStates.SUCCESS);
// }).catchError((error) {});
// },
// child: Text(
// 'SEND',
// style: TextStyle(
// color: Colors.blue,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// ],
// ),
// ),
// ),
//
//
// ],
// );
// },
// fallbackBuilder: (context) =>
// Center(child: CircularProgressIndicator()),
// ),