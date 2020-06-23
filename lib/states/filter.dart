import 'package:date_format/date_format.dart';
import 'package:shiyuan/common/UIKit/ColorTheme.dart';
class Filter{
  static saveValue(dynamic obj){
    return obj ?? '';
  }
  static cover(dynamic cover){
    if(!cover) return '';
    if(cover is Map) return cover['src'];
    return cover;
  }
  static fixed2(dynamic num){
    double newNum=double.parse('$num');
    return newNum.toStringAsFixed(2);
  }
  static auditType(String type){
    if(type == 'wait') return '待审核';
    if(type == 'loading') return '审核中';
    if(type == 'done') return '审核通过';
    if(type == 'waring') return '审核失败';
    return type;
  }
  static time(String date){
    DateTime time = DateTime.parse(date);
    return formatDate(time, [yyyy,'-',mm,'-',dd]);
  }
  static timeRefresh(DateTime time){
    return formatDate(time, [hh,':',nn]);
  }
  static checkColor(String status){
    if (status == '已开始') return NormalColor;
    if (status == '超期未执行') return ErrorColor;
    if (status == '已完成') return SuccessColor;
    if (status == '未完成') return WaitingColor;
    return NormalColor;
  }
  static checkStyle(String style){
    if(style == 'STYLE1') return '检查标准 1';
    if(style == 'STYLE2') return '检查标准 3';
    if(style == 'STYLE') return '检查标准 2';
    return '检查标准';
  }
}