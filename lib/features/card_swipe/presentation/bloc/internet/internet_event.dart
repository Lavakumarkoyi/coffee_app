part of 'internet_bloc.dart';

sealed class InternetEvent extends Equatable {
  const InternetEvent();

  @override
  List<Object> get props => [];
}

class CheckConnectivity extends InternetEvent {}

class ConnectivityChanged extends InternetEvent {
  final dynamic result;

  ConnectivityChanged(this.result);
}
