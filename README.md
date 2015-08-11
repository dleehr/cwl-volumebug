# cwl-volumebug
Demo of CWL issue with intermediate files when using subworkflows and boot2docker

When workflows include multiple subworkflows as steps, files passed from step 1 to step 2 are left in the host's temp directory. This directory cannot be accessed by step 2

# Reproducing

    $ mkdir $HOME/cwl
    $ cwl-runner --tmp-outdir-prefix=$HOME/cwl --tmpdir-prefix=$HOME/cwl volumebug-wrap.cwl volumebug.json
