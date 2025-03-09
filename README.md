# AWS S3 Static Website with CloudFront

This Terraform project sets up a secure static website hosting infrastructure on AWS using S3 and CloudFront.

## Features

- **Secure S3 Static Website**: Configured with proper access controls
- **CloudFront Distribution**: For global content delivery with HTTPS
- **Logging**: All access logs stored in a dedicated S3 bucket
- **Environment Separation**: Separate configurations for production and staging

## Security Features

- Server-side encryption for all S3 buckets
- Public access blocked on all buckets
- HTTPS-only access enforced
- Geo-restriction to limit access to specific countries
- Proper IAM policies with least privilege

## Security Considerations

- The CloudFront distribution is configured to only allow access from the US and India
- All S3 buckets have public access blocked
- Server-side encryption is enabled for all buckets
- HTTPS is enforced for all traffic

## Requirements

- Terraform >= 1.2.0
- AWS Provider ~> 5.0
- Random Provider ~> 3.1.0

## Usage

### Planning Infrastructure Changes

To plan infrastructure changes for production:

### Applying Infrastructure Changes

To apply infrastructure changes for production:

### Using S3 Backend (Optional)

To use the S3 backend for state storage, uncomment the backend configuration in `terraform.tf` and run:

