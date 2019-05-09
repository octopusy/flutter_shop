import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lib/logic//bloc/userinfo_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/homeitem_view_model.dart';
import 'package:flutter_lib/model/homeitem.dart';
import 'package:flutter_lib/model/userinfo.dart';
import 'package:flutter_lib/utils/uidata.dart';

class UserHomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHomeListPage> {
  HomeItemViewModel homeItemViewModel = HomeItemViewModel();
  List<HomeItem> homeItems;
  UserInfoBloc userInfoBloc = new UserInfoBloc();

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
//      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
//    ));
    //InfoBridge.wxInfo();
    return Scaffold(
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.loose,
        //子Widgets溢出的处理方式
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: new Scaffold(body: bodyData())),
          //充值成VIP
          Positioned(
            top: 152,
            left: 10,
            right: 10,
            child: buildBannerVipHeader(),
          )
        ],
      ),
    );
  }

  /*
   * 创建邀请成为vip
   */
  Widget buildBannerVipHeader() {
    print("创建邀请成为vip");
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Card(
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, UIData.VipApplyPage,
                      arguments: 0);
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Row(children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(17, 13, 0, 12),
                              child: Image.asset(
                                //图片地址
                                "images/icon_vip.png",
                                width: 36,
                                height: 35,
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(15, 13, 0, 12),
                              child: Text(
                                //文本区域
                                "福利来袭,会员首冲",
                              ))
                        ]),
                        flex: 2,
                      ),
                      Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: Text(
                                    '立即开通',
                                    style: TextStyle(
                                        color: Color.fromARGB(130, 113, 37, 1),
                                        fontSize: 12.0),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(13))),
                                  color: Color.fromARGB(230, 207, 102, 1),
                                )
                              ]),
                          flex: 1
                          //立即开通
                          )
                    ]))));
  }

  /*
   * 生成 build Common Tools
   */
  Widget buildCommonTools(Userinfo userInfo) {
    print("常用工具");
    homeItems = homeItemViewModel.getMenuItems(userInfo);
//    return Padding(padding: EdgeInsets.all(10), child: Card());
//    return Container(
//      padding: EdgeInsets.all(10),
//      child: Card(),
//    );
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 15, 10),
      child: Card(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: Text(
                        "常用工具",
                        style: TextStyle(color: UIData.ff353535, fontSize: 15),
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            "images/icon_inputnumber.png",
                            width: 35.0,
                            height: 35.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "输入邀请码",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        UIData.InviteInputPage,
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UIData.MineCollectionPage);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            "images/icon_shoucang.png",
                            width: 35.0,
                            height: 35.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "我的收藏",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
//                      Navigator.pushNamed(context, UIData.MineCollectionPage);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            "images/icon_kehu.png",
                            width: 35.0,
                            height: 35.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "客服中心",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
//                      Navigator.pushNamed(context, UIData.AllShopOrderPage,
//                          arguments: 4);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            "images/icon_exit.png",
                            width: 35.0,
                            height: 35.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "注销",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
   * 创建订单条目
   */
  Widget buildOrdlerHeader(Userinfo userInfo) {
    print("创建订单条目");
    return Container(
      padding: EdgeInsets.fromLTRB(10, 60, 15, 5),
      child: Card(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, UIData.AllShopOrderPage,
                    arguments: 0);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 16, 15, 5),
                    child: Text(
                      "我的订单",
                      style: TextStyle(color: UIData.ff353535, fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "查看全部订单",
                          style: TextStyle(
                              color: Color.fromARGB(153, 153, 153, 1),
                              fontSize: 12),
                        ),
                        Padding(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(153, 153, 153, 1),
                            size: 12,
                          ),
                          padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            "images/order1.png",
                            width: 22.0,
                            height: 22.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "待付款",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, UIData.AllShopOrderPage,
                          arguments: 1);
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UIData.AllShopOrderPage,
                          arguments: 2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            "images/order2.png",
                            width: 22.0,
                            height: 22.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "待发货",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UIData.AllShopOrderPage,
                          arguments: 3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            "images/order3.png",
                            width: 22.0,
                            height: 22.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "待收货",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UIData.AllShopOrderPage,
                          arguments: 4);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            "images/order4.png",
                            width: 22.0,
                            height: 22.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "待评价",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//  /*
//   * 创建头部布局
//   */
//  Widget buildHeader(Userinfo userInfo) {
//    return Padding(
//      padding: EdgeInsets.all(10),
//      child: Container(
//        child: Card(
//          child: Column(
//            children: <Widget>[
//              GestureDetector(
//                onTap: () {
//                  Navigator.pushNamed(context, UIData.AllShopOrderPage,
//                      arguments: 0);
//                },
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.all(15),
//                      child: Text(
//                        "我的订单",
//                        style: TextStyle(color: UIData.ff353535, fontSize: 15),
//                      ),
//                    ),
//                    Expanded(
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: <Widget>[
//                          Text(
//                            "查看全部订单",
//                            style:
//                                TextStyle(color: UIData.ff999999, fontSize: 15),
//                          ),
//                          Padding(
//                            child: Icon(
//                              Icons.arrow_forward_ios,
//                              color: UIData.ff999999,
//                              size: 9,
//                            ),
//                            padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              Divider(),
//              Padding(
//                padding: EdgeInsets.fromLTRB(0, 8, 8, 22),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    GestureDetector(
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Padding(
//                            child: Image.asset(
//                              "images/order1.png",
//                              width: 22.0,
//                              height: 22.0,
//                            ),
//                            padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
//                          ),
//                          Text(
//                            "待付款",
//                            style:
//                                TextStyle(color: UIData.ff353535, fontSize: 12),
//                          ),
//                        ],
//                      ),
//                      onTap: () {
//                        Navigator.pushNamed(context, UIData.AllShopOrderPage,
//                            arguments: 1);
//                      },
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.pushNamed(context, UIData.AllShopOrderPage,
//                            arguments: 2);
//                      },
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Padding(
//                            child: Image.asset(
//                              "images/order2.png",
//                              width: 22.0,
//                              height: 22.0,
//                            ),
//                            padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
//                          ),
//                          Text(
//                            "待发货",
//                            style:
//                                TextStyle(color: UIData.ff353535, fontSize: 12),
//                          ),
//                        ],
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.pushNamed(context, UIData.AllShopOrderPage,
//                            arguments: 3);
//                      },
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Padding(
//                            child: Image.asset(
//                              "images/order3.png",
//                              width: 22.0,
//                              height: 22.0,
//                            ),
//                            padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
//                          ),
//                          Text(
//                            "待收货",
//                            style:
//                                TextStyle(color: UIData.ff353535, fontSize: 12),
//                          ),
//                        ],
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.pushNamed(context, UIData.AllShopOrderPage,
//                            arguments: 4);
//                      },
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Padding(
//                            child: Image.asset(
//                              "images/order4.png",
//                              width: 22.0,
//                              height: 22.0,
//                            ),
//                            padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
//                          ),
//                          Text(
//                            "待评价",
//                            style:
//                                TextStyle(color: UIData.ff353535, fontSize: 12),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }

  /*
   * 头部的用户昵称排版
   */
  Row getUserNickNameWidget(Userinfo userInfo) {
    print("getUserNickNameWidget:" + (userInfo == null ? "true" : "false"));
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //头像
        Padding(
          child: CircleAvatar(radius: 30, backgroundImage: getImage(userInfo)),
          padding: EdgeInsets.fromLTRB(22, 10, 0, 0),
        ),
        //用户数据
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 8, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  child: Text(userInfo == null ? "点此登录" : userInfo.nickName,
                      style: TextStyle(color: UIData.fff, fontSize: 18)),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                Padding(
                  child: Text(userInfo == null ? "登录后获取更多精彩内容" : userInfo.phone,
                      style: TextStyle(color: UIData.fff, fontSize: 12)),
                  padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                )
              ],
            ),
          ),
        ),
        //设置按钮
//        Padding(
//          child: FlatButton(
//            child:
//                Image.asset('images/btn_settings.png', width: 23, height: 23),
//          ),
//          padding: EdgeInsets.fromLTRB(0, 23, 15, 0),
//        ),
      ],
    );
  }

  /*
   * 注释
   */
  Padding getMoneyWidget(Userinfo userInfo) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 8, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              child: Column(
                children: <Widget>[
                  //金额
                  Text("123123"),
                  //返现余额
                  Text("123123"),
                ],
              ),
              padding: EdgeInsets.fromLTRB(22, 0, 0, 0),
            ),
            flex: 1,
          ),
          Divider(),
          Expanded(
              child: Padding(
                child: Column(
                  children: <Widget>[
                    //金额
                    Text("123123"),
                    //返现余额
                    Text("123123"),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(22, 0, 0, 0),
              ),
              flex: 1),
          Divider(),
          Expanded(
            child: Padding(
              child: Column(
                children: <Widget>[
                  //金额
                  Text("123123"),
                  //返现余额
                  Text("123123"),
                ],
              ),
              padding: EdgeInsets.fromLTRB(22, 0, 0, 0),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget buildListIItem(int index, Userinfo userInfo) {
    homeItems = homeItemViewModel.getMenuItems(userInfo);
    HomeItem homeItem = homeItems[index];
    return GestureDetector(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      child: Image.asset(
                        homeItem.icon,
                        width: 22.0,
                        height: 22.0,
                      ),
                      padding: EdgeInsets.fromLTRB(22, 12, 16, 8),
                    ),
                    Text(
                      homeItem.title,
                      style: TextStyle(color: UIData.ff353535, fontSize: 15),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        homeItem.subTitle,
                        style: TextStyle(color: UIData.ff999999, fontSize: 15),
                      ),
                      Padding(
                        child: Icon(
                          homeItem.arrowIcon,
                          color: UIData.ff999999,
                          size: 14,
                        ),
                        padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
              child: Divider(),
            ),
          ],
        ),
      ),
      onTap: () {
        //未登录的用户，要主动跳转
        if (userInfo == null) {
          Navigator.pushNamed(context, UIData.Login);
          return;
        }
        Navigator.pushNamed(context, homeItem.action);
      },
    );
  }

  Widget bodyData() {
    userInfoBloc.getUserInfo();
    return StreamBuilder<Userinfo>(
        stream: userInfoBloc.userInfoStream.stream,
        builder: (context, snapshot) {
          return getWidget(snapshot.data);
        });
  }

  /*
   * 头部
   */
  Padding getHeaderWidget(Userinfo userInfo) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 8, 16),
      child: Column(
        children: <Widget>[
          getUserNickNameWidget(userInfo),
          getMoneyWidget(userInfo)
        ],
      ),
    );
  }

  /*
   * 获取配置信息
   */
  CustomScrollView getWidget(Userinfo userInfo) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: false,
          expandedHeight: 155.0,
          floating: false,
          pinned: false,
          //固定在顶部
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            background: GestureDetector(
              child: Container(
                color: UIData.fffa4848,
                child: getHeaderWidget(userInfo),
              ),
              onTap: () {
                //如果用户信息为空，那么我们就要去登录了，如果用户信息不为空，这时候，就要验证下
                gotoLogin(userInfo);
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              //订单列表
              buildOrdlerHeader(userInfo),
              //常用工具
              buildCommonTools(userInfo),
            ],
          ),
        )
      ],
    );
  }

  ImageProvider getImage(Userinfo userInfo) {
    if (userInfo == null) {
      return new AssetImage("images/user_icon.png");
    }
    return new NetworkImage(userInfo.userImgUrl);
  }

  /*
   * 执行去登录或者去激活的操作
   */
  void gotoLogin(Userinfo userInfo) {
    print("跳转至登录页面");
    if (userInfo == null) {
      Navigator.pushNamed(context, UIData.Login);
      return;
    }
    print("跳转至登录页面2:" + userInfo.phone);
    //判断用户手机号是否存在
    if (userInfo.phone == "-") {
      print("去执行页面跳转");
      //执行去绑定手机号
      Navigator.pushNamed(context, UIData.Register);
      return;
    }
  }
}
