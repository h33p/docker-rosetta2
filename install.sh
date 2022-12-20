
mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc

if [ ! -f /proc/sys/fs/binfmt_misc/rosetta ]; then
  echo ":rosetta:M::\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x3e\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/bin/rosetta:OCF" > /proc/sys/fs/binfmt_misc/register
fi

if [ -f /proc/sys/fs/binfmt_misc/qemu-x86_64 ]; then
  echo -1 > /proc/sys/fs/binfmt_misc/qemu-x86_64
fi

# Wait indefinitely
trap 'trap - TERM; kill -s TERM -- -$$' TERM
tail -f /dev/null & wait

exit 0
