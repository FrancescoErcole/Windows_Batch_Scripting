# About
In one of my previous jobs, I created a batch script in DOS to process multiple files.\
Each file consisted of multiple lines, and each line had a particular string in object.\
The string was at a fixed position, and with the same pattern.\
We counted the frequency for each string.

I refactored this code to change the regular expression involved, to not violate any NDA.\
In the original version, the strings were a particular sequence of letters and numbers, while here I simulate a bioinformatics task.\
The strings in scope in this script consist of any sequence of 5 letters belonging to this list: A,C,G,T.\
The sequence is simple, but can be changed with any more complicated expression.

This task is trivial in Python (Pandas) and R, which were not available in my environment back then.\
In any language, the best way to tackle this challenge is to have a dictionary.\
However, DOS does not support this structure, so there should be a workaroud to create a dictionary-like structure here.\
The book in source was helpful to understand how to create a dictionary in DOS.

# Example
Input 1:
```
Line 1:	AAGTC	XX	23
Line 2:	AAGTC	XY	34
Line 3:	CATTC	XY	5
Line 4:	AAGTC	XX	32
Line 5:	CTTTC	XY	15
Line 6:	CATTC	XY	56
```
Input 2:
```
Line 1:	AAGTC	XX	22
Line 2:	GACTC	XY	43
Line 3:	CGTTC	XY	36
Line 4:	AAATC	XX	78
Line 5:	CTATC	XY	3
Line 6:	CATTC	XY	18
```

The file is processed, and the result is provided into a new file.\
Result:
```
File: C:\...\file1.txt 
N rows: 6 
AAGTC: 3 
CATTC: 2 
CTTTC: 1 
 
File: C:\...\file2.txt 
N rows: 6 
AAATC: 1 
AAGTC: 1 
CATTC: 1 
CGTTC: 1 
CTATC: 1 
GACTC: 1 
```

The script can also processes longer files.

# Source
- Batchography: The Art of Batch Files Programming
