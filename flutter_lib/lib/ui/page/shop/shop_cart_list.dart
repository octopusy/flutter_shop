import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/cart_bridge.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/logic/bloc/cart_bloc.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/cart.dart';
import 'package:flutter_lib/ui/page/order/shop_order.dart';
import 'package:flutter_lib/ui/widgets/error_status_widget.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ShopCartListPage extends StatefulWidget {
  bool showBackBtn = false;

  ShopCartListPage(bool showBackBtn) {
    this.showBackBtn = showBackBtn;
  }

  @override
  State<StatefulWidget> createState() {
    return _ShopCartListState();
  }
}

class _ShopCartListState extends State<ShopCartListPage> {
  CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
//    ));

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: UIData.fffa4848,
        centerTitle: false,
        title: Text(
          "购物车",
          style: TextStyle(color: UIData.fff, fontSize: 18),
        ),
        elevation: 0,
        leading: widget.showBackBtn == true
            ? new IconButton(
                icon: Icon(Icons.arrow_back_ios, color: UIData.fff),
                color: UIData.fff,
                onPressed: () => Navigator.pop(context, false),
              )
            : null,
      ),
      body: bodyData(),
    );
  }

  Widget bodyData() {
    cartBloc.findCart();
    return StreamBuilder<Cart>(
        stream: cartBloc.productItems,
        builder: (context, snapshot) {
          Cart cart = snapshot.data;
          if (snapshot.hasData) {
            if ((cart == null ||
                cart.products == null ||
                cart.products.isEmpty ||
                cart.totalCounts == 0)) {
              return ErrorStatusWidget.cart(0, "暂无购物记录~", "立即购物", () {
                if (widget.showBackBtn) {
                  Navigator.pop(context, true);
                } else {
                  Navigator.pushNamed(context, UIData.ShopCategoryList,
                      arguments: "全部分类");
                }
              });
            } else {
              return buildBody(cart);
            }
          } else if (snapshot.hasError) {
            Result result = snapshot.error;
            return ErrorStatusWidget.cart(result.code, result.msg, "立即购物", () {
              if (widget.showBackBtn) {
                Navigator.pop(context, true);
              } else {
                Navigator.pushNamed(context, UIData.ShopCategoryList,
                    arguments: "全部分类");
              }
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  String userAddressId = "12";
  Container buildBody(Cart cart) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 45,
              color: UIData.fffa4848,
              child: Text("."),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 50,
            left: 10,
            right: 10,
            child: buildListView(cart),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            child: Text(
                              "￥" + cart.totalMoney.toStringAsFixed(2),
                              style: TextStyle(
                                  color: UIData.fffa4848, fontSize: 18),
                            ),
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: UIData.getShapeButton(
                        UIData.fffa4848, UIData.fff, 90, 33, "提交订单", 15, 17,
                        () {
                      print("ontap");
                      if (cart.totalCounts <= 0) {
                        Bridge.showShortToast("请至少选择一个商品");
                        return;
                      }
                      //此处需要将cart数据同步到底层
                      synchorizedCartList(cart);
//                      Navigator.push(
//                          context,
//                          new MaterialPageRoute(
//                              builder: (context) => new ShopOrderListPage()));
                    }),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Divider(),
          ),
        ],
      ),
    );
  }

  ListView buildListView(Cart cart) {
    List<SkuWapper> products = cart.products;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        String name =
            (products[index].sku.name != null) ? products[index].sku.name : "";
        String price = "￥" +
            ((products[index].sku.price != null)
                ? products[index].sku.price.toStringAsFixed(2)
                : "0.00");

        String skuInfo =
            products[index].sku.norms == null ? "" : products[index].sku.norms;
        return GestureDetector(
          child: Container(
            child: Card(
              color: UIData.fff,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 0, 12, 0),
                    child: UIData.getImageWithWHFit(
                        products[index].sku.img, BoxFit.cover, 44, 44),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 18, 12, 8),
                          child: Text(name,
                              style: TextStyle(
                                  fontSize: 12, color: UIData.ff353535)),
                        ),
                        skuInfo.isEmpty
                            ? Container(
                                width: 0,
                                height: 0,
                              )
                            : Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 13, 0),
                                child: Container(
                                    height: 18,
                                    width: 92,
                                    decoration: BoxDecoration(
                                        color: UIData.fff7f7f7,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Center(
                                      child: UIData.getTextWidget(
                                          skuInfo, UIData.ff999999, 11),
                                    )),
                              ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 6, 15, 17),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  width: 80,
                                  child: Text(
                                    price,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: UIData.fffa4848, fontSize: 12),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                    child: UIData.getTextWidget(
                                        "-", UIData.ff999999, 11),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UIData.fff7f7f7, width: 1.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                onTap: () {
                                  cartBloc.del2Cart(products[index], 1);
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: Container(
                                  width: 50,
                                  height: 20,
                                  child: Center(
                                    child: UIData.getTextWidget(
                                        products[index].sku.amount.toString(),
                                        UIData.ff999999,
                                        11),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UIData.fff7f7f7, width: 1.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                    child: UIData.getTextWidget(
                                        "+", UIData.ff999999, 11),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UIData.fff7f7f7, width: 1.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    cartBloc.addSkuAmount(products[index], 1);
                                  });
                                },
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
          ),
          onTap: () {},
        );
      },
    );
  }

  /*
   * 立即下单列表
   */
  void synchorizedCartList(Cart cart) {
    Future<Result> future = CartBridge.syschrizonCart(json.encode(cart));
    future.then((result) {
      if (result.code == 200) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ShopOrderListPage()));
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }
}
