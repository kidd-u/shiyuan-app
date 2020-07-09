import 'package:date_format/date_format.dart';
import 'package:shiyuan/common/UIKit/ColorTheme.dart';
import 'dart:convert' as convert;

class Filter {
  static safeValue(dynamic obj) {
    return obj ?? '';
  }

  static src(Map item) {
    if (item.containsKey('src')) return item['src'];
    if (item.containsKey('url')) return item['url'];
    return '';
  }

  static message(Map item) {
    if (item.containsKey('fileName')) return item['fileName'];
    if (item.containsKey('description')) return item['description'];
    return '';
  }

  static fixed2(dynamic num) {
    double newNum = double.parse('$num');
    return newNum.toStringAsFixed(2);
  }

  static toJson(dynamic obj) {
    return convert.jsonEncode(obj);
  }

  static jsonDeCode(String obj) {
    if (obj == null) {
      return null;
    }
    return convert.jsonDecode(obj);
  }

  /** yyyy-mm-dd */
  static time(String date) {
    if (date == null || date == '') {
      return '';
    }
    DateTime time = DateTime.parse(date);
    return formatDate(time, [yyyy, '-', mm, '-', dd]);
  }

  /** yyyy-mm-dd hh-dd */
  static timeHours(String date) {
    if (date == null || date == '') {
      return '';
    }
    DateTime time = DateTime.parse(date);
    return formatDate(time, [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn]);
  }

  /** DateTime转String */
  static dateToTime(DateTime date) {
//    DateTime time = DateTime.parse(date);
    return formatDate(date, [yyyy, '-', mm, '-', dd]);
  }

  static timeRefresh(DateTime time) {
    return formatDate(time, [hh, ':', nn]);
  }

  static auditType(String type) {
    if (type == 'wait') return '待审核';
    if (type == 'loading') return '审核中';
    if (type == 'done') return '审核通过';
    if (type == 'waring') return '审核失败';
    return type;
  }

  static checkColor(String status) {
    if (status == '已开始') return NormalColor;
    if (status == '已超期') return ErrorColor;
    if (status == '已完成') return SuccessColor;
    if (status == '未完成') return WaitingColor;
    return NormalColor;
  }

  static checkYinHuanColor(String status) {
    if (status == '已完成') return SuccessColor;
    if (status == '待整改') return LoadingColor;
    if (status == '待验收') return NormalColor;
    if (status == '已超期') return ErrorColor;
    if (status == '未完成') return WaitingColor;
    return NormalColor;
  }

  static checkShangJiColor(String status) {
    if (status == '待整改') return LoadingColor;
    if (status == '已完成') return SuccessColor;
    if (status == '待复检') return NormalColor;
    if (status == '已超期') return ErrorColor;
    return NormalColor;
  }

  static checkStyle(String style) {
    if (style.toLowerCase() == 'style1') return '检查标准 1';
    if (style.toLowerCase() == 'style2') return '检查标准 3';
    if (style.toLowerCase() == 'style') return '检查标准 2';
    return '检查标准';
  }
}
