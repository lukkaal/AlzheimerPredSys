import 'dart:convert';
import 'package:ad_application/using_model/server_constant.dart';
import 'package:ad_application/using_model/failure.dart';
import 'package:ad_application/using_model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../using_model/gesture_model.dart';
part 'auth_remote_repository.g.dart';


@riverpod // 对函数进行riverpod声明 为这个函数创造 provider 之后 调用 provider 来创建 AuthRemoteRepository() 实例
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) { // 这里的 ref 是 provider_ref 可以在这个函数体内通过 ref.watch 等方式访问其他的 provider
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post( // 返回类型是 http.Response
        Uri.parse(
          'http://127.0.0.1:8000/auth/signup',
        ),
        headers: {
          'Content-Type': 'application/json', // FastAPI 使用 Pydantic 模型来验证和解析数据 它会检查请求体中的字段是否存在且是否符合模型定义的类型
        },
        body: jsonEncode(
          {
            'name': name,
            'email': email,
            'password': password,
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      print(response.statusCode);
      print(response.body);


      if (response.statusCode != 200) {
        // {'detail': 'error message'}
        return Left(AppFailure(resBodyMap['detail'])); // 出现错误的时候 会 raise HTTPException(400, 'Incorrect password!') 这是一个 HTTPException 的实例对象 分别有 status_code 和 detail
      }
      print(UserModel.fromMap(resBodyMap));
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }


  Future<Either<AppFailure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post( // 返回 http.Response 对象 包含 statusCode 和 body 属性
        Uri.parse(
          '${ServerConstant.serverURL}/auth/login',
        ),
        headers: {
          'Content-Type': 'application/json', // FastAPI 会根据请求的 Content-Type 来确定如何解析请求体 这里是 FastAPI 使用 Pydantic 模型自动解析请求体中的 JSON 数据
        },
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>; // 调用 fastapi 中的函数的返回值会在 response.body 当中也包括 HTTPException 的实例对象

      if (response.statusCode != 200) { // 正常返回的 statusCode 是200 body 默认的返回值是 null & 出现异常时 statusCode 是对应的异常值(eg 400\500) body 返回值是 HTTPException.detail 的值
        return Left(AppFailure(resBodyMap['detail']));
        // 如果解析或验证失败 FastAPI(auth) 会自动生成一个详细的错误响应 告知客户端具体的错误原因
      }

      return Right(
          UserModel.fromMap(resBodyMap['user'])
    );
    } catch (e) { // 这里的 e 并不是 来自服务器查询时候返回的报错(即不是 fastapi 当中的 raise httpException) 而是客户端自己的错误 比如网络中断 或 连接问题
    return Left(AppFailure(e.toString())); // 执行这里的时候 说明根本没有和服务器(& fastapi)正常交互
    }
  }
  // 没有使用到
  Future<Either<AppFailure, GestureModel>> upload_gesture_postgres({ // 传到 postgres
    required String id,
    required String name,
    required List<String> trajectory,
    required List<String> pressure
   }) async {
    try {
      print(name);
      final response = await http.post( // 返回 http.Response 对象 包含 statusCode 和 body 属性
        Uri.parse(
          'http://127.0.0.1:8000/gesture/upload',
        ),
        headers: {
          'Content-Type': 'application/json', // FastAPI 会根据请求的 Content-Type 来确定如何解析请求体 这里是 FastAPI 使用 Pydantic 模型自动解析请求体中的 JSON 数据
        },
        body: jsonEncode(
          {
            'id': id,
            'name': name,
            'trajectory': trajectory,
            'pressure': pressure
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>; // 调用 fastapi 中的函数的返回值会在 response.body 当中也包括 HTTPException 的实例对象

      if (response.statusCode != 200) { // 正常返回的 statusCode 是200 body 默认的返回值是 null & 出现异常时 statusCode 是对应的异常值(eg 400\500) body 返回值是 HTTPException.detail 的值
        return Left(AppFailure(resBodyMap['detail']));
        // 如果解析或验证失败 FastAPI(auth) 会自动生成一个详细的错误响应 告知客户端具体的错误原因
      }

      return Right(
          GestureModel.fromMap(resBodyMap)
      );
    } catch (e) { // 这里的 e 并不是 来自服务器查询时候返回的报错(即不是 fastapi 当中的 raise httpException) 而是客户端自己的错误 比如网络中断 或 连接问题
      return Left(AppFailure(e.toString())); // 执行这里的时候 说明根本没有和服务器(& fastapi)正常交互
    }
  }

  Future<Either<AppFailure, GestureModel>> upload_gesture_cloudinary({ // 传到 cloudinary
    required String id,
    required String name,
    required List<String> trajectory,
    required List<String> pressure
  }) async {
    try {
      print(name);
      final response = await http.post( // 返回 http.Response 对象 包含 statusCode 和 body 属性
        Uri.parse(
          'http://127.0.0.1:8000/gesture/gesture_cloudinary',
        ),
        headers: {
          'Content-Type': 'application/json', // FastAPI 会根据请求的 Content-Type 来确定如何解析请求体 这里是 FastAPI 使用 Pydantic 模型自动解析请求体中的 JSON 数据
        },
        body: jsonEncode(
          {
            'id': id,
            'name': name,
            'trajectory': trajectory,
            'pressure': pressure
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>; // 调用 fastapi 中的函数的返回值会在 response.body 当中也包括 HTTPException 的实例对象
      // print(resBodyMap); // 打印看一下
      // print(response.statusCode);
      if (response.statusCode != 200) { // 正常返回的 statusCode 是200 body 默认的返回值是 null & 出现异常时 statusCode 是对应的异常值(eg 400\500) body 返回值是 HTTPException.detail 的值
        return Left(AppFailure(resBodyMap['detail']));
        // 如果解析或验证失败 FastAPI(auth) 会自动生成一个详细的错误响应 告知客户端具体的错误原因
      }

      return Right(
          GestureModel.fromMap(resBodyMap)
      );

    } catch (e) { // 这里的 e 并不是 来自服务器查询时候返回的报错(即不是 fastapi 当中的 raise httpException) 而是客户端自己的错误 比如网络中断 或 连接问题
      return Left(AppFailure(e.toString())); // 执行这里的时候 说明根本没有和服务器(& fastapi)正常交互
    }
  }





}
