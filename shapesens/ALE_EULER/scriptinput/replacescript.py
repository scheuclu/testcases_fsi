
import sys

for argument in sys.argv:
    if argument.startswith("file="):
        filename=argument.replace("file=","")
    if argument.startswith("key="):
        key=argument.replace("key=","")
    if argument.startswith("text="):
        replacefilename=argument.replace("text=","")
    if argument.startswith("verbose="):
        verbose=bool(argument.replace("text=",""))
    else:
        verbose=False

if 'filename' in locals() and 'key' in locals() and 'replacefilename' in locals():
    if verbose==True:
        print("Input valid")
        print("SOURCEFILE:  "+filename)
        print("KEY:         "+key)
        print("REPLACEFILE: "+replacefilename)
else:
    print("INVALID USAGE!")
    print("Usage:")
    print("        python3.5 <this-script-name> file=<source-file> key=<keyword> text=<file-containg-replacement-text>")
    sys.exit()

###########################################################
# Made it to this point so the input format was valid     #
###########################################################

with open(filename) as sourcefile:
    with open(replacefilename) as replacefile:
        fulltext=sourcefile.read()
        fulltext=fulltext.replace(key,replacefile.read())
with open(filename,'w') as sourcefile:
    sourcefile.write(fulltext)
