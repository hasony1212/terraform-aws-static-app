# AWS S3 Static Website with CloudFront

This Terraform project sets up a secure static website hosting infrastructure on AWS using S3 and CloudFront.

## Project Structure 

├── prod-env/
│ ├── terraform.tf # Terraform configuration for production
│ ├── main.tf # Main production infrastructure
│ ├── env_config_file/
│ │ └── prod.tfvars # Production variables
│ └── backend_config/
│ └── prod_backend.tfvars # S3 backend configuration
├── staging-env/
│ ├── terraform.tf # Terraform configuration for staging
│ └── main.tf # Main staging infrastructure
└── s3-static-site/
├── aws_s3_static_website_bucket.tf # S3 bucket for website
├── aws_s3_redirect_bucket.tf # S3 bucket for redirects
├── aws_s3_logs_bucket.tf # S3 bucket for logs
└── aws_cloudfront_distribution.tf # CloudFront distribution

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

