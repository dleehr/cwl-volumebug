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
    source: "#inner.output_file"
steps:
  - id: "#inner"
    run: { import: volumebug.cwl }
    inputs:
    - { id: "#inner.input_file", source: "#input_file" }
    - { id: "#inner.output_file_name", source: "#output_file_name" }
    outputs:
    - { id: "#inner.output_file" }
