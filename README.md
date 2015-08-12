# cwl-volumebug
Demo of CWL issue with intermediate files when using subworkflows and boot2docker

When workflows include multiple subworkflows as steps, files passed from step 1 to step 2 are left in the host's temp directory. This directory cannot be accessed by step 2

# Reproducing

1. Install boot2docker and configure shared folders
2. `$ mkdir $HOME/cwl`
3. `$ cwl-runner --tmp-outdir-prefix=$HOME/cwl/ --tmpdir-prefix=$HOME/cwl/ volumebug-wrap.cwl volumebug.json`

# Output

```
$ cwl-runner --debug --tmp-outdir-prefix=/Users/dcl9/cwl --tmpdir-prefix=/Users/dcl9/cwl volumebug-wrap.cwl volumebug.json 
/Users/dcl9/Code/envs/cwl/bin/cwl-runner 1.0.20150721202036
[workflow 4526913424] initialized from file:///Users/dcl9/Code/python/cwl-volumebug/volumebug-wrap.cwl
[workflow 4526913424] starting
[step 4527254096] starting job step file:///Users/dcl9/Code/python/cwl-volumebug/volumebug-wrap.cwl#wf1 of workflow 4526913424
[workflow 4528105744] initialized from file:///Users/dcl9/Code/python/cwl-volumebug/volumebug.cwl
[workflow 4528105744] starting
[step 4528106064] starting job step file:///Users/dcl9/Code/python/cwl-volumebug/volumebug.cwl#step1 of workflow 4528105744
[job 4526326288] initializing from file:///Users/dcl9/Code/python/cwl-volumebug/reverse.cwl as part of step 4528106064
[job 4526326288] {
    "input_file": {
        "path": "volumebug.cwl", 
        "class": "File"
    }
}
[job 4526326288] command line bindings is [
    {
        "position": [
            -1000000, 
            0
        ], 
        "valueFrom": "rev"
    }, 
    {
        "position": [
            1, 
            "input_file"
        ], 
        "valueFrom": {
            "path": "/tmp/job773483521_cwl-volumebug/volumebug.cwl", 
            "class": "File"
        }
    }
]
[job 4526326288] path mappings is {
    "volumebug.cwl": [
        "/Users/dcl9/Code/python/cwl-volumebug/volumebug.cwl", 
        "/tmp/job773483521_cwl-volumebug/volumebug.cwl"
    ]
}
[job 4526326288] exec docker run -i --volume=/Users/dcl9/Code/python/cwl-volumebug/volumebug.cwl:/tmp/job773483521_cwl-volumebug/volumebug.cwl:ro --volume=/Users/dcl9/cwlfqHVnx:/tmp/job_output:rw --volume=/Users/dcl9/cwlPcGMvp:/tmp/job_tmp:rw --workdir=/tmp/job_output --user=1000 --rm --env=TMPDIR=/tmp/job_tmp ubuntu:14.04 rev /tmp/job773483521_cwl-volumebug/volumebug.cwl > /Users/dcl9/cwlfqHVnx/reverse-output.txt
[job 4526326288] completed success
[job 4526326288] {
    "output_file": {
        "path": "/Users/dcl9/cwlfqHVnx/reverse-output.txt", 
        "size": 754, 
        "class": "File", 
        "checksum": "sha1$4573c3eb3214b59ab25f5ebf1830b5a2a406d9c8"
    }
}
[workflow 4528105744] step 4528106064 completed
[job 4526326288] Removing temporary directory /Users/dcl9/cwlPcGMvp
[step 4528105680] starting job step file:///Users/dcl9/Code/python/cwl-volumebug/volumebug.cwl#step2 of workflow 4528105744
[job 4526329104] initializing from file:///Users/dcl9/Code/python/cwl-volumebug/number.cwl as part of step 4528105680
[job 4526329104] {
    "output_file_name": "processed.txt", 
    "input_file": {
        "path": "/Users/dcl9/cwlfqHVnx/reverse-output.txt", 
        "checksum": "sha1$4573c3eb3214b59ab25f5ebf1830b5a2a406d9c8", 
        "class": "File", 
        "size": 754
    }
}
[job 4526329104] command line bindings is [
    {
        "position": [
            -1000000, 
            0
        ], 
        "valueFrom": "cat"
    }, 
    {
        "position": [
            -1000000, 
            1
        ], 
        "valueFrom": "-n"
    }, 
    {
        "position": [
            1, 
            "input_file"
        ], 
        "valueFrom": {
            "path": "/tmp/job533375105_cwlfqHVnx/reverse-output.txt", 
            "size": 754, 
            "class": "File", 
            "checksum": "sha1$4573c3eb3214b59ab25f5ebf1830b5a2a406d9c8"
        }
    }
]
[job 4526329104] path mappings is {
    "/Users/dcl9/cwlfqHVnx/reverse-output.txt": [
        "/Users/dcl9/cwlfqHVnx/reverse-output.txt", 
        "/tmp/job533375105_cwlfqHVnx/reverse-output.txt"
    ]
}
[job 4526329104] exec docker run -i --volume=/Users/dcl9/cwlfqHVnx/reverse-output.txt:/tmp/job533375105_cwlfqHVnx/reverse-output.txt:ro --volume=/Users/dcl9/cwliZdwTH:/tmp/job_output:rw --volume=/Users/dcl9/cwl5cRpDX:/tmp/job_tmp:rw --workdir=/tmp/job_output --user=1000 --rm --env=TMPDIR=/tmp/job_tmp ubuntu:14.04 cat -n /tmp/job533375105_cwlfqHVnx/reverse-output.txt > /Users/dcl9/cwliZdwTH/processed.txt
[job 4526329104] completed success
[job 4526329104] {
    "output_file": {
        "path": "/Users/dcl9/cwliZdwTH/processed.txt", 
        "size": 971, 
        "class": "File", 
        "checksum": "sha1$12412d44bdd018a301b786c4d21becd57de060fc"
    }
}
[workflow 4528105744] step 4528105680 completed
[job 4526329104] Removing temporary directory /Users/dcl9/cwl5cRpDX
[workflow 4528105744] Moving '/Users/dcl9/cwliZdwTH/processed.txt' to '/var/folders/7t/q8bb2np92p5b26pk_h5lr0lh0000gn/T/tmpM3jhJO/processed.txt'
[workflow 4528105744] Removing intermediate output directory /Users/dcl9/cwliZdwTH
[workflow 4528105744] outdir is /var/folders/7t/q8bb2np92p5b26pk_h5lr0lh0000gn/T/tmpM3jhJO
[workflow 4526913424] step 4527254096 completed
[step 4528105808] starting job step file:///Users/dcl9/Code/python/cwl-volumebug/volumebug-wrap.cwl#wf2 of workflow 4526913424
[workflow 4528104912] initialized from file:///Users/dcl9/Code/python/cwl-volumebug/volumebug.cwl
[workflow 4528104912] starting
[workflow 4528104912] job step file:///Users/dcl9/Code/python/cwl-volumebug/volumebug.cwl#step2 not ready
[step 4526329424] starting job step file:///Users/dcl9/Code/python/cwl-volumebug/volumebug.cwl#step1 of workflow 4528104912
[job 4526329104] initializing from file:///Users/dcl9/Code/python/cwl-volumebug/reverse.cwl as part of step 4526329424
[job 4526329104] {
    "input_file": {
        "path": "/var/folders/7t/q8bb2np92p5b26pk_h5lr0lh0000gn/T/tmpM3jhJO/processed.txt", 
        "size": 971, 
        "class": "File", 
        "checksum": "sha1$12412d44bdd018a301b786c4d21becd57de060fc"
    }
}
[job 4526329104] command line bindings is [
    {
        "position": [
            -1000000, 
            0
        ], 
        "valueFrom": "rev"
    }, 
    {
        "position": [
            1, 
            "input_file"
        ], 
        "valueFrom": {
            "path": "/tmp/job237460264_tmpM3jhJO/processed.txt", 
            "checksum": "sha1$12412d44bdd018a301b786c4d21becd57de060fc", 
            "class": "File", 
            "size": 971
        }
    }
]
[job 4526329104] path mappings is {
    "/var/folders/7t/q8bb2np92p5b26pk_h5lr0lh0000gn/T/tmpM3jhJO/processed.txt": [
        "/var/folders/7t/q8bb2np92p5b26pk_h5lr0lh0000gn/T/tmpM3jhJO/processed.txt", 
        "/tmp/job237460264_tmpM3jhJO/processed.txt"
    ]
}
[job 4526329104] exec docker run -i --volume=/var/folders/7t/q8bb2np92p5b26pk_h5lr0lh0000gn/T/tmpM3jhJO/processed.txt:/tmp/job237460264_tmpM3jhJO/processed.txt:ro --volume=/Users/dcl9/cwl9wtZCS:/tmp/job_output:rw --volume=/Users/dcl9/cwlDFZwY5:/tmp/job_tmp:rw --workdir=/tmp/job_output --user=1000 --rm --env=TMPDIR=/tmp/job_tmp ubuntu:14.04 rev /tmp/job237460264_tmpM3jhJO/processed.txt > /Users/dcl9/cwl9wtZCS/reverse-output.txt
rev: /tmp/job237460264_tmpM3jhJO/processed.txt: Is a directory
[job 4526329104] completed permanentFail
[job 4526329104] {
    "output_file": {
        "path": "/Users/dcl9/cwl9wtZCS/reverse-output.txt", 
        "size": 0, 
        "class": "File", 
        "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709"
    }
}
[workflow 4528104912] step 4526329424 completed
Workflow step file:///Users/dcl9/Code/python/cwl-volumebug/volumebug.cwl#step1 completion status is permanentFail
[job 4526329104] Removing temporary directory /Users/dcl9/cwlDFZwY5
[workflow 4528104912] outdir is /var/folders/7t/q8bb2np92p5b26pk_h5lr0lh0000gn/T/tmpWy_cUp
Unhandled exception
Traceback (most recent call last):
  File "build/bdist.macosx-10.10-intel/egg/cwltool/workflow.py", line 192, in try_make_job
    for j in jobs:
  File "build/bdist.macosx-10.10-intel/egg/cwltool/workflow.py", line 122, in job
    for j in self.step.job(joborder, basedir, output_callback, **kwargs):
  File "build/bdist.macosx-10.10-intel/egg/cwltool/workflow.py", line 399, in job
    for t in self.embedded_tool.job(joborder, basedir, functools.partial(self.receive_output, output_callback), **kwargs):
  File "build/bdist.macosx-10.10-intel/egg/cwltool/workflow.py", line 306, in job
    for w in wj.job(joborder, basedir, output_callback, **kwargs):
  File "build/bdist.macosx-10.10-intel/egg/cwltool/workflow.py", line 281, in job
    output_callback(wo, self.processStatus)
  File "build/bdist.macosx-10.10-intel/egg/cwltool/workflow.py", line 382, in receive_output
    if field in jobout:
TypeError: argument of type 'NoneType' is not iterable
[workflow 4526913424] Removing intermediate output directory /var/folders/7t/q8bb2np92p5b26pk_h5lr0lh0000gn/T/tmpWy_cUp
[workflow 4526913424] outdir is /Users/dcl9/Code/python/cwl-volumebug
Final process status is permanentFail
```
