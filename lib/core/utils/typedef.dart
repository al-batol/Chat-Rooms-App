import 'package:chat_rooms/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

typedef ResultVoid = Future<Either<Failure, Unit>>;

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultStream<T> = Either<Failure, Stream<T>>;
