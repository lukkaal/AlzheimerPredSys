import 'package:ad_application/auth/providers/current_user_notifier.dart';
import 'package:ad_application/auth/viewmodel/gesture_viewmodel.dart';
import 'package:ad_application/using_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../using_widgets/loader.dart';
import '../using_widgets/utils.dart';
import '../widgets/custompaint/drawingpainter.dart';
import 'dart:async';
import '../auth/view/theme/app_pallete.dart';

class DrawingPage extends ConsumerStatefulWidget {
  const DrawingPage({super.key});

  @override
  ConsumerState<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends ConsumerState<DrawingPage> {
  List<Offset?> trajectory_points = [];
  List<double?> pressure_points = [];
  double width = 800;
  double height = 500;

  Timer? _timer; // 用于计时的 Timer
  double _elapsedTime = 0; // 计时的秒数

  void Pointsformatted () async {
    List<String> formattedtrajectory = trajectory_points
        .where((point) => point != null) // 过滤掉 null
        .map((point) {
      // 减去 400 和 250
      double adjustedDx = point!.dx - 400; // 表示确信 point 不为 0
      double adjustedDy = point.dy - 250;
      return '($adjustedDx, $adjustedDy)'; // 返回调整后的字符串
    })
        .toList();

    List<String> formattedpressure = pressure_points
        .where((point) => point != null) // 过滤掉 null
        .map((point) {
      return '$point'; // 返回调整后的字符串
    })
        .toList();

    // Map<String, List<dynamic>> MapData = {
    //   'trajectory' : formattedtrajectory,
    //   'pressure': formattedpressure,
    // };
    //
    // print(MapData);
    UserModel? currentuser = ref.watch(currentUserRepositoryProvider).currentUser;
    await ref.read(gestureViewmodelProvider.notifier).uploadGesture(id: currentuser!.id,
        name: currentuser.name, trajectory: formattedtrajectory, pressure: formattedpressure);
  }


  void _toggleTimer() {
    if (_timer == null) {
      // 开始计时
      _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          _elapsedTime += 0.01; // 每 10 毫秒增加 0.01 秒
        });
      });
    } else {
      // 停止计时
      _timer?.cancel();
      _timer = null;
      print('Elapsed time: $_elapsedTime seconds'); // 保留两位小数
      _elapsedTime = 0; // 重置计时器
    }
  }
  static double _canvasWidth = 0;
  static double _canvasHeight = 0;
  @override
  // Widget build(BuildContext context) {
  //   final isLoading = ref
  //       .watch(gestureViewmodelProvider.select((val) => val?.isLoading == true));
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      gestureViewmodelProvider.select((val) => val?.isLoading == true),
    );

    ref.listen( // 返回值是 void 并且调用 ref.listen 的原因也是根据 state 的变化动态构建整个界面 (more testable) ref.listen 不会触发 UI 重建 (含 next 参数)
      gestureViewmodelProvider,
          (_, next) { // _表示前一个状态(此处忽略) next表示当前状态 当 provider 状态更新时 next 就会获得最新状态
        next?.when(
          data: (data) {
            showSnackBar(
              context,
              'upload successfully!',
            );
          },
          error: (error, st) { // 这里的 error (Object 类型 可以更灵活地接受各种类型的错误对象)和 st 与 authviewmodel 当中的 l.message 和 StackTrace.current 这两个参数相对应
            showSnackBar(context, error.toString());
          },
          loading: () {},
        );
      },
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Drawing App"),
    //   ),
    //   body: isLoading
    //       ? const Loader()
    //       : Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Column(
    //           children: [
    //             const SizedBox(height: 20),
    //             const Text(
    //               '请绘图',
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //             const SizedBox(height: 10),
    //             Listener(
    //               onPointerMove: (PointerMoveEvent event) {
    //                 setState(() {
    //                   if (event.localPosition.dx >= 0 &&
    //                       event.localPosition.dx <= width &&
    //                       event.localPosition.dy >= 0 &&
    //                       event.localPosition.dy <= height) {
    //                     double pressure = event.pressure;
    //                     trajectory_points.add(event.localPosition);
    //                     pressure_points.add(event.pressure);
    //                   }
    //                 });
    //               },
    //               onPointerDown: (PointerDownEvent event) {},
    //               onPointerUp: (PointerUpEvent event) {
    //                 trajectory_points.add(null);
    //                 pressure_points.add(null);
    //               },
    //               child: Stack(
    //                 children: [
    //                   CustomPaint(
    //                     size: Size(width, height),
    //                     painter: DrawingPainter(trajectory_points),
    //                   ),
    //                   // 绘制中心点提示
    //                   Positioned(
    //                     left: width / 2 - 10, // 中心点横坐标
    //                     top: height / 2 - 10, // 中心点纵坐标
    //                     child: Column(
    //                       children: [
    //                         Container(
    //                           width: 20,
    //                           height: 20,
    //                           decoration: BoxDecoration(
    //                             shape: BoxShape.circle,
    //                             color: Colors.blueAccent,  // 圆点颜色
    //                           ),
    //                         ),
    //                         SizedBox(height: 5  ),
    //                         Text(
    //                           'Center',  // 提示文字
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 30),
    //
    //             // ✅ 美化后的按钮行
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Tooltip(
    //                     message: "清空",
    //                     child: IconButton(
    //                       icon: const Icon(Icons.delete_outline),
    //                       iconSize: 50,
    //                       onPressed: () {
    //                         setState(() {
    //                           trajectory_points.clear();
    //                           pressure_points.clear();
    //                         });
    //                       },
    //                     ),
    //                   ),
    //                   const SizedBox(width: 100),
    //                   Tooltip(
    //                     message: "上传",
    //                     child: IconButton(
    //                       icon: const Icon(Icons.cloud_upload_outlined),
    //                       iconSize: 50,
    //                       onPressed: () {
    //                         setState(() {
    //                           Pointsformatted();
    //                         });
    //                       },
    //                     ),
    //                   ),
    //                   const SizedBox(width: 100),
    //                   Tooltip(
    //                     message: "计时",
    //                     child: IconButton(
    //                       icon: const Icon(Icons.timer_outlined),
    //                       iconSize: 50,
    //                       onPressed: () {
    //                         setState(() {
    //                           _toggleTimer();
    //                         });
    //                       },
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    const double gap = 16.0;
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        title: const Text('Drawing App'),
        backgroundColor: Pallete.cardColor,
        elevation: 2,
      ),
      body: isLoading
          ? const Loader()
          : LayoutBuilder(
        builder: (context, constraints) {
          _canvasWidth = constraints.maxWidth * 0.8;
          _canvasHeight = constraints.maxHeight * 0.6;
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(gap),
                child: Column(
                  children: [
                    const SizedBox(height: gap),
                    const Text(
                      '✏️ 请在此绘制',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Pallete.whiteColor,
                      ),
                    ),
                    const SizedBox(height: gap),
                    Container(
                      width: _canvasWidth,
                      height: _canvasHeight,
                      decoration: BoxDecoration(
                        color: Pallete.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Listener(
                            onPointerMove: (e) {
                              setState(() {
                                if (e.localPosition.dx >= 0 &&
                                    e.localPosition.dx <= _canvasWidth &&
                                    e.localPosition.dy >= 0 &&
                                    e.localPosition.dy <= _canvasHeight) {
                                  trajectory_points.add(e.localPosition);
                                  pressure_points.add(e.pressure);
                                }
                              });
                            },
                            onPointerUp: (_) {
                              trajectory_points.add(null);
                              pressure_points.add(null);
                            },
                            child: CustomPaint(
                              size: Size(_canvasWidth, _canvasHeight),
                              painter: DrawingPainter(trajectory_points),
                            ),
                          ),
                          // 中心点提示
                          Positioned(
                            left: (_canvasWidth / 2) - 10,
                            top: (_canvasHeight / 2) - 10,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue[400],
                                border: Border.all(color: Colors.white54, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: gap * 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _actionButton(
                          icon: Icons.delete_outline,
                          color: Pallete.gradient1,
                          onTap: () {
                            // 删除按键：直接清空轨迹，无提示弹窗
                            setState(() {
                              trajectory_points.clear();
                              pressure_points.clear();
                            });
                          },
                        ),
                        const SizedBox(width: gap * 2),
                        _actionButton(
                          icon: Icons.cloud_upload_outlined,
                          color: Pallete.gradient2,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('上传'),
                                content: const Text('是否上传绘图数据？'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('取消'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Pointsformatted();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('确定'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: gap * 2),
                        _actionButton(
                          icon: Icons.timer_outlined,
                          color: Pallete.gradient3,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('计时'),
                                content: const Text('开始/停止计时？'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('取消'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _toggleTimer();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('确定'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// 圆形图标按钮，带水波纹和点击反馈
Widget _actionButton({
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return Material(
    color: color,
    shape: const CircleBorder(),
    elevation: 4,
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    ),
  );
}