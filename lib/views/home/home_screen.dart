import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monitor_sensor/animations/delay_animation.dart';
import 'package:monitor_sensor/configs/values/colors.dart';
import 'package:monitor_sensor/configs/values/custom_icon.dart';
import 'package:monitor_sensor/configs/values/font_size.dart';
import 'package:monitor_sensor/models/nodes.dart';
import 'package:monitor_sensor/provider/helpers/firebase_database_helper.dart';
import 'package:monitor_sensor/provider/singletons/get_it.dart';
import 'package:monitor_sensor/utils/convert_data_util.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Node1 _node1 = Node1();
  Node2 _node2 = Node2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.h,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Mạng cảm biến không dây Zigbee',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp),
              ),
              centerTitle: true,
              background: Stack(
                children: [
                  Image.asset("assets/images/avatar.png"),
                  SafeArea(
                    child: Container(
                      color: Colors.black.withOpacity(0.65),
                      padding:
                          EdgeInsets.symmetric(vertical: 16.w, horizontal: 8.w),
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            'CHUYÊN NGÀNH: HỆ THỐNG NHÚNG VÀ ĐIỀU KHIỂN TỰ ĐỘNG',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                          ),
                          SizedBox(
                            height: 32.w,
                          ),
                          Text(
                            'ĐỒ ÁN TỐT NGHIỆP',
                            style: Theme.of(context).textTheme.title!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.sp,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Text(
                            'Sinh viên: Mai Thị Hương Giang',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Text(
                            'Mã sinh viên: DT010210',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DelayedAnimation(
                delay: 200,
                offset: Offset(0, -0.36),
                child: Text(
                  'NODE 1',
                  style: Theme.of(context).primaryTextTheme.title!.copyWith(
                      fontSize: ScreenUtil().setSp(fzSubTitle),
                      color: primaryDark),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(16),
              ),
              StreamBuilder<Event>(
                  stream: locator
                      .get<FirebaseDatabaseHelper>()
                      .appMessagesRef
                      .child('node1')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data?.snapshot.value != null) {
                      final data = ConvertDataUtils.convertDataToNode1(
                          snapshot.data!.snapshot.value);
                      if (data != null) _node1 = data;
                      return _row1(
                          context, _node1.temp ?? 0, _node1.hum ?? 0);
                    }
                    return _row1(context, 0, 0);
                  }),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              DelayedAnimation(
                delay: 200,
                offset: Offset(0, -0.36),
                child: Text(
                  'NODE 2',
                  style: Theme.of(context).primaryTextTheme.title!.copyWith(
                      fontSize: ScreenUtil().setSp(fzSubTitle),
                      color: primaryDark),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(16),
              ),
              StreamBuilder<Event>(
                  stream: locator
                      .get<FirebaseDatabaseHelper>()
                      .appMessagesRef
                      .child('node2')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data?.snapshot.value != null) {
                      final data = ConvertDataUtils.convertDataToNode2(
                          snapshot.data!.snapshot.value);

                      if (data != null) _node2 = data;
                      return _row2(context, _node2);
                    }
                    return _row2(context, Node2());
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _row1(BuildContext context, double temp, int hum) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: DelayedAnimation(
                delay: 300,
                offset: Offset(-0.36, 0),
                child: _itemParamSensor(
                    context, CustomIcon.temp, 'Nhiệt độ', temp, '°C', false)),
          ),
          Expanded(
            child: DelayedAnimation(
                delay: 300,
                offset: Offset(0.36, 0),
                child: _itemParamSensor(
                    context, CustomIcon.water, 'Độ ẩm', hum, '%', false)),
          ),
        ],
      ),
    );
  }

  Widget _row2(BuildContext context, Node2 node2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: DelayedAnimation(
                delay: 300,
                offset: Offset(-0.36, 0),
                child: _itemParamSensor(context, CustomIcon.air, 'CO2',
                    node2.co2 ?? 0, '%', false)),
          ),
          Expanded(
            child: DelayedAnimation(
                delay: 300,
                offset: Offset(0.36, 0),
                child: _itemParamSensor(context, Icons.wb_twighlight, 'Độ sáng',
                    node2.lux ?? 0, '%', false)),
          ),
        ],
      ),
    );
  }

  Widget _itemParamSensor(BuildContext context, IconData icon, String name,
      num param, String measure, bool isAlert) {
    final color = isAlert ? Colors.red : Colors.blue;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          icon,
          color: primary,
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: Theme.of(context).primaryTextTheme.body2!.copyWith(
                    fontSize: ScreenUtil().setSp(fzBody2), color: primary),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    param.toString(),
                    style: Theme.of(context).primaryTextTheme.subhead!.copyWith(
                        fontSize: ScreenUtil().setSp(fzSubHead), color: color),
                  ),
                  Text(
                    measure,
                    style: Theme.of(context).primaryTextTheme.caption!.copyWith(
                        fontSize: ScreenUtil().setSp(fzCaption), color: color),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
