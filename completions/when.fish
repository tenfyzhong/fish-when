function _when_complete_tz
    printf "_12\tUTC-12 IDLW 国际换日线\n"
    printf "_11\tUTC-11 SST 美属萨摩亚标准时间\n"
    printf "_10\tUTC-10 HST 夏威夷－阿留申标准时间\n"
    printf "_9:30\tUTC-9:30 MIT 马克萨斯群岛标准时间\n"
    printf "_9\tUTC-9 AKST 阿拉斯加标准时间\n"
    printf "_8\tUTC-8 PST 太平洋标准时间\n"
    printf "_7\tUTC-7 MST 北美山区标准时间\n"
    printf "_6\tUTC-6 CST 北美中部标准时间\n"
    printf "_5\tUTC-5 EST 北美东部标准时间\n"
    printf "_4\tUTC-4 AST 大西洋标准时间\n"
    printf "_3:30\tUTC-3:30 NST 纽芬兰岛标准时间\n"
    printf "_3\tUTC-3 BRT 巴西利亚标准时间\n"
    printf "_2\tUTC-2 FNT 费尔南多·迪诺罗尼亚群岛标准时间\n"
    printf "_1\tUTC-1 CVT 佛得角标准时间\n"
    printf "0\tUTC WET 欧洲西部时区 GMT 格林尼治标准时间\n"
    printf "+1\tUTC+1 CET 欧洲中部时区\n"
    printf "+2\tUTC+2 EET 欧洲东部时区\n"
    printf "+3\tUTC+3 MSK 欧洲极东时间／莫斯科时区\n"
    printf "+3:30\tUTC+3:30 IRST 伊朗标准时间\n"
    printf "+4\tUTC+4 GST 海湾标准时间\n"
    printf "+4:30\tUTC+4:30 AFT 阿富汗标准时间\n"
    printf "+5\tUTC+5 PKT 巴基斯坦标准时间\n"
    printf "+5:30\tUTC+5:30 IST 印度标准时间\n"
    printf "+5:45\tUTC+5:45 NPT 尼泊尔标准时间\n"
    printf "+6\tUTC+6 BHT 孟加拉标准时间\n"
    printf "+6:30\tUTC+6:30 MMT 缅甸标准时间\n"
    printf "+7\tUTC+7 ICT 中南半岛标准时间\n"
    printf "+8\tUTC+8 CST 中原标准时间\n"
    printf "+9\tUTC+9 JST 日本标准时间\n"
    printf "+9:30\tUTC+9:30 ACST 澳大利亚中部标准时间\n"
    printf "+10\tUTC+10 AEST 澳大利亚东部标准时间\n"
    printf "+10:30\tUTC+10:30 LHST 豪勋爵群岛标准时间\n"
    printf "+11\tUTC+11 VUT 瓦努阿图标准时间\n"
    printf "+12\tUTC+12 NZST 纽西兰标准时间\n"
    printf "+12:45\tUTC+12:45 CHAST 查塔姆群岛标准时间\n"
    printf "+13\tUTC+13 PHOT 菲尼克斯群岛标准时间\n"
    printf "+14\tUTC+14 LINT 莱恩群岛标准时间\n"
end

complete when -f
complete when -s d -l datetime -d 'convert timestamp to datetime'
complete when -s t -l timestamp -d 'convert datetime to timestamp, any format which support by `date` is supported'
complete when -l ms -d 'the time unit is millisecond'
complete when -k -r -f -l tz -a "(_when_complete_tz)" -d 'the timezone to use when displaying dates.'
complete when -s h -l help -d 'print this help message'
