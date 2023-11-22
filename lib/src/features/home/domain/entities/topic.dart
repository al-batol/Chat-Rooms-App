import 'package:equatable/equatable.dart';

class Topic extends Equatable {
  final String? topic;
  final String? topicId;

  const Topic({this.topicId, this.topic});

  @override
  List<Object?> get props => [topic, topicId];
}
