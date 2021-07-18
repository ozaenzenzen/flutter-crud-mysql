import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'homedata_state.dart';

class HomedataCubit extends Cubit<HomedataState> {
  HomedataCubit() : super(HomedataInitial());
}
