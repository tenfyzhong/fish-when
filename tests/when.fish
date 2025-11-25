source functions/when.fish

# 2025-01-01 00:00:00 timezone 0 = 1735689600
set basetime250101 1735689600
set basetimems250101 1735689600000

set -gx store_tz "$TZ"
set -gx TZ Asia/Shanghai

@test "when -d $basetime250101 = 2025-01-01 08:00:00" (when -d $basetime250101) = "2025-01-01 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when $basetime250101 = 2025-01-01 08:00:00" (when $basetime250101) = "2025-01-01 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when -d $basetimems250101 --ms = 2025-01-01 08:00:00" (when -d $basetimems250101 --ms) = "2025-01-01 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when -d $basetimems250101 = 2025-01-01 08:00:00" (when -d $basetimems250101) = "2025-01-01 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when $basetimems250101 --ms = 2025-01-01 08:00:00" (when $basetimems250101 --ms) = "2025-01-01 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when $basetimems250101 = 2025-01-01 08:00:00" (when $basetimems250101) = "2025-01-01 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when -t '2025-01-01 08:00:00' = $basetime250101" (when -t '2025-01-01 08:00:00') -eq $basetime250101
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when '2025-01-01 08:00:00' = $basetime250101" (when '2025-01-01 08:00:00') -eq $basetime250101
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when -t '2025-01-01 08:00:00' --ms = $basetimems250101" (when -t '2025-01-01 08:00:00' --ms) -eq $basetimems250101
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when '2025-01-01 08:00:00' --ms = $basetimems250101" (when '2025-01-01 08:00:00' --ms) -eq $basetimems250101
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when --tz US/Eastern -d $basetime250101 = 2024-12-31 19:00:00 EST" (when --tz US/Eastern -d $basetime250101) = "2024-12-31 19:00:00 EST -05:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when --tz US/Eastern $basetime250101 = 2024-12-31 19:00:00 EST" (when --tz US/Eastern $basetime250101) = "2024-12-31 19:00:00 EST -05:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when --tz US/Eastern -d 1746028800 = 2025-04-30 12:00:00 EDT" (when --tz US/Eastern -d 1746028800) = "2025-04-30 12:00:00 EDT -04:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when --tz US/Eastern 1746028800 = 2025-04-30 12:00:00 EDT" (when --tz US/Eastern  1746028800) = "2025-04-30 12:00:00 EDT -04:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when --tz US/Eastern -t 2025-04-30 12:00:00 = 1746028800 " (when --tz US/Eastern -t 2025-04-30 12:00:00) = 1746028800
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when --tz US/Eastern 2025-04-30 12:00:00 = 1746028800 " (when --tz US/Eastern 2025-04-30 12:00:00) = 1746028800
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when --tz US/Eastern -t 2025-04-30 12:00:00 EDT = 1746028800 " (when --tz US/Eastern -t 2025-04-30 12:00:00 EDT) = 1746028800
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when --tz US/Eastern 2025-04-30 12:00:00 EDT = 1746028800 " (when --tz US/Eastern 2025-04-30 12:00:00 EDT) = 1746028800
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "echo '2025-01-01 08:00:00' | when = $basetime250101" (echo '2025-01-01 08:00:00' | when) -eq $basetime250101
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "echo '2025-01-01 08:00:00' | when = $basetimems250101" (echo '2025-01-01 08:00:00' | when --ms) -eq $basetimems250101
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "echo $basetimems250101 | when = 2025-01-01 08:00:00" (echo $basetimems250101 | when) = "2025-01-01 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

set TZ "$store_tz"
set -e store_tz

# Tests for -a/--add and -s/--sub
set -gx store_tz "$TZ"
set -gx TZ Asia/Shanghai

# 1d = 86400s
@test "when -a 1d $basetime250101 = 2025-01-02 08:00:00" (when -a 1d $basetime250101) = "2025-01-02 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

# 1h = 3600s
@test "when -a 1h $basetime250101 = 2025-01-01 09:00:00" (when -a 1h $basetime250101) = "2025-01-01 09:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

# 1m = 60s
@test "when -a 1m $basetime250101 = 2025-01-01 08:01:00" (when -a 1m $basetime250101) = "2025-01-01 08:01:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

# 1s = 1s
@test "when -a 1s $basetime250101 = 2025-01-01 08:00:01" (when -a 1s $basetime250101) = "2025-01-01 08:00:01 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

# 1d1h1m1s = 90061s
@test "when -a 1d1h1m1s $basetime250101 = 2025-01-02 09:01:01" (when -a 1d1h1m1s $basetime250101) = "2025-01-02 09:01:01 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

# Subtraction
@test "when -s 1d $basetime250101 = 2024-12-31 08:00:00" (when --sub 1d $basetime250101) = "2024-12-31 08:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

@test "when -s 1h $basetime250101 = 2025-01-01 07:00:00" (when --sub 1h $basetime250101) = "2025-01-01 07:00:00 CST +08:00"
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

# Add to timestamp output
# 1735689600 + 3600 = 1735693200
@test "when -t '2025-01-01 08:00:00' -a 1h = 1735693200" (when -t '2025-01-01 08:00:00' -a 1h) -eq 1735693200
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

# Sub from timestamp output
# 1735689600 - 3600 = 1735686000
@test "when -t '2025-01-01 08:00:00' --sub 1h = 1735686000" (when -t '2025-01-01 08:00:00' --sub 1h) -eq 1735686000
@test "test TZ = Asia/Shanghai" "$TZ" = Asia/Shanghai

set TZ "$store_tz"
set -e store_tz
