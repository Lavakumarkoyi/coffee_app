import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  InternetBloc() : super(InternetInitial()) {
    on<CheckConnectivity>(_onCheckConnectivity);
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  void _onCheckConnectivity(CheckConnectivity event, Emitter<InternetState> emit) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectivityState(connectivityResult, emit);
  }

  void _onConnectivityChanged(ConnectivityChanged event, Emitter<InternetState> emit) {
    print("connectivity changes");
    _updateConnectivityState(event.result, emit);
  }

  void _updateConnectivityState(dynamic result, Emitter<InternetState> emit) {
    List<ConnectivityResult> results;
    if (result is ConnectivityResult) {
      results = [result];
    } else if (result is List<ConnectivityResult>) {
      results = result;
    } else {
      emit(InternetStatus(status: ConnectivityStatus.disconnected));
      return;
    }

    if (results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.ethernet)) {
      // print("emited state for reconnection");
      emit(InternetStatus(status: ConnectivityStatus.connected));
    } else {
      // print("emited state for disconnection");
      emit(InternetStatus(status: ConnectivityStatus.disconnected));
    }
  }

  void startMonitoring() {
    // print("..Monitoring..");
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((results) {
      add(ConnectivityChanged(results));
    });
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
