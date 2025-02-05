# 2025-01-01 00:00:00 timezone 0 = 1735689600
set basetime250101 1735689600
set basetimems250101 1735689600000
set basedate250101 "2025-01-01 00:00:00"

set -gx store_tz "$TZ"
set -gx TZ "Asia/Shanghai"

@test "when -d $basetime250101 = 2025-01-01 08:00:00" (when -d $basetime250101) = "2025-01-01 08:00:00"
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

@test "when -d $basetimems250101 --ms = 2025-01-01 08:00:00" (when -d $basetimems250101 --ms) = "2025-01-01 08:00:00"
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

@test "when -t '2025-01-01 08:00:00' = $basetime250101" (when -t '2025-01-01 08:00:00') -eq $basetime250101
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

@test "when -t '2025-01-01 08:00:00' --ms = $basetimems250101" (when -t '2025-01-01 08:00:00' --ms) -eq $basetimems250101
@test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"

for tz in (seq 0 12)
    set t (math "$basetime250101 - 3600 * $tz")
    @test "when -t '2025-01-01 00:00:00' --tz $tz = $t" (when -t '2025-01-01 00:00:00' --tz $tz) -eq $t
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
    @test "when -t '2025-01-01 00:00:00' --tz +$tz = $t" (when -t '2025-01-01 00:00:00' --tz +$tz) -eq $t
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
    set t (math "$basetime250101 + 3600 * $tz")
    @test "when -t '2025-01-01 00:00:00' --tz _$tz = $t" (when -t '2025-01-01 00:00:00' --tz _$tz) -eq $t
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
    set t (math "($basetime250101 - 3600 * $tz) * 1000")
    @test "when -t '2025-01-01 00:00:00' --tz $tz --ms = $t" (when -t '2025-01-01 00:00:00' --tz $tz --ms) -eq $t
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
    @test "when -t '2025-01-01 00:00:00' --tz +$tz --ms = $t" (when -t '2025-01-01 00:00:00' --tz +$tz --ms) -eq $t
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
    set t (math "($basetime250101 + 3600 * $tz) * 1000")
    @test "when -t '2025-01-01 00:00:00' --tz _$tz --ms = $t" (when -t '2025-01-01 00:00:00' --tz _$tz --ms) -eq $t
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
end

for tz in (seq 0 12)
    set d (printf "2025-01-01 %02d:00:00" $tz)
    @test "when -d $basetime250101 timezone --tz $tz = $d" (when -d $basetime250101 --tz $tz) = "$d"
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
    @test "when -d $basetime250101 timezone --tz +$tz = $d" (when -d $basetime250101 --tz +$tz) = "$d"
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
    @test "when -d $basetimems250101 --tz $tz --ms = $d" (when -d $basetimems250101 --tz $tz --ms) = "$d"
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
    @test "when -d $basetimems250101 --tz +$tz --ms = $d" (when -d $basetimems250101 --tz +$tz --ms) = "$d"
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
end


for tz in (seq 1 12)
    set hour (math "24 - $tz")
    set d (printf "2024-12-31 %02d:00:00" $hour)
    @test "when -d $basetime250101 --tz _$tz = $d" (when -d $basetime250101 --tz _$tz) = "$d"
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
    @test "when -d $basetimems250101 --tz _$tz --ms = $d" (when -d $basetimems250101 --tz _$tz --ms) = "$d"
    @test "test TZ = Asia/Shanghai" "$TZ" = "Asia/Shanghai"
end

set TZ "$store_tz"
set -e store_tz
