import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/add_event_entity.dart';
import '../domain/use_cases/add_event_use_case.dart';
import '../domain/use_cases/delete_event_use_case.dart';
import '../domain/use_cases/edit_event_use_case.dart';
import '../domain/use_cases/get_event_use_case.dart';

part 'tusks_cubit.freezed.dart';
part 'tusks_state.dart';

class TusksCubit extends Cubit<TusksState> {
  final AddEventUseCase _addEventUseCase;
  final DeleteEventUseCase _deleteEventUseCase;
  final EditEventUseCase _editEventUseCase;
  final GetEventUseCase _getEventUseCase;

  TusksCubit(this._addEventUseCase, this._deleteEventUseCase,
      this._editEventUseCase, this._getEventUseCase)
      : super(const TusksState.initial());

  Future<void> addEvent(TaskEntity input) async {
    await _addEventUseCase.call(input);
    try {
      emit(const TusksState.addLoading());
      emit(const TusksState.addSuccess('Tusk added successfully'));
    } catch (e) {
      emit(const TusksState.addFailure('Failed to add event'));
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      await _deleteEventUseCase.execute(id);
      final lastState = state as GetSuccess;
      emit(const TusksState.deleteSuccess('Tusk deleted successfully'));
      emit(TusksState.getSuccess(data: lastState.data));
    } catch (e) {
      emit(const TusksState.deleteFailure('Failed to deleted event'));
    }
  }

  Future<void> editEvent(
      {required TaskEntity input, required String collectionPath}) async {
    await _editEventUseCase.call(input: input, collectionPath: collectionPath);
    try {
      emit(const TusksState.editLoading());
      emit(const TusksState.editSuccess('Tusk edited successfully'));
    } catch (e) {
      emit(const TusksState.editFailure('Failed to edited event'));
    }
  }

  void getEvents() async {
    final result = _getEventUseCase.call();
    try {
      emit(const TusksState.getLoading());

      emit(TusksState.getSuccess(
          message: 'Tusks loaded successfully', data: result));
    } catch (e) {
      emit(const TusksState.getFailure('Failed to load events'));
    }
  }
}
