import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myweather/Features/auth/presentaion/widgets/register_view_body.dart';
import 'package:myweather/Features/pick%20location/presentaion/views/pick_location_view.dart';
import 'package:myweather/core/widgets/custom_gradient_background.dart';
import 'package:myweather/core/widgets/custom_loading_indicator.dart';

import '../../../../constants.dart';
import '../../../../core/widgets/error_bar.dart';
import '../manger/auth_cubit/login_cubit.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: bloc.BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Get.off(
              () => const PickLocationView(),
              transition: Transition.fade,
              duration: kTransionDuration,
            );
          }

          if (state is RegisterFailure) {
            errorBar(context, message: state.errMesasge);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            color: Colors.transparent,
            progressIndicator: const CustomLoadingIndicator(),
            inAsyncCall: state is RegisterLoading ? true : false,
            child: CustomGradientBackGround(
              child: RegisterViewBody(),
            ),
          );
        },
      ),
    );
  }
}
