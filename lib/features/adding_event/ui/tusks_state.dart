part of 'tusks_cubit.dart';

@freezed
class TusksState with _$TusksState {
  const factory TusksState.initial() = _Initial;
  const factory TusksState.addLoading() = AddLoading;
  const factory TusksState.addSuccess(String message) = AddSuccess;
  const factory TusksState.addFailure(String message) = AddFailure;

  ////////////////////////////////
  const factory TusksState.editLoading() = EditLoading;
  const factory TusksState.editSuccess(String message) = EditSuccess;
  const factory TusksState.editFailure(String message) = EditFailure;

  ////////////////////////////////
  const factory TusksState.deleteLoading() = DeleteLoading;
  const factory TusksState.deleteSuccess(String message) = DeleteSuccess;
  const factory TusksState.deleteFailure(String message) = DeleteFailure;

  ////////////////////////////////
  const factory TusksState.getLoading() = GetLoading;
  const factory TusksState.getSuccess(String message) = GetSuccess;
  const factory TusksState.getFailure(String message) = GetFailure;


}
