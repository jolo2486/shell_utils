# shell_utils
I will be collecting various shell utilities here; simple but potentially useful.

# Scripts

## runstatus
A simple script to look for a word in a file, such as a log or status file for an application, at certain intervals. This is useful for
applications which do not have a traditional progressbar, but which
repeatedly writes to a log or status file.

The script will simply output the number of times that the word \<running\> was found in \<filename\> every \<interval\> number of seconds. It will halt when the word \<done\> was found. 

### Usage
`./runstatus.sh <filename> <running> <done> <interval>` where \<filename\> is the path to the file to be checked, \<running\> is a word that is repeatedly written to \<filename\> at certain intervals, \<done\> is any word that when it appears in \<filename\> the script should exit, and \<interval\> is the number of seconds to wait until checking again.

### Example usage
`./runstatus.sh status.txt working done! 5`