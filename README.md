# fish-when
[![GitHub tag](https://img.shields.io/github/tag/tenfyzhong/fish-when.svg)](https://github.com/tenfyzhong/fish-when/tags)
[![CI](https://github.com/tenfyzhong/fish-when/actions/workflows/test.yml/badge.svg)](https://github.com/tenfyzhong/fish-when/actions/workflows/test.yml)
convert timestamp/datetime

# usage
```
when: convert tiemstamp/datetime
Usage: when [options] [timestamp/datetime]

Options:
  -d/--datetime       convert timestamp to datetime
  -t/--timestamp      convert datetime to timestamp, any format which support by `date` is supported
  --ms                the time unit is millisecond
  --tz [+|-]timezone  the timezone to use when displaying dates. default is the local timezone
  -h/--help           print this help message
```

# install
Install using Fisher(or other plugin manager):
```
fisher install tenfyzhong/fish-when
```
