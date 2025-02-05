function when --description 'Format timestamp'
    argparse -i 't/timestamp' 'd/datetime' 'ms' 'tz=' 'h/help' -- $argv 2>/dev/null

    if set -q _flag_help
        _when_help
        return 0
    end

    set -l t $argv

    if test -n "$_flag_tz"
        if string match -q -r '^\d{1,2}(?::\d{2})?$' -- "$_flag_tz"
            set _tz "-$_flag_tz"
            # set -x TZ "UTC-$_tz"
        else if string match -q -r '^\+\d{1,2}(?::\d{2})?$' -- "$_flag_tz"
            set _tz (string replace + - "$_flag_tz")
            # set -x TZ "UTC$_tz"
        else if string match -q -r '^_\d{1,2}(?::\d{2})?$' -- "$_flag_tz"
            set _tz (string replace _ + "$_flag_tz")
            # set -x TZ "UTC$_tz"
        else
            echo "--tz is invalid" >&2
            return 2
        end
    end

    _when_bak_tz
    if test -n "$_tz"
        set -x TZ "UTC$_tz"
    end

    if set -q _flag_datetime
        if test -z "$argv"
            date +'%F %T'
        else
            if set -q _flag_ms
                set t (math "floor($t/1000)")
            end

            date +'%F %T' -d @"$t"
        end
        _when_restore_tz
        return 0
    else if set -q _flag_timestamp
        if test -z "$argv"
            set ts (date +"%s")
        else
            set ts (date -d"$t" +"%s")
        end
        if set -q _flag_ms
            set ts (math "$ts*1000")
        end
        echo "$ts"
        _when_restore_tz
        return 0
    else
        date +'%F %T'
        _when_restore_tz
        return 0
    end
end

function _when_help
    printf %s\n\
        'when: convert tiemstamp/datetime'\
        'Usage: when [options] [timestamp/datetime]'\
        ''\
        'Options:'\
        '  -d/--datetime       convert timestamp to datetime'\
        '  -t/--timestamp      convert datetime to timestamp, any format which support by `date` is supported'\
        '  --ms                the time unit is millisecond'\
        '  --tz [+|-]timezone  the timezone to use when displaying dates. default is the local timezone'\
        '  -h/--help           print this help message'
end

function _when_bak_tz
    set -gx store_tz "$TZ"
end

function _when_restore_tz
    set -x TZ "$store_tz"
    set -e store_tz
end
