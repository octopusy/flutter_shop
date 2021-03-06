import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class AccountBridge {
  static const String component = "account";
  /*
  获取短信验证码   type=0 注册
   */
  static Future<Result> getSmsCode(String type, String phone) async {
//    String data = await distest();
//    print(data);
//    Map<String, dynamic> map = json.decode(data);
//    return Result.fromJson(map);
    print("getSmsCode");
    return await Bridge.dispenser({
      "method": "getSmsCode",
      "params": {
        "action": component,
        "arguments": {
          "method": "getSmsCode",
          "data": {"type": type, "phone": phone}
        }
      }
    });
  }

  static distest() {
    return json.encode({"code": 200});
  }

  /*
  登录
 */
  static Future<Result> login(String phone, String smsCode, String inviteCode) {
    return Bridge.dispenser({
      "method": "login",
      "params": {
        "action": component,
        "arguments": {
          "method": "login",
          "data": {
            "phone": phone,
            "smsCode": smsCode,
            "inviteCode": inviteCode
          },
        }
      }
    });
  }

  /*
  微信登录
 */
  static Future<Result> wxLogin() {
    return Bridge.dispenser({
      "method": "wxlogin",
      "params": {
        "action": component,
        "arguments": {
          "method": "wxlogin",
          "data": {"phone": "123"},
        }
      }
    });
  }

  /*
   * 获取用户信息
   */
  static Future<Result> getUserInfo() {
    return Bridge.dispenser({
      "method": "getUserInfo",
      "params": {
        "action": component,
        "arguments": {
          "method": "getUserInfo",
          "data": {"phone": "123"},
        }
      }
    });
  }

  /*
   * 绑定用户信息
   */
  static Future<Result> bindUserInfo(String phone, String smsCode, String inviteCode) {
    return Bridge.dispenser({
      "method": "bindUserMobile",
      "params": {
        "action": component,
        "arguments": {
          "method": "bindUserMobile",
          "data": {
            "phone": phone,
            "smsCode": smsCode,
            "inviteCode": inviteCode==""?"-":inviteCode,
          },
        }
      }
    });
  }


  /*
   * 绑定用户信息
   */
  static Future<Result> logout() {
    return Bridge.dispenser({
      "method": "logout",
      "params": {
        "action": component,
        "arguments": {
          "method": "logout",
          "data": {
            "token":"token"
          },
        }
      }
    });
  }
}
