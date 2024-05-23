import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/failures/failures.dart';
import '../../domain/entity/login_input.dart';
import '../../domain/use_case/log_out_use_case.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../domain/use_case/registration_via_email_use_case.dart';
import '../../domain/use_case/registration_via_phone_number_use_case.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._registrationUseCase,
    this._registrationViaPhoneNumberUseCase,
  ) : super(const AuthState.initial());
  late String verificationId;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegistrationUseCase _registrationUseCase;
  final RegistrationViaPhoneNumberUseCase _registrationViaPhoneNumberUseCase;

  Future<Either<Failure, UserCredential>> login({
    required LoginInput input,
  }) async {
    emit(const AuthState.loginLoading());
    final result = await _loginUseCase.execute(input);
    if (result is Right) {
      emit(const AuthState.loginSuccess());
    } else {
      emit(AuthState.loginFailure(result.foldLeft.toString()));
    }

    return result;
  }

  Future<void> signOut() async {
    emit(const AuthState.logoutLoading());
    try {
      _logoutUseCase.execute();
      emit(const AuthState.logoutSuccess());
    } catch (e) {
      emit(AuthState.logoutFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserCredential>> registerViaEmail(
      LoginInput input) async {
    emit(const AuthState.registerLoading());
    final result = await _registrationUseCase.execute(input);
    result.fold(
      (l) {
        emit(AuthState.registerFailure(l.message));
      },
      (r) {
        emit(const AuthState.registerSuccess());
      },
    );
    // if (result is Right) {
    //
    // } else {
    //
    // }

    return result;
  }

  Future<void> registerViaPhone(String number) async {
    await _registrationViaPhoneNumberUseCase.execute(
      number: number,
      verificationCompleted: (credential) async {
        await signIn(credential);
      },
      verificationFailed: (exception) {
        if (kDebugMode) {
          print('verificationFailed : ${exception.toString()}');
        }
        emit(ErrorOccurred(exception.toString()));
      },
      codeSent: (verificationId, forceResendingToken) {
        this.verificationId = verificationId;
        emit(const AuthState.phoneNumberSubmitted());
      },
      codeAutoRetrievalTimeout: (verificationId) {
        if (kDebugMode) {
          print('codeAutoRetrievalTimeout');
        }
      },
    );
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(const PhoneOTPVerified());
    } catch (error) {
      emit(ErrorOccurred(error.toString()));
    }
  }
}
