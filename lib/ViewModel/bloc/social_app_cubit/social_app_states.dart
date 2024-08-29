abstract class SocialAppStates{}
class SocialAppInitialState extends SocialAppStates{}
class SocialGetUserLoadingState extends SocialAppStates{}
class SocialGetUserSuccessState extends SocialAppStates{}
class SocialGetUserErrorState extends SocialAppStates{
  final String error;
  SocialGetUserErrorState({required this.error});
}
class SocialChangeNavigationBarIndexState extends SocialAppStates{}
class SocialNewPostScreenState extends SocialAppStates{}
class SocialProfileImagePickedSuccessState extends SocialAppStates{}
class SocialProfileImagePickedErrorState extends SocialAppStates{}
class SocialCoverImagePickedSuccessState extends SocialAppStates{}
class SocialCoverImagePickedErrorState extends SocialAppStates{}
class SocialUploadProfileImageSuccessState extends SocialAppStates{}
class SocialUploadProfileErrorState extends SocialAppStates{}
class SocialUploadCoverImageSuccessState extends SocialAppStates{}
class SocialUploadCoverErrorState extends SocialAppStates{}
class SocialUpdateUserLoadingState extends SocialAppStates{}
class SocialUpdateUserSuccessState extends SocialAppStates{}
class SocialUpdateUserErrorState extends SocialAppStates{}
class SocialCreatePostLoadingState extends SocialAppStates{}
class SocialCreatePostSuccessState extends SocialAppStates{}
class SocialCreatePostErrorState extends SocialAppStates{}
class SocialPostImagePickedSuccessState extends SocialAppStates{}
class SocialPostImagePickedErrorState extends SocialAppStates{}
class SocialRemovePostImageState extends SocialAppStates{}
class SocialGetPostsLoadingState extends SocialAppStates{}
class SocialGetPostsSuccessState extends SocialAppStates{}
class SocialGetPostsErrorState extends SocialAppStates{}