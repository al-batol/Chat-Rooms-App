part of 'topics_cubit.dart';

abstract class TopicsState extends Equatable {
  const TopicsState();

  @override
  List<Object> get props => [];
}

class TopicsInitial extends TopicsState {}

class LoadedTopics extends TopicsState {
  final Stream<List<Topic>> allTopics;

  const LoadedTopics({required this.allTopics});

  @override
  List<Object> get props => [allTopics];
}

class TopicsError extends TopicsState {
  final String message;

  const TopicsError({required this.message});

  @override
  List<Object> get props => [message];
}
