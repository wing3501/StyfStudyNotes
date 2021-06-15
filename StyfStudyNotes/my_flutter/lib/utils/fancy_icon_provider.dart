import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class FancyIcon extends IconData {
  static const Map<String, int> _iconUnicodeDic = {
    "ic_bottombar_zuji": 59261,
    "ic_common_share-filled": 59260,
    "ic_common_jubao": 59259,
    "ic_common_hot-filled": 59258,
    "ic_bottombar_paimaihang_n": 59181,
    "ic_bottombar_jianlou_n": 59188,
    "ic_bottombar_zhonchou_n": 59256,
    "ic_bottombar_pinpaiguan_n": 59257,
    "ic_common_yinhangka": 59255,
    "ic_common_yue": 59254,
    "ic_toast_failed": 59253,
    "ic_fanclub_jiaru": 59246,
    "ic_fanclub_fst": 59249,
    "ic_fanclub_yxq": 59250,
    "ic_fanclub_tequan": 59251,
    "ic_fanclub_tixian": 59252,
    "ic_rzbz_yxhd": 59232,
    "ic_rzbz_dprz": 59234,
    "ic_rzbz_0sxy": 59235,
    "ic_rzbz_bybt": 59236,
    "ic_rzbz_fwbz": 59237,
    "ic_rzbz_jydb": 59238,
    "ic_rzbz_pzhw": 59239,
    "ic_rzbz_qwbz": 59240,
    "ic_rzbz_jsxy": 59241,
    "ic_rzbz_spby": 59242,
    "ic_rzbz_shwy": 59243,
    "ic_rzbz_mfjd": 59244,
    "ic_rzbz_xfbz": 59245,
    "ic_rzbz_rjbp": 59247,
    "ic_rzbz_7x24h": 59248,
    "ic_rz&bz_shwy": 59226,
    "ic_rz&bz_xfbz": 59227,
    "ic_rzbz_aqjy": 59228,
    "ic_rzbz_pmh": 59229,
    "ic_rzbz_grrz": 59230,
    "ic_rzbz_qyrz": 59231,
    "ic_rzbz_bzj": 59233,
    "ic_edit_radiobox_checked-filled": 59225,
    "ic_edit_checkbox_empty": 59218,
    "ic_edit_add": 59219,
    "ic_edit_checkbox_checked-filled": 59220,
    "ic_edit_checkbox_checked-line": 59221,
    "ic_edit_reduce": 59222,
    "ic_edit_radiobox_checked-line": 59223,
    "ic_edit_radiobox_empty": 59224,
    "ic_center_dingdan_daipingjia": 59213,
    "ic_center_dingdan_shouhou": 59214,
    "ic_center_dingdan_daishouhuo": 59215,
    "ic_center_dingdan_daifukuan": 59216,
    "ic_center_dingdan_daifahuo": 59217,
    "ic_bottombar_yuncang_cangpinguan_n": 59207,
    "ic_bottombar_yuncang_cangpinguan_p": 59208,
    "ic_bottombar_yuncang_xuanhuo_n": 59209,
    "ic_bottombar_zuopinpaimai_p": 59210,
    "ic_bottombar_zuopinpaimai_n": 59211,
    "ic_bottombar_yuncang_xuanhuo_p": 59212,
    "ic_bottombar_mingjialu_n": 59205,
    "ic_bottombar_mingjialu_p": 59206,
    "ic_common_add": 59204,
    "ic_common_xtlb": 59203,
    "ic_common_dtlb": 59202,
    "ic_common_chakan": 59201,
    "ic_common_sixin": 59200,
    "ic_common_kefu": 59199,
    "ic_common_sy-off": 59198,
    "ic_common_hot": 59197,
    "ic_common_xpl": 59196,
    "ic_common_bianji": 59195,
    "ic_common_qingchu": 59194,
    "ic_common_sy-on": 59193,
    "ic_common_zhuanzeng": 59192,
    "ic_common_ewm": 59191,
    "ic_common_kulian": 59190,
    "ic_common_@": 59189,
    "ic_common_xiaolian": 59187,
    "ic_common_dingwei": 59186,
    "ic_common_biaoqing": 59185,
    "ic_common_lianxiren": 59184,
    "ic_common_xiazai": 59183,
    "ic_common_ksjp": 59182,
    "ic_common_scgx": 59180,
    "ic_common_shijian": 59179,
    "ic_common_shuaxin": 59178,
    "ic_common_dingdan": 59177,
    "ic_common_yhq": 59176,
    "ic_common_share": 59175,
    "ic_common_pinglun": 59174,
    "ic_common_shoucang_n": 59173,
    "ic_common_dianzan": 59172,
    "ic_common_renzheng": 59171,
    "ic_common_weidou": 59170,
    "ic_common_jgz": 59169,
    "ic_common_copy": 59168,
    "ic_common_live1": 59167,
    "ic_common_delete": 59166,
    "ic_common_gift": 59165,
    "ic_common_saomiao": 59164,
    "ic_common_ygz": 59163,
    "ic_edit_radiobox_checked": 59161,
    "ic_tips_shuoming_filled": 59160,
    "ic_tips_yiwen_line": 59159,
    "ic_tips_yiwen_filled": 59158,
    "ic_tips_jubao_filled": 59157,
    "ic_tips_jinzhi_filled": 59156,
    "ic_tips_jubao_line": 59155,
    "ic_tips_tishi_filled": 59154,
    "ic_tips_tishi_line": 59153,
    "ic_tips_shuoming_line": 59152,
    "ic_tips_jinzhi_line": 59151,
    "ic_direction_down": 59150,
    "ic_direction_up": 59149,
    "ic_direction_back": 59148,
    "ic_direction_arrowdown": 59147,
    "ic_direction_arrowleft": 59146,
    "ic_direction_ arrowup": 59145,
    "ic_direction_caretdown": 59144,
    "ic_direction_arrowright": 59143,
    "ic_direction_caretleft": 59139,
    "ic_direction_caretright": 59138,
    "ic_direction_caretup": 59137,
    "ic_direction_ circledown_filled": 59136,
    "ic_direction_circledown_line": 59135,
    "ic_direction_circleleft_filled": 59134,
    "ic_direction_circleleft_line": 59133,
    "ic_direction_circleright_filled": 59132,
    "ic_direction_circleright_line": 59130,
    "ic_direction_circleup_filled": 59129,
    "ic_direction_circleiup_line": 59128,
    "ic_direction_totop": 59127,
    "ic_bottombar_quguangguang_n": 59126,
    "ic_bottombar_canpai_p": 59124,
    "ic_bottombar_canpai_n": 59123,
    "ic_bottombar_quguangguang_p": 59122,
    "ic_bottombar_jianbao_zhibo_p": 59121,
    "ic_bottombar_jianbao_n": 59120,
    "ic_bottombar_jianbao_zhibo_n": 59119,
    "ic_bottombar_jianbao_p": 59118,
    "ic_bottombar_fenxiang_paipinliebiao_p": 59117,
    "ic_bottombar_fenxiang_paipinliebiao_n": 59116,
    "ic_common_search": 59115,
    "ic_direction_right": 59114,
    "ic_bottombar_huidingbu_p": 59113,
    "ic_common_close": 59111,
    "ic_toast_success": 59110,
    "ic_toast_warn": 59109,
    "ic_toast_sad": 59108,
    "ic_common_shaixuan_n": 59107,
    "ic_common_shaixuan_p": 59106,
    "ic_WeChatnavbar_home": 59105,
    "ic_navbar_search": 59104,
    "ic_navbar_more": 59103,
    "ic_navbar_back": 59102,
    "ic_navbar_share": 59101,
    "ic_navbar_shezhi": 59100,
    "ic_navbar_xiaoxi": 59099,
    "ic_navbar_saoma": 59098,
    "ic_navbar_shuaxin": 59097,
    "ic_navbar_shoucang_n": 59096,
    "ic_navbar_shoucang_p": 59095,
    "ic_bottombar_shouye_n": 59094,
    "ic_bottombar_shouye_p": 59093,
    "ic_bottombar_fenlei_n": 59092,
    "ic_bottombar_fenlei_p": 59091,
    "ic_bottombar_zhibo_n": 59090,
    "ic_bottombar_zhibo_p": 59089,
    "ic_bottombar_xiaoxi_n": 59088,
    "ic_bottombar_xiaoxi_p": 59087,
    "ic_bottombar_wo_n": 59086,
    "ic_bottombar_wo_p": 59085,
    "ic_bottombar_lianxishangjia_n": 59084,
    "ic_bottombar_lianxishangjia_p": 59083,
    "ic_bottombar_dianpu_n": 59082,
    "ic_bottombar_dianpu_p": 59081,
    "ic_bottombar_shequ_n": 59080,
    "ic_bottombar_shequ_p": 59079,
    "ic_bottombar_weiguan_n": 59078,
    "ic_bottombar_weiguan_p": 59077,
    "ic_bottombar_paipinliebiao_n": 59076,
    "ic_bottombar_paipinliebiao_p": 59075,
    "ic_bottombar_tixing_n": 59074,
    "ic_bottombar_tixing_p": 59073,
    "ic_bottombar_canpaixuzhi_n": 59072,
    "ic_bottombar_canpaixuzhi_p": 59071,
    "ic_bottombar_publish_n": 59070,
    "ic_bottombar_publish_p": 59069,
    "ic_bottombar_administer_n": 59068,
    "ic_bottombar_administer_p": 59067,
    "ic_bottombar_upload_n": 59066,
    "ic_bottombar_upload_p": 59065,
    "ic_bottombar_hemai_n": 59064,
    "ic_bottombar_hemai_p": 59063,
    "ic_bottombar_order_n": 59062,
    "ic_bottombar_order_p": 59061,
    "ic_bottombar_talk_n": 59060,
    "ic_bottombar_talk_p": 59059,
  };

  final String iconName;

  FancyIcon(this.iconName)
      : super(
          unicode(iconName),
          fontFamily: "fancy-font",
        );

  static int unicode(String iconName) {
    return _iconUnicodeDic[iconName];
  }

  /// 读取iconfont的json文件
  static Future _readJsonDataIfNeeded() async {
    if (_iconUnicodeDic.isEmpty) {
      final jsonString =
          await rootBundle.loadString("assets/data/fancy-font.json");
      final result = json.decode(jsonString) as Map;
      final list = result["glyphs"];
      for (var itemMap in list) {
        _iconUnicodeDic[itemMap["name"]] = itemMap["unicode_decimal"];
      }
    }
  }

  /// 从json文件提取iconfont名字和unicode
  static void createIconDataFile() async {
    await _readJsonDataIfNeeded();

    var writeData = "";
    _iconUnicodeDic.forEach((key, value) {
      writeData += "\"$key\":$value,";
    });

    var dir = Directory.current.path; //当前项目路径
    var filePath = join(dir, "Users", 'styf', 'Downloads',
        "fancy_icon_const.dart"); //使用path拼接路径
    var file = File(filePath);
    if (!await file.exists()) {
      //如果文件不存在
      file.create(recursive: true); //就递归创建
    }

    IOSink fileSink = file.openWrite(); //sink
    fileSink.write(writeData);
    fileSink.close(); //关闭
  }
}
