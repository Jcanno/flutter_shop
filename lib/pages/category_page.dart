import 'package:flutter/material.dart';
import '../api/category.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/child_category.dart';
import '../provide/cagegory_goods_list.dart';
import 'package:provider/provider.dart';
import '../model/categoryGoodsList.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                Expanded(
                  child: CategoryGoodsList(),
                )
                // CategoryGoodsList()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  LeftCategoryNav({Key key}) : super(key: key);

  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List list = [];
  int listIndex = 0;

  void _getGoodsList({String categoryId }) async {
    var params = {
      'categoryId': categoryId == null ? '' : categoryId,
      'categorySubId': '',
      'page': 1
    };
    
    var res = await getMallGoods(params);
    var data = json.decode(res.toString());
    CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
    Provider.of<CategoryGoodsListProvider>(context, listen: false).setGoodsList(goodsList.data);
  }

  Widget _leftInkWell(index) {
    bool isClick = false;
    isClick = index == listIndex ? true : false;
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provider.of<ChildCategory>(context, listen: false).setChildCategory(childList, categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border( 
            bottom: BorderSide(
              width: 1,
              color: Colors.black12
            )
          )
        ),
        child: Text(list[index].mallCategoryName),
      ),
    );
  }

  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  void _getCategory() async {
    var res = await getCategory();
    Map<String, dynamic> data = json.decode(res.toString());
    CategoryListModel category = CategoryListModel.fromJson(data);
    setState(() {
      list = category.data;
      Provider.of<ChildCategory>(context, listen: false).setChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
      // _getGoodsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
          return _leftInkWell(index);
        },
      ),
    );
  }
}

class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
      child: Consumer<ChildCategory>(
        builder: (context, childCategory, child) {
          return ListView.builder(
            itemCount: childCategory.childCategoryList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              return _rightInkWell(index, childCategory.childCategoryList[index]);
            },
          );
        }
      )
    );
  }

  Widget _rightInkWell(index, item) {
    bool isClick = false;
    int childIndex = Provider.of<ChildCategory>(context, listen: false).childIndex;
    isClick = index == childIndex ? true : false;
    return InkWell(
      onTap: (){
        Provider.of<ChildCategory>(context, listen: false).setChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(25), 
            color: isClick ? Colors.pink : Colors.black
          ),
        ),
      ),
    );
  }

  void _getGoodsList(String categorySubId) async {
    var params = {
      'categoryId': Provider.of<ChildCategory>(context, listen: false).categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };
    
    var res = await getMallGoods(params);
    var data = json.decode(res.toString());
    CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
    if(goodsList.data == null) {
      Provider.of<CategoryGoodsListProvider>(context, listen: false).setGoodsList([]);
    }else {
      Provider.of<CategoryGoodsListProvider>(context, listen: false).setGoodsList(goodsList.data);
    }
  }
}

class CategoryGoodsList extends StatefulWidget {
  CategoryGoodsList({Key key}) : super(key: key);

  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _getGoodsList() async {
    Provider.of<ChildCategory>(context, listen: false).addPage();

    var params = {
      'categoryId': Provider.of<ChildCategory>(context, listen: false).categoryId,
      'categorySubId': Provider.of<ChildCategory>(context, listen: false).categorySubId,
      'page': Provider.of<ChildCategory>(context, listen: false).page
    };
    
    var res = await getMallGoods(params);
    var data = json.decode(res.toString());
    CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
    if(goodsList.data == null) {
      Fluttertoast.showToast(
        msg: '已经到底了',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: 16.0
      );
      Provider.of<ChildCategory>(context, listen: false).changeNoMore('没有更多了');
    }else {
      Provider.of<CategoryGoodsListProvider>(context, listen: false).setMoreGoodsList(goodsList.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(570),
      child: Consumer<CategoryGoodsListProvider>(
        builder: (context, categoryGoodsList, child) {
          try {
            if(Provider.of<ChildCategory>(context, listen: false).page == 1) {
              scrollController.jumpTo(0.0);
            }
          } catch (e) {
          }
          if(categoryGoodsList.goodsList.length > 0) {
            return EasyRefresh(
              footer: ClassicalFooter(
                bgColor: Colors.white,
                textColor: Colors.pink,
                noMoreText: Provider.of<ChildCategory>(context, listen: false).noMoreText,
                loadReadyText: '上拉加载',
                showInfo: true,
                loadingText: '加载中...',
                infoText: '',
                loadedText: '加载完成'
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: categoryGoodsList.goodsList.length,
                itemBuilder: (context, index) {
                  return _goodsItem(categoryGoodsList.goodsList, index);
                }
              ),
              onLoad: () async{
                print('上拉加载');
                _getGoodsList();
              } ,
            );
            
          }else {
            return Center(
              child: Text('暂无数据'),
            );
          }
        }
      )
    );
  }

  Widget _goodsImage(list, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName(list, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(25)),
      ),
    );
  }

  Widget _goodsPrice(list, index) {
    return Container(
      margin: EdgeInsets.only(top: 20) ,
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格: ￥${list[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(26)
            ),
          ),
          Text(
            '￥${list[index].oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough
            ),
          )
        ],
      ),
    );
  }

  Widget _goodsItem(list, index) {
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.black12
            )
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(list, index),
            Column(
              children: <Widget>[
                _goodsName(list, index),
                _goodsPrice(list, index) 
              ],
            )
          ],
        ),
      ),
    );
  }
}

