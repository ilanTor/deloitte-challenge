# deloitte-challenge
## Cloud Security Architect Challenge

### This project contains:
- Terraform script to deploy EC2 and S3 in a secure way, according to CSF V1.1's sub-categories PR.AC-4 and PR-DS-1.
- High level diagram of the solution.


**NOTE:**
- The Terraform script addresses the main resources/services on AWS and the CSF Protect Function.
- The other functions: Detect, Respond and Recover are illustrated in the [Diagram](https://github.com/ilanTor/deloitte-challenge/blob/main/HL%20Diagram%20-%20Deloitte%20Challenge.drawio.png) in this manner:
  1. **Detect Function**: The Detect function can be achieved through the use of AWS CloudTrail, Amazon GuardDuty, and AWS Config.
  2. **Respond Function**: Organizations can implement automated response mechanisms using AWS Lambda functions triggered by CloudWatch Events to respond to security incidents in real-time.
  3. **Recover Function**: The Recover function involves restoring services and data after a security incident. This can be accomplished by leveraging AWS Backup for data recovery and restoring EC2 instances from snapshots or backups stored in Amazon S3.
