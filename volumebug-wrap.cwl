#!/usr/bin/env cwl-runner

class: Workflow
description: "Testing a volume bug"
requirements:
  - class: SubworkflowFeatureRequirement

inputs:
  - id: "#input_file"
    type: File
  - id: "#output_file_name"
    type: string
outputs:
  - id: "#output_file"
    type: File
    source: "#wf2.output_file"
steps:
  - id: "#wf1"
    run: { import: volumebug.cwl }
    inputs:
    - { id: "#wf1.input_file", source: "#input_file" }
    outputs:
    - { id: "#wf1.output_file" }
  - id: "#wf2"
    run: { import: volumebug.cwl }
    inputs:
    - { id: "#wf2.input_file", source: "#wf1.output_file" }
    - { id: "#wf2.output_file_name", source: "#output_file_name" }
    outputs:
    - { id: "#wf2.output_file" }
