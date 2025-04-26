import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText; // 不能在这里赋值 因为 final 只能在 runtime 期间才可以赋值
  final TextEditingController? controller; // Controller 可以是 null 因为有时候只起到一个展示的作用
  final bool isObscureText;
  final bool readOnly; // readOnly 的时候 就不需要 Controller 了
  final VoidCallback? onTap; // TextFormField 的回调函数
  const CustomField({ // 使用该构造函数创建的对象在编译时可以被确定为常量
    super.key,
    required this.hintText,
    required this.controller, // 在构造函数中必须要初始化为非空的值  否则用 required 来显式声明需要传入
    this.isObscureText = false, // final 变量的值在运行时只能被赋值一次 对象在创建时会执行构造函数 允许在这一阶段为 final 变量赋值。
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField( // TextField - Controller
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration( // 调用 inputDecorationTheme
        hintText: hintText, // 在原 Theme.dark().inputDecorationTheme 上继续增添 hintText 的值
        // inputDecorationTheme 的内容（如 contentPadding等）仍然会生效
        // 除非在 InputDecoration 中明确覆盖了这些属性
      ),
      validator: (val) { // 一个常见的场景是在提交表单之前 先验证表单中的所有输入是否有效
        // 我们可以使用 TextFormField 的 validator 参数来提供输入验证逻辑
        if (val!.trim().isEmpty) {
          return "$hintText is missing!";
        } // value 是 TextFormField 或其他表单字段中输入的值 这个值是用户在该输入框中输入的内容 即 _controller.text
        // trim() 这个方法用于移除字符串两端的空白字符
        return null;
      },
      obscureText: isObscureText,
      // obscuringCharacter: '.' 可以指定隐藏字符的样式
    );
  }
}

// 构造函数加上 const 关键字的时候 说明使用该构造函数创建的对象在编译时 可以被确定为 常量
// 也就是说 之后在初始化类对象的时候 传入的变量都应当是 "确定的值"
// 当多个 const 对象使用相同的参数时 编译器会将它们优化为指向同一个实例 存到唯一一块地址空间
// 使用 final 修饰的字段表示这些字段的值在对象创建后不能改变 (比如在类中定义改变变量的方法企图改变 final 变量 这是不正确的)
// 这与常量构造函数的特性相辅相成 确保对象的状态是不可变的

