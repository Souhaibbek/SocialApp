abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUsersSuccessState extends SocialStates {}

class SocialGetUsersLoadingState extends SocialStates {}

class SocialGetUsersErrorState extends SocialStates {
  final TypeError error;

  SocialGetUsersErrorState(this.error);
}

class SocialBotNavBarItemState extends SocialStates {}

class SocialAddPostState extends SocialStates {}

class SocialPickedProfileImageSuccessState extends SocialStates {}

class SocialPickedProfileImageErrorState extends SocialStates {}

class SocialPickedCoverImageSuccessState extends SocialStates {}

class SocialPickedCoverImageErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUploadLoadingState extends SocialStates {}

class SocialUploadSuccessState extends SocialStates {}

class SocialUploadErrorState extends SocialStates {}

class SocialUpdateUserDataSuccessState extends SocialStates {}

class SocialUpdateUserDataErrorState extends SocialStates {}

//create post

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPickedPostImageSuccessState extends SocialStates {}

class SocialPickedPostImageErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

// get posts

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final TypeError error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostLoadingState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final TypeError error;

  SocialLikePostErrorState(this.error);
}

class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostLoadingState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {
  final TypeError error;

  SocialCommentPostErrorState(this.error);
}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final TypeError error;

  SocialGetAllUsersErrorState(this.error);
}

//messages

class SocialSendMessagesSuccessState extends SocialStates {}

class SocialSendMessagesErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}

class SocialGetMessagesErrorState extends SocialStates {}
