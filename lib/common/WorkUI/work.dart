export 'package:shiyuan/common/WorkUI/WorkInput.dart';
export 'package:shiyuan/common/WorkUI/WorkSelect.dart';
export 'package:shiyuan/common/WorkUI/WorkSelectMust.dart';
export 'package:shiyuan/common/WorkUI/WorkSelectTime.dart';
export 'package:shiyuan/common/WorkUI/WorkTitle.dart';
export 'package:shiyuan/common/WorkUI/WorkTitleWithDelete.dart';
export 'package:shiyuan/common/WorkUI/WorkInputArea.dart';
export 'package:shiyuan/common/WorkUI/WorkImageTitle.dart';
export 'package:shiyuan/common/WorkUI/WorkImageWithMessage.dart';
export 'package:shiyuan/common/WorkUI/WorkChoose.dart';
export 'package:shiyuan/common/WorkUI/WorkFenShu.dart';
export 'package:shiyuan/common/WorkUI/WorkTitleTest.dart';
export 'package:shiyuan/common/WorkUI/WorkTestRadio.dart';
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

import 'package:flutter/cupertino.dart';
import 'package:shiyuan/common/WorkUI/WorkChoose.dart';
import 'package:shiyuan/common/WorkUI/WorkDrop.dart';
import 'package:shiyuan/common/WorkUI/WorkImageUpload.dart';
import 'package:shiyuan/common/WorkUI/WorkImageWithMessage.dart';
import 'package:shiyuan/common/WorkUI/WorkInput.dart';
import 'package:shiyuan/common/WorkUI/WorkSelect.dart';
import 'package:shiyuan/common/WorkUI/WorkSelectTime.dart';

class WorkUtil {
  static Widget getWorkFormWidget(Map params, {BuildContext context, Function onChange, bool must = false, bool enable = true}) {
    switch (params['type']) {
      case 'SELECT':
        {
          String title = params['label'];
          List options = params['options'];
          return WorkDrop(context, title: title, actions: options, must: must, onChange: (value) => onChange(value));
        }
        break;

      case 'INPUT':
        {
          String title = params['label'];
          List options = params['options'];
          return WorkInput(title: title, must: must, enable: enable, onChange: (value) => onChange(value));
        }
        break;
      case 'CInput':
        {
          String name = params['name'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          return WorkInput(title: name, must: must == true ? must : required, enable: !disabled ?? enable, onChange: (value) => onChange(value));
        }
        break;
      case 'CCascade':
        {
          String name = params['name'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          return WorkChoose(title: name, must: required, enable: !disabled, onChange: (value) => onChange(value));
        }
        break;
      case 'CUpload':
        {
          String name = params['name'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          return WorkImageUpload(title: name, must: required, enable: !disabled, onChange: (value) => onChange(value));
        }
        break;
      case 'CDate':
        {
          String name = params['name'];
          bool required = params['config']['required'];
          bool disabled = params['config']['disabled'];
          return WorkSelectTime(title: name, must: required, enable: !disabled, onChange: (value) => onChange(value));
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
