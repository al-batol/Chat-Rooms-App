import 'package:bloc/bloc.dart';
import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/get_all_topics.dart';
import 'package:equatable/equatable.dart';

part 'topics_state.dart';

class TopicsCubit extends Cubit<TopicsState> {
  final GetAllTopics _getAllTopics;

  TopicsCubit({required GetAllTopics getAllTopics})
      : _getAllTopics = getAllTopics,
        super(TopicsInitial());

  void getAllTopics() {
    _getAllTopics().fold(
        (failure) => emit(TopicsError(message: failure.message)),
        (allTopics) => emit(LoadedTopics(allTopics: allTopics)));
  }
}
