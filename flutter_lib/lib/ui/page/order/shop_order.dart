import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/order_bridge.dart';
import 'package:flutter_lib/logic/bloc/address_bloc.dart';
import 'package:flutter_lib/logic/bloc/cart_bloc.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/cart.dart';
import 'package:flutter_lib/model/order_result.dart';
import 'package:flutter_lib/model/ordergoods.dart';
import 'package:flutter_lib/ui/page/address/add_edit_address.dart';
import 'package:flutter_lib/ui/page/address/address_list.dart';
import 'package:flutter_lib/ui/widgets/common_dialogs.dart';
import 'package:flutter_lib/ui/widgets/error_status_widget.dart';
import 'package:flutter_lib/utils/BristuaRouter.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ShopOrderListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopOrderListState();
  }
}

class _ShopOrderListState extends State<ShopOrderListPage> {
  double deliverPrice = 0;
  CartBloc cartBloc = CartBloc();
  AddressBloc addressBloc = AddressBloc();

  String userAddressId;

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
//    ));

    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text(
          "提交订单",
          style: TextStyle(color: UIData.ff353535, fontSize: 18),
        ),
        elevation: 0,
        leading: new IconButton(
          icon: Icon(Icons.arrow_back_ios, color: UIData.ff353535),
          color: UIData.fff,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: bodyData(),
    );
  }

  Widget bodyData() {
    print("立即下单即加入购物车，之后从购物车中读取出来");
    cartBloc.findOrderNow();
    return StreamBuilder<Cart>(
        stream: cartBloc.productItems,
        builder: (context, snapshot) {
          Cart cart = snapshot.data;
          if (snapshot.hasError) {
            Result result = snapshot.error;
            return ErrorStatusWidget.order(result.code, result.msg, "点击重试", () {
              cartBloc.findOrderNow();
            });
          } else if (snapshot.hasData) {
            if (cart == null) {
              return ErrorStatusWidget.order(0, "没有数据", "点击重试", () {
                cartBloc.findOrderNow();
              });
            } else {
              return buildBody(cart);
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Container buildBody(Cart cart) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 50,
            left: 10,
            right: 10,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      buildHeaderBody(),
                    ],
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 111,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => buildListIItem(cart.products[index]),
                    childCount: (cart == null || cart.products == null)
                        ? 0
                        : cart.products.length,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      buildDeliverPrive(cart),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        child: Text(
                          "合计",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 15),
                        ),
                        padding: EdgeInsets.fromLTRB(13, 13, 8, 13),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            child: Text(
                              "￥" + cart.totalMoney.toStringAsFixed(2),
                              style: TextStyle(
                                  color: UIData.fffa4848, fontSize: 18),
                            ),
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: UIData.getShapeButton(
                        UIData.fffa4848, UIData.fff, 90, 33, "提交订单", 15, 0, () {
                      List<OrderGoods> orderGoodses = cart.products
                          .map(
                            (sku) => new OrderGoods(
                                  sku.sku.productId,
                                  sku.sku.amount.toString(),
                                  sku.goodsId,
                                ),
                          )
                          .toList();

                      var orders =
                          orderGoodses.map((f) => (f.toJson())).toList();

                      if (userAddressId != null && userAddressId.isNotEmpty) {
                        Future<Result> future = OrderBridge.submitOrder(
                            userAddressId, true, orders);
                        future.then((result) {
                          if (result.code == 200) {
                            if (result.data == null) {
                              Bridge.showLongToast("订单号获取失败");
                              return;
                            }
                            //清除订单的下单数据
                            cartBloc.clearOrderNow();
                            showPayDialog(context, cart.totalMoney,
                                OrderResult.fromJson(result.data).orderId, "");
                          } else {
                            if (result.code == 401) {
                              BristuaRouter.routerUserLogin(context);
                            } else {
                              Bridge.showLongToast(result.msg);
                            }
                          }
                        });
                      } else {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new AddressListPage()));
                      }
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

  GestureDetector buildListIItem(SkuWapper sku) {
    CartProduct cartProduct = sku.sku;
    String name = (cartProduct.name != null) ? cartProduct.name : "";
    String price = "￥" +
        ((cartProduct.price != null)
            ? cartProduct.price.toStringAsFixed(2)
            : "0.00");

    return GestureDetector(
      child: Container(
        child: Card(
          color: UIData.fff,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16, 15, 0, 16),
                child: UIData.getImageWithWHFit(
                  cartProduct.img,
                  BoxFit.cover,
                  88,
                  88,
                ),
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
                          style:
                              TextStyle(fontSize: 12, color: UIData.ff353535),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis),
                    ),
//                    Padding(
//                      padding: EdgeInsets.fromLTRB(12, 0, 13, 0),
//                      child: Container(
//                          height: 18,
//                          width: 92,
//                          decoration: BoxDecoration(
//                              color: UIData.fff7f7f7,
//                              shape: BoxShape.rectangle,
//                              borderRadius: BorderRadius.circular(3)),
//                          child: Center(
//                            child:
//                                UIData.getTextWidget(name, UIData.ff999999, 11),
//                          )),
//                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 6, 15, 17),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              price,
                              style: TextStyle(
                                  color: UIData.fffa4848, fontSize: 15),
                            ),
                          ),
//                          GestureDetector(
//                            child: Container(
//                              width: 20,
//                              height: 20,
//                              child: Center(
//                                child: UIData.getTextWidget(
//                                    "-", UIData.ff999999, 11),
//                              ),
//                              decoration: BoxDecoration(
//                                border: Border.all(
//                                    color: UIData.fff7f7f7, width: 1.0),
//                                shape: BoxShape.rectangle,
//                              ),
//                            ),
//                            onTap: () {
//                              cartBloc.del2Cart(sku, 1);
//                            },
//                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                            child: UIData.getTextWidget(
                                "x " + cartProduct.amount.toString(),
                                UIData.ff999999,
                                11),
                          ),
