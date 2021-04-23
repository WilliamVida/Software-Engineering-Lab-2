#!/usr/bin/env python3

import sys
import shutil
import os
import subprocess
import json
sys.path.append('/usr/share/codio/assessments')
from lib.grade import send_partial

"""
Run from Advanced Code Test with the following command line arguments:
1: file/path/studentCode.lang


On Ruby+Rails stack
Installed RVM: \curl -sSL https://get.rvm.io | bash
Installed PIP: sudo apt install python3-pip

"""

# make symlink
subprocess.call('ln -s ./ source', shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# get repo path
out = subprocess.Popen("git submodule | awk '{print $2}'", shell=True, stdout=subprocess.PIPE, universal_newlines=True).communicate()[0]
mlist = out.split("\n")
priv_rep = mlist[0]


file=sys.argv[1]
# put student submission in autograder/submission
# shutil.copy2(file, ".guides/secure/hw-sinatra-saas-hangperson-ci/autograder/submission")
shutil.copy2(file, f'{priv_rep}/autograder/submission/')

os.chdir(f'{priv_rep}/autograder')
# run setup.sh
#os.system('sh setup.sh')

# execute run_autograder (output sent to /autograder/results/stdout and should generate /autograder/results/results.json)
subprocess.call('bash ./run_autograder', shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# read json
with open('results/results.json') as f:
  read_data = f.read()
data = json.loads(read_data)

total_points = 0
earned_points = 0
print("<div>")
# grep various elements of results.json such as score and max_score broken down by test if applicable
for test in data["tests"]:
  total_points = total_points + test["max_score"]
  earned_points = earned_points + test["score"]
  if len(test["output"]) > 0:
    print("<b>" + test["name"] + "</b>")
    print(test["output"])
print("</div>")  
# rm gradescope

#os.remove("results/results.json")

# # output in pretty HTML to student
if total_points == 0:
  grade = 90
else:
  grade=earned_points/total_points*100
print("<h1>Total Grade: %d </h1>" % grade)
# send grade to Codio autograder
send_partial(grade)
