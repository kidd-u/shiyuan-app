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
    return formatDate(time, [yyyy, '-', mm, '-', dd, '  ', HH, ':', nn]);
  }

  /** DateTime转String */
  static dateToTime(DateTime date) {
//    DateTime time = DateTime.parse(date);
    return formatDate(date, [yyyy, '-', mm, '-', dd]);
  }

  static timeRefresh(DateTime time) {
    return formatDate(time, [HH, ':', nn]);
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
    if (status == '待审核') return LoadingColor;
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
  static typeToString(String type){
  // C 通用
    if (type == 'C_INIT') return '表单提交';
    if (type == 'C_WAIT_START') return '等待流程开始';
    if (type == 'C_WAIT_END') return '等待流程结束';
    if (type == 'C_STATS') return '培训记录统计';
    if (type == 'C_REJECT') return '审核未通过';
  // SC 安全检查
    if (type == 'SC_TEMP_CHECK') return '临时检查';
    if (type == 'SC_PERIOD_START') return '定期检查';
  // DE 隐患整改
  if (type == 'DE_RECTIFY') return '隐患整改';
  if (type == 'DE_ACCEPTANCE') return '隐患验收';
  if (type == 'DE_ARCHIVE') return '隐患数据存档';
  // LC 上级检查
    if (type == 'LC_RECTIFY') return '上级检查整改';
    if (type == 'LC_ACCEPTANCE') return '上级检查验收';
  // WK 作业
    if (type == 'WK_AUDIT') return '作业审核';
    if (type == 'WK_END') return '作业结束';
    if (type == 'WK_LEADER_AUDIT') return '作业申请审核';
    if (type == 'WK_SUPERVISE') return '作业监管';
  // FC 线下培训 | 安全会务
    if (type == 'FC_AUDIT') return '培训审核';
    if (type == 'FC_START') return '培训开始';
    if (type == 'FC_END') return '培训结束';
    if (type == 'FC_SIGN') return '培训签到';
    if (type == 'FC_UPLOAD') return '培训上传记录';
  // OC 线上培训
    if (type == 'OC_AUDIT') return '在线培训审核';
    if (type == 'OC_CLASS') return '在线培训';
    if (type == 'OC_TEST') return '在线考试';
  }
}
