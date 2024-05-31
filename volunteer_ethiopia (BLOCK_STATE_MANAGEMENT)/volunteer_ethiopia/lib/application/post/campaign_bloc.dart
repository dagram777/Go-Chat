import 'package:bloc/bloc.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';


class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final PostRepository postRepository;

  CampaignBloc({required this.postRepository}) : super(LoadingHome()) {
    on<CampaignEvent>(_createcampaign);
  }

  void _createcampaign(CampaignEvent event, Emitter emit) async {
  
    if (event is GetCampaignEvent) {
      var posted = null;
      try {
        print("we are here and we are great");
        posted = await postRepository.getPostDetail(event.id);
        print(posted);
        emit(LoadPostSuccessfull(post: posted));
        print("also i have been here");
      } catch (e) {
        print("we are not great");
        emit(LoadPostFailed());
      }
    }


    if(event is UpdateCampaignEvent){
      emit(UpdatingPost());
      await Future.delayed(Duration(seconds: 1));

      final instance = Post(
          description: event.description,
          title: event.title,
          goal: event.goal,
          image: event.image,
          created: DateTime.now());
      var posted = null;
      try {
        posted = await postRepository.updatePost(event.id,instance);
      } catch (e) {
        emit(UpdatePostFailed());
      }
      if (posted != null) {
        emit(UpdatePostSuccessfull());
      }
    }

    if (event is CreatePost) {

      if (event.image == null) {
        emit(CreateFailed());
        return;
      }
      emit(CreatingPost());
      await Future.delayed(Duration(seconds: 1));

      final instance = Post(
          description: event.description,
          title: event.title,
          goal: event.goal,
          image: event.image,
          created: DateTime.now());
      var post = null;
      try {
        post = await postRepository.createPost(instance);
      } catch (e) {
        emit(CreateFailed());
      }
      if (post != null) {
        emit(CreateSuccess());
        var posts = null;
        try {
          posts = await postRepository.getPosts();
        } catch (e) {
          emit(LoadFailed());
        }
        if (posts != null) {
          emit(LoadSuccess(posts: posts));
        }

      }
    }
    if (event is PickImage) {
      if (event.image != null) {
        emit(PickSuccess());
      } else {
        emit(PickFail());
      }
    }

    if (event is GetPosts) {
      var posts = null;
      try {
        posts = await postRepository.getPosts();
         emit(LoadSuccess(posts: posts));
      } catch (e) {
        emit(LoadFailed());
      }
    }

    if (event is FindPost) {
      Post? post;
      try {
        post = await postRepository.getPostDetail(event.id);
      }
      catch (e) {
        emit(LoadFail());

      }
      if (post != null){
          emit(LoadNotFail(post: post));
      }
 
    }
  }
}
  
