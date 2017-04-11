/*******************************************************************************
Designed and Developed by Atish && Rachana 
The designed code for Phoneme level lab file generation.

*******************************************************************************/


#include<stdio.h>
#include<string.h>

int main(int argc, char *argv[])
{
		char command[1111];
	 	char str[1111];
		//char *command;
		////////////////////////////////////////////////////////////////sprintf(cmd,"whereis %s",str);
		system("$FESTVOXDIR/src/unitsel/setup_clunits phone level lab");
		
		 

		//system("cp -r ../phoneme/Marathi_PhoneSet.txt bin/");
		sprintf(str,"cp -r %s%s%s %s","../resources/languages/",argv[1],"/phoneme/PhoneSet.txt","bin/");
		system(str);

		sprintf(str,"cp -r %s %s","../input/txt.done.data","etc/");
		system(str);
		
		sprintf(str,"cp -r %s%s%s %s","../resources/languages/",argv[1], "/phoneme/il_parser_hts.pl","bin/");  
		system(str);

		sprintf(str,"cp %s%s%s %s","../resources/languages/",argv[1], "/phoneme/phone_level_lab_lexicon.scm","festvox/");
		system(str);

		sprintf(str,"rm -rf %s%s%s","../resources/languages/",argv[1], "/phoneme/phone_level_lab_phoneset.scm");
		system(str);

		system("rm -rf festvox/phone_level_lab_phoneset.scm");
		
		sprintf(str,"cat %s%s%s %s","../resources/languages/",argv[1], "/phoneme/phoneset.scm"," > phone_level_lab_phoneset.scm");
		system(str);
	
		sprintf(str,"cat %s%s%s %s","../resources/languages/",argv[1], "/phoneme/phoneset_base.scm"," >> phone_level_lab_phoneset.scm");
		system(str);

		system("cp -r phone_level_lab_phoneset.scm festvox/");
		system("rm -rf phone_level_lab_phoneset.scm");

		strcpy(command,"festival -b festvox/build_clunits.scm '(build_prompts \"etc/txt.done.data\")'");   /* generate prompts*/
		printf("\n\n ****Building PHONE level LAB files ****\n\n");
		system(command);
		printf("\n\n ****Completed building PHONE level LAB files ****\n\n");
		
		return 0;
}

