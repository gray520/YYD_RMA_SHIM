#!/bin/bash 

echo "************Check CPU Type ******************"
cat /proc/cpuinfo | grep -i "model name" |grep -i N355
if [ $? == 0 ];then
  echo "*****************CPU Is N355 Moudle ****************"
  factory device-data component.cpu_n355=true
fi

cat /proc/cpuinfo | grep -i "model name" |grep -i N355
if [ $? == 1 ];then
  echo "*****************CPU Is Not N355 Moudle ****************"
  factory device-data component.cpu_n355=false
fi

echo "************Check Wireless Type ******************"
dmesg | grep -i Wireless | grep -i Intel
if [ $? == 0 ];then
  echo "*****************Wireless Is Intel Moudle ****************"
  factory device-data component.intel_wireless=true
fi

dmesg | grep -i Wireless | grep -i Intel
if [ $? == 1 ];then
  echo "*****************Wireless Is Not Intel Moudle ****************"
  factory device-data component.intel_wireless=false
fi

google_name=`cros_config / name`
echo ${google_name}
factory device-data component.google_name="${google_name}"

cbx=`factory device-data -g feature_management.chassis_branded` 
echo ${cbx}
if [ "${cbx}" == "True" ]; then
  vpd -i RO_VPD -s custom_label_tag="${google_name}_cbx"
fi

