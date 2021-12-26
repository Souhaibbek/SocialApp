import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/socialcubit/socubit.dart';
import 'package:socialapp/modules/socialcubit/sostates.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = cubit.model;
        nameController.text = model!.name;
        phoneController.text = model.phone;
        bioController.text = model.bio;

        var profile = cubit.profileImage;
        var profileImg;
        profile == null
            ? profileImg = NetworkImage(model.image)
            : profileImg = FileImage(profile);

        var cover = cubit.coverImage;
        var coverImg;
        cover == null
            ? coverImg = NetworkImage(model.cover)
            : coverImg = FileImage(cover);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Edit Profile',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context)
                      .updateUser(
                    bio: bioController.text,
                    name: nameController.text,
                    phone: phoneController.text,
                  )
                      .then((value) {
                    showToast(
                        msg: 'Profile Updated Successfully',
                        state: ToastStates.SUCCESS);
                  }).catchError((error) {
                    showToast(
                        msg: 'Profile Updating Error is ${error.toString()}',
                        state: ToastStates.ERROR);
                  });
                },
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is SocialUploadLoadingState)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 180.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 140.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                ),
                                image: DecorationImage(
                                  image: coverImg,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, right: 10.0),
                            child: InkWell(
                              child: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.white60,
                                child: Icon(
                                  IconBroken.Camera,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                cubit.getCoverImage();
                              },
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 51.0,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: profileImg,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.getProfileImage();
                            },
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.white60,
                              child: Icon(
                                IconBroken.Camera,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (cubit.profileImage != null || cubit.coverImage != null)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(onPressed: (){
                                  cubit.uploadProfileImg();
                                }, text: 'UPLOAD PROFILE'),
                              ],
                            ),
                          ),
                        SizedBox(width: 20.0,),
                        if (cubit.coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(onPressed: (){
                                  cubit.uploadCoverImg();
                                }, text: 'UPLOAD COVER'),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        label: 'Name',
                        type: TextInputType.name,
                        controller: nameController,
                        prefix: IconBroken.User1,
                        validate: (value) {},
                      ),
                      defaultFormField(
                        label: 'Phone',
                        type: TextInputType.phone,
                        controller: phoneController,
                        prefix: IconBroken.Call,
                        validate: (value) {},
                      ),
                      defaultFormField(
                        label: 'Bio',
                        type: TextInputType.text,
                        controller: bioController,
                        prefix: IconBroken.Paper,
                        validate: (value) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
