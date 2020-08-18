
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomRefreshCubit extends Cubit<double> {
  BottomRefreshCubit() : super(0);

  void setOffset(double offset) => emit(offset);

}