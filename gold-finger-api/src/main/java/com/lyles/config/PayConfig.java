package com.lyles.config;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public final class PayConfig {
    private PayConfig() {}

    private static final Map<Integer, ServiceConfig> SERVICES_INTERNAL = new LinkedHashMap<>();
    private static final Map<Integer, DianboConfig> DIANBO_INTERNAL = new LinkedHashMap<>();
    private static final Map<Integer, String> DBKF_INTERNAL = new LinkedHashMap<>();
    private static final Map<Integer, String> SERVICE_TIME_TYPES_INTERNAL = new LinkedHashMap<>();
    private static final Map<Integer, ServiceGroup> SERVICE_GROUPS_INTERNAL = new LinkedHashMap<>();

    public static final Map<Integer, ServiceConfig> SERVICES;
    public static final Map<Integer, DianboConfig> DIANBO;
    public static final Map<Integer, String> DBKF;
    public static final Map<Integer, String> SERVICE_TIME_TYPES;
    public static final Map<Integer, ServiceGroup> SERVICE_GROUPS;

    public static final List<Integer> SJB;
    public static final List<Integer> JPTJ;
    public static final List<Integer> APP;
    public static final List<Integer> JCLMS;

    static {
        service(1).setIntro("胜负彩、任选九、进球彩及半全场四个彩种的特色栏目临场数据及推介，一般于彩票截售当天下午3点左右上线。");

        service(2).setName("金手指标准(电子)版");
        service(2).setMoney(360);
        service(2).setTimeType(3);
        service(2).setEnabled(false);
        service(2).setSmsEnabled(false);
        service(2).setIntro("《足彩金手指》电子版于周一下午至周四下午逐步更新。");

        service(41).setName("金手指日报(1200元/年)");
        service(41).setMoney(180);
        service(41).setTimeType(4);
        service(41).setEnabled(true);
        service(41).setIntro("<span style=\"color:red;\">分一季度（180）、半年（360）两种定制方式。</span>《金手指日报》每日提供传统足彩、竞彩足球、竞彩篮球、北京单场，四大彩种的比赛数据、盘口、赔率分析！");
        service(41).setSmsEnabled(false);

        service(59).setName("竞彩日报(988元/月)");
        service(59).setMoney(988);
        service(59).setTimeType(2);
        service(59).setEnabled(true);
        service(59).setIntro("<span style=\"color:red;\">分一季度（2800）、半年（5500）、一年（9800）两种定制方式。</span>《竞彩日报》每日提供竞彩足球比赛数据、盘口、赔率分析！");
        service(59).setSmsEnabled(false);

        service(42).setName("本站推荐");
        service(42).setMoney(1298);
        service(42).setTimeType(2);
        service(42).setEnabled(true);
        service(42).setIntro("<span style=\"color:red;\">方式一：包月订阅1888元/月，8月打7折销售1298元/月；方式二：点击收费88元/场，8月打7折销售60元/场");
        service(42).setSmsEnabled(false);

        service(8).setName("短信包月增值服务");
        service(8).setMoney(5);
        service(8).setTimeType(2);
        service(8).setIntro("短信包月增值服务需要在真实资料里面填写正确的手机号码(暂不支持小灵通)!");
        service(8).setEnabled(true);

        service(9).setName("彩票指南电子版(998元/年)");
        service(9).setMoney(300);
        service(9).setTimeType(3);
        service(9).setEnabled(true);
        service(9).setSmsEnabled(false);
        service(9).setIntro("《彩票指南》周一红版、周三绿版和周五蓝版三期报纸，一般于前一天晚上21点左右上线。");

        service(10).setName("彩票指南临场");
        service(10).setMoney(50);
        service(10).setTimeType(2);
        service(10).setEnabled(false);

        service(11).setName("双色球杨凯推荐");
        service(11).setMoney(500);
        service(11).setTimeType(2);
        service(11).setEnabled(true);
        service(11).setSmsEnabled(false);

        service(12).setName("双色球财哥推荐");
        service(12).setMoney(500);
        service(12).setTimeType(2);
        service(12).setEnabled(true);
        service(12).setSmsEnabled(false);

        service(13).setName("双色球汪怜花推荐");
        service(13).setMoney(500);
        service(13).setTimeType(2);
        service(13).setEnabled(true);
        service(13).setSmsEnabled(false);

        service(29).setName("双色球神算子推荐");
        service(29).setMoney(500);
        service(29).setTimeType(2);
        service(29).setEnabled(true);
        service(29).setSmsEnabled(false);

        service(30).setName("双色球无极推荐");
        service(30).setMoney(500);
        service(30).setTimeType(2);
        service(30).setEnabled(true);
        service(30).setSmsEnabled(false);

        service(31).setName("双色球王鹏推荐");
        service(31).setMoney(500);
        service(31).setTimeType(2);
        service(31).setEnabled(true);
        service(31).setSmsEnabled(false);

        service(32).setName("双色球薛朝云推荐");
        service(32).setMoney(500);
        service(32).setTimeType(2);
        service(32).setEnabled(true);
        service(32).setSmsEnabled(false);

        service(33).setName("双色球周嘉鱼推荐");
        service(33).setMoney(500);
        service(33).setTimeType(2);
        service(33).setEnabled(true);
        service(33).setSmsEnabled(false);

        service(14).setName("3D三哥推荐");
        service(14).setMoney(500);
        service(14).setTimeType(2);
        service(14).setEnabled(true);
        service(14).setSmsEnabled(false);

        service(15).setName("3D邓明推荐");
        service(15).setMoney(500);
        service(15).setTimeType(2);
        service(15).setEnabled(true);
        service(15).setSmsEnabled(false);

        service(16).setName("3D江华推荐");
        service(16).setMoney(500);
        service(16).setTimeType(2);
        service(16).setEnabled(true);
        service(16).setSmsEnabled(false);

        service(34).setName("3D金鑫推荐");
        service(34).setMoney(500);
        service(34).setTimeType(2);
        service(34).setEnabled(true);
        service(34).setSmsEnabled(false);

        service(35).setName("3D白石推荐");
        service(35).setMoney(500);
        service(35).setTimeType(2);
        service(35).setEnabled(true);
        service(35).setSmsEnabled(false);

        service(36).setName("3D亦真推荐");
        service(36).setMoney(500);
        service(36).setTimeType(2);
        service(36).setEnabled(true);
        service(36).setSmsEnabled(false);

        service(39).setName("3D边城推荐");
        service(39).setMoney(500);
        service(39).setTimeType(2);
        service(39).setEnabled(true);
        service(39).setSmsEnabled(false);

        service(81).setName("3D单挑一注");
        service(81).setMoney(500);
        service(81).setTimeType(2);
        service(81).setEnabled(true);
        service(81).setSmsEnabled(false);

        service(84).setName("3D定位胆码");
        service(84).setMoney(500);
        service(84).setTimeType(2);
        service(84).setEnabled(true);
        service(84).setSmsEnabled(false);

        service(85).setName("3D财哥推荐");
        service(85).setMoney(500);
        service(85).setTimeType(2);
        service(85).setEnabled(true);
        service(85).setSmsEnabled(false);

        service(86).setName("3D周嘉鱼推荐");
        service(86).setMoney(500);
        service(86).setTimeType(2);
        service(86).setEnabled(true);
        service(86).setSmsEnabled(false);

        service(87).setName("3D三哥和值跨度推荐");
        service(87).setMoney(500);
        service(87).setTimeType(2);
        service(87).setEnabled(true);
        service(87).setSmsEnabled(false);

        service(17).setName("排列三财哥推荐");
        service(17).setMoney(500);
        service(17).setTimeType(2);
        service(17).setEnabled(true);
        service(17).setSmsEnabled(false);

        service(18).setName("排列三周嘉鱼推荐");
        service(18).setMoney(500);
        service(18).setTimeType(2);
        service(18).setEnabled(true);
        service(18).setSmsEnabled(false);

        service(19).setName("排列三白石推荐");
        service(19).setMoney(500);
        service(19).setTimeType(2);
        service(19).setEnabled(true);
        service(19).setSmsEnabled(false);

        service(28).setName("排列三三哥推荐");
        service(28).setMoney(500);
        service(28).setTimeType(2);
        service(28).setEnabled(true);
        service(28).setSmsEnabled(false);

        service(37).setName("排列三王鹏推荐");
        service(37).setMoney(500);
        service(37).setTimeType(2);
        service(37).setEnabled(true);
        service(37).setSmsEnabled(false);

        service(38).setName("排列三江华推荐");
        service(38).setMoney(500);
        service(38).setTimeType(2);
        service(38).setEnabled(true);
        service(38).setSmsEnabled(false);

        service(82).setName("排列三定位胆码");
        service(82).setMoney(500);
        service(82).setTimeType(2);
        service(82).setEnabled(true);
        service(82).setSmsEnabled(false);

        service(83).setName("排列三单挑一注");
        service(83).setMoney(500);
        service(83).setTimeType(2);
        service(83).setEnabled(true);
        service(83).setSmsEnabled(false);

        service(20).setName("大乐透杨凯推荐");
        service(20).setMoney(500);
        service(20).setTimeType(2);
        service(20).setEnabled(true);
        service(20).setSmsEnabled(false);

        service(21).setName("七星彩周嘉鱼推荐");
        service(21).setMoney(500);
        service(21).setTimeType(2);
        service(21).setEnabled(true);
        service(21).setSmsEnabled(false);

        service(22).setName("七乐彩亦真推荐");
        service(22).setMoney(500);
        service(22).setTimeType(2);
        service(22).setEnabled(true);
        service(22).setSmsEnabled(false);

        service(23).setName("大乐透定位推荐（小康）");
        service(23).setMoney(500);
        service(23).setTimeType(2);
        service(23).setEnabled(true);
        service(23).setSmsEnabled(false);

        service(24).setName("诸葛生肖五行配");
        service(24).setMoney(500);
        service(24).setTimeType(2);
        service(24).setEnabled(true);
        service(24).setSmsEnabled(false);

        service(25).setName("李飞排列五");

        service(303).setName("竞彩过关串");
        service(303).setMoney(1298);
        service(303).setTimeType(2);
        service(303).setEnabled(true);
        service(303).setSmsEnabled(true);

        service(197030).setName("金手指头条");
        service(197030).setMoney(1);
        service(197030).setTimeType(5);
        service(197030).setEnabled(true);
        service(197030).setIntro("《金手指头条》：世界杯比赛日，天天有推介，单场点播每场588元；如提前预定10场打6.6折，共3888元；一次性预定20场打五折，共5888元。");

        service(197043).setName("大师兄精品");
        service(197043).setMoney(1);
        service(197043).setTimeType(6);
        service(197043).setEnabled(true);
        service(197043).setIntro("《大师兄精品》：单场点播每场288元；如提前预定10场打七折，共2000元；一次性预定20场打五折，共2888元。");

        service(197038).setName("一剑封喉精品");
        service(197038).setMoney(1);
        service(197038).setTimeType(6);
        service(197038).setEnabled(true);
        service(197038).setIntro("《一剑封喉精品》：单场点播每场288元；如提前预定10场打七折，共2000元；一次性预定20场打五折，共2888元。");

        service(197045).setName("精度打击·竞彩·单场");
        service(197045).setMoney(1);
        service(197045).setTimeType(6);
        service(197045).setEnabled(true);
        service(197045).setIntro("《晓万水宝精品》：单场点播每场288元；如提前预定10场打七折，共2000元；一次性预定20场打五折，共2888元。");

        service(79).setName("精品套餐");
        service(79).setMoney(1);
        service(79).setTimeType(7);
        service(79).setEnabled(true);
        service(79).setIntro("以上四大栏目将对64场世界杯所有赛事，实行组合推介，单场点播共需25932元，如提前预定所有64场赛事，全包价打3.8折，只需9998元！");

        service(40).setName("财哥包月推荐(500元/月)");
        service(40).setUser("admin_lj");
        service(40).setDiscount(1);
        service(40).setMoney(500);
        service(40).setTimeType(2);
        service(40).setEnabled(true);
        service(40).setSmsEnabled(false);

        service(42).setName("杨凯包月推荐(500元/月)");
        service(42).setUser("admin_lj");
        service(42).setDiscount(1);
        service(42).setMoney(500);
        service(42).setTimeType(2);
        service(42).setEnabled(true);
        service(42).setIntro("");
        service(42).setSmsEnabled(false);

        service(43).setName("汪怜花包月推荐(500元/月)");
        service(43).setUser("admin_lj");
        service(43).setDiscount(1);
        service(43).setMoney(500);
        service(43).setTimeType(2);
        service(43).setEnabled(true);
        service(43).setSmsEnabled(false);

        service(44).setName("神算子包月推荐(500元/月)");
        service(44).setUser("admin_lj");
        service(44).setDiscount(1);
        service(44).setMoney(500);
        service(44).setTimeType(2);
        service(44).setEnabled(true);
        service(44).setSmsEnabled(false);

        service(45).setName("薛朝云包月推荐(500元/月)");
        service(45).setUser("admin_lj");
        service(45).setDiscount(1);
        service(45).setMoney(500);
        service(45).setTimeType(2);
        service(45).setEnabled(true);
        service(45).setSmsEnabled(false);

        service(46).setName("王鹏包月推荐(500元/月)");
        service(46).setUser("admin_hrb");
        service(46).setDiscount(1);
        service(46).setMoney(500);
        service(46).setTimeType(2);
        service(46).setEnabled(true);
        service(46).setSmsEnabled(false);

        service(47).setName("周嘉鱼包月推荐(500元/月)");
        service(47).setUser("admin_hrb");
        service(47).setDiscount(1);
        service(47).setMoney(500);
        service(47).setTimeType(2);
        service(47).setEnabled(true);
        service(47).setSmsEnabled(false);

        service(48).setName("三哥包月推荐(500元/月)");
        service(48).setUser("admin_hrb");
        service(48).setDiscount(1);
        service(48).setMoney(500);
        service(48).setTimeType(2);
        service(48).setEnabled(true);
        service(48).setSmsEnabled(false);

        service(49).setName("亦真包月推荐(500元/月)");
        service(49).setUser("admin_hrb");
        service(49).setDiscount(1);
        service(49).setMoney(500);
        service(49).setTimeType(2);
        service(49).setEnabled(true);
        service(49).setSmsEnabled(false);

        service(50).setName("金鑫包月推荐(500元/月)");
        service(50).setUser("admin_lj");
        service(50).setDiscount(1);
        service(50).setMoney(500);
        service(50).setTimeType(2);
        service(50).setEnabled(true);
        service(50).setSmsEnabled(false);

        service(51).setName("邓明包月推荐(500元/月)");
        service(51).setUser("admin_cj");
        service(51).setDiscount(1);
        service(51).setMoney(500);
        service(51).setTimeType(2);
        service(51).setEnabled(true);
        service(51).setSmsEnabled(false);

        service(52).setName("白石包月推荐(500元/月)");
        service(52).setUser("admin_cj");
        service(52).setDiscount(1);
        service(52).setMoney(500);
        service(52).setTimeType(2);
        service(52).setEnabled(true);
        service(52).setSmsEnabled(false);

        service(53).setName("江华包月推荐(500元/月)");
        service(53).setUser("admin_lj");
        service(53).setDiscount(1);
        service(53).setMoney(500);
        service(53).setTimeType(2);
        service(53).setEnabled(true);
        service(53).setSmsEnabled(false);

        service(54).setName("边城包月推荐(500元/月)");
        service(54).setUser("admin_cj");
        service(54).setDiscount(1);
        service(54).setMoney(500);
        service(54).setTimeType(2);
        service(54).setEnabled(true);
        service(54).setSmsEnabled(false);

        service(55).setName("单挑一注包月推荐(500元/月)");
        service(55).setUser("admin_lj");
        service(55).setDiscount(1);
        service(55).setMoney(500);
        service(55).setTimeType(2);
        service(55).setEnabled(true);
        service(55).setSmsEnabled(false);

        service(56).setName("定位胆码包月推荐(500元/月)");
        service(56).setUser("admin_cj");
        service(56).setDiscount(1);
        service(56).setMoney(500);
        service(56).setTimeType(2);
        service(56).setEnabled(true);
        service(56).setSmsEnabled(false);

        service(57).setName("公孙龙包月推荐(500元/月)");
        service(57).setUser("admin_cj");
        service(57).setDiscount(1);
        service(57).setMoney(500);
        service(57).setTimeType(2);
        service(57).setEnabled(true);
        service(57).setSmsEnabled(false);

        service(58).setName("诸葛明包月推荐(500元/月)");
        service(58).setUser("admin_cj");
        service(58).setDiscount(1);
        service(58).setMoney(500);
        service(58).setTimeType(2);
        service(58).setEnabled(true);
        service(58).setSmsEnabled(false);

        dianbo(0).setId("197");
        dianbo(0).setIntro("单场赛事分析");
        dianbo(0).setMoney(List.of(0, 2, 8, 18, 28, 38, 58, 68, 88, 98, 188, 288, 588, 888, 999));

        dianbo(1).setId("265");
        dianbo(1).setIntro("精品单场");
        dianbo(1).setMoney(List.of(0, 88, 168, 188, 288, 388, 488, 588, 688, 788, 888, 999));

        dianbo(2).setId("134");
        dianbo(2).setIntro("胜负彩、任九专区");
        dianbo(2).setMoney(List.of(0, 8, 10, 15, 18, 28, 38, 58, 68, 88, 100, 150, 200, 588));

        dianbo(3).setId("133");

        dianbo(4).setId("290");
        dianbo(4).setIntro("本站推荐");

        dianbo(5).setId("303");
        dianbo(5).setIntro("竞彩过关串");
        dianbo(5).setMoney(List.of(0, 99, 199, 588));

        dianbo(6).setId("189");
        dianbo(6).setIntro("特色单场专区");
        dianbo(6).setMoney(List.of(0, 20, 25, 50, 100, 150, 200, 588));

        dianbo(7).setId("304");
        dianbo(7).setIntro("彩票指南");
        dianbo(7).setMoney(List.of(0, 5, 10, 15, 20));

        dianbo(8).setId("282");
        dianbo(8).setIntro("曹明");
        dianbo(8).setMoney(List.of(28, 38, 58, 68, 98, 588));

        dianbo(9).setId("280");
        dianbo(9).setIntro("张英杰");
        dianbo(9).setMoney(List.of(28, 38, 58, 68, 98, 588));

        dianbo(10).setId("279");
        dianbo(10).setIntro("吴建华");
        dianbo(10).setMoney(List.of(28, 38, 58, 68, 98, 588));

        dianbo(11).setId("278");
        dianbo(11).setIntro("李驭成");
        dianbo(11).setMoney(List.of(28, 38, 58, 68, 98, 588));

        dianbo(12).setId("277");
        dianbo(12).setIntro("黄炯");
        dianbo(12).setMoney(List.of(28, 38, 58, 68, 98, 588));

        dianbo(19).setId("276");
        dianbo(19).setIntro("过关串");
        dianbo(19).setMoney(List.of(28, 38, 58, 68, 98, 588));

        dianbo(18).setId("155");
        dianbo(18).setIntro("双色球");
        dianbo(18).setMoney(List.of(10, 5, 0, 3, 8, 15, 20, 28, 38, 58, 88));

        dianbo(13).setId("156");
        dianbo(13).setIntro("排三五");
        dianbo(13).setMoney(List.of(10, 5, 0, 3, 8, 15, 20, 28, 38, 58, 88));

        dianbo(14).setId("157");
        dianbo(14).setIntro("3D");
        dianbo(14).setMoney(List.of(10, 5, 0, 3, 8, 15, 20, 28, 38, 58, 88));

        dianbo(15).setId("159");
        dianbo(15).setIntro("七星彩");
        dianbo(15).setMoney(List.of(10, 5, 0, 3, 8, 15, 20, 28, 38, 58, 88));

        dianbo(16).setId("160");
        dianbo(16).setIntro("七乐彩");
        dianbo(16).setMoney(List.of(10, 5, 0, 3, 8, 15, 20, 28, 38, 58, 88));

        dianbo(17).setId("161");
        dianbo(17).setIntro("大乐透");
        dianbo(17).setMoney(List.of(10, 5, 0, 3, 8, 15, 20, 28, 38, 58, 88));

        dianbo(19).setId("322");
        dianbo(19).setIntro("金手指");
        dianbo(19).setMoney(List.of(0, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(20).setId("328");
        dianbo(20).setIntro("十年一剑");
        dianbo(20).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(21).setId("323");
        dianbo(21).setIntro("威廉王子");
        dianbo(21).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(22).setId("324");
        dianbo(22).setIntro("三水");
        dianbo(22).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(23).setId("329");
        dianbo(23).setIntro("临风");
        dianbo(23).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(24).setId("327");
        dianbo(24).setIntro("下盘奇人");
        dianbo(24).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(25).setId("326");
        dianbo(25).setIntro("李林");
        dianbo(25).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(26).setId("325");
        dianbo(26).setIntro("晓万水宝");
        dianbo(26).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(27).setId("331");
        dianbo(27).setIntro("英系小王子");
        dianbo(27).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(28).setId("332");
        dianbo(28).setIntro("盘口掌门");
        dianbo(28).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(29).setId("333");
        dianbo(29).setIntro("波哥看足彩");
        dianbo(29).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(30).setId("396");
        dianbo(30).setIntro("好运小球迷");
        dianbo(30).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        dianbo(31).setId("397");
        dianbo(31).setIntro("蜀山侠客");
        dianbo(31).setMoney(List.of(0, 18, 28, 38, 58, 88, 128, 158, 188, 288));

        SERVICE_TIME_TYPES_INTERNAL.put(1, "天");
        SERVICE_TIME_TYPES_INTERNAL.put(2, "月");
        SERVICE_TIME_TYPES_INTERNAL.put(3, "年");
        SERVICE_TIME_TYPES_INTERNAL.put(4, "一季度");

        SERVICE_GROUPS_INTERNAL.put(0, new ServiceGroup("竞技彩", List.of(2, 41, 303)));
        SERVICE_GROUPS_INTERNAL.put(1, new ServiceGroup("数字彩", List.of(9, 40, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58)));
        SERVICE_GROUPS_INTERNAL.put(2, new ServiceGroup("竞技彩+数字彩", List.of(9, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59)));
        SERVICE_GROUPS_INTERNAL.put(5, new ServiceGroup("精品套餐", List.of(197030, 197033, 197035, 197036, 197038, 197043, 197046, 79)));

        DBKF_INTERNAL.put(197001, "竞彩胆材");
        DBKF_INTERNAL.put(197002, "北单胆材");
        DBKF_INTERNAL.put(197003, "形势解读");
        DBKF_INTERNAL.put(197004, "澳指分析");
        DBKF_INTERNAL.put(197005, "十年一剑");
        DBKF_INTERNAL.put(189321, "亚指心理");
        DBKF_INTERNAL.put(189322, "十年一剑");
        DBKF_INTERNAL.put(197009, "鬼手竞彩");
        DBKF_INTERNAL.put(197010, "一水拆盘");
        DBKF_INTERNAL.put(197011, "亚指变化");
        DBKF_INTERNAL.put(134306, "亚指变化");
        DBKF_INTERNAL.put(134326, "初指比较");
        DBKF_INTERNAL.put(197072, "风险压力");
        DBKF_INTERNAL.put(197013, "三要素解彩");
        DBKF_INTERNAL.put(265283, "冷刀精品单场");
        DBKF_INTERNAL.put(265269, "吴建华精品单场");
        DBKF_INTERNAL.put(265266, "曹明精品单场");
        DBKF_INTERNAL.put(265270, "所罗门精品单场");
        DBKF_INTERNAL.put(265267, "晓万水宝精品单场");
        DBKF_INTERNAL.put(265271, "十年一剑精品单场");
        DBKF_INTERNAL.put(265268, "郑林平精品单场");
        DBKF_INTERNAL.put(265285, "威廉王子");
        DBKF_INTERNAL.put(265290, "本站建议");
        DBKF_INTERNAL.put(134294, "郑林平欧洲杯特色");
        DBKF_INTERNAL.put(134295, "曹明过关");
        DBKF_INTERNAL.put(134297, "李驭成欧洲杯特色");
        DBKF_INTERNAL.put(134299, "胜负差选任九");
        DBKF_INTERNAL.put(134309, "临场冷热倾向");
        DBKF_INTERNAL.put(197014, "冷刀重心");
        DBKF_INTERNAL.put(197015, "盈亏数据");
        DBKF_INTERNAL.put(134300, "只玩二串一");
        DBKF_INTERNAL.put(134301, "平指系数");
        DBKF_INTERNAL.put(134302, "实战小单");
        DBKF_INTERNAL.put(197016, "冷刀足彩");
        DBKF_INTERNAL.put(197017, "鬼手专栏");
        DBKF_INTERNAL.put(134308, "竞彩二串一");
        DBKF_INTERNAL.put(197018, "竞彩二串一");
        DBKF_INTERNAL.put(265303, "竞彩过关串");
        DBKF_INTERNAL.put(134303, "全氏杀号");
        DBKF_INTERNAL.put(134304, "晓万过关串");
        DBKF_INTERNAL.put(134305, "所罗门过关");
        DBKF_INTERNAL.put(134307, "亚指解九场");
        DBKF_INTERNAL.put(134311, "冷刀过关");
        DBKF_INTERNAL.put(197020, "欧指组合");
        DBKF_INTERNAL.put(134313, "天天四串一");
        DBKF_INTERNAL.put(197023, "拖鞋狗单场");
        DBKF_INTERNAL.put(134315, "欧指精析过关");
        DBKF_INTERNAL.put(134316, "天天三串一");
        DBKF_INTERNAL.put(134317, "天天五串一");
        DBKF_INTERNAL.put(134310, "吴建华任选9");
        DBKF_INTERNAL.put(134337, "数据分类法");
        DBKF_INTERNAL.put(134342, "盈亏数据");
        DBKF_INTERNAL.put(134343, "威廉解彩");
        DBKF_INTERNAL.put(134349, "晓万冷门");
        DBKF_INTERNAL.put(189310, "吴建华任选9");
        DBKF_INTERNAL.put(189311, "李驭成任选9");
        DBKF_INTERNAL.put(189312, "曹明任选9");
        DBKF_INTERNAL.put(189313, "亚指核心");
        DBKF_INTERNAL.put(189314, "罗氏定位");
        DBKF_INTERNAL.put(189315, "凯利数据");
        DBKF_INTERNAL.put(189316, "盈亏数据");
        DBKF_INTERNAL.put(189317, "欧亚差异");
        DBKF_INTERNAL.put(189318, "返还差");
        DBKF_INTERNAL.put(189319, "标准差");
        DBKF_INTERNAL.put(189320, "晓万水宝");
        DBKF_INTERNAL.put(189323, "欧指对比值");
        DBKF_INTERNAL.put(189324, "冷热倾向");
        DBKF_INTERNAL.put(189325, "离散数据");
        DBKF_INTERNAL.put(189326, "聚焦英德");
        DBKF_INTERNAL.put(189327, "聚焦小联赛");
        DBKF_INTERNAL.put(189328, "聚焦意西");
        DBKF_INTERNAL.put(189329, "八月入秋");
        DBKF_INTERNAL.put(189330, "新版投资冷热");
        DBKF_INTERNAL.put(189331, "鬼手专栏");
        DBKF_INTERNAL.put(189332, "亚指变化");
        DBKF_INTERNAL.put(189333, "交易解彩");
        DBKF_INTERNAL.put(189334, "热门数据");
        DBKF_INTERNAL.put(189335, "李军解亚指");
        DBKF_INTERNAL.put(134318, "杀庄匠过关");
        DBKF_INTERNAL.put(197024, "杀庄匠单场");
        DBKF_INTERNAL.put(197025, "欧指精析");
        DBKF_INTERNAL.put(134320, "竞彩投资");
        DBKF_INTERNAL.put(134319, "冷热判断");
        DBKF_INTERNAL.put(134321, "曹明足彩难点");
        DBKF_INTERNAL.put(197021, "热门数据");
        DBKF_INTERNAL.put(197026, "冷刀竞彩理财");
        DBKF_INTERNAL.put(197027, "横向比较");
        DBKF_INTERNAL.put(197028, "所罗门解读");
        DBKF_INTERNAL.put(134322, "欧亚数据对比");
        DBKF_INTERNAL.put(134323, "拖鞋狗杀号");
        DBKF_INTERNAL.put(197029, "初指心理");
        DBKF_INTERNAL.put(197030, "金手指头条");
        DBKF_INTERNAL.put(134325, "鬼手足彩");
        DBKF_INTERNAL.put(197031, "每日精选");
        DBKF_INTERNAL.put(197032, "冷热倾向搜冷");
        DBKF_INTERNAL.put(197073, "千峰解盘");
        DBKF_INTERNAL.put(197041, "竞彩特供");
        DBKF_INTERNAL.put(134328, "竞彩特供");
        DBKF_INTERNAL.put(134329, "定胆专栏");
        DBKF_INTERNAL.put(134330, "热度对比");
        DBKF_INTERNAL.put(134331, "新版标准差");
        DBKF_INTERNAL.put(134332, "足彩基石");
        DBKF_INTERNAL.put(134333, "拖鞋狗解读");
        DBKF_INTERNAL.put(134334, "罗氏定位");
        DBKF_INTERNAL.put(134335, "研究变化");
        DBKF_INTERNAL.put(134336, "晓万水宝");
        DBKF_INTERNAL.put(134338, "李军解读");
        DBKF_INTERNAL.put(134339, "返还差");
        DBKF_INTERNAL.put(134341, "标准数据");
        DBKF_INTERNAL.put(134344, "任九三步曲");
        DBKF_INTERNAL.put(134345, "澳指专栏解读");
        DBKF_INTERNAL.put(134346, "郑曹合推");
        DBKF_INTERNAL.put(134347, "热门数据");
        DBKF_INTERNAL.put(134350, "竞彩实买单");
        DBKF_INTERNAL.put(134351, "胜负彩实买单");
        DBKF_INTERNAL.put(134352, "任九实买单");
        DBKF_INTERNAL.put(134353, "移位补防法");
        DBKF_INTERNAL.put(134355, "世界杯曹明过关");
        DBKF_INTERNAL.put(134356, "世界杯拖鞋狗过关");
        DBKF_INTERNAL.put(134357, "世界杯所罗门过关");
        DBKF_INTERNAL.put(134358, "世界杯吴建华过关");
        DBKF_INTERNAL.put(134364, "双八平测");
        DBKF_INTERNAL.put(134365, "热力标差数据");
        DBKF_INTERNAL.put(134366, "历史亚指统计");
        DBKF_INTERNAL.put(134367, "相同数据");
        DBKF_INTERNAL.put(134368, "风险压力数据");
        DBKF_INTERNAL.put(197033, "冷刀竞彩");
        DBKF_INTERNAL.put(197034, "绝杀21点");
        DBKF_INTERNAL.put(197035, "吴建华竞彩");
        DBKF_INTERNAL.put(197038, "一剑封喉");
        DBKF_INTERNAL.put(197042, "杀庄匠竞彩");
        DBKF_INTERNAL.put(197046, "拖鞋狗竞彩");
        DBKF_INTERNAL.put(197048, "欧亚差异解读");
        DBKF_INTERNAL.put(197049, "必发赔率");
        DBKF_INTERNAL.put(197050, "标准数据");
        DBKF_INTERNAL.put(197051, "STS欧指");
        DBKF_INTERNAL.put(197052, "主流数据");
        DBKF_INTERNAL.put(197054, "冷刀竞彩");
        DBKF_INTERNAL.put(197055, "吴建华专栏");
        DBKF_INTERNAL.put(197056, "所罗门竞彩");
        DBKF_INTERNAL.put(197057, "拖鞋狗竞彩");
        DBKF_INTERNAL.put(197058, "曹明竞彩");
        DBKF_INTERNAL.put(197060, "吴建华猜比分");
        DBKF_INTERNAL.put(197061, "所罗猜比分");
        DBKF_INTERNAL.put(197062, "拖鞋狗猜比分");
        DBKF_INTERNAL.put(197063, "曹明猜比分");
        DBKF_INTERNAL.put(197065, "欧亚关系");
        DBKF_INTERNAL.put(197066, "所罗理财");
        DBKF_INTERNAL.put(197067, "拖鞋狗理财");
        DBKF_INTERNAL.put(197068, "曹明理财");
        DBKF_INTERNAL.put(197069, "鬼手精品");
        DBKF_INTERNAL.put(197070, "所罗门重心");
        DBKF_INTERNAL.put(197071, "离散数据");
        DBKF_INTERNAL.put(277001, "拖鞋狗");
        DBKF_INTERNAL.put(277002, "拖鞋狗2串1天天见");
        DBKF_INTERNAL.put(278001, "李驭成");
        DBKF_INTERNAL.put(279001, "吴建华");
        DBKF_INTERNAL.put(280001, "冷刀");
        DBKF_INTERNAL.put(282001, "曹明APP");
        DBKF_INTERNAL.put(282002, "绝杀21点");
        DBKF_INTERNAL.put(282003, "热门数据");
        DBKF_INTERNAL.put(323001, "威廉王子");
        DBKF_INTERNAL.put(324001, "三水");
        DBKF_INTERNAL.put(325001, "晓万水宝");
        DBKF_INTERNAL.put(326001, "李林");
        DBKF_INTERNAL.put(327001, "奇人");
        DBKF_INTERNAL.put(328001, "十年一剑");
        DBKF_INTERNAL.put(329001, "临风");
        DBKF_INTERNAL.put(331001, "英系小王子");
        DBKF_INTERNAL.put(332001, "高飞");
        DBKF_INTERNAL.put(333001, "波哥");
        DBKF_INTERNAL.put(396001, "千峰解盘");
        DBKF_INTERNAL.put(397001, "蜀仙侠客");
        DBKF_INTERNAL.put(79, "世界杯64场套餐");
        DBKF_INTERNAL.put(322001, "金手指头条");
        DBKF_INTERNAL.put(322002, "金手指欧指");
        DBKF_INTERNAL.put(322003, "金手指预测");
        DBKF_INTERNAL.put(322004, "金手指数据说话");
        DBKF_INTERNAL.put(322005, "金手指欧亚差异");
        DBKF_INTERNAL.put(322006, "金手指进球数");
        DBKF_INTERNAL.put(322007, "金手指媒体预测");
        DBKF_INTERNAL.put(134360, "临风专栏");
        DBKF_INTERNAL.put(134361, "晓万专栏");
        DBKF_INTERNAL.put(134362, "吴建华专栏");
        DBKF_INTERNAL.put(134363, "冷刀专栏");
        DBKF_INTERNAL.put(304305, "排三单挑一注");
        DBKF_INTERNAL.put(304306, "3D定位胆码");
        DBKF_INTERNAL.put(304307, "3D单挑一注");
        DBKF_INTERNAL.put(304308, "金鑫3D精推");
        DBKF_INTERNAL.put(304309, "邓明3D推荐");
        DBKF_INTERNAL.put(304310, "财哥3D精选");
        DBKF_INTERNAL.put(304311, "三哥3D金胆");
        DBKF_INTERNAL.put(304312, "汪怜花双色球");
        DBKF_INTERNAL.put(304313, "薛朝云双色球(三胆七拖)");
        DBKF_INTERNAL.put(304314, "杨凯双色球(三胆七拖)");
        DBKF_INTERNAL.put(304315, "神算子推荐");
        DBKF_INTERNAL.put(304315, "白石3D");
        DBKF_INTERNAL.put(5001, "点播->双色球");
        DBKF_INTERNAL.put(6001, "点播->3D");
        DBKF_INTERNAL.put(7001, "点播->排三排五");
        DBKF_INTERNAL.put(8001, "点播->大乐透");

        SJB = List.of(197038, 197043, 197045, 197027);
        JPTJ = List.of(197033, 197038, 197042, 197046, 197035, 197069);
        APP = List.of(277001, 277002, 278001, 279001, 280001, 282001);
        JCLMS = List.of(277, 278, 279, 280, 282, 323, 324, 325, 326, 327, 328, 329, 331, 332, 333, 396, 397);

        SERVICES = Collections.unmodifiableMap(SERVICES_INTERNAL);
        DIANBO = Collections.unmodifiableMap(DIANBO_INTERNAL);
        DBKF = Collections.unmodifiableMap(DBKF_INTERNAL);
        SERVICE_TIME_TYPES = Collections.unmodifiableMap(SERVICE_TIME_TYPES_INTERNAL);
        SERVICE_GROUPS = Collections.unmodifiableMap(SERVICE_GROUPS_INTERNAL);
    }

    private static ServiceConfig service(int id) {
        return SERVICES_INTERNAL.computeIfAbsent(id, ServiceConfig::new);
    }

    private static DianboConfig dianbo(int index) {
        return DIANBO_INTERNAL.computeIfAbsent(index, DianboConfig::new);
    }

    public static final class ServiceConfig {
        private final int id;
        private String name;
        private Integer money;
        private Integer timeType;
        private Boolean enabled;
        private Boolean smsEnabled;
        private String intro;
        private String user;
        private Integer discount;

        private ServiceConfig(int id) {
            this.id = id;
        }

        public int getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public Integer getMoney() {
            return money;
        }

        public Integer getTimeType() {
            return timeType;
        }

        public Boolean getEnabled() {
            return enabled;
        }

        public Boolean getSmsEnabled() {
            return smsEnabled;
        }

        public String getIntro() {
            return intro;
        }

        public String getUser() {
            return user;
        }

        public Integer getDiscount() {
            return discount;
        }

        private void setName(String name) {
            this.name = name;
        }

        private void setMoney(Integer money) {
            this.money = money;
        }

        private void setTimeType(Integer timeType) {
            this.timeType = timeType;
        }

        private void setEnabled(Boolean enabled) {
            this.enabled = enabled;
        }

        private void setSmsEnabled(Boolean smsEnabled) {
            this.smsEnabled = smsEnabled;
        }

        private void setIntro(String intro) {
            this.intro = intro;
        }

        private void setUser(String user) {
            this.user = user;
        }

        private void setDiscount(Integer discount) {
            this.discount = discount;
        }
    }

    public static final class DianboConfig {
        private final int index;
        private String id;
        private String intro;
        private List<Integer> money;

        private DianboConfig(int index) {
            this.index = index;
        }

        public int getIndex() {
            return index;
        }

        public String getId() {
            return id;
        }

        public String getIntro() {
            return intro;
        }

        public List<Integer> getMoney() {
            return money;
        }

        private void setId(String id) {
            this.id = id;
        }

        private void setIntro(String intro) {
            this.intro = intro;
        }

        private void setMoney(List<Integer> money) {
            this.money = money;
        }
    }

    public static final class ServiceGroup {
        private final String name;
        private final List<Integer> ids;

        public ServiceGroup(String name, List<Integer> ids) {
            this.name = name;
            this.ids = ids;
        }

        public String getName() {
            return name;
        }

        public List<Integer> getIds() {
            return ids;
        }
    }
}
