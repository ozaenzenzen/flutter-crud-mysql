import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'connect_state.dart';

class ConnectCubit extends Cubit<ConnectState> {
  ConnectCubit() : super(ConnectInitial());
}
