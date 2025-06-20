import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:to_do_app/featuers/home/domain/repos/repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  final HomeRepo homeRepo;
  Future<void> getHomeData() async {
    emit(HomeLoading());
    final result = await homeRepo.getHomeDataList();
    result.fold((l) => emit(HomeFailure(message: l.errModel.errorMessage)),
        (r) => emit(HomeSuccess(homeData: r)));
  }
}
