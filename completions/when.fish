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
complete when -s d -l datetime -d 'Convert timestamp to datetime (overrides -t if set)'
complete when -s t -l timestamp -d 'Convert datetime to timestamp (supports various date formats)'
complete when -s s -d 'Treat input/output as seconds (overrides --ms if set)'
complete when -l ms -d 'Treat input/output as milliseconds (default for numeric input)'
complete when -k -r -f -l tz -a "(_when_complete_tz)" -d 'Use specified timezone (default: local timezone)'
complete when -s h -l help -d 'Show this help message'
