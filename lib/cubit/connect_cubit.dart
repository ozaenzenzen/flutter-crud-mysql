import 'package:bloc/bloc.dart';
import 'package:flutter_crud_mysql_1/services/connect.dart';
import 'package:meta/meta.dart';

part 'connect_state.dart';

class ConnectCubit extends Cubit<ConnectState> {
  ConnectCubit() : super(ConnectInitial());

  void getData(){
    Connect connect = Connect();
    // state = connect.getData();
    // emit(state = connect.getData());
  }
}
