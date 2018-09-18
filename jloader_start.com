#!/usr/bin/perl
#########################################################
$cntrlr=0;
$compathfilename="PROGRAM_FILES/loader_execute.com";
while ($cntrlr < 1){
    print "\n*********************************";
    print "\n************ JLOADER ************";
    print "\n** A CUSTOM SQL-LOADER PROGRAM **";
    print "\n*********************************";
    print "\n***PROCESS MENU***\n";
    print "[1] - START\n";
    print "[0] - EXIT Program\n\n";

    print "Enter Process Number: ";
    my $pno = <STDIN>;
    chomp $pno; 
    if (($pno eq 1) || ($pno eq 0)) {
        if ($pno eq 1) {
            print "\n***LIST OF FILES TO PROCESS***\n";
            system ("find ./INPUT -type f -name '*.txt' -o -name '*.lst' | sed 's|^\./INPUT/||'");

            print "\nEnter a file to process: ";
            my $inpfilename = <STDIN>;
            chomp $inpfilename; 
            # print $inpfilename; 

            if (-e "./INPUT/". $inpfilename){                
                print "File exists!\n"; 

                print "\n***LIST OF CUSTOM SQL PROCESSES***\n";
                system ("find ./CUSTOM -type f -name '*.sql' | sed 's|^\./CUSTOM/||'");            

                print "\nEnter custom sql for processing: ";
                my $sqlfilename = <STDIN>; 
                chomp $sqlfilename;
                # print $sqlfilename;

                if (-e "./CUSTOM/". $sqlfilename){
                    print "File exists!\n";

                    print "\n***LOADER COLUMN NUMBER***\n";
                    print "\nEnter number of columns to load: ";
                    my $colnum = <STDIN>;
                    chomp $colnum;
                    # print $colnum;

                    if ($colnum =~ /^\d+?$/) {
                        print "Numeric!\n";

                        print "\n***INPUT OVERVIEW***\n";
                        print "Input Filename: $inpfilename";
                        print "\nSQL Filename: $sqlfilename";
                        print "\nNumber of Cols: $colnum";

                        $datetimestring = localtime();
                        print "\n\nSTART EXEC TIME: $datetimestring\n";
                        system("$compathfilename $inpfilename $sqlfilename $colnum");
                        print "\nProcess another? (Input [X]/[x] to EXIT; Else, proceed with another processing): ";
                        my $anotherflg = <STDIN>;
                        chomp $anotherflg;

                        if (($anotherflg eq "X") || ($anotherflg eq "x")){
                            print "EXITING PROGRAM...\n";
                            exit 0;
                        }
                        else{
                            $cntrlr--;
                        }

                    } 
                    else{
                        print "Not numeric!\n";
                        $cntrlr--;
                    }
                }
                else {
                    print "File does not exists!\n";
                    $cntrlr--;
                }
            }
            else {
                print "File does not exists!\n"; 
                $cntrlr--;
            }
        }
        elsif ($pno eq 0) {
            print "EXITING PROGRAM...\n";
            exit 0;
        }
        $cntrlr++;
    }
    else {
        print "Invalid Process Number!\n";
    }
    
}
