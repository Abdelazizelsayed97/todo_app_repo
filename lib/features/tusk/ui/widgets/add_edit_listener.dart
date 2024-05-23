import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/toast.dart';
import '../tusks_cubit.dart';

class AddEditListener extends StatelessWidget {
  const AddEditListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TusksCubit, TusksState>(
      listener: (context, state) {
        if (state is AddSuccess) {
          Navigator.of(context).pop();
          ShowToast.showToastMessage(message: state.message);
        } else if (state is AddFailure) {
          ShowToast.showToastMessage(message: state.message);
        }
        if (state is EditSuccess) {
          Navigator.of(context).pop();
          ShowToast.showToastMessage(message: state.message);
        } else if (state is EditFailure) {
          ShowToast.showToastMessage(message: state.message);
        }
      },
      child: child,
    );
  }
}
