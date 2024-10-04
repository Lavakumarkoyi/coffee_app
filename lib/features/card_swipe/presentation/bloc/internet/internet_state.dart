part of 'internet_bloc.dart';

sealed class InternetState {}

final class InternetInitial extends InternetState {}

enum ConnectivityStatus { connected, disconnected }

final class InternetStatus extends InternetState {
  final ConnectivityStatus status;

  InternetStatus({required this.status});
}
