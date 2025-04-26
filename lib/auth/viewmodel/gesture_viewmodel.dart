
import 'package:ad_application/using_model/gesture_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/auth_remote_repository.dart';
part 'gesture_viewmodel.g.dart';




@riverpod
  class GestureViewmodel extends _$GestureViewmodel {
  // AutoDisposeNotifier<AsyncValue<UserModel>?> 说明这个类会用来管理一个 AsyncValue<UserModel>? 类型的状态 state
  late AuthRemoteRepository _authRemoteRepository;
  @override
  AsyncValue<GestureModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    // 可不用声明直接在类内调用到 ref 方法
    return null;
  }
  Future<void> uploadGesture({
    required String id,
    required String name,
    required List<String> trajectory,
    required List<String> pressure
  }) async {
    print(id);
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.upload_gesture_cloudinary(
        id: id,
        name: name,
        trajectory: trajectory,
        pressure: pressure
    ); // 返回值类型是 <Either<AppFailure, UserModel>>

    final val = switch (res) {
      Left(value: final l) => state = const AsyncValue.loading(),
    //     AsyncValue.error(
    //   l.message, // 是 AsyncValue.error 的 error 主要属性
    //   StackTrace.current, // stackTrace 用于存储错误发生时的堆栈跟踪信息 可以帮助定位错误发生的代码位置
    // ),
      Right(value: final r) => {
        state = AsyncValue.data(r),
      }, // 正确的情况下 value 是 UserModel 类型的实例对象
    };
    print(val);
  }

}

