import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/models/messagemodel.dart';
import 'package:socialapp/models/usermodel.dart';
import 'package:socialapp/modules/socialcubit/socubit.dart';
import 'package:socialapp/modules/socialcubit/sostates.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatefulWidget {
  final SocialUserModel socialUserModel;

  ChatDetailsScreen({required this.socialUserModel});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context)
          .getMessages(receiverId: widget.socialUserModel.uid);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 16.0,
                    backgroundImage: NetworkImage(widget.socialUserModel.image),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    widget.socialUserModel.name,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(IconBroken.Message),
                ),
              ],
            ),
            body: Conditional.single(
              widgetBuilder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: SocialCubit.get(context).messages.length,
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];
                              if (SocialCubit.get(context).model!.uid ==
                                  message.senderId) {
                                return buildMyMessage(message);
                              } else {
                                return buildComingMessage(message);
                              }
                            }),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xA2A2A7A6),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextFormField(
                                  controller: messageController,
                                  maxLengthEnforcement: MaxLengthEnforcement
                                      .truncateAfterCompositionEnds,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message here...',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              child: MaterialButton(
                                color: Colors.blue,
                                onPressed: () {
                                  SocialCubit.get(context).sendMessages(
                                    text: messageController.text,
                                    dateTime: DateTime.now().toString(),
                                    receiverId: widget.socialUserModel.uid,
                                  );
                                },
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              context: context,
              conditionBuilder: (BuildContext context) =>
                  SocialCubit.get(context).messages.length > 0,
              fallbackBuilder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text('Start a conversation'),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xA2A2A7A6),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextFormField(
                                  // onFieldSubmitted: (value){
                                  //   SocialCubit.get(context).sendMessages(
                                  //     text: messageController.text,
                                  //     dateTime: DateTime.now().toString(),
                                  //     receiverId: widget.socialUserModel.uid,
                                  //   );
                                  //   setState(() {
                                  //     messageController.text='';
                                  //     messageController.clear();
                                  //   });
                                  // },
                                  // onEditingComplete: (){
                                  //   SocialCubit.get(context).sendMessages(
                                  //     text: messageController.text,
                                  //     dateTime: DateTime.now().toString(),
                                  //     receiverId: widget.socialUserModel.uid,
                                  //   );
                                  //   setState(() {
                                  //     messageController.text='';
                                  //     messageController.clear();
                                  //   });
                                  // },
                                  // onSaved: (value){
                                  //   SocialCubit.get(context).sendMessages(
                                  //     text: messageController.text,
                                  //     dateTime: DateTime.now().toString(),
                                  //     receiverId: widget.socialUserModel.uid,
                                  //   );
                                  //   setState(() {
                                  //     messageController.text='';
                                  //     messageController.clear();
                                  //   });
                                  // },
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message here...',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              child: MaterialButton(
                                color: Colors.blue,
                                onPressed: () {
                                  SocialCubit.get(context).sendMessages(
                                    text: messageController.text,
                                    dateTime: DateTime.now().toString(),
                                    receiverId: widget.socialUserModel.uid,
                                  );
                                  setState(() {
                                    messageController.text='';
                                    messageController.clear();
                                  });
                                },
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }
}

Widget buildComingMessage(MessageModel messageModel) => InkWell(
      onLongPress: () {
        showToast(msg: messageModel.dateTime, state: ToastStates.SUCCESS);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              ),
              color: Colors.grey[300],
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: Text(messageModel.text),
          ),
        ),
      ),
    );

Widget buildMyMessage(MessageModel messageModel) => InkWell(
      onLongPress: () {
        showToast(msg: messageModel.dateTime, state: ToastStates.SUCCESS);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              ),
              color: Colors.lightBlueAccent.withOpacity(.4),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: Text(messageModel.text),
          ),
        ),
      ),
    );
