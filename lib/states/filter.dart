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
    time = time.toLocal();
    String t = time.year.toString() + '-' + time.month.toString() + '-' + time.day.toString();
    return t;
  }
}