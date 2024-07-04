# TFE FDO Concurrency Test on Kubernetes

## Overview

This Terraform configuration is designed to test Terraform Enterprise (TFE) Flexible Deployment Options (FDO). The primary goal is to understand run concurrency and assist with appropriate TFE architecture scaling and K8s cluster sizing.

# Disclaimer - this is a simulated test to assist with initial sizing, it's critical to understand TFE and K8s performance using observability tools. Ensure you have sufficient capacity buffer for unplanned workloads. K8s cluster scaling along with the HCP Terraform operator agent controller can assist in handling unplanned workload demands

## Components

1. `random_pet` resource: Generates a random pet name with a specified prefix and length.
2. `time_sleep` resource: Introduces a 30-second delay in the execution.
3. `null_resource`: Creates multiple instances based on the `var.instances` value.
4. AWS data sources: Queries EKS clusters and caller identity in two different regions.

## Purpose

- The `random_pet` resource with a large length (200) and a timestamp keeper ensures unique runs each time.
- The `time_sleep` resource adds a controlled delay to simulate longer-running operations.
- Multiple `null_resource` instances allow testing of parallel execution capabilities.
- AWS data sources add memory load and increase the returned run payload, simulating real-world scenarios without actually provisioning resources.

## Usage

1. Set the required variables:
   - `prefix`: Prefix for the random pet name
   - `instances`: Number of null resources to create

2. Configure AWS providers for two different regions (aliased as `a` and `b`).

3. Run Terraform operations (plan, apply) to observe the behavior and performance of TFE.

## Note

This configuration is specifically designed for testing purposes and does not create any permanent AWS resources. It focuses on generating load and simulating concurrent operations to evaluate TFE's performance on Kubernetes.


## Example push creds to TFE variable set

```
 doormat login -f && eval $(doormat aws export --account ${DOORMAT_AWS_USER})
 VARSET=varset-Rr8e7o7Larik2Neb
 doormat aws tf-push variable-set --hostname tfe.simon-lynch.sbx.hashidemos.io --organization apj --id $VARSET --role arn:aws:iam::855831148133:role/aws_simon.lynch_test-developer
```