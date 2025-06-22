import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:to_do_app/featuers/home/domain/repos/repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  final HomeRepo homeRepo;

  List<HomeEntity> _allTasks = [];
  List<HomeEntity> _filteredTasks = [];
  String _currentFilter = 'All';

  List<HomeEntity> get filteredTasks => _filteredTasks;
  String get currentFilter => _currentFilter;

  Future<void> getHomeData() async {
    emit(HomeLoading());
    final result = await homeRepo.getHomeDataList();
    result.fold(
      (l) => emit(HomeFailure(message: l.errModel.errorMessage)),
      (r) {
        _allTasks = r;
        _filteredTasks = r;
        emit(HomeSuccess(homeData: _filteredTasks));
      },
    );
  }

  void filterByStatus(String status) {
    _currentFilter = status;

    if (status == 'All') {
      _filteredTasks = List.from(_allTasks);
    } else {
      _filteredTasks = _allTasks
          .where((task) =>
              task.status.toLowerCase() == status.toLowerCase() ||
              task.status.toLowerCase().contains(status.toLowerCase()))
          .toList();
    }

    emit(HomeSuccess(homeData: _filteredTasks));
  }

  void clearFilter() {
    _currentFilter = 'All';
    _filteredTasks = List.from(_allTasks);
    emit(HomeSuccess(homeData: _filteredTasks));
  }
}
