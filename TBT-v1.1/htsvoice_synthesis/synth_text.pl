#!/usr/bin/perl
use Parallel::ForkManager;
# ----------------------------------------------------------------- #
#Ministry Of Communications & Information Technology, Govt. Of India#
#          and Indian Institute Of Technology - Madras              #
#                    developed by TTS Group                         #
#                  http://lantana.tenet.res.in/                     #
#                    Copyright (c) 2009-2015                        #
# ----------------------------------------------------------------- #
#                                                                   #
#                                                                   #
# All rights reserved.                                              #
#                                                                   #
# Redistribution and use in source and binary forms, with or        #
# without modification, are permitted provided that the following   #
# conditions are met:                                               #
#                                                                   #
# - Redistributions of source code must retain the above copyright  #
#   notice, this list of conditions and the following disclaimer.   #
# - Redistributions in binary form must reproduce the above         #
#   copyright notice, this list of conditions and the following     #
#   disclaimer in the documentation and/or other materials provided #
#   with the distribution.                                          #
# - Neither the name of the HTS working group nor the names of its  #
#   contributors may be used to endorse or promote products derived #
#   from this software without specific prior written permission.   #
#                                                                   #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND            #
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,       #
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF          #
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE          #
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS #
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,          #
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED   #
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,     #
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON #
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,   #
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY    #
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE           #
# POSSIBILITY OF SUCH DAMAGE.                                       #
# ----------------------------------------------------------------- #


my $story=$ARGV[0];
if($story eq "") {
  print "Usage: perl $0 <inputstory>\n";
  print "Exiting at ". __FILE__ . ":". __LINE__ ."\n";
  exit -1;
}

$story =~ s/(^\s+|\s+$)//g;
$story =~ s/\।/\./g;
$story =~ s/\-/\ /g;
$story =~ s/\"//g;
$story =~ s/\//\ \/\ /g;
print "The story to be synthesized is: $story\n";
print "The output syllable file is: $out_word_file_name\n";

my @words = split(/\. /, $story);
print "The words are : \n";

$r=`rm out/*.wav`;
my $pm = Parallel::ForkManager->new(100); # number of parallel processes
for(my $i=1; $i<=@words; $i++)
{
$datestring = localtime();
print "Local date and time $datestring\n";
	 my $pid = $pm->start and next;   ### calling parallel processes.
	print "piiiiiidddddd=".$pid;
     $words[$i-1] =~ s/(^\s+|\s+$)//g;
       # $words[$i-1] =~ s/[a-zA-Z]//g;
        $words[$i-1] =~ s/` |'//g;
   #  $r=`sh synthhindi.sh \"$words[$i-1]\" $i`;
my $rm='rm -rf  resources'.$i;
system($rm);
  my $c='cp -rf  resources resources'.$i;
#system($c);
#my $c1='cp   synthhindi.sh synthhindi'.$i.'.sh';
system($c);
  $r=` sh resources$i/synthhindi.sh \"$words[$i-1]\"  $i`  ;
 print "\nat0";
     print $r;
print "\nat1";
     if($i < 10 ) {
        $FileName = "000".$i;
     }
     elsif($i <100) {
        $FileName = "00".$i;
     }
     elsif($i <1000) {
        $FileName = "0".$i;
     }
     else {
        $FileName = $i;
     }

   #  $r=`mv gen/hts_engine/test.wav out/$FileName.wav`;
my $wavname="test$i.wav";
  $r=`mv resources$i/test.wav out/$FileName.wav`;
#my $rm='rm -rf  resources'.$i;
#system($rm);

$pm->finish; # Terminates the child process
print "pranaw$1";
}
$pm->wait_all_children;
$r=`normalize-audio out/*.wav`; 
$r=`ch_wave out/*.wav -o out.wav`;
system("play out.wav");

