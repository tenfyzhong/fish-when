# 2025-01-01 00:00:00 timezone 0 = 1735689600
set basetime250101 1735689600
set basetimems250101 1735689600000
set basedate250101 "2025-01-01 00:00:00"

set -gx store_tz "$TZ"
set -gx TZ "Asia/Shanghai"

@test "when -d $basetime250101 = 2025-01-01 08:00:00" (when -d $basetime250101) = "2025-01-01 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

@test "when -d $basetimems250101 --ms = 2025-01-01 08:00:00" (when -d $basetimems250101 --ms) = "2025-01-01 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

@test "when -t '2025-01-01 08:00:00' = $basetime250101" (when -t '2025-01-01 08:00:00') -eq $basetime250101
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

@test "when -t '2025-01-01 08:00:00' --ms = $basetimems250101" (when -t '2025-01-01 08:00:00' --ms) -eq $basetimems250101
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

@test "when --tz US/Eastern -d $basetime250101 = 2024-12-31 19:00:00 EST" (when --tz US/Eastern -d $basetime250101) = "2024-12-31 19:00:00 EST -05:00"
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

@test "when --tz US/Eastern -d 1746028800 = 2025-04-30 12:00:00 EDT" (when --tz US/Eastern -d 1746028800) = "2025-04-30 12:00:00 EDT -04:00"
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

@test "when --tz US/Eastern -t 2025-04-30 12:00:00 = 1746028800 " (when --tz US/Eastern -t 2025-04-30 12:00:00) = "1746028800"
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

@test "when --tz US/Eastern -t 2025-04-30 12:00:00 EDT = 1746028800 " (when --tz US/Eastern -t 2025-04-30 12:00:00 EDT) = "1746028800"
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

set TZ "$store_tz"
set -e store_tz
