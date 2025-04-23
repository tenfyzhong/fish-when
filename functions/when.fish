function when --description 'Format timestamp'
    argparse -i 't/timestamp' 'd/datetime' 'ms' 'tz=' 'h/help' -- $argv 2>/dev/null

    if set -q _flag_help
        _when_help
        return 0
    end

    set -l t $argv
    set -l date_style (_when_detect_date_style)

    if test "$date_style" = "unknown"
        echo "Unsupport `date` command" >&2
        return 1
    end

    _when_bak_tz
    if test -n "$_flag_tz"
        set -x TZ "$_flag_tz"
    end

    if set -q _flag_datetime
        if test -z "$argv"
            date +'%F %T %Z'
        else
            if set -q _flag_ms
                set t (math "floor($t/1000)")
            end

            # date +'%F %T %Z' -d @"$t"
            if test "$date_style" = "gnu"
                date +'%F %T %Z' -d @"$t"
            else
                date -j -f "%s" "$t" +'%F %T %Z'
            end
        end
        _when_restore_tz
        return 0
    else if set -q _flag_timestamp
        if test -z "$argv"
            set ts (date +"%s")
        else
            # set ts (date -d"$t" +"%s")
            if test "$date_style" = "gnu"
                set ts (date -d "$t" +"%s")
            else
                set ts (date -j -f "%a %b %d %T %Z %Y" "$t" +"%s" 2>/dev/null || date -j -f "%F %T" "$t" +"%s" 2>/dev/null || date -j -f "%F" "$t" +"%s")
            end
        end
        if set -q _flag_ms
            set ts (math "$ts*1000")
        end
        echo "$ts"
        _when_restore_tz
        return 0
    else
        date +'%F %T %Z'
        _when_restore_tz
        return 0
    end
end

function _when_help
    printf %s\n\
        'when: convert timestamp/datetime'\
        'Usage: when [options] [timestamp/datetime]'\
        ''\
        'Options:'\
        '  -d/--datetime       convert timestamp to datetime'\
        '  -t/--timestamp      convert datetime to timestamp, any format which support by `date` is supported'\
        '  --ms                the time unit is millisecond'\
        '  --tz timezone  the timezone to use when displaying dates. default is the local timezone'\
        '  -h/--help           print this help message'
end

function _when_bak_tz
    set -gx store_tz "$TZ"
end

function _when_restore_tz
    set -x TZ "$store_tz"
    set -e store_tz
end

function _when_detect_date_style
    if date -d "now" +%s >/dev/null 2>&1
        echo "gnu"
    else if date -j -f "%s" (date +%s) >/dev/null 2>&1
        echo "bsd"
    else
        echo "unknown"
    end
end
