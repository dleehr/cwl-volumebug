#!/usr/bin/env cwl-runner

class: Workflow
description: "Testing a volume bug"
# requirements:
#   - class: SubworkflowFeatureRequirement

inputs:
  - id: "#input_file"
    type: File
  - id: "#output_file_name"
    type: string
outputs:
  - id: "#output_file"
    type: File
    source: "#step2.output_file"
steps:
  - id: "#step1"
    run: { import: reverse.cwl }
    inputs:
    - { id: "#step1.input_file", source: "#input_file" }
    outputs:
    - { id: "#step1.output_file" }
  - id: "#step2"
    run: { import: number.cwl }
    inputs:
    - { id: "#step2.input_file", source: "#step1.output_file" }
    - { id: "#step2.output_file_name", source: "#output_file_name" }
    outputs:
    - { id: "#step2.output_file" }
