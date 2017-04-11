#! bin/bash
##########################
#
#
################
#HTS-demo_CMU-ARCTIC-SLT

#HTS-demo_CMU-ARCTIC-SLT requires Festival-2.4, SPTK-3.9, HTS-2.3, and hts_engine API-1.10.
#Please install them before running this demo.


sudo locate SPTK > sptk_list
sudo locate hts_engine_API-1.10 > hts_engine_list
sptk=$(head -1 sptk_list) > list1
hts_engine=$(head -1 hts_engine_list) > list2

#cd HTS-demo_CMU-ARCTIC-SLT
./configure --with-fest-search-path=$FESTDIR/examples \
                 --with-sptk-search-path=$sptk/bin \
                 --with-hts-search-path=/usr/local/HTS-2.3/bin \
                 --with-hts-engine-search-path=$hts_engine/bin


echo "================DONE WITH HTSVOICE SETUP======================"


echo "##########Raw files generation Started##########################"

LNG=$1

rm -rf data/raw
rm -rf data/utts
rm -rf data/questions
rm -rf data/Makefile
rm -rf data/labels/gen
rm -rf scripts/Training.pl
mkdir data/labels/gen


cp -r ../temp/htsvoice/raw_files/raw data/
cp -r ../resources/languages/$LNG/htsvoice/questions data/
cp -r ../temp/htsvoice/utts data/
cp -r ../resources/common/htsvoice/call_make.sh data/

cp -r ../resources/common/htsvoice/Makefile data/
cp -r ../resources/common/htsvoice/scripts_of_htsvoice/Training.pl scripts/
cp -r ../resources/common/htsvoice/scripts_of_htsvoice/build_train_scp_from_fal.sh scripts/ 

make

#rm -rf  hts_engine_list list1 list2 sptk_list


echo "%%%%%%%%%%%%%%%Voice Building Started%%%%%%%%%Wait for Some Time==============>>>>"






