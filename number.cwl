#!/usr/bin/env cwl-runner

class: CommandLineTool
#
# requirements:
#   - class: DockerRequirement
#     dockerImageId: ubuntu:14.04

inputs:
  - id: "#input_file"
    type: File
    inputBinding:
      position: 1
  - id: "#output_file_name"
    type: string
    default: 'step1-output.txt'

outputs:
  - id: "#output_file"
    type: File
    outputBinding:
      glob:
        engine: cwl:JsonPointer
        script: /job/output_file_name

baseCommand: ["cat", "-n"]
stdout:
  engine: cwl:JsonPointer
  script: /job/output_file_name

