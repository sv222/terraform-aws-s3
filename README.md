# Terraform S3 Bucket Module

This Terraform module creates an S3 bucket in a production-ready configuration. The module allows for specifying the S3 bucket name, region, and versioning settings, as well as custom object lifecycle rules. The module includes outputs for the unique ID, ARN, domain name, and region of the created S3 bucket.

## Usage Example

To use this module, create a new Terraform configuration file and reference this module using a `module` block. Here is an example of how to use this module:

```terraform
    module "s3_bucket" {
    source = "github.com/sv222/terraform-aws-s3"
    
    bucket_name = "my-bucket"
    region      = "us-west-2"
    versioning  = true
    
    lifecycle_rule = {
        "rule1" = {
        id      = "rule1"
        status  = "Enabled"
        prefix  = "logs/"
        tags    = {
            environment = "production"
        }
        transition = [
            {
            days          = 30
            storage_class = "STANDARD_IA"
            },
            {
            days          = 60
            storage_class = "GLACIER"
            }
        ]
        expiration = {
            days = 365
        }
        }
    }
    }
```

In this example, the `bucket_name` variable is set to `my-bucket`, the `region` variable is set to `us-west-2`, and versioning is enabled. The `lifecycle_rule` variable defines a custom rule with a prefix of `logs/`, a tag of `environment=production`, and two transitions to the `STANDARD_IA` and `GLACIER` storage classes after 30 and 60 days, respectively. Objects matching this rule will be deleted after 365 days. The module includes four outputs for the created S3 bucket.

## Inputs

This module has the following input variables:

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `bucket_name` | The name of the S3 bucket to create. | `string` | n/a |
| `region` | The region in which to create the S3 bucket. | `string` | n/a |
| `versioning` | Whether versioning should be enabled for the S3 bucket. | `bool` | `true` |
| `lifecycle_rule` | A map of S3 object lifecycle rules. | `map(string)` | `{}` |

## Outputs

This module has the following output variables:

| Name | Description |
|------|-------------|
| `bucket_id` | The unique ID of the S3 bucket. |
| `bucket_arn` | The ARN of the S3 bucket. |
| `bucket_domain_name` | The domain name of the S3 bucket. |
| `bucket_region` | The region in which the S3 bucket was created. |

---

## Contributing

Feel free to contribute to this project by submitting pull requests or reporting issues.

## License

This project is licensed under the MIT License.
