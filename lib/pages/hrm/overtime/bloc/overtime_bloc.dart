import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'overtime_event.dart';
part 'overtime_state.dart';

class OvertimeBloc extends Bloc<OvertimeEvent, OvertimeState> {
  OvertimeBloc() : super(OvertimeInitial()) {
    on<OvertimeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
