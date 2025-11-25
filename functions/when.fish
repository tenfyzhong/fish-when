function when --description 'Format timestamp'
    argparse -i t/timestamp d/datetime ms 'tz=' h/help 'a/add=' 's/sub=' -- $argv 2>/dev/null

    if set -q _flag_help
        _when_help
        return 0
    end

    set -l t $argv
    if test -z "$t"
        if not isatty stdin
            read -L t
        end
    end

    set -l date_style (_when_detect_date_style)

    if test "$date_style" = unknown
        echo "Unsupport `date` command" >&2
        return 1
    end

    set to_datetime ''
    if set -q _flag_datetime
        set to_datetime 1
    else if set -q _flag_timestamp
        set to_datetime 0
    end

    # Auto-detect timestamp/datetime if no flags specified
    if test -z "$to_datetime"
        if test -z "$t"
            # No input - use current time
            set to_datetime 1
        else if string match -qr '^[0-9]+$' -- "$t"
            # Numeric input - treat as timestamp
            set to_datetime 1
        else
            # Non-numeric input - treat as datetime
            set to_datetime 0
        end
    end

    _when_bak_tz
    if test -n "$_flag_tz"
        set -x TZ "$_flag_tz"
    end

    # Calculate offset in seconds
    set -l offset 0
    if set -q _flag_add
        set -l add_sec (_when_parse_duration "$_flag_add")
        set offset (math "$offset + $add_sec")
    end
    if set -q _flag_sub
        set -l sub_sec (_when_parse_duration "$_flag_sub")
        set offset (math "$offset - $sub_sec")
    end

    if test "$to_datetime" = 1
        if test -z "$t"
            set t (date +%s)
        else
            if set -q _flag_ms
                set t (math "floor($t/1000)")
            else
                set t (string length -- "$t" | grep -q '^1[0-2]$' && echo "$t" || math "floor($t/1000)")
            end
        end

        # Apply offset
        set t (math "$t + $offset")

        if test "$date_style" = gnu
            date +'%F %T %Z %:z' -d @"$t"
        else
            date -j -f "%s" "$t" +'%F %T %Z %:z'
        end
        _when_restore_tz
        return 0
    else if test "$to_datetime" = 0
        if test -z "$t"
            set ts (date +"%s")
        else
            if test "$date_style" = gnu
                set ts (date -d "$t" +"%s")
            else
                set ts (date -j -f "%a %b %d %T %Z %Y" "$t" +"%s" 2>/dev/null || date -j -f "%F %T" "$t" +"%s" 2>/dev/null || date -j -f "%F" "$t" +"%s")
            end
        end

        # Apply offset
        set ts (math "$ts + $offset")

        if set -q _flag_ms
            set ts (math "$ts*1000")
        end
        echo "$ts"
        _when_restore_tz
        return 0
    else
        # Should not reach here
        date +'%F %T %Z %:z'
        _when_restore_tz
        return 0
    end
end

function _when_help
    printf %s\n \
        'when - Convert between timestamps and human-readable datetime formats' \
        '' \
        'Usage:' \
        '  when [OPTIONS] [TIMESTAMP|DATETIME]' \
        '' \
        'Options:' \
        '  -d, --datetime      Convert timestamp to datetime (overrides -t if set)' \
        '  -t, --timestamp     Convert datetime to timestamp (supports various date formats)' \
        '  --ms                Treat input/output as milliseconds (default for numeric input)' \
        '  --tz TIMEZONE       Use specified timezone (default: local timezone)' \
        '  -a, --add DURATION  Add duration to time (e.g. 1d2h3m4s)' \
        '  -s, --sub DURATION  Subtract duration from time (e.g. 1d2h3m4s)' \
        '  -h, --help          Show this help message' \
        '' \
        'Examples:' \
        '  when 1635724800                  # Convert timestamp to datetime' \
        '  when 2021-10-31 10:11:12         # Convert date to timestamp' \
        '  when --ms 1635724800000          # Handle millisecond timestamps' \
        '  when -a 1d                       # Current time + 1 day' \
        '  when -a 1h30m 1635724800         # Timestamp + 1 hour 30 minutes'
end

function _when_bak_tz
    set -gx store_tz "$TZ"
end

function _when_restore_tz
    set -x TZ "$store_tz"
    set -e store_tz
end

function _when_detect_date_style
    if date -d now +%s >/dev/null 2>&1
        echo gnu
    else if date -j -f "%s" (date +%s) >/dev/null 2>&1
        echo bsd
    else
        echo unknown
    end
end

function _when_parse_duration
    set -l duration $argv[1]
    set -l total_seconds 0

    # Parse days
    if string match -qr '([0-9]+)d' -- "$duration"
        set -l d (string match -r '([0-9]+)d' -- "$duration")[2]
        set total_seconds (math "$total_seconds + $d * 86400")
    end

    # Parse hours
    if string match -qr '([0-9]+)h' -- "$duration"
        set -l h (string match -r '([0-9]+)h' -- "$duration")[2]
        set total_seconds (math "$total_seconds + $h * 3600")
    end

    # Parse minutes
    if string match -qr '([0-9]+)m' -- "$duration"
        set -l m (string match -r '([0-9]+)m' -- "$duration")[2]
        set total_seconds (math "$total_seconds + $m * 60")
    end

    # Parse seconds
    if string match -qr '([0-9]+)s' -- "$duration"
        set -l s (string match -r '([0-9]+)s' -- "$duration")[2]
        set total_seconds (math "$total_seconds + $s")
    end

    echo $total_seconds
end
