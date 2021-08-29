import 'package:wardeleven/models/enums.dart';

import 'failure_handler.dart';

abstract class BaseViewModelContract {
  void setLoadingState(LoadingState newState);

  LoadingState get loadingState;

  FailureHandler? get failure;

  void setFailure(FailureHandler failure);
}
