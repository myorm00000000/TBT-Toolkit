#!/bin/sh

gender=$1

##List out wav files to generate .f0 frequency files
ls wav_16KHz/*.wav > list.txt

#Pass that list to generate -f0 files
./pitchextract.sh list.txt


#list out .f0 file's name in list_of_f0 which is created in source_hybrid_seg/for_f0_values
ls f0_files/*.f0 > list_of_f0

##to take first value from f0 file#####to remove only 0 from .txt value file####

rm -rf f0_txt_files
mkdir f0_txt_files

for line in `cat list_of_f0`
do  
	name=$(basename "$line" ".f0")
	cut -d\. -f1 $line | sort -n | sed '/^0/ d'  > f0_txt_files/$name.txt
done

rm -rf global_f0_values
touch global_f0_values
cat f0_txt_files/*.txt >> global_f0_values

sort -n global_f0_values  > sorted
uniq -c sorted > sorted_with_count


 if [ "$gender" = "female" ];
   then
	a1=$( awk '$2 >= 80 && $2 <= 110 {print $1, $2}' sorted_with_count | awk -v min=0 '{if($1>min){want=$2; min=$1}}END{print want}' )
	a2=$( awk '$2 >= 310 && $2 <= 350 {print $1, $2}' sorted_with_count | awk -v max=0 '{if($1>max){want=$2; max=$1}}END{print want}' )
	
 fi
 if [ "$gender" = "male" ];	
   then
	a1=$( awk '$2 >= 50 && $2 <= 80 {print $1, $2}' sorted_with_count | awk -v min=0 '{if($1>min){want=$2; min=$1}}END{print want}' )
	a2=$( awk '$2 >= 220 && $2 <= 250 {print $1, $2}' sorted_with_count | awk -v max=0 '{if($1>max){want=$2; max=$1}}END{print want}' )
   else
	echo "Call us for any help..."
 fi

sed -i "48s/.*/LOWERF0    = $a1    # lower limit for f0 extraction (Hz)/" ../../resources/common/htsvoice/Makefile

sed -i "49s/.*/UPPERF0    = $a2    # upper limit for f0 extraction (Hz)/" ../../resources/common/htsvoice/Makefile
