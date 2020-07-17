export 'package:shiyuan/common/WorkUI/WorkInput.dart';
export 'package:shiyuan/common/WorkUI/WorkSelect.dart';
export 'package:shiyuan/common/WorkUI/WorkSelectMust.dart';
export 'package:shiyuan/common/WorkUI/WorkSelectTime.dart';
export 'package:shiyuan/common/WorkUI/WorkSelectTimeRange.dart';
export 'package:shiyuan/common/WorkUI/WorkTitle.dart';
export 'package:shiyuan/common/WorkUI/WorkTitleWithDelete.dart';
export 'package:shiyuan/common/WorkUI/WorkInputArea.dart';
export 'package:shiyuan/common/WorkUI/WorkImageTitle.dart';
export 'package:shiyuan/common/WorkUI/WorkImageWithMessage.dart';
export 'package:shiyuan/common/WorkUI/WorkChoose.dart';
export 'package:shiyuan/common/WorkUI/WorkFenShu.dart';
export 'package:shiyuan/common/WorkUI/WorkTitleTest.dart';
export 'package:shiyuan/common/WorkUI/WorkTestRadio.dart';
export 'package:shiyuan/common/WorkUI/WorkTestRadioMore.dart';
export 'package:shiyuan/common/WorkUI/WorkTestRadioTof.dart';
export 'package:shiyuan/common/WorkUI/WorkTestRadioAnswer.dart';
export 'package:shiyuan/common/WorkUI/WorkTestLastBtn.dart';
export 'package:shiyuan/common/WorkUI/WorkTestNextBtn.dart';
export 'package:shiyuan/common/WorkUI/WorkButtonCancel.dart';
export 'package:shiyuan/common/WorkUI/WorkButtonDone.dart';
export 'package:shiyuan/common/WorkUI/WorkFile.dart';
export 'package:shiyuan/common/WorkUI/WorkNormal.dart';
export 'package:shiyuan/common/WorkUI/WorkRadio.dart';
export 'package:shiyuan/common/WorkUI/WorkEmpty.dart';
export 'package:shiyuan/common/WorkUI/WorkDrop.dart';
export 'package:shiyuan/common/WorkUI/WorkYinhuanTitle.dart';
export 'package:shiyuan/common/WorkUI/WorkImageUpload.dart';
export 'package:shiyuan/common/WorkUI/WorkYinHuanCell.dart';
export 'package:shiyuan/common/WorkUI/WorkWorkPeoples.dart';

import 'package:flutter/cupertino.dart';
import 'package:shiyuan/common/WorkUI/WorkChoose.dart';
import 'package:shiyuan/common/WorkUI/WorkDrop.dart';
import 'package:shiyuan/common/WorkUI/WorkImageUpload.dart';
import 'package:shiyuan/common/WorkUI/WorkImageWithMessage.dart';
import 'package:shiyuan/common/WorkUI/WorkInput.dart';
import 'package:shiyuan/common/WorkUI/WorkInputArea.dart';
import 'package:shiyuan/common/WorkUI/WorkSelect.dart';
import 'package:shiyuan/common/WorkUI/WorkSelectTime.dart';
import 'package:shiyuan/common/WorkUI/WorkSelectTimeRange.dart';
import 'package:shiyuan/common/WorkUI/WorkWorkPeoples.dart';
import 'package:shiyuan/states/default.dart';

///未能统一，因为不同的流程返回的格式还是有差别，还是需要单独判断，参考YinhuanAdd,homeworkCheck,yinhuanDetail,homeworkApply
class WorkUtil {
  static Widget getWorkFormWidget(Map params, {BuildContext context, Function onChange, bool must = false, bool enable = true}) {
    switch (params['type']) {
      case 'SELECT':
        {
          String title = params['label'];
          String value = params['value'];
          List options = params['options']??[];
          return WorkDrop(context, title: title,value: value, actions: options, must: must, onChange: (value) => onChange(value));
        }
        break;

      case 'INPUT':
        {
          String title = params['label'];
          String value = params['value'];
          List options = params['options'];
          return WorkInput(title: title,value: value, must: must, enable: enable, onChange: (value) => onChange(value));
        }
        break;
      case 'CInput':
        {
          String name = params['name'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          String type = params['config']['type'];
          String label = params['label'];
          if (type == 'TEXTAREA') {
            return WorkInputArea(
                title: name,value: label, must: must == true ? must : required, enable: !disabled ?? enable, onChange: (value) => onChange(value));
          }
          if (disabled) {
            return WorkSelect(title: name, value: label);
          }
          return WorkInput(title: name,value: label, must: must == true ? must : required, enable: !disabled ?? enable, onChange: (value) => onChange(value));
        }
        break;
      case 'CCascade':
        {
          String name = params['name'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          bool isPeople = params['config']['store'] == 'ACCOUNT';
          String label = params['label'];
          if (disabled) {
            return WorkSelect(title: name, value: label);
          }
          return WorkChoose(
            title: name,
            value: label,
            isPeople: isPeople,
            must: required,
            enable: !disabled,
            onChange: (value) => onChange({'value': value['id'], 'label': value['name']}),
          );
        }
        break;
      case 'CUpload':
        {
          String name = params['name'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          var label = params['label'];
          if (disabled) {
            return WorkSelect(title: name, value: label);
          }
          return WorkImageUpload(title: name,value: Filter.jsonDeCode(label), must: required, enable: !disabled, onChange: (value) => onChange(value));
        }
        break;
      case 'CUploadImage':
        {
          String name = params['name'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          var label = params['label'];
          if (disabled) {
            return WorkSelect(title: name, value: label);
          }
          return WorkImageUpload(title: name,value: Filter.jsonDeCode(label), must: required, enable: !disabled, onChange: (value) => onChange(value));
        }
        break;
      case 'CDate':
        {
          String name = params['name'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          String label = params['label'];
          String type=params['config']['type'];
          if (disabled) {
            return WorkSelect(title: name, value: label);
          }
          if (type == 'DATERANGE') {
            int max=params['config']['max'];
            return WorkSelectTimeRange(title: name,value: label, max: max,must: required, enable: !disabled, onChange: (value) => onChange(value));
          }  
          return WorkSelectTime(title: name,value: label, must: required, enable: !disabled, onChange: (value) => onChange(value));
        }
        break;
      case 'CWork':
        {
          String name = params['name'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          var label = params['label'];
          return WorkWorkPeoples(value: Filter.jsonDeCode(label)??[], must: required, enable: !disabled, onChange: (value) => onChange(value));
        }
        break;

      default:
        {
          String name = params['name'] ?? params['label'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          return WorkInput(title: name, must: must, enable: enable, onChange: (value) => onChange(value));
        }
        break;
    }
  }
}
