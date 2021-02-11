import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_to_bloc_communication/constants/enum.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;

  StreamSubscription connetivityStreamSubscription;

  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    connetivityStreamSubscription = monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connetivityStreamSubscription.cancel();
    return super.close();
  }
}
