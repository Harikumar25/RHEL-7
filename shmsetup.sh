#!/bin/bash
# ./shmsetup >> /etc/sysctl.conf
# sysctl -p
page_size=`getconf PAGE_SIZE`
phys_pages=`getconf _PHYS_PAGES`
Memory=`cat /proc/meminfo |grep -i MemTotal |awk '{print $2}'`

if [ -z "$page_size" ]; then
  echo Error:  cannot determine page size
  exit 1
fi

if [ -z "$phys_pages" ]; then
  echo Error:  cannot determine number of memory pages
  exit 2
fi

shmall=`expr $Memory \* 1024 / $page_size`
shmmax=`expr $Memory \* 1024 / 2`

echo \# Maximum shared segment size in bytes
echo kernel.shmmax = $shmmax
echo \# Maximum number of shared memory segments in pages
echo kernel.shmall = $shmall