//                          GestureDetector(
//                            child: Container(
//                              width: 20,
//                              height: 20,
//                              child: Center(
//                                child: UIData.getTextWidget(
//                                    "+", UIData.ff999999, 11),
//                              ),
//                              decoration: BoxDecoration(
//                                border: Border.all(
//                                    color: UIData.fff7f7f7, width: 1.0),
//                                shape: BoxShape.rectangle,
//                              ),
//                            ),
//                            onTap: () {
//                              cartBloc.addSkuAmount(sku, 1);
//                            },
//                          ),
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
  }

  Widget buildHeaderBody() {
    addressBloc.getAddressList(context);
    return StreamBuilder<List<Address>>(
        stream: addressBloc.productItems,
        builder: (context, snapshot) {
          Address address = (snapshot.data != null && snapshot.data.length > 0)
              ? snapshot.data[0]
              : null;
          return snapshot.hasData
              ? buildHeader(address)
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget buildHeader(Address address) {
    if (address != null) {
      userAddressId = address.userAddressId;
    }
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: address == null
              ? Text(
                  "添加地址",
                  style: TextStyle(color: UIData.ff353535, fontSize: 13),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.my_location,
                      color: UIData.fffa4848,
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            address.name + address.phone,
                            style:
                                TextStyle(color: UIData.ff353535, fontSize: 13),
                          ),
                          Text(
                            address.address,
                            style:
                                TextStyle(color: UIData.ff999999, fontSize: 12),
                          ),
                        ],
                      ),
                    )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: UIData.ff999999,
                    ),
                  ],
                ),
        ),
      ),
      onTap: () {
        if (address == null) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new AddAddressListPage(null)));
        } else {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new AddressListPage()));
        }
      },
    );
  }

  Widget buildDeliverPrive(Cart cart) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(13, 13, 10, 10),
                    child: Text(
                      "商品小计",
                      style: TextStyle(color: UIData.ff353535, fontSize: 12),
                    ),
                  ),
                  Padding(
                    child: Text(
                      "￥" + cart.totalMoney.toStringAsFixed(2),
                      style: TextStyle(color: UIData.fffa4848, fontSize: 18),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(13, 13, 10, 10),
                    child: Text(
                      "运费",
                      style: TextStyle(color: UIData.ff353535, fontSize: 12),
                    ),
                  ),
                  Padding(
                    child: Text(
                      "￥" + deliverPrice.toStringAsFixed(2),
                      style: TextStyle(color: UIData.fffa4848, fontSize: 18),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
