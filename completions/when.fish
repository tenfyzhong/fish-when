function _when_complete_tz
    # List all timezone files and trim the prefix `/usr/share/zoneinfo/`
    ls -R /usr/share/zoneinfo | awk '
        /:$/ { dir = substr($0, 1, length($0)-1) }
        /^[^.]/ && !/:/ {
            if (dir != "" && $0 !~ /^posix\// && $0 !~ /^right\//) {
                path = dir "/" $0
                sub("^/usr/share/zoneinfo/", "", path)
                printf "%s\t%s\n", path, path
            }
        }' | sort
end

complete when -f
complete when -s d -l datetime -d 'convert timestamp to datetime'
complete when -s t -l timestamp -d 'convert datetime to timestamp, any format which support by `date` is supported'
complete when -l ms -d 'the time unit is millisecond'
complete when -k -r -f -l tz -a "(_when_complete_tz)" -d 'the timezone to use when displaying dates.'
complete when -s h -l help -d 'print this help message'
