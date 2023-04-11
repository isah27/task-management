part of 'date_picker_cubit.dart';

abstract class DatePickerState extends Equatable {
  const DatePickerState();

  @override
  List<Object> get props => [];
}


class DatePickerLoading extends DatePickerState {}

class DateChangedState extends DatePickerState {
  const DateChangedState({required this.date});
  final DateTime date;
  @override
  List<Object> get props => [date];
}
