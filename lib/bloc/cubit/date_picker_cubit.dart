import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_picker_state.dart';

class DatePickerCubit extends Cubit<DatePickerState> {
  DatePickerCubit() : super(DateChangedState(date: DateTime.now()));
  DateTime date = DateTime.now();
  changeDate(DateTime selectedDate) {
    emit(DatePickerLoading());
    date = selectedDate;
    emit(DateChangedState(date: date));
  }
}
